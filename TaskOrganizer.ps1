<#
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
	Create Date:		18. November 2020
	Version:			1.00
	
	Notes:
	
	Revision History:
	Name:           Date:		Version:	Description:
	---------------------------------------------------------------------------------------
	Frank Honore	11-18-2020	1.00		Release


#>

# Input Parameters.
Param (
)

# General Variables for all scripts.
$Scriptpath = split-path -parent $MyInvocation.MyCommand.Definition

# Variables used by the script
$Global:Scriptpath            = split-path -parent $MyInvocation.MyCommand.Definition
$Global:ModulesPath           = $Scriptpath + "\modules\"
$Global:DataPath              = $Scriptpath + "\data\"
$Global:TaskScriptsPath       = $Scriptpath + "\Scripts\"
$TaskOrganizerScriptOrderPath = $DataPath + "TaskOrganizerScriptOrder.txt"
$Global:sScriptVersion        = "1.00"
$Global:sLogPath              = $Scriptpath + "\log\"
$Global:sLogName              = (Get-Date).tostring("MM-dd-yyyy_HHmmss") + "_TaskOrganizer.log"

<#
---------------------------------------------------------------------------------------------------------------------------------------------------
	Functions
---------------------------------------------------------------------------------------------------------------------------------------------------
#>
$modules = Get-ChildItem $ModulesPath -Filter *.psm1
$modules | ForEach-Object -Process {
    $Scriptmodule = $_ -replace ".psm1"
    Get-Module -Name $Scriptmodule | Remove-Module
    Import-Module $ModulesPath\$_
}

<#
---------------------------------------------------------------------------------------------------------------------------------------------------
	General Script handling
---------------------------------------------------------------------------------------------------------------------------------------------------
#>
$Global:sLogFile = Start-Log -LogPath $sLogPath -LogName $sLogName -ScriptVersion $sScriptVersion
$Global:TaskOrganizerDate = Get-StartEndOfMonth
Write-LogInfo -LogPath $sLogFile -Message "Collected Dates from Get-StartEndOfMonth"
ForEach ($Date in $TaskOrganizerDate){
	Write-LogInfo -LogPath $sLogFile -Message $Date
}


$TaskOrganizerScriptOrder = Import-Csv -Path $TaskOrganizerScriptOrderPath -Delimiter ";"
$TaskOrganizerScriptOrder | ForEach-Object -Process {
	Set-Location -Path $TaskScriptsPath
    Submit-TaskOrganizerTasks -TaskOrganizerTasksName $_.Order
}

##### End of Script. Cleaning up - Start #####
Set-Location -Path $Scriptpath
Stop-Log -LogPath $sLogFile -NoExit
Remove-Variable -Name "Scriptpath" -Scope Global
Remove-Variable -Name "ModulesPath" -Scope Global
Remove-Variable -Name "DataPath" -Scope Global
Remove-Variable -Name "TaskScriptsPath" -Scope Global
Remove-Variable -Name "TaskOrganizerScriptOrderPath" -Scope Script
Remove-Variable -Name "TaskOrganizerDate" -Scope Global
Remove-Variable -Name "sLogPath" -Scope Global
Remove-Variable -Name "sLogName" -Scope Global
Remove-Variable -Name "sLogFile" -Scope Global
$modules | ForEach-Object -Process {
    $Scriptmodule = $_ -replace ".psm1"
    Get-Module -Name $Scriptmodule | Remove-Module
}
##### End of Script. Cleaning up - End #####

Exit 0
<#
---------------------------------------------------------------------------------------------------------------------------------------------------
	End of Script
---------------------------------------------------------------------------------------------------------------------------------------------------
#>
