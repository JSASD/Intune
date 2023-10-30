param($printServer, $printerName)

Write-Host "Printer to remove: $printerName"
Write-Host ""
Write-Host "Removing Printer"
Remove-Printer -Name "\\$printServer\$printerName"