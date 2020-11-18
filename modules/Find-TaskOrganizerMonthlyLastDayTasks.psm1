Function Find-TaskOrganizerMonthlyLastDayTasks ($TaskOrganizerTasksName) {
    If ($TaskOrganizerDate[0].Day -eq $TaskOrganizerDate[2].Day) {
        Start-TaskOrganizerTaskTrigger $TaskOrganizerTasksName
    } else {
        $LogMessage = "No tasks to run in " + "TaskOrganizerMonthlyLastDayTasks"
        Write-LogInfo -LogPath $sLogFile -Message $LogMessage
    }
}