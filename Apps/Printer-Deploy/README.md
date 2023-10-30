# Printer-Deploy
Deploys a printer using PowerShell and a few arguments

## deploy-printer.ps1
### Required arguments
 - `-printServer`: Print server to add from
   - This must be a DNS name, such as `printserver.company.com`
 - `-printerName`: Name of shared printer on server

### Optional arguments
 - `-setDefaultPrinter`: Boolean. Defaults `$false`, set this to `$true` if you want to set the installed printer as default

## undeploy-printer.ps1
### Required arguments
 - `-printServer`: Print server attached to the printer to remove
   - This must be a DNS name, such as `printserver.company.com`
 - `-printerName`: Name of shared printer on server

## detect-printer.ps1
### Required changes
 - You must change the server name and printer name to match as command line arguments cannot be passed for Intune detection scripts.