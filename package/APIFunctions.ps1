<#
Function name: GetFile
Description: Downloads malware samples from MalwareBazaar sending an HTTP POST request to https://mb-api.abuse.ch/api/v1/. Any downloaded malware sample will be zipped and password protected. 
Function calls: -
Input: $hash , $OutputFilePath
Output: -
#>
function GetFile {
    
        param (
		[Parameter(Mandatory=$true)] [string]$hash,
		[Parameter(Mandatory=$false)] [string]$OutputFilePath
		)

    #Set TLS 1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


    #Path check
        if(!$OutputFilePath){
		    $CurrentPath = Get-Location	
			$Filename=[GUID]::NewGuid().ToString();
            $OutputFilePath = $CurrentPath.toString() + "\"+$Filename+".zip"
		}			
		
             
        
			 
    #Retrieve the malware!
        $body = @{query = 'get_file' ; sha256_hash = $hash}
        try{	
		
		Invoke-WebRequest -Method 'post' -Uri 'https://mb-api.abuse.ch/api/v1/' -Body $body  -UseBasicParsing -OutFile $OutputFilePath
        }
		catch {
			Write-Host "Cannot retrieve malware sample" -Foregroundcolor red
		}

		 
		return
                        
}


<#
Function name: GetInfo
Description: Checks if a particular malware sample is known to MalwareBazaar by query the API for the corresponding hash (using HTTP POST form data).
Function calls: -
Input: $hash
Output: $Info
#>
function GetInfo {
	 
	 param (
		[Parameter(Mandatory=$true)] [string]$hash
		)
		
		
	#Set TLS 1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    #Check malware!
        $body = @{query = 'get_info' ; hash = $hash}
        try{	
		
		$Data = Invoke-WebRequest -Method 'post' -Uri 'https://mb-api.abuse.ch/api/v1/' -Body $body  -UseBasicParsing
        }
		catch {
			Write-Host "Cannot check malware info" -Foregroundcolor red
		}


$JsonContent = $Data.content

$Info = (ConvertFrom-Json $JsonContent).data

return $Info

}

<#
Function name: GetTagInfo
Description: Gets a list of malware samples (max 1'000) associated with a specific tag by query the API (using HTTP POST form data).
Function calls: -
Input: $tag , $limit
Output: $Info
#>
function GetTagInfo {
	 
	 param (
		[Parameter(Mandatory=$true)] [string]$tag,
		[Parameter(Mandatory=$false)] $limit
		)
		
		
	#Set TLS 1.2
        [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

    #check limit
	if(!$limit) { $limit = 50}


    #Check malware!
        $body = @{query = 'get_taginfo' ; tag = $tag ; limit = $limit}
        try{	
		
		$Data = Invoke-WebRequest -Method 'post' -Uri 'https://mb-api.abuse.ch/api/v1/' -Body $body  -UseBasicParsing
        }
		catch {
			Write-Host "Cannot get malware info " -Foregroundcolor red
		}


$JsonContent = $Data.content

$Info = (ConvertFrom-Json $JsonContent).data

return $Info

}