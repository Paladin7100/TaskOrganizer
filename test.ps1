[xml]$XAML = @'
<Window
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
    Title="Server Rebuild Request" Height="600" Width="1000" Background="White" ResizeMode="NoResize">
    <Grid Margin="0,0,0,0" Background="White">

    <Grid
    xmlns:Controls="clr-namespace:MahApps.Metro.Controls;assembly=MahApps.Metro"
    xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"

    xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml">


    <Grid>
   <DataGrid Name="Datagrid" IsReadOnly="False" CanUserAddRows="True" CanUserDeleteRows="True" CanUserReorderColumns="True" CanUserSortColumns="True" AutoGenerateColumns="False" RowBackground="#D1F29C" RowDetailsVisibilityMode="Visible" Cursor="Hand"  >


        <DataGrid.Columns >


           <DataGridTextColumn Header="TaskName" IsReadOnly="False" Binding="{Binding TaskName}" Width="100" Foreground="#FF631F1F" />
           <DataGridTextColumn Header="Category" IsReadOnly="False" Binding="{Binding Category}" Width="100" Foreground="#FF631F1F" />


            <DataGridTextColumn Header="Status" Binding="{Binding Status}" Width="80" Foreground="#FF631F1F"/>
            <DataGridTextColumn Header="Created By" Binding="{Binding 'Created By'}" Width="100" Foreground="#FF631F1F"/>
            <DataGridTextColumn Header="Asigned To" Binding="{Binding 'Asigned To'}" Width="100" Foreground="#FF631F1F"/>
            <DataGridTextColumn Header="Dead Line" Binding="{Binding 'Dead Line'}" Width="90" Foreground="#FF631F1F"/>
            <DataGridTextColumn Header="Age" Binding="{Binding 'Age'}" Width="50" Foreground="#FF631F1F"/>
            <DataGridHyperlinkColumn Header="Source URL" Binding="{Binding 'Source URL'}" Width="300" FocusManager.IsFocusScope="True" />
            <DataGridTemplateColumn Header="Action">


                        <DataGridTemplateColumn.CellEditingTemplate>
                            <DataTemplate>
                                <ComboBox 
                                    Height="22" >

                                    <ComboBoxItem AllowDrop="True" Content="'In Progress','Done'" IsSelected="False"/>
                                </ComboBox>
                            </DataTemplate>
                            </DataGridTemplateColumn.CellEditingTemplate>

                    </DataGridTemplateColumn>



                    <DataGridTemplateColumn>

                        <DataGridTemplateColumn.CellTemplate>


                        </DataGridTemplateColumn.CellTemplate>
                    </DataGridTemplateColumn>


        </DataGrid.Columns>



    </DataGrid>
    </Grid>



</Grid>


    </Grid>
</Window>
'@


#Read XAML
$reader=(New-Object System.Xml.XmlNodeReader $xaml) 
try{$Form=[Windows.Markup.XamlReader]::Load( $reader )}
catch{Write-Host "Unable to load Windows.Markup.XamlReader. Some possible causes for this problem include: .NET Framework is missing PowerShell must be launched with PowerShell -sta, invalid XAML code was encountered."; exit}

$xaml.SelectNodes("//*[@Name]") | %{Set-Variable -Name ($_.Name) -Value $Form.FindName($_.Name)}

$Datagrid.RowStyle=[System.Windows.Style]::new()
$Datagrid.IsEnabled=$true
#$Datagrid.is
$itemsArray = @([pscustomobject]@{TaskName='Test1';Category='CTB';Status='InProgress'; 'Created By'='TestCode'; 'Asigned To'='TestCode'; 'Dead Line'=$DeadLine; Age=$Age; 'Source URL'=$href},
    [pscustomobject]@{TaskName='Test2';Category='CTB';Status='InProgress'; 'Created By'='TestCode'; 'Asigned To'='TestCode'; 'Dead Line'=$DeadLine; Age=$Age; 'Source URL'=$href},
    [pscustomobject]@{TaskName=$null;Category=$null;Status=$null; 'Created By'=$null; 'Asigned To'=$null; 'Dead Line'=$DeadLine; Age=$Age; 'Source URL'=$href}
)
$Datagrid.ItemsSource = $itemsArray
#$DataGrid.AddChild([pscustomobject]@{TaskName='Test1';Category='CTB';Status='InProgress'; 'Created By'='TestCode'; 'Asigned To'='TestCode'; 'Dead Line'=$DeadLine; Age=$Age; 'Source URL'=$href})
#$DataGrid.AddChild([pscustomobject]@{TaskName='Test2';Category='CTB';Status='InProgress'; 'Created By'='TestCode'; 'Asigned To'='TestCode'; 'Dead Line'=$DeadLine; Age=$Age; 'Source URL'=$href})
#$DataGrid.AddChild([pscustomobject]@{TaskName=$null;Category=$null;Status=$null; 'Created By'=$null; 'Asigned To'=$null; 'Dead Line'=$DeadLine; Age=$Age; 'Source URL'=$href})


$Datagrid.Add_Mousedoubleclick({
Write-Host "Mouse double clicked"
$Datagrid.Items.EditItem($Datagrid.SelectedItem)
})


$Form.ShowDialog()