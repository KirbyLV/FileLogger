# FileLogger
Powershell script for file change logger and file list creation. made for media server management

Please save this file as .ps1 to execute in powershell

Execute the script in powershell 

Within the ps code, the following needs to be changed:
## PLEASE CHANGE the following variables to set the file and folder locations 
    ##  watchfolder = the location of the changing files to be monitored, where changes trigger log file actions
    ##  logfile = a .txt file containing time stamps of any file changes, replacements, additions, or deletions
    ##  folderpath = the location of the list of files to be created, often the same as watchfolder
    ##  csvpath = a .csv file containing the list of files and SUBFOLDERS
