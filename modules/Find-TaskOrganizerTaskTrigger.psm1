function Start-TaskOrganizerTaskTrigger {
    param (
        $TaskOrganizerTasksName
    )
    
    $LogMessage = "Getting Tasks " + $TaskOrganizerTasksName
    Write-LogInfo -LogPath $sLogFile -Message $LogMessage
    
    $RunTasksPath = $DataPath + $TaskOrganizerTasksName + ".txt"
    $RunTasks = Import-Csv -Path $RunTasksPath -Delimiter ";"
    
    ForEach ($Task in $RunTasks){
        $LogMessage = "Running Task " + $Task.ReportFile
        Write-LogInfo -LogPath $sLogFile -Message  $LogMessage
        $TaskOrganizerTaskParametersFile = $DataPath + $TaskOrganizerTasksName + "." + $Task.ReportFile + ".Parameters.txt"
        If ((Test-Path -Path $TaskOrganizerTaskParametersFile) -eq $true) {
            $TaskOrganizerTaskParameters = Import-Csv -Path $TaskOrganizerTaskParametersFile -Delimiter ";"
            ForEach ($TaskOrganizerTaskParameter in $TaskOrganizerTaskParameters) {
                $TaskOrganizerTaskParametersHeaders = $TaskOrganizerTaskParameters | Get-member -MemberType 'NoteProperty' | Select-Object -ExpandProperty 'Name'
                $ScriptCommand = ""
                $ScriptCommandParameters = @{}
                ForEach ($TaskOrganizerTaskParametersHeader in $TaskOrganizerTaskParametersHeaders) {
                    $ScriptCommandParameters.Add($TaskOrganizerTaskParametersHeader,$TaskOrganizerTaskParameter.($TaskOrganizerTaskParametersHeader))
                }
            $ScriptCommand = $TaskScriptsPath + $Task.ReportFile
            &$ScriptCommand @ScriptCommandParameters
            }
        } else {
            $LogMessage = "Missing file: $TaskOrganizerTaskParametersFile"
            Write-LogWarning -LogPath $sLogFile -Message $LogMessage -ToScreen
        }
    }
    
}



