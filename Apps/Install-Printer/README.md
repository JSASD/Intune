# Usage
## Install
```PowerShell
PowerShell.exe -ExecutionPolicy bypass -file ./Install-Printer.ps1 -PortName "{Printer_IP_Or_Hostname}" -PrinterIP "{Printer_IP_Or_Network_Share_Location}" -PrinterName "{Name_Of_Printer_To_Show_In_Windows}" -DriverName "{Driver_Name_From_INF_File}" -INFFile "{Location_Of_INF_File}"
```

Where:
 - `{Printer_IP_Or_Hostname}` is whatever you want the name of the port to be.
 - `{Printer_IP_Or_Network_Share_Location}` is the IP address or network share location of the device.
 - `{Name_Of_Printer_To_Show_In_Windows}` is the name you want to show up in the list of printers.
 - `{Driver_Name_From_INF_File}` is the name of the driver found in your `.inf` file.
 - `{Location_Of_INF_File}` is the location of the `.inf` file you have. Can be a subdirectory of the script's directory.


## Uninstall
```PowerShell
PowerShell.exe -ExecutionPolicy bypass -file ./Uninstall-Printer.ps1 -PrinterName "{Locally_Installed_Printer_Name}"
```

Where:
 - `{Locally_Installed_Printer_Name}` is the display name of the printer in Windows' list of printers.


# Detection
## Registry
`Key`: `HKEY_LOCAL_MACHINE\Software\Microsoft\Windows NT\CurrentVersion\Print\Printers\{Locally_Installed_Printer_Name}`
`Name`: `{Locally_Installed_Printer_Name}`
```

Where:
 - `{Locally_Installed_Printer_Name}` is the display name of the printer in Windows' list of printers.