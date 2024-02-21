# Set-DefaultBackground
Set of scripts to set a default background for a Windows installation. Since this is not done using configuration profile, it can be changed later by the user if desied.

# Setup
 - `Stage-DesktopBackground.ps1` must be packaged as a Win32 script so it only runs once. Detection just checks if the background exists in the copied location.
 - `Set-DesktopBackground.ps1` only sets the default background, so this can be used as a script.

## Win32 package
Use `Stage-DesktopBackground.ps1` as the setup file. And run it with:
```PowerShell
PowerShell.exe -ExecutionPolicy Bypass -File "Stage-DesktopBackground.ps1"
```

