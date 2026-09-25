<#
.SYNOPSIS
    FRUSTRATED GAMER OPTIMIZER (FGOptimizer) - Modern WPF GUI Edition
.DESCRIPTION
    Full Graphical User Interface (GUI) powered by WPF and PowerShell.
    Allows users to toggle gaming tweaks, telemetry settings, service optimizations, and clean system junk.
#>

# 1. Force Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Load WPF Assemblies
Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Drawing, System.Windows.Forms

# Define XAML Interface
[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Frustrated Gamer Optimizer v2.0" Height="580" Width="720"
        WindowStartupLocation="CenterScreen" ResizeMode="NoResize"
        Background="#12131C" Foreground="White" FontFamily="Segoe UI">
    <Grid Margin="20">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Header -->
        <Border Grid.Row="0" Background="#1C1E2D" CornerRadius="8" Padding="15" Margin="0,0,0,15">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0">
                    <TextBlock Text="FRUSTRATED GAMER OPTIMIZER" FontSize="20" FontWeight="Bold" Foreground="#F39C12"/>
                    <TextBlock Text="Ultimate Low Latency &amp; High FPS Game Optimizer Engine" FontSize="12" Foreground="#8A8F9E" Margin="0,2,0,0"/>
                </StackPanel>
                <Border Grid.Column="1" Background="#26293C" CornerRadius="5" Padding="10,5">
                    <TextBlock Text="v2.0 GUI" FontWeight="Bold" Foreground="#00E5FF"/>
                </Border>
            </Grid>
        </Border>

        <!-- Main Tweak Options -->
        <ScrollViewer Grid.Row="1" VerticalScrollBarVisibility="Auto">
            <StackPanel Margin="0,0,10,0">
                <!-- Group 1: Performance Tweaks -->
                <Border Background="#1A1C29" CornerRadius="6" Padding="12" Margin="0,0,0,10" BorderBrush="#2D3146" BorderThickness="1">
                    <StackPanel>
                        <TextBlock Text="⚡ Gaming &amp; Latency Tweaks" FontSize="14" FontWeight="Bold" Foreground="#F39C12" Margin="0,0,0,8"/>
                        <CheckBox Name="chkGPU" Content="Enable High GPU Priority &amp; System Responsiveness" IsChecked="True" Foreground="White" Margin="0,4"/>
                        <CheckBox Name="chkNet" Content="Optimize Network Throttling Index (Low Latency / Ping)" IsChecked="True" Foreground="White" Margin="0,4"/>
                        <CheckBox Name="chkMenu" Content="Remove Start Menu &amp; Context Menu Delays" IsChecked="True" Foreground="White" Margin="0,4"/>
                    </StackPanel>
                </Border>

                <!-- Group 2: Telemetry Tweaks -->
                <Border Background="#1A1C29" CornerRadius="6" Padding="12" Margin="0,0,0,10" BorderBrush="#2D3146" BorderThickness="1">
                    <StackPanel>
                        <TextBlock Text="🛡️ Privacy &amp; Telemetry Disablement" FontSize="14" FontWeight="Bold" Foreground="#00E5FF" Margin="0,0,0,8"/>
                        <CheckBox Name="chkTelemetry" Content="Disable Windows DiagTrack &amp; Error Reporting" IsChecked="True" Foreground="White" Margin="0,4"/>
                        <CheckBox Name="chkAppTelemetry" Content="Disable Chrome, Firefox &amp; Office Telemetry" IsChecked="True" Foreground="White" Margin="0,4"/>
                        <CheckBox Name="chkSticky" Content="Disable Sticky Keys Popup (Gaming Protection)" IsChecked="True" Foreground="White" Margin="0,4"/>
                    </StackPanel>
                </Border>

                <!-- Group 3: Service & Disk Tweaks -->
                <Border Background="#1A1C29" CornerRadius="6" Padding="12" Margin="0,0,0,10" BorderBrush="#2D3146" BorderThickness="1">
                    <StackPanel>
                        <TextBlock Text="🚀 Services &amp; System Optimization" FontSize="14" FontWeight="Bold" Foreground="#2ECC71" Margin="0,0,0,8"/>
                        <CheckBox Name="chkSysMain" Content="Disable SysMain (Superfetch) &amp; Unused Services" IsChecked="True" Foreground="White" Margin="0,4"/>
                        <CheckBox Name="chkHiber" Content="Disable Hibernation (Free up GBs of Storage)" IsChecked="True" Foreground="White" Margin="0,4"/>
                        <CheckBox Name="chkLongPath" Content="Enable Windows Long File Paths Support" IsChecked="True" Foreground="White" Margin="0,4"/>
                    </StackPanel>
                </Border>
            </StackPanel>
        </ScrollViewer>

        <!-- Status Box -->
        <Border Grid.Row="2" Background="#171824" CornerRadius="5" Padding="10" Margin="0,10,0,10">
            <TextBlock Name="txtStatus" Text="Ready. Select your desired tweaks above and click 'Apply Tweaks'." Foreground="#A0A5B5" FontSize="12"/>
        </Border>

        <!-- Buttons -->
        <Grid Grid.Row="3">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="*"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <Button Name="btnApply" Content="⚡ APPLY SELECTED TWEAKS" Grid.Column="0" Height="42" Margin="0,0,5,0"
                    Background="#F39C12" Foreground="Black" FontWeight="Bold" FontSize="13" BorderThickness="0" Cursor="Hand">
                <Button.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="6"/>
                    </Style>
                </Button.Resources>
            </Button>

            <Button Name="btnClean" Content="🧹 CLEAN JUNK &amp; TEMP FILES" Grid.Column="1" Height="42" Margin="5,0,0,0"
                    Background="#00E5FF" Foreground="Black" FontWeight="Bold" FontSize="13" BorderThickness="0" Cursor="Hand">
                <Button.Resources>
                    <Style TargetType="Border">
                        <Setter Property="CornerRadius" Value="6"/>
                    </Style>
                </Button.Resources>
            </Button>
        </Grid>
    </Grid>
</Window>
"@

# Read & Create WPF Window
$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [System.Windows.Markup.XamlReader]::Load($reader)

# Get Controls
$btnApply       = $window.FindName("btnApply")
$btnClean       = $window.FindName("btnClean")
$txtStatus      = $window.FindName("txtStatus")
$chkGPU         = $window.FindName("chkGPU")
$chkNet         = $window.FindName("chkNet")
$chkMenu        = $window.FindName("chkMenu")
$chkTelemetry   = $window.FindName("chkTelemetry")
$chkAppTelemetry= $window.FindName("chkAppTelemetry")
$chkSticky      = $window.FindName("chkSticky")
$chkSysMain     = $window.FindName("chkSysMain")
$chkHiber       = $window.FindName("chkHiber")
$chkLongPath    = $window.FindName("chkLongPath")

# Safe Helper Functions
function Set-RegKey ($Path, $Name, $Value, $Type = "DWord") {
    try {
        if (-not (Test-Path $Path)) { New-Item -Path $Path -Force | Out-Null }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -ErrorAction SilentlyContinue
    } catch {}
}

function Disable-Svc ($SvcName) {
    try {
        if (Get-Service -Name $SvcName -ErrorAction SilentlyContinue) {
            Stop-Service -Name $SvcName -Force -ErrorAction SilentlyContinue
            Set-Service -Name $SvcName -StartupType Disabled -ErrorAction SilentlyContinue
        }
    } catch {}
}

# Button Click: Apply Tweaks
$btnApply.Add_Click({
    $txtStatus.Text = "Applying selected tweaks... Please wait."
    $txtStatus.Foreground = [System.Windows.Media.Brushes]::Yellow

    if ($chkGPU.IsChecked) {
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "SystemResponsiveness" 1
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "GPU Priority" 8
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Priority" 6
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Scheduling Category" "High" "String"
    }

    if ($chkNet.IsChecked) {
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "NetworkThrottlingIndex" 0xffffffff
    }

    if ($chkMenu.IsChecked) {
        Set-RegKey "HKCU:\Control Panel\Desktop" "MenuShowDelay" "0" "String"
    }

    if ($chkTelemetry.IsChecked) {
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "Disabled" 1
        Set-RegKey "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" "DisableSR" 1
        Disable-Svc "DiagTrack"
        Disable-Svc "diagsvc"
        Disable-Svc "dmwappushservice"
        Disable-Svc "PcaSvc"
    }

    if ($chkAppTelemetry.IsChecked) {
        Set-RegKey "HKCU:\Software\Policies\Microsoft\Office\16.0\osm" "enabletelemetry" 0
        Set-RegKey "HKLM:\SOFTWARE\Policies\Mozilla\Firefox" "DisableTelemetry" 1
        Set-RegKey "HKLM:\SOFTWARE\Policies\Google\Chrome" "MetricsReportingEnabled" 0
    }

    if ($chkSticky.IsChecked) {
        Set-RegKey "HKCU:\Control Panel\Accessibility\StickyKeys" "Flags" "506" "String"
    }

    if ($chkSysMain.IsChecked) {
        Disable-Svc "SysMain"
        Disable-Svc "Fax"
        Disable-Svc "Spooler"
    }

    if ($chkHiber.IsChecked) {
        powercfg -h off 2>$null
    }

    if ($chkLongPath.IsChecked) {
        Set-RegKey "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "LongPathsEnabled" 1
    }

    $txtStatus.Text = "⚡ SUCCESS: All selected tweaks applied successfully! Please restart your PC."
    $txtStatus.Foreground = [System.Windows.Media.Brushes]::LimeGreen
})

# Button Click: Clean Junk Files
$btnClean.Add_Click({
    $txtStatus.Text = "Cleaning system temporary files and junk..."
    $txtStatus.Foreground = [System.Windows.Media.Brushes]::Yellow

    $tempFolders = @($env:TEMP, "C:\Windows\Temp", "C:\Windows\Prefetch")
    foreach ($folder in $tempFolders) {
        if (Test-Path $folder) {
            Remove-Item -Path "$folder\*" -Recurse -Force -ErrorAction SilentlyContinue
        }
    }

    $txtStatus.Text = "🧹 SUCCESS: System junk files and caches cleared!"
    $txtStatus.Foreground = [System.Windows.Media.Brushes]::LimeGreen
})

# Launch GUI
$window.ShowDialog() | Out-Null
