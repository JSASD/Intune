# Test-PointAndPrintRestriction.ps1
# Tests the point and print restrition to check for a value match from Install-PointAndPrintRestriction.ps1
# JSASD Technology Department

# Detection Script
$registryPath = "HKLM:\Software\Policies\Microsoft\Windows NT\Printers\PointAndPrint"
$valueName = "RestrictDriverInstallationToAdministrators"
$dataValue = 0 # The expected value

# Check if the value exists and is set correctly
if ((Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue).$valueName -eq $dataValue) {
    Write-Host "Registry value is set correctly."
    exit 0
} else {
    Write-Host "Registry value is not set or not set correctly."
    exit 1
}