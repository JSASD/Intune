param($printServer, $printerName, $setDefaultPrinter=$false)

Write-Host "Adding Printer"
Add-Printer -ConnectionName "\\$printServer\$printerName"

Write-Host ""

# Set default printer if $setDefaultPrinter is $true
If ($setDefaultPrinter -eq $true) {
    Write-Host "Setting default printer"
    (Get-WmiObject -class win32_printer -Filter "ShareName='$printerName'")
}