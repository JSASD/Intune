# New-Shortcut.ps1
# Creates a Windows shortcut to anything you want, placing it on the public desktop
# JSASD Technology Department

function New-Shortcut {
    param (
        [switch]$Public,
        [string]$ShortcutName,
        [string]$TargetPath,
        [string]$IconStoragePath,
        [string]$IconName
    )

    Write-Host "Public: $Public"

    # Decide if shortcut is public based on -Public parameter
    if ($Public) {
        $ShortcutDestination = "$env:PUBLIC\Desktop"
    } else {
        $ShortcutDestination = [Environment]::GetFolderPath("Desktop")
    }

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
# Sending to the public desktop (MUST RUN IN SYSTEM CONTEXT)
New-Shortcut    -ShortcutName "Your app.lnk" `
                -TargetPath "C:\Program Files\YourApp\YourApp.exe" `
                -IconStoragePath "C:\ProgramData\YourApp\Icons" `
                -IconName "Icon.ico" `
                -Public
# Sending to the current user's desktop (MUST RUN IN USER CONTEXT)
# New-Shortcut  -ShortcutName "Your app.lnk" `
#                 -TargetPath "C:\Program Files\YourApp\YourApp.exe" `
#                 -IconStoragePath "C:\ProgramData\YourApp\Icons" `
#                 -IconName "Icon.ico" `
