function Get-LastSaturdayOfMonth([DateTime] $d) {    
    $lastDay = new-object DateTime($d.Year, $d.Month, [DateTime]::DaysInMonth($d.Year, $d.Month))
    $diff = ([int] [DayOfWeek]::Saturday) - ([int] $lastDay.DayOfWeek)

    if ($diff -ge 0) {
        return $lastDay.AddDays(- (7-$diff))
    }
    else {
        return $lastDay.AddDays($diff)
    }    
}
Function Find-TaskOrganizerMonthlyLastSaturdayTasks ($TaskOrganizerTasksName) {
    $TaskOrganizerFileName = $TaskOrganizerFileName + ".txt"
    $date = (Get-Date)
    $LastSaturdayMonth = Get-LastSaturdayOfMonth($date)
    
    If ($date.day -eq $LastSaturdayMonth.day){
        Start-TaskOrganizerTaskTrigger $TaskOrganizerTasksName
    } else {
        $LogMessage = "No tasks to run in " + "TaskOrganizerMonthlyLastSaturdayTasks"
        Write-LogInfo -LogPath $sLogFile -Message $LogMessage
    }
}