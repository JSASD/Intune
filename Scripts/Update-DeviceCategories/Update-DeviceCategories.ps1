# Update-DeviceCategories.ps1
# Bulk updates Intune managed device categories
# JSASD Technology Department

#=======================User Input Start============================================================================
param (
    [Parameter(Mandatory=$true, ParameterSetName="Run")]
    [string]$csvFilePath,
    [string]$deviceCategory,    
    
    [string]$successLogFilePath = "c:\windows\temp\success.log",
    [string]$skippedLogFilePath = "c:\windows\temp\skipped.log",

    [Parameter(Mandatory=$false, ParameterSetName="Help")]
    [switch]$h
)
#=======================User Input End==============================================================================

function Show-Help {
    "Usage:"
    "    .\YourScriptName.ps1 -csvFilePath <path_to_csv>"
    "Parameters:"
    "    -csvFilePath         The path to the CSV file to process. [Required]"
    "    -deviceCategory      The category ID to apply to the device [Required]"
    "    -successLogFilePath  The path to the success log file. [Optional]"
    "    -skippedLogFilePath   The path to the skip log file. [Optional]"
    "    -h                   Shows this help message."
    exit
}

if ($PSCmdlet.ParameterSetName -eq "Help") {
    Show-Help
    exit
}


Clear-Host
Set-ExecutionPolicy -ExecutionPolicy 'ByPass' -Scope 'Process' -Force -ErrorAction 'Stop' 
$error.clear()


# Begin actions
Write-Host "========= Begin bulk update actions ================"
Write-Host ""


# Check if MSGraph module is installed
$MGIModule = Get-module -Name "Microsoft.Graph.Intune" -ListAvailable
Write-Host "Checking Microsoft.Graph.Intune is Installed or Not" -ForegroundColor Yellow
If ($MGIModule -eq $null) {
    Write-Host "Microsoft.Graph.Intune module is not Installed" -ForegroundColor Yellow
    Write-Host "Installing Microsoft.Graph.Intune module" -ForegroundColor Yellow
    Install-Module -Name Microsoft.Graph.Intune -Force
    Write-Host "Microsoft.Graph.Intune successfully Installed" -ForegroundColor Green
    Write-Host "Importing Microsoft.Graph.Intune module" -ForegroundColor Yellow
    Import-Module Microsoft.Graph.Intune -Force
}
ELSE 
{
    Write-Host "Microsoft.Graph.Intune is Installed" -ForegroundColor Green
    Write-Host "Importing Microsoft.Graph.Intune module" -ForegroundColor Yellow
    Import-Module Microsoft.Graph.Intune -Force
}


# Connect to Microsoft Graph
Connect-MSGraph -Quiet
Update-MSGraphEnvironment -SchemaVersion 'beta' -Quiet


# Check if the success and skipped log files exist, create them if not
if (-not (Test-Path $successLogFilePath)) {
    New-Item -Path $successLogFilePath -ItemType File
}

if (-not (Test-Path $skippedLogFilePath)) {
    New-Item -Path $skippedLogFilePath -ItemType File
}


# Import the CSV file and ensure its always treated as an array
$csvData = @(Import-Csv $csvFilePath)


# Check if CSV data has been imported and has rows
if ($csvData.Count -eq 0) {
    Write-Host "The CSV file seems to be empty or the data isn't formatted as expected. Exiting script." -ForegroundColor Red
    exit
}


# Get Intune managed devices
$intuneDevices = (Invoke-MSGraphRequest -HttpMethod GET -Url 'deviceManagement/managedDevices').value


# Create a progress bar
$progress = 1
Write-Host ""
Write-Host "Total Device count in CSV file for updating device category: "$csvData.Count"" -ForegroundColor White
Write-Host ""


# Initialize success and skipped logs
$successLog = @()
$skippedLog = @()


# Function to set Category on a device
function Set-DeviceCategory 
{
    param(
    [Parameter(Mandatory)]
    [string]$DeviceID,
    [Parameter(Mandatory)]
    [string]$DeviceCategory

    )
    Write-Host "Setting device category: $DeviceCategory, for device: $DeviceID"
    $body = @{ '@odata.id' = "https://graph.microsoft.com/beta/deviceManagement/deviceCategories/$DeviceCategory" }
    Invoke-MSGraphRequest -HttpMethod PUT -Url "deviceManagement/managedDevices/$DeviceID/deviceCategory/`$ref" -Content $body

}


foreach ($row in $csvData)
{
    $serialNumber = $row.SerialNumber

    $deviceToModify = $intuneDevices | Where-Object { $_.serialNumber -eq $serialNumber }

    if ($deviceToModify) {
        Write-Host "$progress = Matched, updating the new Category for Serial Number: $serialNumber"
        Set-DeviceCategory -DeviceID $deviceToModify.id -DeviceCategory $deviceCategory
        Write-Host "$progress = Found and updated device category for Serial Number: $serialNumber"
        $successLog += "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Updated device category for Serial Number: $serialNumber"
    }
    else {
        Write-Host "$progress = Skipping as Serial Number is not found in list of managed devices. Serial: $serialNumber"
        $skippedLog += "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Skipping as Serial Number not found in Intune Autopilot Service: $serialNumber"
    }
    $progress++
    if ($csvData.count -gt 0) {
        $percentComplete = [math]::Round((($progress-1) / $csvData.count) * 100, 2)
        Write-Progress -Activity "Updating Group Tag for $progress --> $serialNumber" -Status "Progress: $percentComplete% Complete" -PercentComplete $percentComplete
    } else {
        Write-Host "CSV data is empty, cannot proceed with progress calculation."
    }
}


Write-Host "========= Bulk update actions complete ======================"


# Display total devices, total successes, and total failures
Write-Host  " "
Write-Host "========= Results ======================================================="
Write-Host  " "
Write-Host "Total Devices: "$csvData.count" " -ForegroundColor white
Write-Host "Total Successes: "$successLog.count"" -ForegroundColor Green
Write-Host "Total Skipped: "$skippedLog.count"" -ForegroundColor yellow
Write-Host  " "
Write-Host "======== End Results =========================================================="
Write-Host  " "


# Save success and skipped logs to separate files
$successLog | Out-File -FilePath $successLogFilePath
$skippedLog | Out-File -FilePath $skippedLogFilePath