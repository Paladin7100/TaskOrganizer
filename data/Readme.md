# TaskOrganizer
## Datafile Structure

All files are comma separated files, separator used is ";"

| Task Organizer config Files | Description |
| ----------- | ----------- |
| TaskOrganizerScriptOrder.txt | This file sets the order in when each batch of scripts will be run. Add one line for Scheduler function to be run |
| TaskOrganizerDailyTasks.txt | Scheduler function: Configuration file for the function **Find-TaskOrganizerDailyTasks.psm1**. |
| TaskOrganizerDay_daynumber.txt | Scheduler function: Configuration file for the function **Find-TaskOrganizerDayTasks.psm1**. |
| TaskOrganizerMonthlyFirstDayTasks.txt | Scheduler function: Configuration file for the function **Find-TaskOrganizerMonthlyFirstDayTasks.psm1**. |
| TaskOrganizerMonthlyLastDayTasks.txt | Scheduler function: Configuration file for the function **Find-TaskOrganizerMonthlyLastDayTasks.psm1**. |
| TaskOrganizerMonthlyLastSaturdayTasks.txt | Scheduler function: Configuration file for the function **Find-TaskOrganizerMonthlyLastSaturdayTasks.psm1**. |

---
<br/><br/>

| Script config Files | Description |
| ----------- | ----------- |
|TaskOrganizerDailyTasks. NameOfScriptIncludingExtension. Parameters.txt | Parameter descriptions for Scripts that will be ran by **TaskOrganizerDailyTasks**. Each parameter needed for the script to run, one column for each. E.g. **TaskOrganizerDailyTasks.TestScriptDaily.ps1.Parameters.txt** |
|TaskOrganizerDay_daynumber. NameOfScriptIncludingExtension. Parameters.txt | Parameter descriptions for Scripts that will be ran by **TaskOrganizerDay**. Each parameter needed for the script to run, one column for each. E.g. **TaskOrganizerDay_17.TestScriptDay.ps1.Parameters.txt** |
|TaskOrganizerMonthlyFirstDayTasks. NameOfScriptIncludingExtension. Parameters.txt|Parameter descriptions for Scripts that will be ran by **TaskOrganizerMonthlyFirstDayTasks**. Each parameter needed for the script to run, one column for each. E.g. **TaskOrganizerMonthlyFirstDayTasks.TestScriptMonthlyFirstDay.ps1.Parameters.txt**|
|TaskOrganizerMonthlyLastDayTasks. NameOfScriptIncludingExtension. Parameters.txt|Parameter descriptions for Scripts that will be ran by **TaskOrganizerMonthlyLastDayTasks**. Each parameter needed for the script to run, one column for each. E.g. **TaskOrganizerMonthlyLastDayTasks.TestScriptMonthlyLastDay.ps1.Parameters.txt**|
|TaskOrganizerMonthlyLastSaturdayTasks. NameOfScriptIncludingExtension. Parameters.txt|Parameter descriptions for Scripts that will be ran by **TaskOrganizerDay**. Each parameter needed for the script to run, one column for each. E.g. **TaskOrganizerMonthlyLastSaturdayTasks.TestScript1MonthlyLastSat.ps1.Parameters.txt**|


---
<br/><br/>
