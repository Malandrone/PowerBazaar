#MAIN MENU
function DisplayMainMenu {
    param( )

#initialize
$global:ApiKey = ""
$global:DecryptionPassword = "infected"
$global:ResultsLimit = 50

if((Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ | Get-ItemProperty | Select-Object InstallLocation)[0] -match "7-zip"){
$global:7ZipPath = ((Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ | Get-ItemProperty | Select-Object InstallLocation)  -match "7-zip").InstallLocation + "7z.exe"
}

do {
	
 $Choice = "NONE"
 Clear-Host
 PrintLogo
 
 
 Write-Host "[1]-Query a malware sample " 
 Write-Host "[2]-Query malware samples by tag " 
 Write-Host "[3]-Retrieve a malware sample by hash "
 Write-Host "[4]-Retrieve malware samples by tag "
 Write-Host "[5]-Unzip files from a folder "
 Write-Host "[6]-Settings " 
 Write-Host "[7]-About "
 Write-Host "[0]-Exit " 

 $Choice = Read-Host -Prompt 'Insert your choice'
 
 switch ( $Choice ) {
     
	 1  { QueryMalwareSample }
	 2  { QueryMalwareSamplesByTag }
	 3  { RetrieveMalwareSampleByHash }
	 4  { RetrieveMalwareSamplesByTag}
	 5  { UnzipFilesFromFolder}
	 6  { DisplaySettingsMenu  }
	 7  { DisplayAboutMenu }
 }

}

until($Choice -eq "0")

return  
}


#1-QUERY MALWARE SAMPLE
function QueryMalwareSample {
    param( )

Clear-Host
PrintLogo

do {
 $Choice = "NONE"
 Clear-Host
 PrintLogo

 Write-Host "[1]-Query by hash "
 Write-Host "[2]-Query by file "
 Write-Host "[0]-Go back "
 $Choice = Read-Host -Prompt 'Insert your choice'
 
 switch ( $Choice ) {
	 
     1  { QueryByHash  }
     2  { QueryByFile  }
	
 }

}

until($Choice -eq "0")


return  
}

#1.1-QUERY BY HASH
function QueryByHash {
    param( )

Clear-Host
PrintLogo

Write-Host "Insert the SHA256 hash value of the malware sample you want to check (insert # to go back)" 
$hash = Read-Host

if($hash -ne "#"){
	$Info = GetInfo $hash

	Clear-Host
	PrintLogo

	if ($Info){
		Write-Host "Record found! Sample is stored in the MalwareBazaar repository:`r`n" -ForegroundColor yellow
		$Info
	}

	else  { Write-Host "Hash not found`r`n" -ForegroundColor red}

	pause
}
return
}


#1.2-QUERY BY FILE
function QueryByFile {
    param( )

Clear-Host
PrintLogo

Write-Host "Select file you want to check" 

$InputFilePath = DisplayDialogWindowFile

if ( $InputFilePath -eq ""){
 Write-Host "No file uploaded" -ForegroundColor red
 pause
 return
}

$hash = ((Get-FileHash $InputFilePath).Hash)

$Info = GetInfo $hash

Clear-Host
PrintLogo

if ($Info){
	Write-Host "Record found! Sample is stored in the MalwareBazaar repository`r`n" -ForegroundColor yellow
	Write-Host "*******************************************!!!ALERT!!!*******************************************" -ForegroundColor red
	Write-Host "                                        Malicious content:                             " -ForegroundColor red
	Write-Host $InputFilePath
	Write-Host "*************************************************************************************************" -ForegroundColor red
	
	$Info
}

else  { Write-Host "Hash not found`r`n" -ForegroundColor red}

pause

return
}


#2-QUERY MALWARE SAMPLES BY TAG
function QueryMalwareSamplesByTag {
    param( )

Clear-Host
PrintLogo

Write-Host "Insert the tag of the malware samples you want to check (insert # to go back)" 
$tag = Read-Host

if($tag -ne "#"){
	$Info = GetTagInfo $tag $global:ResultsLimit

	Clear-Host
	PrintLogo

	if ($Info){
	
		$message= "Results for tag '"+$tag+"'`r`n"
		Write-Host $message -ForegroundColor yellow
		$Info
	
		$Filename= $tag+"_samples_info_from_MalwareBazaar.txt"
		$DefaultPath = (Get-Location).Path
		$OutputFilePath = $DefaultPath +"\"+$Filename
	
		$Info>$Filename
	
		$message= "Results have been saved to "+$OutputFilePath
		Write-Host $message -ForegroundColor green


	}

	else  { 

		$message= "No results for tag '"+$tag+"'"
		Write-Host $message -ForegroundColor red
	}
	pause

}
return  
}

#3-RETRIEVE MALWARE SAMPLE BY HASH
function RetrieveMalwareSampleByHash {
    param( )

Clear-Host
PrintLogo

Write-Host "Insert SHA256 hash value of the malware sample you want to download (insert # to go back)" 
$hash = Read-Host

if ($hash -ne "#"){
	Write-Host "[OPTIONAL]Insert output file path (default path: PowerBazaar folder)"
		$OutputFolderPath = DisplayDialogWindowFolder
		$OutputFilePath = ""
		if ( $OutputFolderPath -ne ""){    
		   $OutputFileName = $hash
		   $OutputFilePath = $OutputFolderPath+"\"+$hash + ".zip"
		}
		else {
			$DefaultPath = (Get-Location).Path
			$OutputFilePath = $DefaultPath +"\"+$hash+ ".zip";
		}
	   
		 GetFile $hash $OutputFilePath
	   

	Clear-Host
	PrintLogo
	$message = "Malware sample "+$hash+ " has been downloaded to "+$OutputFilePath  
	Write-Host $message -Foregroundcolor green 

	pause
}
return  
}

#4-RETRIEVE MALWARE SAMPLES BY TAG
function RetrieveMalwareSamplesByTag {
    param( )

Clear-Host
PrintLogo

Write-Host "Insert the tag of the malware samples you want to download (insert # to go back)" 
$tag = Read-Host

if ($tag -ne "#"){
Write-Host "[OPTIONAL]Insert output folder path (default path: PowerBazaar\samples folder)"
$DefaultPath = (Get-Location).Path

$OutputFolderPath = DisplayDialogWindowFolder

if(!$OutputFolderPath){   $OutputFolderPath = $DefaultPath+"\samples" }


Clear-Host
PrintLogo
$message = "Downloading to "+$OutputFolderPath
Write-Host $message -ForegroundColor yellow


$Info = GetTagInfo $tag $global:ResultsLimit
foreach ($i in $Info){
	
	$hash = $i.sha256_hash
	$OutputFilePath = $OutputFolderPath+"\"+$hash + ".zip"
	
	if( !(Test-path $OutputFilePath)) {
			
		GetFile $hash $OutputFilePath
		
		$message= "Downloaded: "+$OutputFilePath
	    Write-Host $message -Foregroundcolor green
    
	}
	else {
	$message= $OutputFilePath +" has already been downloaded"
	Write-Host $message -Foregroundcolor yellow
	}	

sleep 1;

}


$message = "The "+$global:ResultsLimit+" most recent malware samples having tag '"+$tag+"' have been downloaded!"  
Write-Host $message -Foregroundcolor green 

pause
}
return  
}

#5-UNZIP FILES FROM A FOLDER
function UnzipFilesFromFolder {
 param( )

Clear-Host
PrintLogo
if (!((Get-ChildItem -Path HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\ | Get-ItemProperty | Select-Object InstallLocation)[0] -match "7-zip")){
	
	Write-Host "Error: it seems that 7-zip is not installed on your computer. You must install 7-zip to use this feature. 
If 7z is installed instead, please specify the path of the .exe file on settings menu" -ForegroundColor red
}
else {
	
	
	Write-Host "Select folder path where files are located" 
    $InputFolderPath = DisplayDialogWindowFolder

    if ( $InputFolderPath -eq ""){
       Write-Host "No folder selected" -ForegroundColor red
	   pause
	break;
    }
	
	
	Write-Host "[OPTIONAL]Insert output folder path (default path: PowerBazaar\unzipped folder)"
	$DefaultPath = (Get-Location).Path

	$OutputFolderPath = DisplayDialogWindowFolder

	if(!$OutputFolderPath){   $OutputFolderPath = $DefaultPath+"\unzipped" }


	Clear-Host
	PrintLogo
	$message = "Unzipping to "+$OutputFolderPath
	Write-Host $message -ForegroundColor yellow


foreach ($file in (Get-ChildItem $InputFolderPath)) {

 $Source = $InputFolderPath+"\"+$file
    	
 $Destination = $OutputFolderPath+"\"	# add +(($file.toString()).replace(".zip","")) to keep separated folders
  
 Open7ZipFile -ExePath7Zip $global:7ZipPath -Source $Source -Destination $Destination -Password $global:DecryptionPassword 	

}


Write-Host "Done" -ForegroundColor green
pause

}
return
}




#6-SETTINGS MENU
function DisplaySettingsMenu {

do {
	
$Choice = "NONE"
Clear-Host
PrintLogo

 Write-Host "[1]-Set Proxy Credentials "
 Write-Host "[2]-Set MalwareBazaar API key, current key: " -nonewline
 Write-Host $global:ApiKey
 Write-Host "[3]-Set .zip decryption password, current password: " -nonewline
 Write-Host $global:DecryptionPassword
 Write-Host "[4]-Set results limit, current value: " -nonewline
 Write-Host $global:ResultsLimit
 Write-Host "[5]-Set 7-Zip installation path, current path: " -nonewline
 Write-Host $global:7ZipPath
 
 Write-Host "[0]-Go back " 

 $Choice = Read-Host -Prompt 'Insert your choice'
 
 switch ( $Choice ) {
     1  { $global:WebClient = SetProxyCredentials  }
	 2  { $global:ApiKey = SetApiKey }
	 3  { $global:DecryptionPassword = SetDecryptionPassword }
	 4  { $global:ResultsLimit = SetResultsLimit }
	 5  { $global:7ZipPath = Set7ZipPath }
 
 }

}

until($Choice -eq "0")

return  

}


#7-ABOUT MENU
function DisplayAboutMenu {
    param()

Clear-Host
PrintLogo


$about = @'

-Version    : 1.0  
-Author     : Giuseppe Malandrone 
-Email      : giusemaland@gmail.com
-Linkedin   : linkedin.com/in/giuseppe-malandrone-8b3938130/
'@

$license = @'
                    GNU GENERAL PUBLIC LICENSE
                       Version 3, 29 June 2007

 Copyright (C) 2007 Free Software Foundation, Inc. <http://fsf.org/>

'@

Write-Host $about
Write-Host "`n`r"
Write-Host $license -ForegroundColor white  
Pause
return
}

#PowerBazaar module import
Import-Module ./package\PowerBazaar.psd1

#START GUI
DisplayMainMenu