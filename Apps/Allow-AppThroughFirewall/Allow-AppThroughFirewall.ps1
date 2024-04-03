# Allow-AppThroughFirewall.ps1
# Allow a given app through the windows firewall
# JSASD Technology Department

# User input parameters
param (
    [Parameter(Mandatory=$true, ParameterSetName="Run")]
    [string]$appName,
    [string]$appPath,

    [Parameter(Mandatory=$false, ParameterSetName="Help")]
    [switch]$h
)

# Help message
function Show-Help {
    "Usage:"
    "    .\Allow-AppThroughFirewall.ps1 -appName ""Name of your app"" -appPath ""C:\ProgramFiles\App\App.exe"""
    "Parameters:"
    "    -appName       Name of the app to allow through the firewall [Required]"
    "    -appPath       Path to the exe file of the app [Required]"
    "    -h             Shows this help message [Optional]"
}
if($PSCmdlet.ParameterSetName -eq "Help") {
    Show-Help
    exit
}


Set-ExecutionPolicy -ExecutionPolicy 'Bypass' -Scop 'Process' -Force -ErrorAction 'Stop'

# Create rule
New-NetFirewallRule -DisplayName "$appName" -Direction Inbound -Program "$appPath" -Action Allow