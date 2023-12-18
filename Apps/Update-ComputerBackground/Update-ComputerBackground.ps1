# PowerShell Script to Download, Set, and Clean Up Desktop Background

param(
    [string]$imageUrl,
    [switch]$Debug
)

# Debug log file path
$debugLogPath = "C:\ProgramData\IntuneBackgrounds\debugLog.txt"

# Function to write debug message
function Write-DebugLog {
    param(
        [string]$Message
    )

    if ($Debug) {
        Add-Content -Path $debugLogPath -Value "$(Get-Date -Format "yyyy-MM-dd HH:mm:ss"): $Message"
    }
}

# Start logging if Debug is enabled
if ($Debug) {
    "Script execution started with debug mode." | Out-File -FilePath $debugLogPath
}

# Exit if no URL is provided
if (-not $imageUrl) {
    Write-Host "No image URL provided."
    Write-DebugLog "Script execution completed"
    exit 2
}

# Check if the URL is a JPEG or PNG image
if (-not ($imageUrl -match "\.(jpg|jpeg|png)$")) {
    Write-Host "The provided URL does not point to a valid JPEG or PNG image."
    Write-DebugLog "Script execution completed"
    exit 3
}

# Specify the local path in a common directory accessible to all users
$localImageName = [System.IO.Path]::GetFileName($imageUrl)
$folderPath = "C:\ProgramData\IntuneBackgrounds"
$localImagePath = Join-Path $folderPath $localImageName

# Create the IntuneBackgrounds folder in ProgramData if it doesn't exist
if (-not (Test-Path -Path $folderPath)) {
    New-Item -Path $folderPath -ItemType Directory
    Write-DebugLog "Created IntuneBackgrounds folder"
} else {
    # Remove previous images if they exist
    Get-ChildItem -Path $folderPath | Where-Object { $_.Extension -match "jpg|jpeg|png" -and $_.Name -ne $localImageName } | Remove-Item -Force
    Write-DebugLog "Deleted all files in IntuneBackgrounds folder"
}

function Get-Image {
    param(
        [string]$Url,
        [string]$Path
    )

    try {
        Invoke-WebRequest -Uri $Url -OutFile $Path
        Write-DebugLog "Downloaded image file"
    } catch {
        Write-Host "Error in downloading the image."
        Write-DebugLog "Script execution completed"
        exit 4
    }
}

function Set-DesktopBackground {
    param(
        [string]$Path
    )

    if (-not ([System.Management.Automation.PSTypeName]'Wallpaper').Type) {
        Add-Type -TypeDefinition @"
        using System;
        using System.Runtime.InteropServices;

        public class Wallpaper {
            [DllImport("user32.dll", CharSet = CharSet.Auto)]
            public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
        }
"@
    }

    try {
        $SPI_SETDESKWALLPAPER = 0x0014
        $SPIF_UPDATEINIFILE = 0x01
        $SPIF_SENDCHANGE = 0x02

        [Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $Path, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE)
        Write-DebugLog "Set desktop wallpaper"
    } catch {
        Write-Host "Error in setting the desktop background."
        Write-DebugLog "Script execution completed"
        exit 5
    }
}


if (-not (Test-Path -Path $localImagePath)) {
    Get-Image -Url $imageUrl -Path $localImagePath
}

Set-DesktopBackground -Path $localImagePath

# End of the script
Write-DebugLog "Script execution completed"

exit 0
