# Update-ComputerBackground
Updates the background on a computer from a given URL as an argument. Can be any `.png`, `.jpg` or `.jpeg` file.

## Usage
```powershell
PowerShell.exe -File SetBackground.ps1 -imageUrl "http://example.com/path/to/image.png"
```

## Return Codes
 - `0`: The script executed successfully without any errors
 - `1`: General error, not explicitly used
 - `2`: No image URL was provided
 - `3`: Provided URL does not point to a valid JPEG or PNG image
 - `4`: Error in downloading the image from the provided URL
 - `5`: Error in setting the desktop background