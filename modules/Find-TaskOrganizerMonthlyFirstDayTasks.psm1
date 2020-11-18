Function Find-TaskOrganizerMonthlyFirstDayTasks ($TaskOrganizerTasksName) {
    If ($TaskOrganizerDate[0].Day -eq $TaskOrganizerDate[1].Day) {
        Start-TaskOrganizerTaskTrigger $TaskOrganizerTasksName "TaskOrganizerMonthlyFirstDayTasks"
    } else {
        $LogMessage = "No tasks to run in " + "TaskOrganizerMonthlyFirstDayTasks"
        Write-LogInfo -LogPath $sLogFile -Message $LogMessage
    }
}