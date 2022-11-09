<#
Function name: PrintLogo 
Description: Displays the PowerBazaar logo and some info about the module   
Function calls: -
Input: -
Output: -   
#>
function PrintLogo( ) {
    param(  )
	
$logo = @'
   ___                        ___                           
  / _ \_____      _____ _ __ / __\ __ _ ______ _  __ _ _ __ 
 / /_)/ _ \ \ /\ / / _ \ '__/__\/// _` |_  / _` |/ _` | '__|
/ ___/ (_) \ V  V /  __/ | / \/  \ (_| |/ / (_| | (_| | |   
\/    \___/ \_/\_/ \___|_| \_____/\__,_/___\__,_|\__,_|_|   
                                                            
'@                                                           
# generated on http://www.patorjk.com/software/taag/#p=display&f=Graffiti&t=Type%20Something%20


$slogan ="             PowerShell tool for MalwareBazaar"




Write-Host $logo -Foregroundcolor cyan
Write-Host $slogan -Foregroundcolor cyan
Write-Host "`n`r"  
   

return
}