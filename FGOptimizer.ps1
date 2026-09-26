<#
.SYNOPSIS
    FRUSTRATED GAMER OPTIMIZER (FGOptimizer) - Full Original C# GUI Launcher
.DESCRIPTION
    Downloads the compiled FG_Optimizer.dll directly into memory with cache-busting
    and launches your exact original C# GUI application (with gauges, sidebar & HWID info).
#>

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

# Cache buster to bypass GitHub CDN cache
$v = Get-Random
$dllUrl = "https://raw.githubusercontent.com/klrkofficialshop/dogingontop/main/FG_Optimizer.dll?v=$v"

Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host "   FRUSTRATED GAMER OPTIMIZER - LOADING FULL C# ENGINE    " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host "[*] Downloading FG_Optimizer.dll into memory..." -ForegroundColor Yellow

try {
    $webClient = New-Object System.Net.WebClient
    $webClient.Headers.Add("User-Agent", "Mozilla/5.0")
    $webClient.Headers.Add("Cache-Control", "no-cache")
    $dllBytes = $webClient.DownloadData($dllUrl)

    Write-Host "[+] Loaded $([Math]::Round($dllBytes.Length / 1KB, 2)) KB into memory. Starting GUI..." -ForegroundColor Green

    # Load assembly dynamically in PowerShell process memory
    $assembly = [System.Reflection.Assembly]::Load($dllBytes)

    [System.Windows.Forms.Application]::EnableVisualStyles()
    [FG_Optimizer.Program]::Main()

} catch {
    Write-Host "[-] Error launching FG Optimizer GUI: $_" -ForegroundColor Red
    Pause
}
