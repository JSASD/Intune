# DetectionScript.ps1
# Checks if AutoLogon is properly configured in Windows.
# JSASD Technology Department

########################
# CHANGE THE FOLLOWING #
########################

$registryPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon"
$desiredAutoAdminLogon = "1"
$desiredUsername = "yourUsername"
$desiredDomain = "yourDomain"

#########################
# DO NOT TOUCH THE REST #
#########################

# Fetch registry values
$autoAdminLogon = (Get-ItemProperty -Path $registryPath -Name "AutoAdminLogon" -ErrorAction SilentlyContinue).AutoAdminLogon
$username = (Get-ItemProperty -Path $registryPath -Name "DefaultUsername" -ErrorAction SilentlyContinue).DefaultUsername
$domain = (Get-ItemProperty -Path $registryPath -Name "DefaultDomainName" -ErrorAction SilentlyContinue).DefaultDomainName

# Check if values match the desired settings
if ($autoAdminLogon -eq $desiredAutoAdminLogon -and $username -eq $desiredUsername -and $domain -eq $desiredDomain) {
    Exit 0 # Settings are correct
} else {
    Exit 1 # Settings are incorrect, remediation needed
}