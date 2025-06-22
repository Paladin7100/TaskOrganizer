#-------------------------------------------------------------#
#----Initial Declarations-------------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationCore, PresentationFramework

$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Width="1000" Height="600">
<Grid Margin="0,0,0,0">
<ComboBox HorizontalAlignment="Left" VerticalAlignment="Top" Width="350" Margin="35,60,0,0" Name="ComboBoxScriptOrder"/>
<ComboBox HorizontalAlignment="Left" VerticalAlignment="Top" Width="350" Margin="435,60,0,0" Name="ComboBoxScheduledTask"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="ScriptOrder" Margin="30,40,0,0" FontWeight="SemiBold" Name="LabelScriptOrder"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="ScheduledTask" Margin="430,40,0,0" FontWeight="SemiBold" Name="LabelScheduledTask"/>

<Button Content="Update Parameter File" HorizontalAlignment="Left" VerticalAlignment="Top" Width="100" Margin="35,160,0,0" Name="ButtonUpdateParameterFile" Height="35"/>
<DataGrid HorizontalAlignment="Left" VerticalAlignment="Top" Width="900" Height="250" Margin="35,235,0,0" Name="DataGridParameters"/>

</Grid>
</Window>
"@

#-------------------------------------------------------------#
#----Control Event Handlers-----------------------------------#
#-------------------------------------------------------------#

$ScriptOrder = import-csv D:\Users\frank.TITAN\OneDrive\Scripts\GIT\TaskOrganizer\data\TaskOrganizerScriptOrder.txt -Delimiter ";"

function fncScriptOrder {
    $ComboBoxScriptOrder.Items.Clear() # Clear the list
    $ComboBoxScriptOrder.Text = $null  # Clear the current entry
    ForEach ($item in $ScriptOrder.Order) {
        $ComboBoxScriptOrder.Items.Add($item)
    }
}
function fncScheduler {
    
}
function fncScheduledTask {
    Write-Host $ComboBoxScriptOrder.SelectedItem
    $SchedulerPath = "D:\Users\frank.TITAN\OneDrive\Scripts\GIT\TaskOrganizer\data\" + $ComboBoxScriptOrder.SelectedItem + ".txt"
    Write-Host $SchedulerPath
    $ScheduledTask = import-csv $SchedulerPath -Delimiter ";"
    $ComboBoxScheduledTask.Items.Clear() # Clear the list
    # $ComboBoxScheduler.Text = $null  # Clear the current entry
    ForEach ($item in $ScheduledTask.ReportFile) {
        $ComboBoxScheduledTask.Items.Add($item)
    }
    $ComboBoxScheduledTask.SelectedIndex = 0
}
function fncDataGridAddParameter {
    If ($ComboBoxScheduledTask.SelectedItem){
        Write-Host $ComboBoxScheduledTask.SelectedItem
        $Global:DataGridParamatersPath = "D:\Users\frank.TITAN\OneDrive\Scripts\GIT\TaskOrganizer\data\" + $ComboBoxScriptOrder.SelectedItem + "." + $ComboBoxScheduledTask.SelectedItem + ".Parameters.txt"
        $DataGridParamaters = import-csv $DataGridParamatersPath -Delimiter ";"

        $Headers = $DataGridParamaters | Get-member -MemberType 'NoteProperty' | Select-Object -ExpandProperty 'Name'

        # Add data to a datatable
        $Datatable = New-Object System.Data.DataTable
        [void]$Datatable.Columns.AddRange($Headers)
        foreach ($item in $DataGridParamaters)
        {
            $Array = @()
            Foreach ($Header in $Headers)
            {
                $array += $item.$Header
            }
            [void]$Datatable.Rows.Add($array)
        }

        # Create a datagrid object and populate with datatable
        $DataGridParameters.ItemsSource = $Datatable.DefaultView
        $DataGridParameters.CanUserAddRows = $true
        $DataGridParameters.CanUserDeleteRows = $true
        $DataGridParameters.IsReadOnly = $false
        $DataGridParameters.GridLinesVisibility = "None"
    }
}

function fncUpdateParameterFile {
    $global:a = $DataGridParameters.ItemsSource | ConvertTo-Csv -Delimiter ";" -NoTypeInformation
    Write-Host $a
    $DataGridParameters.ItemsSource | ConvertTo-Csv -Delimiter ";" -NoTypeInformation | Out-File $DataGridParamatersPath
    # write-host $DataGridParameters.Items
}

function fncAddParameter2 {
    # Write-Host $Datatable.Columns.ColumnName
    ForEach ($items in $Datatable.Columns.ColumnName){
        $DatatableData = @()
        # Write-Host $Datatable.($items)
        $row = New-Object PSObject
        [array]$DatatableContent = $Datatable.$items
                # [array]$DatatableContent = $Datatable.($items.ColumnName)
        Write-Host $DatatableContent
        ForEach ($item in $DatatableContent){
            # Write-Host $item
            # sleep 1
            $row | Add-Member -MemberType NoteProperty -Name $items -Value $item
        }
        $DatatableData += $row         
    }
    write-host $DatatableData
    # Write-host $Datatable.table
}
#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }

# $ScriptParameters = Import-Csv D:\Users\frank.TITAN\OneDrive\Scripts\GIT\TaskOrganizer\data\TaskOrganizerDailyTasks.TestScriptDaily.ps1.Parameters.txt -Delimiter ";"

# $Headers = $ScriptParameters | Get-member -MemberType 'NoteProperty' | Select-Object -ExpandProperty 'Name'

# # Add data to a datatable
# $Datatable = New-Object System.Data.DataTable
# [void]$Datatable.Columns.AddRange($Headers)
# foreach ($item in $ScriptParameters)
# {
#     $Array = @()
#     Foreach ($Header in $Headers)
#     {
#         $array += $item.$Header
#     }
#     [void]$Datatable.Rows.Add($array)
# }

# # Create a datagrid object and populate with datatable
# $DataGridParameters.ItemsSource = $Datatable.DefaultView
# $DataGridParameters.CanUserAddRows = $true
# $DataGridParameters.CanUserDeleteRows = $true
# $DataGridParameters.IsReadOnly = $false
# $DataGridParameters.GridLinesVisibility = "None"

$ComboBoxScriptOrder.Add_SelectionChanged({fncScheduledTask $this $_})
$ComboBoxScheduledTask.Add_SelectionChanged({fncDataGridAddParameter $this $_})
$ButtonUpdateParameterFile.Add_Click({fncUpdateParameterFile $this $_})

fncScriptOrder
$Window.ShowDialog()
