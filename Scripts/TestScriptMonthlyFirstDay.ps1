Param (
	$Parameter1 = "",
	$Parameter2 = "",
	$Parameter3 = "",
	$Parameter4 = "",
	$Parameter5 = ""
)
# $Parameters = "Paramter1 = " + "$SCVMMServer" + " " + "Paramter2 = " + "$Paramter2" + " " + "Paramter3 = " + "$Paramter3" + " " + "Paramter4 = " + "$Paramter4" + " " + "Paramter5 = " + "$Paramter5"
$Message = $PSCommandPath


# Write-Warning "$Message"
Write-Warning "Parameter1 = $Parameter1"
Write-Warning "Parameter2 = $Parameter2"
Write-Warning "Parameter3 = $Parameter3"
Write-Warning "Parameter4 = $Parameter4"
Write-Warning "Parameter5 = $Parameter5"
