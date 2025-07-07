# Definite requirements
## IntuneWinAppUtil.exe
 - Microsoft's `.intunewin` wrapper
 - Packs installers and respective files into a single `.intunewin` file for upload to Intune
 - [Download on GitHub](https://github.com/microsoft/Microsoft-Win32-Content-Prep-Tool)

# Possible requirements
## ServiceUI.exe
 - Microsoft Deployment Toolkit's `ServiceUI.exe`
   - Allows interactive PSADT sessions while being run as administrator
   - [Install MDT](https://www.microsoft.com/en-us/download/details.aspx?id=54259)
   - Go to `C:\Program Files\Microsoft Deployment Toolkit\Templates\Distribution\Tools\x64\`
   - Copy the `ServiceUI.exe` file into the root of the PSADT project folder


# Apps
## ActivInspire
### Info
 - **Name:** ActivInspire
 - **Version:** 3.x.y
 - **Installer Type:** `.msi with PSADT`
 - **Description:** Promethean ActivInspire interactive white board software

### Requires
 - [`ServiceUI.exe`](#serviceuiexe) in the root of the project folder
 - ActivInspire `Netinstall` installation files (extracted MSI by running the installer on a local machine)
 - Download ActivInspire here

### Deployment Info
 - **Method:** Win32 PowerShell PSADT
 - **Install command:**
 ```powershell
 ServiceUI.exe -process:explorer.exe Invoke-AppDeployToolkit.exe -DeploymentType Install -DeployMode Interactive
 ```
 - **Uninstall command:**
 ```powershell
 Invoke-AppDeployToolkit.exe -DeploymentType Uninstall -DeployMode Silent
 ```


## Add-PrinterDriver
### Info
 - **Name:** Add-PrinterDriver
 - **Version:** 2.0
 - **Installer Type:** `.ps1 as .intunewin`
 - **Description:** Deploys a printer driver from a specified folder and .inf file.

### Requires
 - [`IntuneWinAppUtil.exe`](#intunewinapputilexe)

### Deployment Info
 - **Method:** Win32 PowerShell call
 - **Install command:**
   ```powershell
   PowerShell.exe -ExecutionPolicy Bypass -File "Add-PrinterDriver.ps1
   ```
 - **Uninstall command:**
   ```powershell
   PowerShell.exe -ExecutionPolicy Bypass -File "RemovePrinterDriver.ps1"
   ```

## Allow-AppThroughFirewall
### Info
 - **Name:** Allow-AppThroughFirewall
 - **Version:** 1.0
 - **Installer Type:** `.ps1 as .intunewin`
 - **Description:** Adds an app to be allowed through the firewall.

### Deployment Info
 - **Method:** Win32 PowerShell call
 - **Install command:**
   ```powershell
   PowerShell.exe -ExecutionPolicy Bypass -File "Allow-AppThroughFirewall.ps1" -appName "Name of your app" -appPath "C:\ProgramFiles\App\App.exe"
   ```

## Install-3DxWare
### Info
 - **Name:** Install-3DxWare
 - **Version:** 1.0
 - **Installer Type:** `.ps1 as .intunewin`
 - **Description:** Installs 3D Connexion's 3DxWare software with settings.

### Deployment Info
 - **Method:** Win32 PowerShell
 - **Install command:**
   ```powershell
   PowerShell.exe -ExecutionPolicy Bypass -File "Install-3DxWare.ps1"
   ```
 - **Uninstall:** Uninstall via installed MSI Product ID


## Install-Printer
### Info
 - **Name:** Install-Printer
 - **Version:** 1.0
 - **Installer Type:** `.ps1 as .intunewin`
 - **Description:** Installs printer and driver using a .inf file.

### Deployment Info
 - **Method:** Win32 PowerShell
 - **Install command:**
 ```powershell
 PowerShell.exe -ExecutionPolicy Bypass -File .\Install-Printer.ps1 -PortName "IP_10.10.1.1" -PrinterIP "10.1.1.1" -PrinterName "Canon Printer Upstairs" -DriverName "Canon Generic Plus UFR II" -INFFile "CNLB0MA64.inf"
 ```
 - **Uninstall command:**
 ```powershell
 powershell.exe -ExecutionPolicy Bypass -File .\Remove-Printer.ps1 -PrinterName "Canon Printer Upstairs"
 ```


## New-Shortcut
### Info
 - **Name:** New-Shortcut
 - **Version:** 1.0
 - **Installer Type:** `.ps1 as .intunewin`
 - **Description:** Creates a Windows shortcut to anything you want, placed on the public desktop.

### Deployment Info
 - **Method:** Win32 PowerShell
 - **Install command:**
 ```powershell
 PowerShell.exe -ExecutionPolicy Bypass -File .\New-Shortcut.ps1 -ShortcutName "Name" -TargetPath "WhatTheShortcutOpens" -IconStoragePath "WhereIsTheIcon" -IconName "Name of the icon" -ShortcutDestination "C:\Users\Public\Desktop [Optional]"
 ```
 - **Uninstall command:**
 ```powershell
 PowerShell.exe -ExecutionPolicy Bypass -File .\Uninstall-Shortcut.ps1 -ShortcutName "Name" -ShortcutDestination "C:\Users\Public\Desktop [Optional if not specified under install]" -IconDirectory "WhereIsTheIcon"
 ```


## Set-DefaultBackground
### Info
 - **Name:** Set-DefaultBackground
 - **Version:** 1.0
 - **Installer Type:** `.ps1 as .intunewin` and `script`
 - **Description:** Stages files and sets default backgrounds. Can be configured to enforce backgrounds downloaded from the company portal.

### Deployment Info
See `Set-DefaultBackground/README.md` for deployment details.