<#
Function name: SetProxyCredentials
Description: Allows to insert username and password through a dialog window to login into a proxy. Credentials (WebClient) are returned as an Object.  
Function calls: - 
Input:  -
Output: $WebClient
#>
function SetProxyCredentials {
    param( )

Clear-Host
PrintLogo

$WebClient = New-Object System.Net.WebClient
$Credentials = Get-Credential
$WebClient.Proxy.Credentials = $Credentials

	
return	$WebClient
}	

<#
Function name: SetApiKey
Description: Allows to insert a MalwareBazaar API key.  
Function calls: - 
Input:  -
Output: $ApiKey
#>
function SetApiKey {
    param( )

Clear-Host
PrintLogo
		
	Write-Host "Insert your MalwareBazaar API key"
	$ApiKey = Read-Host 

	
return	$ApiKey
}	

<#
Function name: SetDecryptionPassword
Description: Allows to insert a decryption password to unzip .zip files password protected.  
Function calls: - 
Input:  -
Output: $DecryptionPassword
#>
function SetDecryptionPassword {
    param( )

Clear-Host
PrintLogo
		
	Write-Host "Insert decryption password"
	$DecryptionPassword = Read-Host 

	
return	$DecryptionPassword
}	

<#
Function name: SetLimitResult
Description: Allows to set a maximum value for the number of results returned by a query.  
Function calls: - 
Input:  -
Output: $Limit
#>
function SetResultsLimit {
    param( )

Clear-Host
PrintLogo
		
	Write-Host "Insert max number of results you want to display"
	$Limit = Read-Host 

	
return	$Limit
}	


<#
Function name: Set7ZipPath
Description: Allows to set the path to the 7-zip tool. If 7-zip is installed this parameter is set automatically.  
Function calls: - 
Input:  -
Output: $Path
#>
function Set7ZipPath {
    param( )

Clear-Host
PrintLogo
		
	Write-Host "Insert 7-Zip installation path"
	$Path = Read-Host 

	
return	$Path
}	