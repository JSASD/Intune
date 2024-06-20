# Install-Shortcut
Installs a shortcut to any URL / program on the Windows public desktop.

# Requirements
 - Ability to run scripts on the system (this must be run in the `System` context if creating a Win32 app in Intune)
 - An icon file in the same directory as the script

# Install-Shortcut.ps1
## Usage
Script contents are all bundled into a function. An example call is at the bottom.

The following function parameters can be set:
 - `$ShortcutName`: Friendly name of the shortcut, this is what it will be called on the desktop.
 - `$TargetPath`: The URL / path to the program you want to open.
 - `$IconStoragePath`: Where you want to locally store the icon for the shortcut, must be accessible by the script at runtime.
 - `$IconName`: Name of the icon in the script directory.
 - [Optional] `$ShortcutDestination`: Where the shortcut should be placed after creation

## Examples
### Using default destination
```PowerShell
New-Shortcut -ShortcutName "Your App.lnk" `
             -TargetPath "https://www.jsasd.org" `
             -IconStoragePath "C:\ProgramData\YourApp\Icons" `
             -IconName "Icon.ico"
```

### Using custom destination
```PowerShell
New-Shortcut -ShortcutName "Your App.lnk" `
             -TargetPath "https://www.jsasd.org" `
             -IconStoragePath "C:\ProgramData\YourApp\Icons" `
             -IconName "Icon.ico" `
             -ShortcutDestination "C:\Users\YourUser\Desktop"
```

Run the script as normal, no arguments are needed.

# Uninstall-Shortcut.ps1
## Usage
tl;dr
 - Set parameters that correspond directly to those in `New-Shortcut.ps1` to be the same values in this script.

The following function parameters can be set:
 - `$ShortcutName`: Name of the shortcut on the desktop.
 - `$ShortcutDestination`: Where the shortcut is currently installed to.
 - `$IconDirectory`: Directory in which the icon exists. This will delete the directory you specify.