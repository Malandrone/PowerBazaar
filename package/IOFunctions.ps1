<#
Function name: DisplayDialogWindowFile
Description: Displays a dialog window to set the input file path
Function calls: 
Input:  -
Output: $InputFile
#>
function DisplayDialogWindowFile() {
	
   Add-Type -AssemblyName System.Windows.Forms
   $FileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{ InitialDirectory = [Environment]::GetFolderPath('Desktop') }
   $null = $FileBrowser.ShowDialog()
   $InputFile = $FileBrowser.FileName
   
  return $InputFile	
	
}


<#
Function name: DisplayDialogWindowFolder
Description: Displays a dialog window to set the input folder path
Function calls: 
Input:  -
Output: $InputFolder
#>
function DisplayDialogWindowFolder() {
	
   Add-Type -AssemblyName System.Windows.Forms
   $FolderBrowser = New-Object System.Windows.Forms.FolderBrowserDialog
   $null = $FolderBrowser.ShowDialog()
   $InputFolder = $FolderBrowser.SelectedPath
   
  return $InputFolder	
	
}


<#
Function name: Open7ZipFile
Description: Decrypts a .zip file 
Function calls: 
Input:  $Source , $Destination , $Password , $ExePath7Zip
Output: -
#>
function Open7ZipFile{
    Param(
        [Parameter(Mandatory=$true)]
        [string]$Source,
        [Parameter(Mandatory=$true)]
        [string]$Destination,
        [string]$Password,
        [Parameter(Mandatory=$true)]
        [string]$ExePath7Zip
       
    )
    
	$Command = "& `"$ExePath7Zip`" e -o`"$Destination`" -y" + $(if($Password.Length -gt 0){" -p`"$Password`""}) + " `"$Source`""
  
	
	IEX $Command |Out-null

return	

}