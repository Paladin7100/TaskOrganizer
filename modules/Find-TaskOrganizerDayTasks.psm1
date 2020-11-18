Function Find-TaskOrganizerDayTasks ($TaskOrganizerTasksName) {
    If ($TaskOrganizerDate[0].Day -eq ($TaskOrganizerTasksName).Split("_")[1]) {
        Start-TaskOrganizerTaskTrigger $TaskOrganizerTasksName
    } else {
        $LogMessage = "No tasks to run in " + "TaskOrganizerDayTasks"
        Write-LogInfo -LogPath $sLogFile -Message $LogMessage
    }
}