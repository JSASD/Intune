# Install-SecurlySmartPAC
Sets the `Proxy setup script` value in the `Windows settings app > Network & internet > Proxy` to your organization's Smart PAC URL with your Filter ID (FID) and the currently signed-in user.

## Usage
You'll just need to change one variable value in each script: `$filterID`. This is usually something like `securly@yourdomain.com`, where `yourdomain.com` is your organization's email domain name.

Once this is changed, create a remediation script in Intune, setting `Detect-SecurlySmartPAC.ps1` as the detection script, and `Install-SecurlySmartPAC.ps1` as the remediation script.