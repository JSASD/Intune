# Set-WindowsBingSearch.ps1
# Configures BingSearchEnabled in Windows.
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

# Create the registry key if it doesn't exist
if (-not (Test-Path $registryPath)) {
    New-Item -Path $registryPath -Force | Out-Null
}

# Set the registry value
New-ItemProperty -Path $registryPath -Name $valueName -Value $desiredValue -PropertyType DWord -Force | Out-Null

# Verify the value was set correctly
$currentValue = (Get-ItemProperty -Path $registryPath -Name $valueName -ErrorAction SilentlyContinue).$valueName

if ($currentValue -eq $desiredValue) {
    Exit 0 # Remediation successful
} else {
    Exit 1 # Remediation failed
}