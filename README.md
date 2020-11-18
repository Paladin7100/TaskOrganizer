# TaskOrganizer
	.SYNOPSIS
	Script to organize script running.

	.DESCRIPTION
	Task Organizer manages script and runs them i order set by the datafiles in the \data\ folder.
	'TaskOrganizerDailyTasks' runs tasks that will run every day. No check is made against date.
	'TaskOrganizerDayTasks' runs tasks on a specific day of the month. See Readme.md file in \data\ folder for more information.
	'TaskOrganizerMonthlyFirstDayTasks' runs tasks on a first day of the month.
	'TaskOrganizerMonthlyLastDayTasks' runs tasks on a last day of the month.
	'TaskOrganizerMonthlyLastSaturdayTasks' is an example of a custom script to run tasks on other dates. This one runs on last saturday of month.
	See Readme.md file in \data\ folder for more information on how to configure the data files.
	To change the folder where the external script are ran from, update the variable "$Global:TaskScriptsPath" in this script.
	
	Command line format:
	TaskOrganizer.ps1

	.INPUTS
	Comma separated files in \data\ folder.

	.OUTPUTS
	Log file stored in \log\<date>_TaskOrganizer.log>.

	.EXAMPLE
	TaskOrganizer.ps1

	
	.NOTES
	Author:				Frank Honore
	Create Date:	    	18. November 2020
	Version:			1.00
	
	Notes:
	
	Revision History:
	Name:           Date:		Version:	Description:
	---------------------------------------------------------------------------------------
	Frank Honore	11-18-2020	1.00		Release
