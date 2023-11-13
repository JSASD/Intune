# Add-PrinterDriver
Adds the `HP Universal` print driver to the Windows Driver Store and installs the `HP Universal Printing PCL 6 (v7.0.1)` driver

# Usage
This script can be run as is, provided it is in the same directory as the included `HpUniversal` folder.

Other drivers can be used by modifying the scripts variables.

## Modifiable variables
 - `$FolderName`: The folder path relative to the scripts location, without leading and trailing slashes (`/`)
 - `$FileName`: The file name of the `.inf` file to use for driver store importing
 - `$PrinterDriverName`: The name of the driver from the `.inf` file

# Adding to Intune
 - Use the [Microsoft-Win32-Content-Prep-Tool](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool) to package this directory into a `.intunewin` file
 - Fill in the app information as necessary
 - In **Program**
   - `Install command`: `PowerShell.exe -ExecutionPolicy Bypass -File "Add-PrinterDriver.ps1"`
   - `Uninstall command`: `PowerShell.exe -ExecutionPolicy Bypass -File "Remove-PrinterDriver.ps1"`
   - Return codes:
     - `0`: `Success`
     - `1603`: `Failed`