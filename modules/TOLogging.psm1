###
# Original Author: Luca Sturlese
# Original Name: PSLogging
# URL: http://9to5IT.com
###
# Author: Frank Honore
# Please give recognition to original Author
# Synopsis largly copied from the original Author
# I changed the name of the module so that it won't get confused with the original.
###
# Set-StrictMode -Version Latest

Function Start-Log {
<#
.SYNOPSIS
    Creates a new log file

.DESCRIPTION
    Creates a log file with the path and name specified in the parameters. Checks if log file exists, and if it does deletes it and creates a new one.
    Once created, writes initial logging data

.PARAMETER LogPath
    Mandatory. Path of where log is to be created. Example: C:\Windows\Temp

.PARAMETER LogName
    Mandatory. Name of log file to be created. Example: Test_Script.log

.PARAMETER ScriptVersion
    Optional. Version of the running script which will be written in the log. Example: 1.5

.PARAMETER ToScreen
    Optional. When parameter specified will display the content to screen as well as write to log file. This provides an additional
    another option to write content to screen as opposed to using debug mode.

.INPUTS
    Parameters above

.OUTPUTS
    Log file created
    Return logfile fullpath

.NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  10/05/12
    Purpose/Change: Initial function development.

    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  19/05/12
    Purpose/Change: Added debug mode support.

    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed function name to use approved PowerShell Verbs. Improved help documentation.

    Version:        1.3
    Author:         Luca Sturlese
    Creation Date:  07/09/15
    Purpose/Change: Resolved issue with New-Item cmdlet. No longer creates error. Tested - all ok.

    Version:        1.4
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.

    Version:        2.0
    Author:         Frank Honore
    Creation Date:  16/11/20
    Purpose/Change: Added color to -ToScreen parameter
                    Restructured how the log output is handled
                    Adding padding to message output to write timecode same row each time 
                    Adding timecode and massageclassification each time
                    Removed -Timestand option
                    Removed Link in Synopsis
                    Added output/return value "path to logfile"
                    Changed ScriptVersion to optional
                    Added -Dateformat option

.LINK

.EXAMPLE
    $Logfile = Start-Log -LogPath "C:\Windows\Temp" -LogName "Test_Script.log" -ScriptVersion "1.5"

    Creates a new log file with the file path of C:\Windows\Temp\Test_Script.log. Initialises the log file with
    the date and time the log was created (or the calling script started executing) and the calling script's version.
#>

    [CmdletBinding()]

    Param (
        [Parameter(Mandatory=$true,Position=1)][string]$LogPath,
        [Parameter(Mandatory=$true,Position=2)][string]$LogName,
        [Parameter(Mandatory=$false)][string]$ScriptVersion,
        [Parameter(Mandatory=$false)][string]$Dateformat = "MM-dd-yyyy HH:mm:ss",
        [Parameter(Mandatory=$false)][switch]$ToScreen
    )

    Process {
        $sFullPath = Join-Path -Path $LogPath -ChildPath $LogName

        #Check if file exists and delete if it does
        If ( (Test-Path -Path $sFullPath) ) {
            Remove-Item -Path $sFullPath -Force | Out-Null
        }

        #Create file and start logging
        New-Item -Path $sFullPath -ItemType File | Out-Null

        #Building start logging message
        $sLogMessageArr = @()
        $sLogMessageArr += ((Get-Date).tostring($Dateformat)).PadRight(24) + "Info".PadRight(12) + "*********************************************************************"
        $sLogMessageArr += ((Get-Date).tostring($Dateformat)).PadRight(24) + "Info".PadRight(12) + "***                      Started processing                       ***"
        If ($ScriptVersion){
            $ScriptVersionMeassage = "***".PadRight(25) + "Script Version:  " + $ScriptVersion
            $ScriptVersionMeassage = $ScriptVersionMeassage.PadRight(66) + "***"
            $sLogMessageArr += ((Get-Date).tostring($Dateformat)).PadRight(24) + "Info".PadRight(12) + $ScriptVersionMeassage
        }
        $sLogMessageArr += ((Get-Date).tostring($Dateformat)).PadRight(24) + "Info".PadRight(12) + "*********************************************************************"
        $sLogMessageArr += ""
        $sLogMessageArr += ((Get-Date).tostring($Dateformat)).PadRight(24) + "Info".PadRight(12) + "*********************************************************************"
        $sLogMessageArr += ""

        ForEach ($line in $sLogMessageArr){
            Add-Content -Path $sFullPath -Value $line
        }

        #Write to screen for debug mode
        ForEach ($line in $sLogMessageArr){
            Write-Debug $line
        }

        #Write to scren for ToScreen mode
        If ( $ToScreen -eq $True ) {
            ForEach ($line in $sLogMessageArr){
                Write-Host $line -ForegroundColor Cyan
            }
        }
    return $sFullPath
    }
}


Function Write-LogInfo {
<#
.SYNOPSIS
    Writes informational message to specified log file

.DESCRIPTION
    Appends a new informational message to the specified log file

.PARAMETER LogPath
    Mandatory. Full path of the log file you want to write to. Example: C:\Windows\Temp\Test_Script.log

.PARAMETER Message
    Mandatory. The string that you want to write to the log

.PARAMETER ToScreen
    Optional. When parameter specified will display the content to screen as well as write to log file. This provides an additional
    another option to write content to screen as opposed to using debug mode.

.INPUTS
    Parameters above

.OUTPUTS
    None

.NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  10/05/12
    Purpose/Change: Initial function development.

    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  19/05/12
    Purpose/Change: Added debug mode support.

    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed function name to use approved PowerShell Verbs. Improved help documentation.

    Version:        1.3
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed parameter name from LineValue to Message to improve consistency across functions.

    Version:        1.4
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -TimeStamp parameter which append a timestamp to the end of the line. Useful for knowing when a task started and stopped.

    Version:        1.5
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.

    Version:        2.0
    Author:         Frank Honore
    Creation Date:  16/11/20
    Purpose/Change: Added color to -ToScreen parameter
                    Restructured how the log output is handled
                    Adding timecode and massageclassification each time 
                    Removed -Timestand option
                    Removed Link in Synopsis
                    Added -Dateformat option

.LINK

.EXAMPLE
    Write-LogInfo -LogPath $Logfile -Message "This is a new line which I am appending to the end of the log file."

    Writes a new informational log message to a new line in the specified log file.
#>

    [CmdletBinding()]

    Param (
        [Parameter(Mandatory=$true,Position=1)][string]$LogPath,
        [Parameter(Mandatory=$true,Position=2,ValueFromPipeline=$true)][string]$Message,
        [Parameter(Mandatory=$false)][string]$Dateformat = "MM-dd-yyyy HH:mm:ss",
        [Parameter(Mandatory=$false)][switch]$ToScreen
    )

    Process {
        #Add TimeStamp to message
        $Message = ((Get-Date).tostring($Dateformat)).PadRight(24) + "Info".PadRight(12) + "$Message"

        #Write Content to Log
        Add-Content -Path $LogPath -Value $Message

        #Write to screen for debug mode
        Write-Debug $Message

        #Write to scren for ToScreen mode
        If ( $ToScreen -eq $True ) {
            Write-Host $Message -ForegroundColor Cyan
        }
    }
}

Function Write-LogWarning {
<#
.SYNOPSIS
    Writes warning message to specified log file

.DESCRIPTION
    Appends a new warning message to the specified log file. Automatically prefixes line with WARNING:

.PARAMETER LogPath
    Mandatory. Full path of the log file you want to write to. Example: C:\Windows\Temp\Test_Script.log

.PARAMETER Message
    Mandatory. The string that you want to write to the log

.PARAMETER ToScreen
    Optional. When parameter specified will display the content to screen as well as write to log file. This provides an additional
    another option to write content to screen as opposed to using debug mode.

.INPUTS
    Parameters above

.OUTPUTS
    None

.NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Initial function development.

    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -TimeStamp parameter which append a timestamp to the end of the line. Useful for knowing when a task started and stopped.

    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.

    Version:        2.0
    Author:         Frank Honore
    Creation Date:  16/11/20
    Purpose/Change: Added color to -ToScreen parameter
                    Restructured how the log output is handled
                    Adding timecode and massageclassification each time 
                    Removed -Timestand option
                    Removed Link in Synopsis
                    Added -Dateformat option
                    Removed Warning label

.LINK

.EXAMPLE
    Write-LogWarning -LogPath $Logfile -Message "This is a warning message."

    Writes a new warning log message to a new line in the specified log file.
#>

    [CmdletBinding()]

    Param (
        [Parameter(Mandatory=$true,Position=1)][string]$LogPath,
        [Parameter(Mandatory=$true,Position=2,ValueFromPipeline=$true)][string]$Message,
        [Parameter(Mandatory=$false)][string]$Dateformat = "MM-dd-yyyy HH:mm:ss",
        [Parameter(Mandatory=$false)][switch]$ToScreen
    )

    Process {
        #Add TimeStamp to message
        $Message = ((Get-Date).tostring($Dateformat)).PadRight(24) + "WARNING".PadRight(12) + "$Message"

        #Write Content to Log
        Add-Content -Path $LogPath -Value $Message

        #Write to screen for debug mode
        Write-Debug $Message

        #Write to scren for ToScreen mode
        If ( $ToScreen -eq $True ) {
            Write-Host $Message -ForegroundColor Yellow
        }
    }
}

Function Write-LogError {
<#
.SYNOPSIS
    Writes error message to specified log file

.DESCRIPTION
    Appends a new error message to the specified log file. Automatically prefixes line with ERROR:

.PARAMETER LogPath
    Mandatory. Full path of the log file you want to write to. Example: C:\Windows\Temp\Test_Script.log

.PARAMETER Message
    Mandatory. The description of the error you want to pass (pass your own or use $_.Exception)

.PARAMETER ExitGracefully
    Optional. If parameter specified, then runs Stop-Log and then exits script

.PARAMETER ToScreen
    Optional. When parameter specified will display the content to screen as well as write to log file. This provides an additional
    another option to write content to screen as opposed to using debug mode.

.INPUTS
    Parameters above

.OUTPUTS
    None

.NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  10/05/12
    Purpose/Change: Initial function development.

    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  19/05/12
    Purpose/Change: Added debug mode support. Added -ExitGracefully parameter functionality.

    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed function name to use approved PowerShell Verbs. Improved help documentation.

    Version:        1.3
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed parameter name from ErrorDesc to Message to improve consistency across functions.

    Version:        1.4
    Author:         Luca Sturlese
    Creation Date:  03/09/15
    Purpose/Change: Improved readability and cleaniness of error writing.

    Version:        1.5
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Changed -ExitGracefully parameter to switch type so no longer need to specify $True or $False (see example for info).

    Version:        1.6
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -TimeStamp parameter which append a timestamp to the end of the line. Useful for knowing when a task started and stopped.

    Version:        1.7
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.

    Version:        2.0
    Author:         Frank Honore
    Creation Date:  16/11/20
    Purpose/Change: Added color to -ToScreen parameter
                    Restructured how the log output is handled
                    Adding timecode and massageclassification each time 
                    Removed -Timestand option
                    Removed Link in Synopsis
                    Added -Dateformat option
                    Removed Error label

.LINK

.EXAMPLE
    Write-LogError -LogPath $Logfile -Message $_.Exception -ExitGracefully

    Writes a new error log message to a new line in the specified log file. Once the error has been written,
    the Stop-Log function is excuted and the calling script is exited.

.EXAMPLE
    Write-LogError -LogPath "C:\Windows\Temp\Test_Script.log" -Message $_.Exception

    Writes a new error log message to a new line in the specified log file, but does not execute the Stop-Log
    function, nor does it exit the calling script. In other words, the only thing that occurs is an error message
    is written to the log file and that is it.

    Note: If you don't specify the -ExitGracefully parameter, then the script will not exit on error.
#>

    [CmdletBinding()]

    Param (
        [Parameter(Mandatory=$true,Position=1)][string]$LogPath,
        [Parameter(Mandatory=$true,Position=2,ValueFromPipeline=$true)][string]$Message,
        [Parameter(Mandatory=$false)][string]$Dateformat = "MM-dd-yyyy HH:mm:ss",
        [Parameter(Mandatory=$false)][switch]$ExitGracefully,
        [Parameter(Mandatory=$false)][switch]$ToScreen
    )

    Process {
        #Add TimeStamp to message
        $Message = ((Get-Date).tostring($Dateformat)).PadRight(24) + "ERROR".PadRight(12) + "$Message"

        #Write Content to Log
        Add-Content -Path $LogPath -Value $Message

        #Write to screen for debug mode
        Write-Debug $Message

        #Write to scren for ToScreen mode
        If ( $ToScreen -eq $True ) {
            Write-Host $Message -ForegroundColor Red
        }

        #If $ExitGracefully = True then run Log-Finish and exit script
        If ( $ExitGracefully -eq $True ){
            Add-Content -Path $LogPath -Value " "
            Stop-Log -LogPath $LogPath
            Break
        }
    }
}

Function Stop-Log {
<#
.SYNOPSIS
    Write closing data to log file & exits the calling script

.DESCRIPTION
    Writes finishing logging data to specified log file and then exits the calling script

.PARAMETER LogPath
    Mandatory. Full path of the log file you want to write finishing data to. Example: C:\Windows\Temp\Test_Script.log

.PARAMETER NoExit
    Optional. If parameter specified, then the function will not exit the calling script, so that further execution can occur (like Send-Log)

.PARAMETER ToScreen
    Optional. When parameter specified will display the content to screen as well as write to log file. This provides an additional
    another option to write content to screen as opposed to using debug mode.

.INPUTS
    Parameters above

.OUTPUTS
    None

.NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  10/05/12
    Purpose/Change: Initial function development.

    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  19/05/12
    Purpose/Change: Added debug mode support.

    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  01/08/12
    Purpose/Change: Added option to not exit calling script if required (via optional parameter).

    Version:        1.3
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed function name to use approved PowerShell Verbs. Improved help documentation.

    Version:        1.4
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Changed -NoExit parameter to switch type so no longer need to specify $True or $False (see example for info).

    Version:        1.5
    Author:         Luca Sturlese
    Creation Date:  12/09/15
    Purpose/Change: Added -ToScreen parameter which will display content to screen as well as write to the log file.

    Version:        2.0
    Author:         Frank Honore
    Creation Date:  16/11/20
    Purpose/Change: Added color to -ToScreen parameter
                    Restructured how the log output is handled
                    Adding timecode and massageclassification each time 
                    Removed -Timestand option
                    Removed Link in Synopsis
                    Added -Dateformat option

.LINK

.EXAMPLE
    Stop-Log -LogPath "C:\Windows\Temp\Test_Script.log"

    Writes the closing logging information to the log file and then exits the calling script.

    Note: If you don't specify the -NoExit parameter, then the script will exit the calling script.

.EXAMPLE
    Stop-Log -LogPath $Logfile -NoExit

    Writes the closing logging information to the log file but does not exit the calling script. This then
    allows you to continue executing additional functionality in the calling script (such as calling the
    Send-Log function to email the created log to users).
#>

    [CmdletBinding()]

    Param (
        [Parameter(Mandatory=$true,Position=1)][string]$LogPath,
        [Parameter(Mandatory=$false)][string]$Dateformat = "MM-dd-yyyy HH:mm:ss",
        [Parameter(Mandatory=$false)][switch]$NoExit,
        [Parameter(Mandatory=$false)][switch]$ToScreen
    )

    Process {
        #Building Finish logging message
        $sLogMessageArr = @()
        $sLogMessageArr += ""
        $sLogMessageArr += ((Get-Date).tostring($Dateformat)).PadRight(24) + "Info".PadRight(12) + "*********************************************************************"
        $sLogMessageArr += ((Get-Date).tostring($Dateformat)).PadRight(24) + "Info".PadRight(12) + "Finished processing."
        $sLogMessageArr += ((Get-Date).tostring($Dateformat)).PadRight(24) + "Info".PadRight(12) + "*********************************************************************"

        ForEach ($line in $sLogMessageArr){
            Add-Content -Path $LogPath -Value $line
        }

        #Write to screen for debug mode
        ForEach ($line in $sLogMessageArr){
            Write-Debug $line
        }

        #Write to scren for ToScreen mode
        If ( $ToScreen -eq $True ) {
            ForEach ($line in $sLogMessageArr){
                Write-Host $line -ForegroundColor Cyan
            }
        }

        #Exit calling script if NoExit has not been specified or is set to False
        If( !($NoExit) -or ($NoExit -eq $False) ){
        Exit
        }
    }
}

Function Send-Log {
<#
.SYNOPSIS
    Emails completed log file to list of recipients

.DESCRIPTION
    Emails the contents of the specified log file to a list of recipients

.PARAMETER SMTPServer
    Mandatory. FQDN of the SMTP server used to send the email. Example: smtp.google.com

.PARAMETER LogPath
    Mandatory. Full path of the log file you want to email. Example: C:\Windows\Temp\Test_Script.log

.PARAMETER EmailFrom
    Mandatory. The email addresses of who you want to send the email from. Example: "admin@9to5IT.com"

.PARAMETER EmailTo
    Mandatory. The email addresses of where to send the email to. Seperate multiple emails by ",". Example: "admin@9to5IT.com, test@test.com"

.PARAMETER EmailSubject
    Mandatory. The subject of the email you want to send. Example: "Cool Script - [" + (Get-Date).ToShortDateString() + "]"

.INPUTS
    Parameters above

.OUTPUTS
    Email sent to the list of addresses specified

.NOTES
    Version:        1.0
    Author:         Luca Sturlese
    Creation Date:  05.10.12
    Purpose/Change: Initial function development.

    Version:        1.1
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Changed function name to use approved PowerShell Verbs. Improved help documentation.

    Version:        1.2
    Author:         Luca Sturlese
    Creation Date:  02/09/15
    Purpose/Change: Added SMTPServer parameter to pass SMTP server as oppposed to having to set it in the function manually.

    Version:        2.0
    Author:         Frank Honore
    Creation Date:  16/11/20
    Purpose/Change: Removed Link in Synopsis

.LINK

.EXAMPLE
    Send-Log -SMTPServer "smtp.google.com" -LogPath "C:\Windows\Temp\Test_Script.log" -EmailFrom "admin@9to5IT.com" -EmailTo "admin@9to5IT.com, test@test.com" -EmailSubject "Cool Script"

    Sends an email with the contents of the log file as the body of the email. Sends the email from admin@9to5IT.com and sends
    the email to admin@9to5IT.com and test@test.com email addresses. The email has the subject of Cool Script. The email is
    sent using the smtp.google.com SMTP server.
#>

    [CmdletBinding()]

    Param (
        [Parameter(Mandatory=$true,Position=1)][string]$SMTPServer,
        [Parameter(Mandatory=$true,Position=2)][string]$LogPath,
        [Parameter(Mandatory=$true,Position=3)][string]$EmailFrom,
        [Parameter(Mandatory=$true,Position=4)][string]$EmailTo,
        [Parameter(Mandatory=$true,Position=5)][string]$EmailSubject
    )

    Process {
        Try {
        $sBody = ( Get-Content $LogPath | Out-String )

        #Create SMTP object and send email
        $oSmtp = new-object Net.Mail.SmtpClient( $SMTPServer )
        $oSmtp.Send( $EmailFrom, $EmailTo, $EmailSubject, $sBody )
        Exit 0
        }

        Catch {
        Exit 1
        }
    }
}
