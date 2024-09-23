# Set-AutoLogon.ps1
# Creates / modifies registry values to enable AutoLogon in Windows.
# USE CAUTION as the username / password is stored in plain text in the registry
# JSASD Technology Department

########################
# CHANGE THE FOLLOWING #
########################

$defaultUsername = "yourUsername"
$defaultPassword = "yourPassword"
$defaultDomain = "yourDomain"
$logFilePath = "C:\ProgramData\Set-AutoLogon\autologon.log"

#########################
# DO NOT TOUCH THE REST #
#########################

# Ensure the log directory exists
if (-not (Test-Path "C:\ProgramData\Set-AutoLogon")) {
    New-Item -ItemType Directory -Path "C:\ProgramData\Set-AutoLogon"
    Add-Content -Path $logFilePath -Value "Log directory created."
}

# Logging function
function Write-Log {
    Param ([string]$message)
    Add-Content -Path $logFilePath -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss'): $message"
}

try {
    # Using reg add to ensure registry settings are applied correctly
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v AutoAdminLogon /t REG_SZ /d 1 /f | Out-String | ForEach-Object { Write-Log $_ }
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultUsername /t REG_SZ /d $defaultUsername /f | Out-String | ForEach-Object { Write-Log $_ }
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultPassword /t REG_SZ /d $defaultPassword /f | Out-String | ForEach-Object { Write-Log $_ }
    reg add "HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon" /v DefaultDomainName /t REG_SZ /d $defaultDomain /f | Out-String | ForEach-Object { Write-Log $_ }

    Write-Log "All AutoLogon registry values have been successfully set."
} catch {
    Write-Log "Failed to set registry values: $_"
    Exit 1 # Exit indicating a failure
}

# Verification step can also be added here if needed.
