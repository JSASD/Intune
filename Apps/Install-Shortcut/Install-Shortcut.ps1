# Install-Shortcut.ps1
# Creates a Windows shortcut to anything you want, placing it on the public desktop
# JSASD Technology Department

function New-Shortcut {
    param (
        [string]$ShortcutName,
        [string]$TargetPath,
        [string]$IconStoragePath,
        [string]$IconName,
        [string]$ShortcutDestination = "C:\Users\Public\Desktop"
    )

    # Paths
    $ShortcutPath = Join-Path -Path $ShortcutDestination -ChildPath $ShortcutName
    $IconPath = Join-Path -Path $IconStoragePath -ChildPath $IconName

    # Get the directory where the script is running from
    $ScriptPath = $PSScriptRoot

    # Ensure the icon storage directory exists
    If (-Not (Test-Path -Path $IconStoragePath)) {
        New-Item -ItemType Directory -Path $IconStoragePath
    }

    # Construct the source icon path
    $SourceIconPath = Join-Path -Path $ScriptPath -ChildPath $IconName

    # Ensure the source icon file exists before copying
    If (-Not (Test-Path -Path $SourceIconPath)) {
        Write-Error "The source icon file does not exist: $SourceIconPath"
        return
    }

    # Copy the icon to the specified path
    Copy-Item -Path $SourceIconPath -Destination $IconPath -Force

    # Create the shortcut
    $WScriptShell = New-Object -ComObject WScript.Shell
    $Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
    $Shortcut.TargetPath = $TargetPath
    $Shortcut.IconLocation = $IconPath
    $Shortcut.Save()
}

# Example usage of the function
New-Shortcut -ShortcutName "Your App.lnk" `
             -TargetPath "https://www.jsasd.org" `
             -IconStoragePath "C:\ProgramData\YourApp\Icons" `
             -IconName "Icon.ico" `
             #-ShortcutDestination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\YourApp"