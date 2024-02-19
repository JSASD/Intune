# Update-DeviceCategories
Updates the device category fields in mass for managed Intune devices. Uses the serial number to match the device, and updates the category field if it exists.

Useful for already deployed laptops, where device categories are utilized and you want to ensure the correct category is set on a known list of serial numbers.
<br>

# Usage
## Prep the CSV file
As of now, the CSV file only contains one column: `SerialNumber`.

All rows will need to have one serial number. So the file should just be a list of serials, with `SerialNumber` at the top. Ex:

```csv
SerialNumber
Serial1
Serial2
Serial3
Serial4
```
## Install required module
The Microsoft Graph Intune module is required for this script.

Install it with
```powershell
# Must be run in PowerShell 5
Install-Module Microsoft.MSGraph.Intune
```

## Get the device category ID from the Graph API
 - Open PowerShell 5 or lower (PowerShell 7 will *NOT* work).
 - Run the following commands:
```powershell
Connect-MSGraph
(Invoke-MSGraphRequest -HttpMethod GET -Url "https://graph.microsoft.com/beta/deviceManagement/deviceCategories").value
```
 - This will output a list of available device categories for your Tenant
 - Copy the ID for the next part

## Run the script
`cd` into the directory containing the script.

Run the script with the required arguments: `-csvFilePath` and `-deviceCategory`.
  - The CSV file path needs to be the direct path to the location of the CSV file, it cannot be relative.
  - The device category needs to be the ID copied from the last section

The script will run, and let you know how many were successful, and how many were skipped (not found).

## Logging
The default logging locations are:
 - Success Log: `C:\windows\temp\success.log`
 - Skip Log: `C:\windows\temp\skipped.log`

## Other command-line parameters
There are other parameters available. To see them, run:
```powershell
.\Update-DeviceCategories.ps1 -h
```