# Remove-PointAndPrintRestriction.ps1
# Unsets the Point And Print Restriction made with Install-PointAndPrintRestriction.ps1
# JSASD Technology Department

# Registry variables
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
$valueName = "RestrictDriverInstallationToAdministrators"
$dataValue = 1

# Add or update the registry value
Set-ItemProperty -Path $registryPath -Name $valueName -Value $dataValue -Type DWord
Write-Host "Registry value has been set."