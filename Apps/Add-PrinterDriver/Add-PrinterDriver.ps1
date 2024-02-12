# v2.0
# Add-PrinterDriver.ps1
# Adds the Konica Minolta 650iSeriesPCL Driver to Windows
# JSASD Technology Department


# THESE MUST BE SET
# Define the network path, file name, and printer driver name as variables
$driverPath = "\\server\share\folder"
$infFile = "printDriverFile.inf"
$PrinterDriverName = "Print Driver Name"


# Check if the printer driver is already installed
if (Get-PrinterDriver -Name $PrinterDriverName -ErrorAction SilentlyContinue) {
    Write-Host "Printer driver '$PrinterDriverName' is already installed."
} else {
    Write-Host "Driver path: $driverPath"

    # Attempt to add the driver to the driver store
    $addDriverResult = & pnputil.exe /add-driver "$driverPath\$infFile" *>&1
    Write-Host "pnputil output: $addDriverResult"

    if ($addDriverResult -match "Driver package added successfully.") {
        Write-Host "Driver package added successfully. Installing driver..."

        # Attempt to add the printer driver
        Add-PrinterDriver -Name $PrinterDriverName

        # Verify if the driver was successfully installed
        if (Get-PrinterDriver -Name $PrinterDriverName -ErrorAction SilentlyContinue) {
            Write-Host "Printer driver '$PrinterDriverName' installed successfully."
        } else {
            Write-Error "Failed to verify the installation of the printer driver."
        }
    } else {
        # Write an error if the driver was not added
        Write-Error "Failed to add the driver to the driver store."
    }
}

# At the end of the script
if ($LASTEXITCODE -eq 0) {
    exit 0  # Success
} else {
    exit 1603  # Generic error code for installation failure
}