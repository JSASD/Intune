# Set-AutoLogon.ps1
# Creates / modifies registry values to enable AutoLogon in Windows.
# USE CAUTION as the username / password is stored in plain text in the registry
# JSASD Technology Department

# Path to the registry key
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

# Remove AutoLogon registry values
Remove-ItemProperty -Path $registryPath -Name "DefaultPassword" -ErrorAction SilentlyContinue
Remove-ItemProperty -Path $registryPath -Name "DefaultUsername" -ErrorAction SilentlyContinue
Set-ItemProperty -Path $registryPath -Name "DefaultDomainName" -Value ""
Set-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -Value "0"

Write-Host "AutoLogon settings have been reset."