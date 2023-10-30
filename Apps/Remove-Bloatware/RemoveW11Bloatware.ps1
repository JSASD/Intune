$Version = "v1.1"

# Remove Microsoft bloatware/crapware
# Original file https://gist.github.com/mark05e/a79221b4245962a477a49eb281d97388#file-remove-hpbloatware-ps1 
# and modified by Jeroen Burgerhout (@BurgerhoutJ)
# modified for JSASD by Quinn Henry

# Custom logging function
function Write-Log {
    param (
        [Parameter(Mandatory=$true)]
        [string] $Message
    )

    $logFilePath = "$($env:ProgramData)\Microsoft\RemoveW11Bloatware\RemoveW11Bloatware.log"
    Add-Content -Path $logFilePath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): $Message"
}

Write-Log -Message "RemoveW11Bloatware.ps1 - $Version"

# Create a tag file just so Intune knows this was installed
if (-not (Test-Path "$($env:ProgramData)\Microsoft\RemoveW11Bloatware"))
{
    New-Item -ItemType Directory -Force -Path "$($env:ProgramData)\Microsoft\RemoveW11Bloatware" > $null
}
Set-Content -Path "$($env:ProgramData)\Microsoft\RemoveW11Bloatware\RemoveW11Bloatware.ps1.tag" -Value "Installed"

# List of built-in apps to remove
$UninstallPackages = @(
    "Clipchamp.Clipchamp"
    "Microsoft.BingNews"
    "Microsoft.BingWeather"
    "Microsoft.Getstarted"
    "Microsoft.GetHelp"
    "Microsoft.MicrosoftOfficeHub"
    "Microsoft.MicrosoftSolitaireCollection"
    "Microsoft.Paint"
    "Microsoft.People"
    "Microsoft.PowerAutomateDesktop"
    "Microsoft.windowscommunicationsapps"
    "Microsoft.WindowsFeedbackHub"
    "Microsoft.WindowsMaps"
    "Microsoft.Xbox.TCUI"
    "Microsoft.XboxGameCallableUI"
    "Microsoft.XboxGameOverlay"
    "Microsoft.XboxGamingOverlay"
    "Microsoft.XboxIdentityProvider"
    "Microsoft.XboxSpeechToTextOverlay"
    "Microsoft.YourPhone"
    "Microsoft.ZuneMusic"
    "Microsoft.ZuneVideo"
    "MicrosoftTeams"
    "Microsoft.GamingApp"
)

# List of programs to uninstall
$UninstallPrograms = @(
)

$InstalledPackages = Get-AppxPackage -AllUsers | Where {($UninstallPackages -contains $_.Name)}
$ProvisionedPackages = Get-AppxProvisionedPackage -Online | Where {($UninstallPackages -contains $_.DisplayName)}
$InstalledPrograms = Get-Package | Where {$UninstallPrograms -contains $_.Name}

# Print a warning for not found apps
$UninstallPackages | ForEach {
    if (($_ -notin $InstalledPackages.Name) -and ($_ -notin $ProvisionedPackages.DisplayName)) {
        Write-Log -Message "Warning: App not found: [$_]"
    }
}

# Remove provisioned packages first
ForEach ($ProvPackage in $ProvisionedPackages) {

    Write-Log -Message "Attempting to remove provisioned package: [$($ProvPackage.DisplayName)]..."

    Try {
        Remove-AppxProvisionedPackage -PackageName $ProvPackage.PackageName -Online -ErrorAction Stop > $null
        Write-Log -Message "Successfully removed provisioned package: [$($ProvPackage.DisplayName)]"
    }
    Catch {
        Write-Log -Message "Warning: Failed to remove provisioned package: [$($ProvPackage.DisplayName)]"
    }
}

# Remove appx packages
ForEach ($AppxPackage in $InstalledPackages) {

    Write-Log -Message "Attempting to remove Appx package: [$($AppxPackage.Name)]..."

    Try {
        Remove-AppxPackage -Package $AppxPackage.PackageFullName -AllUsers -ErrorAction Stop > $null
        Write-Log -Message "Successfully removed Appx package: [$($AppxPackage.Name)]"
    }
    Catch {
        Write-Log -Message "Warning: Failed to remove Appx package: [$($AppxPackage.Name)]"
    }
}

# Remove installed programs
$InstalledPrograms | ForEach {

    Write-Log -Message "Attempting to uninstall: [$($_.Name)]..."

    Try {
        $_ | Uninstall-Package -AllVersions -Force -ErrorAction Stop > $null
        Write-Log -Message "Successfully uninstalled: [$($_.Name)]"
    }
    Catch {
        Write-Log -Message "Warning: Failed to uninstall: [$($_.Name)]"
    }
}