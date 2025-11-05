$RegistryPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Session Manager\Power"
$PropertyName = "HiberbootEnabled"
$PropertyValue = 0
Set-ItemProperty -Path $RegistryPath -Name $PropertyName -Value $PropertyValue -Type DWORD -Force -Confirm:$False