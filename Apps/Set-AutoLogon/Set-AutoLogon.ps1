# Set-AutoLogon.ps1
# Creates / modifies registry values to enable AutoLogon in Windows.
# USE CAUTION as the username / password is stored in plain text in the registry
# JSASD Technology Department

########################
# CHANGE THE FOLLOWING #
########################

# Set the credentials and domain directly in the script
$defaultUsername = "yourUsername"
$defaultPassword = "yourPassword"
$defaultDomain = "yourDomain"

#########################
# DO NOT TOUCH THE REST #
#########################


# Path to the registry key
$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"

# Set registry values
Set-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -Value "1"
Set-ItemProperty -Path $registryPath -Name "DefaultUsername" -Value $defaultUsername
Set-ItemProperty -Path $registryPath -Name "DefaultPassword" -Value $defaultPassword
Set-ItemProperty -Path $registryPath -Name "DefaultDomainName" -Value $defaultDomain

Write-Host "AutoLogon registry values have been set."
