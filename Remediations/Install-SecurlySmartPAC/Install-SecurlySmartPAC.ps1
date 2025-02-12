# Install-SecurlySmartPAC.ps1
# Installs the Smart PAC for the current user.
# JSASD Technology Department

# Retrieve the current username without the domain
$currentUserFull = [System.Security.Principal.WindowsIdentity]::GetCurrent().Name
$username = $currentUserFull.Split('\')[-1]
$filterID = securly@yourdomain.com

# Define the registry path and key name
$registryPath = "HKCU:\Software\Microsoft\Windows\CurrentVersion\Internet Settings"
$keyName = "AutoConfigURL"

# Construct the expected value for the registry key with the username embedded in the URL
$expectedValue = "https://useast2-www.securly.com/smart.pac?fid=$filterID&user=$username@jsasd.org"

# Retrieve the current value, if it exists
$currentValue = (Get-ItemProperty -Path $registryPath -Name $keyName -ErrorAction SilentlyContinue).$keyName

# Check if the key exists and has the correct value
if ($currentValue -eq $expectedValue) {
    Write-Output "The registry key '$keyName' already exists and has the correct value."
} else {
    # Set or update the registry key value
    Set-ItemProperty -Path $registryPath -Name $keyName -Value $expectedValue -Type String
    Write-Output "Registry key '$keyName' set or updated with value: $expectedValue"
}