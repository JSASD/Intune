$Version = "v1.3"
$Success = $false

$directory = "C:\ProgramData\Hide-TaskbarItems"
if (-not (Test-Path $directory)) {
    New-Item -ItemType Directory -Path $directory
}

function Write-Log {
    param ([string]$Message)
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    "$timestamp - $Message" | Out-File -FilePath "$Directory\Detection.txt" -Append
}

Write-Log "Starting detection script $Version"

function Test-RegistryValue {
    param (
        [parameter(Mandatory=$true)]$Path,
        [parameter(Mandatory=$true)]$Value
    )
    
    try {
        Get-ItemProperty -Path $Path | Select-Object -ExpandProperty $Value -ErrorAction Stop | Out-Null
        return $true
    } catch {
        return $false
    }
}

$regPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion"
$checks = @(
    @{ Path="$regPath\Explorer\Advanced"; Value="ShowTaskViewButton"; Message="Task view active." },
    @{ Path="$regPath\Explorer\Advanced"; Value="TaskbarDa"; Message="Widgets button active" },
    @{ Path="$regPath\Search"; Value="SearchboxTaskbarMode"; Message="Search active" }
)

foreach ($check in $checks) {
    if (Test-RegistryValue -Path $check.Path -Value $check.Value) {
        if ((Get-ItemProperty -Path $check.Path | Select-Object -ExpandProperty $check.Value) -eq 0) {
            $Success = $true
        } else {
            Write-Log $check.Message
            exit 1
        }
    } else {
        Write-Log "$($check.Message) - Not found"
        exit 1
    }
}

if ($Success) {
    Write-Log "Detection script found all required settings, exiting."
    exit 0
}
