# Detect-WindowsBingSearch.ps1
# Checks if BingSearchEnabled is properly configured in Windows.
# JSASD Technology Department

########################
# CHANGE THE FOLLOWING #
########################

$registryPath = "HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search"
$valueName = "BingSearchEnabled"
$desiredValue = 0

#########################
# DO NOT TOUCH THE REST #
#########################

# Fetch registry value
$currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue).$valueName

# Check if value matches the desired setting
if ($currentValue -eq $desiredValue) {
    Exit 0 # Settings are correct
} else {
    Exit 1 # Settings are incorrect, remediation needed
}