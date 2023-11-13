# v1.0
# REmove-PrinterDriver.ps1
# Removes the HP Universal PCL 6 v7.0.1 driver to Windows
# JSASD Technology Department

# Define the printer driver name as a variable
$PrinterDriverName = "HP Universal Printing PCL 6 (v7.0.1)"

# Check if the printer driver is installed
if (Get-PrinterDriver -Name $PrinterDriverName -ErrorAction SilentlyContinue) {
    Write-Host "Printer driver '$PrinterDriverName' is found. Proceeding with uninstallation..."

    # Remove the printer driver
    try {
        Remove-PrinterDriver -Name $PrinterDriverName -ErrorAction Stop
        Write-Host "Printer driver '$PrinterDriverName' has been removed."
    } catch {
        Write-Error "Failed to remove the printer driver. Error: $_"
    }
} else {
    Write-Host "Printer driver '$PrinterDriverName' not found. No action required."
}

# At the end of the script
if ($LASTEXITCODE -eq 0) {
    exit 0  # Success
} else {
    exit 1605  # Generic error code for uninstallation failure
}