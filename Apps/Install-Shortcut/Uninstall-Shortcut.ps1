# Uninstall-Shortcut.ps1
# Removes the created shortcut from the public desktop and the specified icon directory
# JSASD Technology Department

function Remove-Shortcut {
    param (
        [string]$ShortcutName,
        [string]$ShortcutDestination = "$env:PUBLIC\Desktop",
        [string]$IconDirectory
    )

    # Define the path of the shortcut to be removed
    $ShortcutPath = Join-Path -Path $ShortcutDestination -ChildPath $ShortcutName

    # Check if the shortcut exists and remove it
    if (Test-Path $ShortcutPath) {
        Remove-Item $ShortcutPath -Force
        Write-Output "Shortcut removed successfully."
    } else {
        Write-Output "Shortcut does not exist."
    }

    # Check if the icon directory exists and remove it
    if (Test-Path $IconDirectory) {
        Remove-Item $IconDirectory -Recurse -Force
        Write-Output "Icon directory removed successfully."
    } else {
        Write-Output "Icon directory does not exist."
    }
}

# Example usage of the function
Remove-Shortcut -ShortcutName "Your app.lnk" `
                -ShortcutDestination "C:\Users\qhenry\Downloads" `
                -IconDirectory "C:\ProgramData\YourApp"
# To specify a custom destination for the shortcut:
# Remove-Shortcut -ShortcutName "Your app.lnk" `
#                 -IconDirectory "C:\ProgramData\YourApp"
#                 -ShortcutDestination "C:\ProgramData\Microsoft\Windows\Start Menu\Programs\YourApp"
