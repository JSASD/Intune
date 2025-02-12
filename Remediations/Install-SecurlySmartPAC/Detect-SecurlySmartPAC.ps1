# Detect-SecurlySmartPAC.ps1
# Checks if the Smart PAC is configured for the current user.
# JSASD Technology Department

# Define the registry path and key name
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$keyName = "AutoConfigURL"

# Retrieve the current username without the domain
$currentUserFull = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$username = $currentUserFull.Split('\')[-1]

# Construct the expected value for the registry key with the username embedded in the URL
$expectedValue = "https://useast2-www.securly.com/smart.pac?fid=securly@jsasd.org&user=$username@jsasd.org"

# Retrieve the current value of the registry key, if it exists
$currentValue = (Get-ItemProperty -Path $registryPath -Name $keyName -ErrorAction SilentlyContinue).$keyName

# Check if the key exists and has the correct value
if ($currentValue -eq $expectedValue) {
    Write-Output "Compliant"
    exit 0 # Exit code 0 for compliance in Intune
} else {
    Write-Output "Non-compliant"
    exit 1 # Exit code 1 for non-compliance in Intune
}
