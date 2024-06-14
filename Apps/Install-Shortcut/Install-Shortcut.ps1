# Install-Shortcut.ps1
# Creates a Windows shortcut to anything you want, placing it on the public desktop
# JSASD Technology Department


########################
# CHANGE THE FOLLOWING #
########################

# Paths
## Where the shortcut will be stored and named
$ShortcutName = "Name of shortcut.lnk"
## Where the shortcut points to
$TargetPath = "https://path/to/your/link"
## Place to copy icon to
$IconStoragePath = "C:\ProgramData\YourProgram\Icons"
## Name of icon in this folder
$IconName = "Icon.ico"

#########################
# DO NOT TOUCH THE REST #
#########################


## Where the shortcut will be stored and named
$ShortcutPath = "$env:PUBLIC\Desktop\$ShortcutName"
## What icon to use
$IconPath = Join-Path -Path $IconStoragePath -ChildPath "$IconName"

# Get the directory where the script is running from
$ScriptPath = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent

# Ensure the icon storage directory exists
If (-Not (Test-Path -Path $IconStoragePath)) {
    New-Item -ItemType Directory -Path $IconStoragePath
}



# Copy the icon to the specified path
Copy-Item -Path "$ScriptPath\$IconName" -Destination $IconPath -Force

# Create the shortcut
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = $TargetPath
$Shortcut.IconLocation = $IconPath
$Shortcut.Save()
