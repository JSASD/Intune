# Add-PrinterDriver
Adds a desired print driver via `.inf` file from a network share.


# Usage
3 variables need to be set in order to use this:
 - `$driverPath` [`Add-PrinterDriver.ps1`]
 - `$infFile` [`Add-PrinterDriver.ps1`]
 - `$PrinterDriverName` [`Add-PrinterDriver.ps1`, `Detect-PrinterDriver.ps1`, `Remove-PrinterDriver.ps1`]


# Adding to Intune
 - Use the [Microsoft-Win32-Content-Prep-Tool](https://github.com/Microsoft/Microsoft-Win32-Content-Prep-Tool) to package this directory into a `.intunewin` file
 - Fill in the app information as necessary
 - In **Program**
   - `Install command`: `PowerShell.exe -ExecutionPolicy Bypass -File "Add-PrinterDriver.ps1"`
   - `Uninstall command`: `PowerShell.exe -ExecutionPolicy Bypass -File "Remove-PrinterDriver.ps1"`
   - Return codes:
     - `0`: `Success`
     - `1603`: `Failed`
 - In **Detection rules**
   - `Rules format`: `Use a custom detection script`
     - `Script file`: *Upload the* `Detect-PrinterDriver.ps1` *file*
     - `Run script as 32-bit...`: `No`
     - `Enforce script signature...`: `No`