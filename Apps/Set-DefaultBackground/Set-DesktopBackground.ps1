# Set-DesktopBackground.ps1
# Sets a default background in Windows 11, this script and the background are copied using Stage-DesktopBackground.ps1
# JSASD Technology Department

$filepath = "C:\Users\Public\Pictures\jsasd-background.jpg"

$code = @'
using System.Runtime.InteropServices;

namespace Win32{
    
    public class Wallpaper{

      [DllImport("user32.dll", CharSet=CharSet.Auto)]
      static  extern int SystemParametersInfo (int uAction , int uParam , string lpvParam , int fuWinIni) ;

      public static void SetWallpaper(string thePath){
         SystemParametersInfo(20,0,thePath,3);
      }
    }
}
'@
add-type $code

[Win32.Wallpaper]::SetWallpaper($filepath)