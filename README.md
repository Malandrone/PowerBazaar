![alt text](https://raw.githubusercontent.com/Malandrone/PowerBazaar/main/Logo.PNG)
# PowerBazaar
PowerBazaar is a simple PowerShell tool which allows to easily interact with the [MalwareBazaar](https://bazaar.abuse.ch/) repository via API.

**WARNING**: 
 - This tool downloads malware on your computer. Use it only in a isolated execution environment ( VirtualBox for example) 
 - Windows Defender might avoid the tool from working properly. Disable it temporarily if necessary.

**REQUIREMENTS**:
 - Windows PowerShell v5.1
 - OS Windows 10 64 bit

### How to use the tool
 - Enable scripts execution: launch PowerShell as Administrator and run the command:
 
   ```Set-ExecutionPolicy bypass```
 - If it doesn't work, open Registry Editor as Administrator and go to:
   
   ```Computer\HKEY_LOCAL_MACHINE\SOFTWARE\Policies\Microsoft\Windows\PowerShell```
   
   Set the parameter "ExecutionPolicy" on value "Bypass"
 - Disable any antivirus software in order to allow the tool to analyze malware without interruption.
 - Click on **PowerBazaar.bat** to start the GUI.
 
Main menu includes the following options:
- **[1]-Query a malware sample:** Takes a hash value (sha256) as input and if there is a record associated with that hash in the MalwareBazaar repository, it returns some information about it.
- **[2]-Query malware samples by tag:** Takes a tag (string) as input and returns some information about all the records associated with that tag. Information obtained in this way is saved in a .txt file.
- **[3]-Retrieve a malware sample by hash:** Takes a hash value (sha256) as input and if there is a record associated with that hash in the MalwareBazaar repository, that record (malware sample) is downloaded as .zip file password protected.
- **[4]-Retrieve malware samples by tag:** Takes a tag (string) as input and downloads all ll the records (malware samples) associated with that tag as .zip files password protected.
- **[5]-Unzip files from a folder:** A useful feature that allows to quickly unzip all retrieved data. It requires [7-zip](https://www.7-zip.org/) installed on your system. (Use this feature with caution!!!).
- **[6]-Settings:** Here can the following parameters can be set: 
	- Proxy credentials
	- MalwareBazaar API key
	- Decryption password for .zip files
	- Maximum limit for the number of results returned by a query
	- 7-zip installation path.If 7-zip is installed this parameter is set automatically
- **[7]-About:** Displays some info about the tool.
- **[0]-Exit:** Terminates the program.

### License
GPL-3.0

### References
[MalwareBazaar API](https://bazaar.abuse.ch/api/)
