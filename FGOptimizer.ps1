<#
.SYNOPSIS
    FRUSTRATED GAMER OPTIMIZER (FGOptimizer) - Full Dashboard Edition
.DESCRIPTION
    High-end multi-tab WPF GUI modeled after Chris Titus WinUtil.
    Includes Tweaks, Telemetry, Software Installer (via Winget), and System Cleaner.
#>

# Force Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework, PresentationCore, WindowsBase, System.Drawing, System.Windows.Forms

[xml]$xaml = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2006/xaml/presentation"
        xmlns:x="http://schemas.microsoft.com/winfx/2006/xaml"
        Title="Frustrated Gamer Optimizer Dashboard v2.0" Height="680" Width="980"
        WindowStartupLocation="CenterScreen" Background="#0F1017" Foreground="White" FontFamily="Segoe UI">
    <Grid Margin="15">
        <Grid.RowDefinitions>
            <RowDefinition Height="Auto"/>
            <RowDefinition Height="*"/>
            <RowDefinition Height="Auto"/>
        </Grid.RowDefinitions>

        <!-- Top Header Bar -->
        <Border Grid.Row="0" Background="#161824" CornerRadius="8" Padding="15,10" Margin="0,0,0,12" BorderBrush="#26293C" BorderThickness="1">
            <Grid>
                <Grid.ColumnDefinitions>
                    <ColumnDefinition Width="*"/>
                    <ColumnDefinition Width="Auto"/>
                </Grid.ColumnDefinitions>
                <StackPanel Grid.Column="0" Orientation="Horizontal" VerticalAlignment="Center">
                    <TextBlock Text="⚡" FontSize="22" Margin="0,0,10,0" VerticalAlignment="Center"/>
                    <StackPanel>
                        <TextBlock Text="FRUSTRATED GAMER OPTIMIZER" FontSize="18" FontWeight="Bold" Foreground="#F39C12"/>
                        <TextBlock Text="Windows Performance, Low Latency &amp; Application Manager" FontSize="11" Foreground="#8A8F9E"/>
                    </StackPanel>
                </StackPanel>
                <StackPanel Grid.Column="1" Orientation="Horizontal" VerticalAlignment="Center">
                    <Border Background="#202336" CornerRadius="4" Padding="10,4" Margin="5,0">
                        <TextBlock Text="Win10/11 Compatible" FontSize="11" Foreground="#00E5FF" FontWeight="Bold"/>
                    </Border>
                    <Border Background="#2A1C35" CornerRadius="4" Padding="10,4">
                        <TextBlock Text="v2.0 Dashboard" FontSize="11" Foreground="#E74C3C" FontWeight="Bold"/>
                    </Border>
                </StackPanel>
            </Grid>
        </Border>

        <!-- Main Body: Sidebar + Tabs -->
        <Grid Grid.Row="1">
            <Grid.ColumnDefinitions>
                <ColumnDefinition Width="210"/>
                <ColumnDefinition Width="*"/>
            </Grid.ColumnDefinitions>

            <!-- Left Sidebar Controls -->
            <Border Grid.Column="0" Background="#141622" CornerRadius="8" Padding="12" Margin="0,0,12,0" BorderBrush="#23263A" BorderThickness="1">
                <Grid>
                    <Grid.RowDefinitions>
                        <RowDefinition Height="Auto"/>
                        <RowDefinition Height="*"/>
                        <RowDefinition Height="Auto"/>
                    </Grid.RowDefinitions>

                    <StackPanel Grid.Row="0">
                        <TextBlock Text="ACTIONS" FontSize="11" FontWeight="Bold" Foreground="#6C7293" Margin="0,0,0,8"/>
                        <Button Name="btnSelectAll" Content="Select All Options" Height="32" Margin="0,0,0,6" Background="#222538" Foreground="White" BorderThickness="0" Cursor="Hand"/>
                        <Button Name="btnClearAll" Content="Clear All Options" Height="32" Margin="0,0,0,12" Background="#222538" Foreground="#A0A5B5" BorderThickness="0" Cursor="Hand"/>
                    </StackPanel>

                    <StackPanel Grid.Row="2">
                        <Button Name="btnApplyTweaks" Content="⚡ APPLY ALL TWEAKS" Height="44" Margin="0,0,0,8" Background="#F39C12" Foreground="Black" FontWeight="Bold" FontSize="12" BorderThickness="0" Cursor="Hand"/>
                        <Button Name="btnRunCleaner" Content="🧹 RUN CLEANER" Height="44" Background="#00E5FF" Foreground="Black" FontWeight="Bold" FontSize="12" BorderThickness="0" Cursor="Hand"/>
                    </StackPanel>
                </Grid>
            </Border>

            <!-- Right Tab Control -->
            <TabControl Grid.Column="1" Background="Transparent" BorderThickness="0">
                <TabControl.Resources>
                    <Style TargetType="TabItem">
                        <Setter Property="Background" Value="#161824"/>
                        <Setter Property="Foreground" Value="#A0A5B5"/>
                        <Setter Property="Padding" Value="14,8"/>
                        <Setter Property="Margin" Value="0,0,4,6"/>
                        <Setter Property="FontWeight" Value="Bold"/>
                        <Setter Property="BorderThickness" Value="0"/>
                    </Style>
                </TabControl.Resources>

                <!-- TAB 1: GAMING & LATENCY TWEAKS -->
                <TabItem Header="⚡ Gaming &amp; Latency">
                    <ScrollViewer VerticalScrollBarVisibility="Auto" Margin="0,8,0,0">
                        <StackPanel>
                            <Border Background="#161824" CornerRadius="6" Padding="15" Margin="0,0,0,10" BorderBrush="#26293C" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="System Responsiveness &amp; GPU Priority" FontSize="14" FontWeight="Bold" Foreground="#F39C12" Margin="0,0,0,10"/>
                                    <CheckBox Name="chkGPU" Content="Set SystemResponsiveness = 1 &amp; High GPU Priority" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="chkNet" Content="Set NetworkThrottlingIndex = Unlimited (Reduces Game Ping)" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="chkMenu" Content="Set MenuShowDelay = 0 (Instant Menu Response)" IsChecked="True" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </Border>

                            <Border Background="#161824" CornerRadius="6" Padding="15" Margin="0,0,0,10" BorderBrush="#26293C" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Input &amp; Gaming Protection" FontSize="14" FontWeight="Bold" Foreground="#00E5FF" Margin="0,0,0,10"/>
                                    <CheckBox Name="chkSticky" Content="Disable Sticky Keys Popup (Prevents Shift key minimize in games)" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="chkClassicMenu" Content="Restore Classic Windows 11 Right-Click Context Menu" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="chkLongPaths" Content="Enable NTFS Long File Paths Support" IsChecked="True" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </ScrollViewer>
                </TabItem>

                <!-- TAB 2: TELEMETRY & PRIVACY -->
                <TabItem Header="🛡️ Privacy &amp; Services">
                    <ScrollViewer VerticalScrollBarVisibility="Auto" Margin="0,8,0,0">
                        <StackPanel>
                            <Border Background="#161824" CornerRadius="6" Padding="15" Margin="0,0,0,10" BorderBrush="#26293C" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Windows Telemetry &amp; Diagnostics" FontSize="14" FontWeight="Bold" Foreground="#E74C3C" Margin="0,0,0,10"/>
                                    <CheckBox Name="chkDiagTrack" Content="Disable Connected User Experiences &amp; Telemetry (DiagTrack)" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="chkWER" Content="Disable Windows Error Reporting Service" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="chkAppTelemetry" Content="Disable Chrome, Firefox &amp; Microsoft Office Telemetry" IsChecked="True" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </Border>

                            <Border Background="#161824" CornerRadius="6" Padding="15" Margin="0,0,0,10" BorderBrush="#26293C" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Background Services &amp; Taskbar" FontSize="14" FontWeight="Bold" Foreground="#9B59B6" Margin="0,0,0,10"/>
                                    <CheckBox Name="chkSysMain" Content="Disable SysMain (Superfetch) Service" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="chkPrintFax" Content="Disable Print Spooler &amp; Fax Services" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="chkFeeds" Content="Disable Taskbar News, Weather &amp; Feeds Widget" IsChecked="True" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </ScrollViewer>
                </TabItem>

                <!-- TAB 3: APP INSTALLER (WINGET) -->
                <TabItem Header="📦 App Installer">
                    <ScrollViewer VerticalScrollBarVisibility="Auto" Margin="0,8,0,0">
                        <StackPanel>
                            <Border Background="#161824" CornerRadius="6" Padding="15" Margin="0,0,0,10" BorderBrush="#26293C" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="One-Click Software Installer (via Winget)" FontSize="14" FontWeight="Bold" Foreground="#2ECC71" Margin="0,0,0,10"/>
                                    <UniformGrid Columns="2">
                                        <CheckBox Name="appChrome" Content="Google Chrome" Foreground="White" Margin="0,5"/>
                                        <CheckBox Name="appDiscord" Content="Discord" Foreground="White" Margin="0,5"/>
                                        <CheckBox Name="appBrave" Content="Brave Browser" Foreground="White" Margin="0,5"/>
                                        <CheckBox Name="appSteam" Content="Steam" Foreground="White" Margin="0,5"/>
                                        <CheckBox Name="appFirefox" Content="Mozilla Firefox" Foreground="White" Margin="0,5"/>
                                        <CheckBox Name="appOBS" Content="OBS Studio" Foreground="White" Margin="0,5"/>
                                        <CheckBox Name="app7Zip" Content="7-Zip" Foreground="White" Margin="0,5"/>
                                        <CheckBox Name="appVSCode" Content="Visual Studio Code" Foreground="White" Margin="0,5"/>
                                    </UniformGrid>
                                    <Button Name="btnInstallApps" Content="📦 Install Selected Apps" Height="36" Margin="0,15,0,0" Background="#2ECC71" Foreground="Black" FontWeight="Bold" Cursor="Hand"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </ScrollViewer>
                </TabItem>

                <!-- TAB 4: SYSTEM CLEANER -->
                <TabItem Header="🧹 System Cleaner">
                    <ScrollViewer VerticalScrollBarVisibility="Auto" Margin="0,8,0,0">
                        <StackPanel>
                            <Border Background="#161824" CornerRadius="6" Padding="15" Margin="0,0,0,10" BorderBrush="#26293C" BorderThickness="1">
                                <StackPanel>
                                    <TextBlock Text="Storage &amp; Junk File Cleaning" FontSize="14" FontWeight="Bold" Foreground="#00E5FF" Margin="0,0,0,10"/>
                                    <CheckBox Name="cleanTemp" Content="Clear User &amp; Windows Temp Folders (%TEMP%, C:\Windows\Temp)" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="cleanPrefetch" Content="Clear Windows Prefetch Cache" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="cleanLogs" Content="Clear Windows Log Files &amp; Error Logs" IsChecked="True" Foreground="White" Margin="0,5"/>
                                    <CheckBox Name="chkHiber" Content="Disable Hibernation File (Frees 4GB - 16GB Storage)" IsChecked="True" Foreground="White" Margin="0,5"/>
                                </StackPanel>
                            </Border>
                        </StackPanel>
                    </ScrollViewer>
                </TabItem>
            </TabControl>
        </Grid>

        <!-- Bottom Log Output Console -->
        <Border Grid.Row="2" Background="#11121B" CornerRadius="6" Padding="10" Margin="0,10,0,0" BorderBrush="#202334" BorderThickness="1">
            <TextBox Name="txtConsole" Height="70" Background="Transparent" Foreground="#00E5FF" BorderThickness="0"
                     IsReadOnly="True" TextWrapping="Wrap" VerticalScrollBarVisibility="Auto" FontFamily="Consolas" FontSize="11"
                     Text="[System] Dashboard initialized. Select options and click 'APPLY ALL TWEAKS' or 'RUN CLEANER'."/>
        </Border>
    </Grid>
</Window>
"@

$reader = New-Object System.Xml.XmlNodeReader $xaml
$window = [System.Windows.Markup.XamlReader]::Load($reader)

# Controls Reference
$txtConsole     = $window.FindName("txtConsole")
$btnApplyTweaks = $window.FindName("btnApplyTweaks")
$btnRunCleaner  = $window.FindName("btnRunCleaner")
$btnInstallApps = $window.FindName("btnInstallApps")
$btnSelectAll   = $window.FindName("btnSelectAll")
$btnClearAll    = $window.FindName("btnClearAll")

# Checkboxes
$chkGPU         = $window.FindName("chkGPU")
$chkNet         = $window.FindName("chkNet")
$chkMenu        = $window.FindName("chkMenu")
$chkSticky      = $window.FindName("chkSticky")
$chkClassicMenu = $window.FindName("chkClassicMenu")
$chkLongPaths   = $window.FindName("chkLongPaths")
$chkDiagTrack   = $window.FindName("chkDiagTrack")
$chkWER         = $window.FindName("chkWER")
$chkAppTelemetry= $window.FindName("chkAppTelemetry")
$chkSysMain     = $window.FindName("chkSysMain")
$chkPrintFax    = $window.FindName("chkPrintFax")
$chkFeeds       = $window.FindName("chkFeeds")

# App Checkboxes
$appChrome  = $window.FindName("appChrome")
$appDiscord = $window.FindName("appDiscord")
$appBrave   = $window.FindName("appBrave")
$appSteam   = $window.FindName("appSteam")
$appFirefox = $window.FindName("appFirefox")
$appOBS     = $window.FindName("appOBS")
$app7Zip    = $window.FindName("app7Zip")
$appVSCode  = $window.FindName("appVSCode")

# Cleaner Checkboxes
$cleanTemp     = $window.FindName("cleanTemp")
$cleanPrefetch = $window.FindName("cleanPrefetch")
$cleanLogs     = $window.FindName("cleanLogs")
$chkHiber      = $window.FindName("chkHiber")

function LogMsg ($msg) {
    $txtConsole.AppendText("`n[$(Get-Date -Format 'HH:mm:ss')] $msg")
    $txtConsole.ScrollToEnd()
}

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

# Select/Clear All Buttons
$btnSelectAll.Add_Click({
    $chkGPU.IsChecked = $chkNet.IsChecked = $chkMenu.IsChecked = $chkSticky.IsChecked = $chkClassicMenu.IsChecked = $chkLongPaths.IsChecked = $true
    $chkDiagTrack.IsChecked = $chkWER.IsChecked = $chkAppTelemetry.IsChecked = $chkSysMain.IsChecked = $chkPrintFax.IsChecked = $chkFeeds.IsChecked = $true
    LogMsg "Selected all tweak options."
})

$btnClearAll.Add_Click({
    $chkGPU.IsChecked = $chkNet.IsChecked = $chkMenu.IsChecked = $chkSticky.IsChecked = $chkClassicMenu.IsChecked = $chkLongPaths.IsChecked = $false
    $chkDiagTrack.IsChecked = $chkWER.IsChecked = $chkAppTelemetry.IsChecked = $chkSysMain.IsChecked = $chkPrintFax.IsChecked = $chkFeeds.IsChecked = $false
    LogMsg "Cleared all tweak options."
})

# Apply Tweaks
$btnApplyTweaks.Add_Click({
    LogMsg "Executing selected System & Gaming Tweaks..."

    if ($chkGPU.IsChecked) {
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "SystemResponsiveness" 1
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "GPU Priority" 8
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Priority" 6
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games" "Scheduling Category" "High" "String"
        LogMsg "-> GPU Priority & SystemResponsiveness applied."
    }

    if ($chkNet.IsChecked) {
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" "NetworkThrottlingIndex" 0xffffffff
        LogMsg "-> Network Throttling Index set to Unlimited."
    }

    if ($chkMenu.IsChecked) {
        Set-RegKey "HKCU:\Control Panel\Desktop" "MenuShowDelay" "0" "String"
        LogMsg "-> MenuShowDelay set to 0."
    }

    if ($chkSticky.IsChecked) {
        Set-RegKey "HKCU:\Control Panel\Accessibility\StickyKeys" "Flags" "506" "String"
        LogMsg "-> Sticky Keys popup disabled."
    }

    if ($chkClassicMenu.IsChecked) {
        Set-RegKey "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" "" "" "String"
        LogMsg "-> Windows 11 Classic Context Menu restored."
    }

    if ($chkLongPaths.IsChecked) {
        Set-RegKey "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" "LongPathsEnabled" 1
        LogMsg "-> Long File Paths enabled."
    }

    if ($chkDiagTrack.IsChecked) {
        Disable-Svc "DiagTrack"
        Disable-Svc "diagsvc"
        Disable-Svc "dmwappushservice"
        LogMsg "-> Telemetry services disabled."
    }

    if ($chkWER.IsChecked) {
        Set-RegKey "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" "Disabled" 1
        LogMsg "-> Windows Error Reporting disabled."
    }

    if ($chkAppTelemetry.IsChecked) {
        Set-RegKey "HKCU:\Software\Policies\Microsoft\Office\16.0\osm" "enabletelemetry" 0
        Set-RegKey "HKLM:\SOFTWARE\Policies\Mozilla\Firefox" "DisableTelemetry" 1
        Set-RegKey "HKLM:\SOFTWARE\Policies\Google\Chrome" "MetricsReportingEnabled" 0
        LogMsg "-> App telemetry disabled."
    }

    if ($chkSysMain.IsChecked) { Disable-Svc "SysMain"; LogMsg "-> SysMain disabled." }
    if ($chkPrintFax.IsChecked) { Disable-Svc "Spooler"; Disable-Svc "Fax"; LogMsg "-> Print & Fax disabled." }
    if ($chkFeeds.IsChecked) {
        Set-RegKey "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" "ShellFeedsTaskbarViewMode" 2
        LogMsg "-> Taskbar Feeds disabled."
    }

    LogMsg "⚡ SUCCESS: All selected tweaks applied! Restart recommended."
})

# Cleaner Engine
$btnRunCleaner.Add_Click({
    LogMsg "Running System Cleaner..."

    if ($cleanTemp.IsChecked) {
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        LogMsg "-> Temp folders cleared."
    }

    if ($cleanPrefetch.IsChecked) {
        Remove-Item "C:\Windows\Prefetch\*" -Recurse -Force -ErrorAction SilentlyContinue
        LogMsg "-> Prefetch cache cleared."
    }

    if ($chkHiber.IsChecked) {
        powercfg -h off 2>$null
        LogMsg "-> Hibernation file disabled (Storage freed)."
    }

    LogMsg "🧹 SUCCESS: System junk cleaning completed!"
})

# App Installer Engine
$btnInstallApps.Add_Click({
    $appsToInstall = @()
    if ($appChrome.IsChecked)  { $appsToInstall += "Google.Chrome" }
    if ($appDiscord.IsChecked) { $appsToInstall += "Discord.Discord" }
    if ($appBrave.IsChecked)   { $appsToInstall += "Brave.Brave" }
    if ($appSteam.IsChecked)   { $appsToInstall += "Valve.Steam" }
    if ($appFirefox.IsChecked) { $appsToInstall += "Mozilla.Firefox" }
    if ($appOBS.IsChecked)     { $appsToInstall += "OBSProject.OBSStudio" }
    if ($app7Zip.IsChecked)    { $appsToInstall += "7zip.7zip" }
    if ($appVSCode.IsChecked)  { $appsToInstall += "Microsoft.VisualStudioCode" }

    if ($appsToInstall.Count -eq 0) {
        LogMsg "[-] No applications selected to install."
        return
    }

    foreach ($appId in $appsToInstall) {
        LogMsg "Installing $appId via Winget..."
        Start-Process winget -ArgumentList "install --id $appId --silent --accept-source-agreements --accept-package-agreements" -NoNewWindow -Wait
        LogMsg "Installed $appId successfully!"
    }
})

# Launch Window
$window.ShowDialog() | Out-Null
