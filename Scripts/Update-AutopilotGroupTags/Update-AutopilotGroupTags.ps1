# Update-AutopilotGroupTags.ps1
# Bulk updates Autopilot Device Group Tags
# JSASD Technology Department

#=======================User Input Start============================================================================
param (
    [Parameter(Mandatory=$true, ParameterSetName="Run")]
    [string]$csvFilePath,
    
    [string]$successLogFilePath = "c:\windows\temp\success.log",
    [string]$failedLogFilePath = "c:\windows\temp\failed.log",

    [Parameter(Mandatory=$false, ParameterSetName="Help")]
    [switch]$h
)
#=======================User Input End==============================================================================
 
function Show-Help {
    "Usage:"
    "    .\YourScriptName.ps1 -csvFilePath <path_to_csv>"
    "Parameters:"
    "    -csvFilePath         The path to the CSV file to process. [Required]"
    "    -successLogFilePath  The path to the success log file. [Optional]"
    "    -failedLogFilePath   The path to the failure log file. [Optional]"
    "    -h                   Shows this help message."
    exit
}

if ($PSCmdlet.ParameterSetName -eq "Help") {
    Show-Help
    exit
}


Clear-Host
Set-ExecutionPolicy -ExecutionPolicy 'ByPass' -Scope 'Process' -Force -ErrorAction 'Stop' 
$error.clear() ## this is the clear error history 


Write-Host "========= Begin bulk update actions ================"
Write-Host ""


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
Update-MSGraphEnvironment -SchemaVersion "Beta" -Quiet


# Check if the success and failed log files exist, create them if not
if (-not (Test-Path $successLogFilePath)) {
    New-Item -Path $successLogFilePath -ItemType File
}

if (-not (Test-Path $failedLogFilePath)) {
    New-Item -Path $failedLogFilePath -ItemType File
}


# Import the CSV file and ensure it's always treated as an array
$csvData = @(Import-Csv -Path $csvFilePath)


# Check if CSV data has been imported and has rows
if ($csvData.Count -eq 0) {
    Write-Host "The CSV file seems to be empty or the data isn't formatted as expected. Exiting script." -ForegroundColor Red
    exit
}



# Get Windows Autopilot device identities
$autopilotDevices = Invoke-MSGraphRequest -HttpMethod GET -Url "deviceManagement/windowsAutopilotDeviceIdentities" | Get-MSGraphAllPages


# Create a progress bar
$progress = 1
Write-Host ""
Write-Host "Total Device count in CSV file for updating Group Tag : "$csvData.count"" -ForegroundColor White
Write-Host ""


# Initialize success and failed logs
$successLog = @()
$failedLog = @()


foreach ($row in $csvData) {
    $serialNumber = $row.SerialNumber
    $groupTag = $row.NewGroupTag

    $autopilotDevice = $autopilotDevices | Where-Object { $_.serialNumber -eq $serialNumber }

    if ($autopilotDevice) {
        Write-Host "$progress = Matched, updating New Group Tag for serial number: $serialNumber" -ForegroundColor Yellow
        $autopilotDevice.groupTag = $groupTag  
        $requestBody =
@"
{
groupTag:`"$($autopilotDevice.groupTag)`"
}
"@
        $Url = "deviceManagement/windowsAutopilotDeviceIdentities/$($autopilotDevice.id)/UpdateDeviceProperties"
        Invoke-MSGraphRequest -HttpMethod POST -Content $requestBody -Url $url
        Write-Host "$progress = Updated New Group Tag for Serial Number: $serialNumber = '$groupTag' (✅)" -ForegroundColor Green
        Write-Host  " "
        # Log success
        $successLog += "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Updated Group Tag for Serial Number: $serialNumber  = '$groupTag' "
        
    } else {
        Write-Host "$progress = Skipping as Serial Number not found in Intune Autopilot Service: $serialNumber (X)" -ForegroundColor Red
        Write-Host  " "
        
        # Log failure
        $failedLog += "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') Skipping as Serial Number not found in Intune Autopilot Service: $serialNumber"
        
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
Write-Host "Total Failures: "$failedLog.count"" -ForegroundColor red
Write-Host  " "
Write-Host "======== End Results =========================================================="
Write-Host  " "


# Save success and failed logs to separate files
$successLog | Out-File -FilePath $successLogFilePath
$failedLog | Out-File -FilePath $failedLogFilePath


Write-Host  " "
Write-Host "Success log saved to $successLogFilePath."
Write-Host "Failed log saved to $failedLogFilePath."