# TaskOrganizer
## Datafile Structure

All files are comma separated files, separator used is ";"

| Task Organizer Functions | Description |
| ----------- | ----------- |
| Submit-TaskOrganizerTasks | This function collects the order in when each batch of scripts will be run from config file i data folder. |
| Find-TaskOrganizerDailyTasks | Scheduler function: Lists and sets the order for scripts which will run each day |
| Find-TaskOrganizerDayTasks | Scheduler function: Lists and sets the order for scripts which will run on a specific day of the mont. E.g. for datafile TaskOrganizerDay_15.txt which will run on the 15th each month, 'TaskOrganizerDay_15' have to be added to the TaskOrganizerDailyTasks.txt file |
| Find-TaskOrganizerMonthlyFirstDayTasks | Scheduler function: Lists and sets the order for scripts which will run first day of each month |
| Find-TaskOrganizerMonthlyLastDayTasks | Scheduler function: Lists and sets the order for scripts which will run last day of each month |
| TaskOrganizerMonthlyLastSaturdayTasks.txt | Scheduler function: Example of a script where user can add extra controls on when to run. This one runs scripts last saturday of each month. Function Find-|

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
