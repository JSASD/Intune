# Set-AutoLogon
Creates / modifies registry values to enable AutoLogon in Windows.

# Requirements
 - Ability to run scripts on the system (this must be run in the `System` context if creating a Win32 app in Intune)

# Recommendations
 - If in Intune, package this into a `.intunewin` file in order to monitor delivery of the script.
 - If a Win32 app is not desired, the next best thing would be to use this as a remediation script, but modification and the addition of a detection script will be necessary.

# Set-AutoLogon.ps1
## Usage
Change the values udner `# CHANGE THE FOLLOWING #`:
 - `$defaultUsername`: Username you want to autologon with
 - `$defaultPassword`: Password you want to autologon with
 - `$defaultDomain`: Your domain name in the format of `company.com`

# Unset-AutoLogon.ps1
This script removes / clears values set by `Set-AutoLogon.ps`. No changes are necessary, and can be run as-is to revert any changes made.


# Security notes
**PLEASE NOTE:** This script stores a password in plain text in delivery to the machine and in the Windows registry. Make sure the account being used has no administrative privilege and is not using an important password.

The Jersey Shore Area School District is not responsible for delivery of insecure passwords or vulnerabilities on your systems.