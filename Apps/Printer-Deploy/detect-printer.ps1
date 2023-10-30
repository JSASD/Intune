# Checks if given printer is installed on the system

$printServer = "myprint.server"
$printer = "MyPrinter-Share"

# Get list of printers, filter down to items where the name is \\$printServer\$printer
$printerList = Get-Printer | Where-Object { $_.Name -eq "\\$printServer\$printer"}

# If the $printerList variable contains nothing, the printer doesn't exist. Exit as unsuccessful (0).
If ($null -eq $printerList) {
    Write-Host "Printer not found. Exiting..."
    Exit 0
}
# If the $printerLis variable contains an object, the printer does exist. Exit as successful (1).
else {
    Write-Host "Printer found. Exiting..."
    Exit 1
}