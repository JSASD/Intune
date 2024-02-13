# Install-PointAndPrintRestriction.ps1
# Changes the Point And Print Restriction on Windows to allow / disallow non-admin driver installs
# JSASD Technology Department

# Registry variables
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
$valueName = "RestrictDriverInstallationToAdministrators"
$dataValue = 0

# Check if the registry path exists, if not, create it
if (-Not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force
}

# Add or update the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $dataValue -Type DWord
Write-Host "Registry value has been set."