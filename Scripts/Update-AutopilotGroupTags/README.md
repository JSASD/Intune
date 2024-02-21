# Update-AutopilotGroupTags
Updates group tags in mass for the autopilot service. Uses the serial number to match the device, and updates the group tag accordingly.

Useful for new deployments where group tags are utilized to sort out devices by logical groups.
<br>

# Usage
## Prep the CSV file
Change the `serials.csv.example` file to `serials.csv` (or a preferred name).

All your CSV file needs is two columns: `SerialNumber` and `NewGroupTag`.

All rows will need to have information corresponding to existing devices added to Intune Autopilot, with their respective desired Group Tags.

## Install required module
The Microsoft Graph Intune modele is required for this script.

Install it with:
```powershell
# Must be run in PowerShell 5
Install-Module Microsoft.MSGraph.Intune
```

## Run the script
`cd` into the directory containing the script.

To receive a prompt to provide a CSV location, run it with:
```powershell
.\Update-AutopilotGroupTags.ps1
```

To run it with arguments:
```powershell
.\Update-AutopilotGroupTags.ps1 -c .\example.csv  # Make sure to replace "example.csv" with your actual CSV file
```

## Logging
The default logging locations are:
 - Success Log: `C:\windows\temp\success.log`
 - Failed Log: `C:\windows\temp\failed.log`

## Other command-line parameters
There are other parameters available, to see them, run:
```powershell
.\Update-AutopilotGroupTags.ps1 -h
```
