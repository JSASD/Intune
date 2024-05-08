# Json file to check against
$jsonFile = "$($ENV:LOCALAPPDATA)\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\app_settings.json"

# Read and convert the JSON file to a PowerShell object
$jsonData = Get-Content -Path $jsonFile -Raw | ConvertFrom-Json

# Check if 'open_app_in_background' is true
if ($jsonData.PSObject.Properties.Name -contains 'open_app_in_background' -and $jsonData.open_app_in_background -eq $true) {
    Write-Output "The 'open_app_in_background' property is correctly set to true."
    exit 0
} else {
    Write-Output "The 'open_app_in_background' property is not set to true or is missing."
    exit 1
}