##Windows Media Server File Scripts:

##Please save this file as .ps1 to execute in powershell

##the following scripts executed in powershell

## PLEASE CHANGE the following variables to set the file and folder locations 
    ##  watchfolder = the location of the changing files to be monitored, where changes trigger log file actions
    ##  logfile = a .txt file containing time stamps of any file changes, replacements, additions, or deletions
    ##  folderpath = the location of the list of files to be created, often the same as watchfolder
    ##  csvpath = a .csv file containing the list of files and SUBFOLDERS

$watchfolder = "D:\d3 Projects\Projectlocation"
$logfile = "D:\log.txt"
$folderpath = $watchfolder
$csvpath = "D:\projectfilelist.csv"


##Create folder watcher to execute logging and file list scripts on file change, 

### SET FOLDER TO WATCH + FILES TO WATCH + SUBFOLDERS YES/NO
    $watcher = New-Object System.IO.FileSystemWatcher
    $watcher.Path = $watchfolder
    $watcher.Filter = "*.*"
    $watcher.IncludeSubdirectories = $true
    $watcher.EnableRaisingEvents = $true  

### DEFINE ACTIONS AFTER AN EVENT IS DETECTED
    $logaction = { $path = $Event.SourceEventArgs.FullPath
                $changeType = $Event.SourceEventArgs.ChangeType
                $logline = "$(Get-Date), $changeType, $path"
                Add-content $logfile -value $logline
              }    
    $filelist = { $folderpath = "[insert project directory here]"
                $logpath = "[insert destination to place file list]"
                Get-ChildItem -Recurse $folderpath | Select-Object FullName, name | Export-Csv -path $csvpath -noTypeInfo }
### DECIDE WHICH EVENTS SHOULD BE WATCHED 
    Register-ObjectEvent $watcher "Created" -Action $logaction
    Register-ObjectEvent $watcher "Created" -Action $filelist
    Register-ObjectEvent $watcher "Changed" -Action $logaction
    Register-ObjectEvent $watcher "Changed" -Action $filelist
    Register-ObjectEvent $watcher "Deleted" -Action $logaction
    Register-ObjectEvent $watcher "Deleted" -Action $filelist
    Register-ObjectEvent $watcher "Renamed" -Action $logaction
    Register-ObjectEvent $watcher "Renamed" -Action $filelist
        while ($true) {sleep 10}

### to end the watcher process, simply close the powershell window OR hit ctrl-c to stop and close