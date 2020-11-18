Function Submit-TaskOrganizerTasks ($TaskOrganizerTasksName) {
    If ((1..31) -contains $TaskOrganizerTasksName.Split("_")[1]) {
        $LogMessage = "Running Function " + $TaskOrganizerTasksName
        Write-LogInfo -LogPath $sLogFile -Message $LogMessage
        Find-TaskOrganizerDayTasks $TaskOrganizerTasksName
    
    } else {
        $LogMessage = "Running Function " + $TaskOrganizerTasksName
        Write-LogInfo -LogPath $sLogFile -Message  $LogMessage
        $FncCommand = "Find-" + $TaskOrganizerTasksName
        &$FncCommand $TaskOrganizerTasksName
    }
}
