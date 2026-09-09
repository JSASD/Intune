# Set-WindowsBingSearch
Sets the `BingSearchEnabled` registry value to `0` to remove web search from the Windows start menu.

## Registry key location
 - The scripts check/create in the `HKCU:\SOFTWARE\Microsoft\Windows\CurrentVersion\Search` key.
 - If remediated, a 32-bit DWORD named `BingSearchEnabled` is created with a value of `0`.

## Usage
Drop the detection and remediation scripts into an Intune remediation. Set your desired interval, and let it do the magic.