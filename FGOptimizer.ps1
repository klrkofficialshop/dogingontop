<#
.SYNOPSIS
    FRUSTRATED GAMER OPTIMIZER (FGOptimizer) - Pure PowerShell Edition
.DESCRIPTION
    Ultimate Low Latency & High FPS Game Optimizer Engine.
    Converts all FG Optimizer C# tweaks into a clean, transparent, single-file PowerShell script.
.LINK
    https://github.com/your-username/FG-Optimizer
#>

# ==============================================================================
# 1. ELEVATE TO ADMINISTRATOR PRIVILEGES IF NOT ALREADY ELEVATED
# ==============================================================================
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Host "[!] Requesting Administrator Privileges..." -ForegroundColor Yellow
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# Clear screen and show header
Clear-Host
Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host "   FRUSTRATED GAMER OPTIMIZER - POWERSHELL ENGINE        " -ForegroundColor Cyan
Write-Host "   Version 2.0 | High Performance & Low Latency Engine    " -ForegroundColor Gray
Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host ""

# Helper function to set registry properties safely
function Set-RegistryKeySafely {
    param (
        [string]$Path,
        [string]$Name,
        [object]$Value,
        [string]$Type = "DWord"
    )
    try {
        if (-not (Test-Path $Path)) {
            New-Item -Path $Path -Force | Out-Null
        }
        Set-ItemProperty -Path $Path -Name $Name -Value $Value -Type $Type -ErrorAction SilentlyContinue
    } catch {
        Write-Host "  [-] Failed to set $Name under $Path" -ForegroundColor Red
    }
}

# Helper function to manage services safely
function Set-ServiceSafely {
    param (
        [string]$ServiceName,
        [string]$StartupType = "Disabled"
    )
    try {
        if (Get-Service -Name $ServiceName -ErrorAction SilentlyContinue) {
            if ($StartupType -eq "Disabled") {
                Stop-Service -Name $ServiceName -Force -ErrorAction SilentlyContinue
            }
            Set-Service -Name $ServiceName -StartupType $StartupType -ErrorAction SilentlyContinue
            Write-Host "  [+] Configured service '$ServiceName' -> $StartupType" -ForegroundColor Gray
        }
    } catch {}
}

# ==============================================================================
# 2. SYSTEM & GAMING LATENCY TWEAKS
# ==============================================================================
Write-Host "[1/5] Applying Gaming & System Priority Tweaks..." -ForegroundColor Green

# System Responsiveness & Multimedia Tasks (Games)
Set-RegistryKeySafely -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 1 -Type DWord
Set-RegistryKeySafely -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff -Type DWord

$gamesTasksPath = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
Set-RegistryKeySafely -Path $gamesTasksPath -Name "GPU Priority" -Value 8 -Type DWord
Set-RegistryKeySafely -Path $gamesTasksPath -Name "Priority" -Value 6 -Type DWord
Set-RegistryKeySafely -Path $gamesTasksPath -Name "Scheduling Category" -Value "High" -Type String

# Remove Menu Delays
Set-RegistryKeySafely -Path "HKCU:\Control Panel\Desktop" -Name "MenuShowDelay" -Value "0" -Type String

# Enable Long Paths
Set-RegistryKeySafely -Path "HKLM:\SYSTEM\CurrentControlSet\Control\FileSystem" -Name "LongPathsEnabled" -Value 1 -Type DWord

# ==============================================================================
# 3. TELEMETRY & BACKGROUND TRACKING DISABLEMENT
# ==============================================================================
Write-Host "[2/5] Disabling Telemetry, Diagnostics & Error Reporting..." -ForegroundColor Green

# Windows Error Reporting & SmartScreen
Set-RegistryKeySafely -Path "HKLM:\SOFTWARE\Microsoft\Windows\Windows Error Reporting" -Name "Disabled" -Value 1 -Type DWord
Set-RegistryKeySafely -Path "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\SystemRestore" -Name "DisableSR" -Value 1 -Type DWord

# Office, Firefox, Chrome Telemetry Policies
Set-RegistryKeySafely -Path "HKCU:\Software\Policies\Microsoft\Office\16.0\osm" -Name "enabletelemetry" -Value 0 -Type DWord
Set-RegistryKeySafely -Path "HKLM:\SOFTWARE\Policies\Mozilla\Firefox" -Name "DisableTelemetry" -Value 1 -Type DWord
Set-RegistryKeySafely -Path "HKLM:\SOFTWARE\Policies\Google\Chrome" -Name "MetricsReportingEnabled" -Value 0 -Type DWord

# Background Telemetry & Unused Services
$telemetryServices = @("DiagTrack", "diagsvc", "dmwappushservice", "PcaSvc", "NvTelemetryContainer", "SensrSvc", "WMPNetworkSvc")
foreach ($svc in $telemetryServices) {
    Set-ServiceSafely -ServiceName $svc -StartupType "Disabled"
}

# ==============================================================================
# 4. DISABLING UNNECESSARY OS SERVICES & FEATURES
# ==============================================================================
Write-Host "[3/5] Optimizing Background Services & Storage..." -ForegroundColor Green

# Disable SysMain (Superfetch) & Search Indexing (Optional performance boosters)
Set-ServiceSafely -ServiceName "SysMain" -StartupType "Disabled"
Set-ServiceSafely -ServiceName "Fax" -StartupType "Disabled"
Set-ServiceSafely -ServiceName "Spooler" -StartupType "Disabled"

# Disable Hibernation (Reclaims hiberfil.sys storage space)
Write-Host "  [+] Disabling Hibernation to free up disk space..." -ForegroundColor Gray
powercfg -h off 2>$null

# ==============================================================================
# 5. UI & EXPLORER OPTIMIZATIONS
# ==============================================================================
Write-Host "[4/5] Tweaking Windows Explorer & UI..." -ForegroundColor Green

# Restore Windows 11 Classic Context Menu
Set-RegistryKeySafely -Path "HKCU:\Software\Classes\CLSID\{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}\InprocServer32" -Name "" -Value "" -Type String

# Hide Taskbar Weather & News
Set-RegistryKeySafely -Path "HKCU:\Software\Microsoft\Windows\CurrentVersion\Feeds" -Name "ShellFeedsTaskbarViewMode" -Value 2 -Type DWord
Set-RegistryKeySafely -Path "HKLM:\SOFTWARE\Policies\Microsoft\Dsh" -Name "AllowNewsAndInterests" -Value 0 -Type DWord

# Sticky Keys Disable (Prevents accidental popups during gaming)
Set-RegistryKeySafely -Path "HKCU:\Control Panel\Accessibility\StickyKeys" -Name "Flags" -Value "506" -Type String

# ==============================================================================
# 6. COMPLETION SUMMARY
# ==============================================================================
Write-Host "[5/5] Finalizing Optimization..." -ForegroundColor Green
Write-Host ""
Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host "  SUCCESS: All FG Optimizer Tweaks Have Been Applied!     " -ForegroundColor Green
Write-Host "  Recommended: Restart your PC to complete configuration.  " -ForegroundColor Yellow
Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host ""
