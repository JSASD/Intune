# Json file to check against
$jsonFile = "$($ENV:LOCALAPPDATA)\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\app_settings.json"

# Parse JSON data
$jsonData = Get-Content $jsonFile -Raw | ConvertFrom-Json


# Check if Teams is running
$teamsRunning = Get-Process ms-teams* -ErrorAction SilentlyContinue

# Stop Teams if it is running
if ($teamsRunning) {
    $teamsRunning | Stop-Process
    Write-Output "Teams was running and has been stopped."
}


# Check the current value, modify if necessary
if ($jsonData.open_app_in_background -eq $true) {
    Write-Output "App already set to open in background."
} else {
    (Get-Content "$($ENV:LOCALAPPDATA)\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\app_settings.json").replace('"open_app_in_background":false', '"open_app_in_background":true') | Set-Content "$($ENV:LOCALAPPDATA)\Packages\MSTeams_8wekyb3d8bbwe\LocalCache\Microsoft\MSTeams\app_settings.json"
    Write-Output "Settings have been changed to open app in background."
}


# Restart Teams only if it was running before
if ($teamsRunning) {
    Set-Location ($ENV:USERPROFILE + '\AppData\Local\Microsoft\WindowsApps')
    Start-Process "ms-teams.exe"
    Write-Output "Teams has been restarted."
} else {
    Write-Output "Teams was not originally running, so it has not been restarted."
}
