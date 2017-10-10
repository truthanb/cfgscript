# cfgscript
2 scripts to help create a xml config from excel or csv

For the xls script you will need to make sure you have ImportExcel module installed. "Install-Module ImportExcel" should take care of it. You also probably need to have Excel installed on the machine the script will run on. 


If you use the create_config_csv module you will want to put it in the C:\Users\\{username}\Documents\WindowsPowerShell\Modules folder. You'll then want to run the following command in powershell "Import-Module create_config_csv". Then you'll be able to use the script like a commandlet where you pass in the -csvFilePath and the -xmlFilePath, and it'll do the rest. 
It would look like this "Set-ConfigFromCsv -csvFilePath "C:\filepathToCsv.csv" -xmlFilePath "C:\filepathToXml.xml"
