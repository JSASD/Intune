# TeamsOpenInBackground
These scripts will change the Teams configuration file for the local user to either open in the background, or in the foreground.
 - Default for new installations is to open in the foreground.

# Script process
Both of these scripts will:
 - Check if Teams is already running.
 - Stop teams if so.
 - Change the configuration file in the user's `appdata` folder according to the script that is running
   - If running `Enable-TeamsOpenInBackground.ps1`, the key `"open_app_in_background"` is set to `true`
   - If running `Disable-TeamsOpenInBackground.ps1`, the key `"open_app_in_background"` is set to `false`
 - Restart the Teams app if it was running previously.