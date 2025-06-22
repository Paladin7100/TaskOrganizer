#-------------------------------------------------------------#
#----Initial Declarations-------------------------------------#
#-------------------------------------------------------------#

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Windows.Forms, System.Drawing 

if ($MyInvocation.MyCommand.CommandType -eq "ExternalScript")
{ # Powershell script
	$ScriptPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
}
else
{ # PS2EXE compiled script
	$ScriptPath = Split-Path -Parent -Path ([Environment]::GetCommandLineArgs()[0])
}

$AssemblyLocation = Join-Path -Path $ScriptPath -ChildPath .\themes
foreach ($Assembly in (Dir $AssemblyLocation -Filter *.dll)) {
    [System.Reflection.Assembly]::LoadFrom($Assembly.fullName) | out-null
}

<#
$Xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation" Width="1000" Height="600">
<Grid Margin="0,0,0,0">
<TabControl Margin="2.84375,9,0,0" Name="TabTABNAME" HorizontalContentAlignment="Left">
<TabItem Header="Task Order"><Grid Background="#FFE5E5E5">
</Grid>
</TabItem>
<TabItem Header="Script Parameters">
<Grid Background="#FFE5E5E5">
<ComboBox HorizontalAlignment="Left" VerticalAlignment="Top" Width="350" Margin="35,60,0,0" Name="ComboBoxScriptOrder"/>
<ComboBox HorizontalAlignment="Left" VerticalAlignment="Top" Width="350" Margin="435,60,0,0" Name="ComboBoxScheduledTask"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="ScriptOrder" Margin="30,40,0,0" FontWeight="SemiBold" Name="LabelScriptOrder"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="ScheduledTask" Margin="430,40,0,0" FontWeight="SemiBold" Name="LabelScheduledTask"/>

<Button Content="Update Parameter File" HorizontalAlignment="Left" VerticalAlignment="Top" Width="100" Margin="35,160,0,0" Name="ButtonUpdateParameterFile" Height="35"/>
<DataGrid HorizontalAlignment="Left" VerticalAlignment="Top" Width="900" Height="250" Margin="35,235,0,0" Name="DataGridParameters"/>
</Grid>
</TabItem>
<TabItem Header="Tab3">
<Grid Background="#FFE5E5E5">
</Grid>
</TabItem>
</TabControl>
</Grid></Window>
"@
#>
$Xaml = @"
<Controls:MetroWindow 
        xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        xmlns:d="http://schemas.microsoft.com/expression/blend/2008"
        xmlns:mc="http://schemas.openxmlformats.org/markup-compatibility/2006"
        xmlns:Controls="clr-namespace:MahApps.Metro.Controls;assembly=MahApps.Metro"
        xmlns:mah="clr-namespace:MahApps.Metro.Controls;assembly=MahApps.Metro" 
        xmlns:iconPacks="clr-namespace:MahApps.Metro.IconPacks;assembly=MahApps.Metro.IconPacks.Modern"
        Title="Create New Customer / New VM Network" Height="600" Width="1000">

        <Window.Resources>
			<ResourceDictionary>
			  <ResourceDictionary.MergedDictionaries>
				<!-- MahApps.Metro resource dictionaries. Make sure that all file names are Case Sensitive! -->
				<ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Controls.xaml" />
				<ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Fonts.xaml" />
				<!-- Theme setting -->
				<ResourceDictionary Source="pack://application:,,,/MahApps.Metro;component/Styles/Themes/Light.Red.xaml" />
			  </ResourceDictionary.MergedDictionaries>
			</ResourceDictionary>
        </Window.Resources>

<Grid Margin="0,0,0,0">
<TabControl Margin="3,9,0,0" Name="TabTABNAME" HorizontalContentAlignment="Left">
<TabItem Header="Task Order"><Grid>
</Grid>
</TabItem>
<TabItem Header="Script Parameters">
<Grid >
<ComboBox HorizontalAlignment="Left" VerticalAlignment="Top" Width="350" Margin="35,60,0,0" Name="ComboBoxScriptOrder"/>
<ComboBox HorizontalAlignment="Left" VerticalAlignment="Top" Width="350" Margin="435,60,0,0" Name="ComboBoxScheduledTask"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="ScriptOrder" Margin="30,40,0,0" FontWeight="SemiBold" Name="LabelScriptOrder"/>
<Label HorizontalAlignment="Left" VerticalAlignment="Top" Content="ScheduledTask" Margin="430,40,0,0" FontWeight="SemiBold" Name="LabelScheduledTask"/>

<Button Content="Update Parameter File" HorizontalAlignment="Left" VerticalAlignment="Top" Width="100" Margin="35,160,0,0" Name="ButtonUpdateParameterFile" Height="35"/>
<DataGrid HorizontalAlignment="Left" VerticalAlignment="Top" Width="900" Height="250" Margin="35,235,0,0" Name="DataGridParameters"/>
</Grid>
</TabItem>
<TabItem Header="Tab3">
<Grid >
</Grid>
</TabItem>
</TabControl>
</Grid>
</Controls:MetroWindow>
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
    $DataGridParameters.ItemsSource | ConvertTo-Csv -Delimiter ";" -NoTypeInformation | Out-File $DataGridParamatersPath
}

#endregion

#-------------------------------------------------------------#
#----Script Execution-----------------------------------------#
#-------------------------------------------------------------#

$Window = [Windows.Markup.XamlReader]::Parse($Xaml)

[xml]$xml = $Xaml

$xml.SelectNodes("//*[@Name]") | ForEach-Object { Set-Variable -Name $_.Name -Value $Window.FindName($_.Name) }

$ComboBoxScriptOrder.Add_SelectionChanged({fncScheduledTask $this $_})
$ComboBoxScheduledTask.Add_SelectionChanged({fncDataGridAddParameter $this $_})
$ButtonUpdateParameterFile.Add_Click({fncUpdateParameterFile $this $_})

fncScriptOrder
$Window.ShowDialog()
