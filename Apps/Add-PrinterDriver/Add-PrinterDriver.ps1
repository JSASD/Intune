# v1.0
# Add-PrinterDriver.ps1
# Adds the HP Universal PCL 6 v7.0.1 driver to Windows
# JSASD Technology Department

# Define the folder, file name, and printer driver name as variables
$FolderName = "HpUniversal"
$FileName = "hpcu255u.inf"
$PrinterDriverName = "HP Universal Printing PCL 6 (v7.0.1)"

# Check if the printer driver is already installed
if (Get-PrinterDriver -Name $PrinterDriverName -ErrorAction SilentlyContinue) {
    Write-Host "Printer driver '$PrinterDriverName' is already installed."
} else {
    # Construct the full path to the driver file
    $driverPath = Join-Path -Path $PSScriptRoot -ChildPath $FolderName
    $driverPath = Join-Path -Path $driverPath -ChildPath $FileName

    Write-Host "Driver path: $driverPath"

    # Attempt to add the driver to the driver store
    $addDriverResult = & pnputil.exe /add-driver $driverPath

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