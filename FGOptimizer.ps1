<#
.SYNOPSIS
    FRUSTRATED GAMER OPTIMIZER (FGOptimizer) - In-Memory Assembly Loader
.DESCRIPTION
    Loads the compiled FG_Optimizer.dll directly into PowerShell memory from GitHub
    and launches your exact C# GUI application with hardware monitoring & dashboard UI.
#>

# 1. Force Administrator Privileges
if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host "   FRUSTRATED GAMER OPTIMIZER - IN-MEMORY LAUNCHER       " -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor DarkYellow
Write-Host "[*] Fetching FG Optimizer Engine from GitHub..." -ForegroundColor Yellow

# GitHub Direct Download URL for the DLL
$dllUrl = "https://raw.githubusercontent.com/klrkofficialshop/dogingontop/main/FG_Optimizer.dll"

try {
    # Download DLL bytes straight into memory
    $webClient = New-Object System.Net.WebClient
    $dllBytes = $webClient.DownloadData($dllUrl)

    Write-Host "[+] Assembly downloaded successfully. Loading into memory..." -ForegroundColor Green

    # Load assembly dynamically in PowerShell memory space
    $assembly = [System.Reflection.Assembly]::Load($dllBytes)

    Write-Host "[+] Launching Frustrated Gamer Optimizer GUI..." -ForegroundColor Green
    
    # Enable Visual Styles & Execute Program.Main()
    [System.Windows.Forms.Application]::EnableVisualStyles()
    [FG_Optimizer.Program]::Main()

} catch {
    Write-Host "[-] Failed to load FG Optimizer: $_" -ForegroundColor Red
    Pause
}
