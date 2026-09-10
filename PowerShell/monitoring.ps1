try {
    # Optionally clears terminal upon execution
    Clear-Host

    # Finds name of script running
    $global:ScriptName = Split-Path $PSCommandPath -Leaf
    
    # Set directory/file to monitor
    $Watcher = New-Object System.IO.FileSystemWatcher
    $Watcher.Path = "C:\Users\jacob\AppData\Roaming\Factorio\script-output"
    $Watcher.EnableRaisingEvents = $true

    # Storing date (time) of execution  
    $global:LastRun = Get-Date

    # Action to be executed upon detected event
    $Action = {
            $Path = $Event.SourceEventArgs.FullPath
            $File = [System.IO.Path]::GetFileName($Path)
            Write-Host "`nTriggered by: $File, Action initiated..."

            $Now = Get-Date

            # Time filter to debounce duplicate calls of $Action
            # If time difference less than 500 ms, then don't treat the action
            if (($Now - $global:LastRun).TotalMilliseconds -lt 500) {
                Write-Host "Duplicate action debounced!"
                return
            }

            # Switch case setting mode based on which file was updated in the monitored directory
            switch ($File) {
                "bp_out.txt" {
                    $Mode="decode"
                }
                "request.txt" {
                    $Mode="encode"      
                }
                default {
                    Write-Host "Error encountered: Not triggered by correct file name... `nTriggered by: $File`nTerminating the request"
                    return
                }
            }

            Write-Host "Running $Mode"
            # Executing the bash script with a given mode at the given location (here: Ubuntu VM)
            $exec_path = "bash /home/jacob/factorio/converter.sh $Mode"
            Start-Process "C:\Windows\System32\wsl.exe" -ArgumentList $exec_path -NoNewWindow -Wait

            # Updating time of last run
            Write-Host "`nFrom" $global:ScriptName": `nAction completed!"
            $global:LastRun = Get-Date
            }
        
    # Creation of event watcher
    $WatcherName = "FileChangerWatcher"
    Register-ObjectEvent $Watcher "Changed" -Action $Action -SourceIdentifier $WatcherName
    while ($true) {Start-Sleep 5}        
}
finally {
    # Clean up of process created
    Write-Host "`nExiting and cleaning up process $WatcherName`n"
    Unregister-Event -SourceIdentifier $WatcherName
    Get-Job | Where-Object { $_.Name -eq $WatcherName } | Remove-Job
    $Watcher.Dispose()
}