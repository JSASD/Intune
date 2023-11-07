# Update-AutopilotGroupTags

# Getting started

## Install required module

Install the Microsoft Graph Intune module:
```powershell
Install-Module Microsoft.MSGraph.Intune
```

# Run the script
`cd` into the directory containing the script

To receive a prompt to provide a CSV location, run it with:
```powershell
.\Update-AutopilotGroupTags.ps1
```

To run it with arguments:
```powershell
.\Update-AutopilotGroupTags.ps1 -c .\example.csv  # Make sure to replace "example.csv" with your actual CSV file
```

## Other command line parameters
There are other parameters available, to see them, run:
```powershell
.\Update-AutopilotGroupTags.ps1 -h
```