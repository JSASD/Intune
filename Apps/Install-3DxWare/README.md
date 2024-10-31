# Install-3DxWare
Installs the 3DConnexion 3DxWare driver software silently, with options.

*NOTE:* Please reference 3DConnexion's guide for up-to-date unattended installation setups. This has been tested on version ~10.9.1.
 - All file names below reference this version. You may need to change this based on the most recent version of the software.

## Get latest driver installer
First, head over to 3DConnexion's website and download the latest driver.

THIS SCRIPT WILL NOT WORK WITHOUT AN OFFICIAL INSTALLER AND UNATTENDED XML FILE.

## Get the unattended XML setup file
Once you have the driver installer downloaded, open a terminal as admin and run the following command:

```PowerShell
.\3DxWare64_v10-9-1_b650.exe SaveSettings="C:\temp\3DxWareSetup.xml" /install
```

 - Run through the installer steps, changing any settings you desire.
 - Once this is finished, you should have an unattended file in `C:\temp\`.

## Test unattended setup
 - Since the installer installed the driver, test uninstall by running the uninstall command:
```PowerShell
.\3DxWare64_v10-9-1_b650.exe /uninstall /quiet /norestart
```
 - Once that is done, run the `Install-3DxWare.ps1` script.
 - This should install silently.


## All done!
Set it up for Intune with the content prep tool. :)