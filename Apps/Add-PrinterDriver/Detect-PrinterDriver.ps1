# v1.0
# Detect-PrinterDriver.ps1
# Detects if the HP Universal PCL 6 v7.0.1 driver is added to Windows
# JSASD Technology Department

$PrinterDriverName = "Print Driver Name"

$driverInstalled = Get-PrinterDriver -Name $PrinterDriverName -ErrorAction SilentlyContinue
if ($driverInstalled) {
    Write-Host "Installed"
    exit 0  # Indicates presence of the driver
} else {
    Write-Host "Not installed"
    exit 1  # Indicates the driver is not installed
}
