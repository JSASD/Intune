# Uninstall-Shortcut.ps1
# Removes the created shortcut from the public desktop
# JSASD Technology Department

function Remove-Shortcut {
    param (
        [string]$ShortcutName,
        [string]$IconStoragePath,
        [string]$IconName
    )

    # Define the path of the shortcut and icon to be removed
    $ShortcutPath = "$env:PUBLIC\Desktop\$ShortcutName"
    $IconPath = Join-Path -Path $IconStoragePath -ChildPath $IconName

    # Check if the shortcut exists and remove it
    if (Test-Path $ShortcutPath) {
        Remove-Item $ShortcutPath -Force
        Write-Output "Shortcut removed successfully."
    } else {
        Write-Output "Shortcut does not exist."
    }

    # Check if the icon exists and remove it
    if (Test-Path $IconPath) {
        Remove-Item $IconPath -Force
        Write-Output "Icon removed successfully."
    } else {
        Write-Output "Icon does not exist."
    }
}

# Example usage of the function
Remove-Shortcut -ShortcutName "Name of shortcut.lnk" `
                -IconStoragePath "C:\ProgramData\YourProgram\Icons" `
                -IconName "Icon.ico"
