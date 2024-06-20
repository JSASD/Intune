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
 - The parameters available this script are identical to those that correspond in `Install-Shortcut.ps1`
 - Set them identically in this script in order to uninstall properly

The following function parameters can be set:
 - `$ShortcutName`: Name of the shortcut on the desktop.
 - `$IconStoragePath`: Path to the icon that was copied to the local machine.
 - `$IconName`: Name of the icon in the local path.