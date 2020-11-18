

Function Get-StartEndOfMonth {
    $date = Get-Date
    $year = $date.Year
    $month = $date.Month
        
    # create a new DateTime object set to the first day of a given month and year
    $startOfMonth = Get-Date -Year $year -Month $month -Day 1 -Hour 0 -Minute 0 -Second 0 -Millisecond 0
    # add a month and subtract the smallest possible time unit
    $endOfMonth = ($startOfMonth).AddMonths(1).AddTicks(-1)

    return $date,$startOfMonth,$endOfMonth
}
