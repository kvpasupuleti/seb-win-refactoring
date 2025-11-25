# TSB Black Screen Diagnostic Script
# Run this on the machine having black screen issues

Write-Host "========================================" -ForegroundColor Cyan
Write-Host " TSB Black Screen Diagnostics" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

$issues = @()

# Check 1: .NET Framework 4.8
Write-Host "[1/6] Checking .NET Framework 4.8..." -ForegroundColor Yellow
try {
    $dotnet = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" -ErrorAction Stop
    if ($dotnet.Release -ge 528040) {
        Write-Host "  [OK] .NET Framework 4.8 is installed (Release: $($dotnet.Release))" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] .NET Framework 4.8 is NOT installed (Found: $($dotnet.Release))" -ForegroundColor Red
        $issues += ".NET Framework 4.8 missing"
    }
} catch {
    Write-Host "  [FAIL] .NET Framework 4.8 is NOT installed" -ForegroundColor Red
    $issues += ".NET Framework 4.8 missing"
}
Write-Host ""

# Check 2: Visual C++ Redistributable 2015-2022
Write-Host "[2/6] Checking Visual C++ Redistributable..." -ForegroundColor Yellow
$vcRedist = Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\VisualStudio\14.0\VC\Runtimes\x64" -ErrorAction SilentlyContinue
if ($vcRedist) {
    Write-Host "  [OK] Visual C++ Redistributable x64 is installed (Version: $($vcRedist.Version))" -ForegroundColor Green
} else {
    Write-Host "  [FAIL] Visual C++ Redistributable x64 is NOT installed" -ForegroundColor Red
    $issues += "Visual C++ Redistributable x64 2015-2022 missing - CRITICAL!"
}
Write-Host ""

# Check 3: WebView2
Write-Host "[3/6] Checking Microsoft Edge WebView2..." -ForegroundColor Yellow
$webview2 = Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" -ErrorAction SilentlyContinue
if ($webview2) {
    Write-Host "  [OK] WebView2 is installed (Version: $($webview2.pv))" -ForegroundColor Green
} else {
    Write-Host "  [WARNING] WebView2 might not be installed" -ForegroundColor Yellow
    $issues += "WebView2 might be missing"
}
Write-Host ""

# Check 4: TSB Installation
Write-Host "[4/6] Checking TSB installation..." -ForegroundColor Yellow
$tsbPath = "C:\Program Files\TopinSecureBrowser\Application"
if (Test-Path $tsbPath) {
    Write-Host "  [OK] TSB is installed at: $tsbPath" -ForegroundColor Green
    
    # Check for CefSharp DLLs
    $cefSharpDll = Join-Path $tsbPath "CefSharp.dll"
    $cefSharpCoreDll = Join-Path $tsbPath "CefSharp.Core.dll"
    $libcef = Join-Path $tsbPath "libcef.dll"
    
    if (Test-Path $libcef) {
        $size = (Get-Item $libcef).Length / 1MB
        Write-Host "  [OK] libcef.dll found ($([math]::Round($size, 2)) MB)" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] libcef.dll is MISSING - CefSharp won't work!" -ForegroundColor Red
        $issues += "libcef.dll missing - CefSharp cannot initialize!"
    }
    
    if (Test-Path $cefSharpDll) {
        Write-Host "  [OK] CefSharp.dll found" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] CefSharp.dll is MISSING" -ForegroundColor Red
        $issues += "CefSharp.dll missing"
    }
    
    if (Test-Path $cefSharpCoreDll) {
        Write-Host "  [OK] CefSharp.Core.dll found" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] CefSharp.Core.dll is MISSING" -ForegroundColor Red
        $issues += "CefSharp.Core.dll missing"
    }
    
    # Check for locales folder
    $localesPath = Join-Path $tsbPath "locales"
    if (Test-Path $localesPath) {
        Write-Host "  [OK] locales folder found" -ForegroundColor Green
    } else {
        Write-Host "  [FAIL] locales folder is MISSING" -ForegroundColor Red
        $issues += "locales folder missing"
    }
    
} else {
    Write-Host "  [FAIL] TSB is NOT installed (checked: $tsbPath)" -ForegroundColor Red
    $issues += "TSB not installed"
}
Write-Host ""

# Check 5: Logs
Write-Host "[5/6] Checking for TSB logs..." -ForegroundColor Yellow
$logsPath = Join-Path $env:LOCALAPPDATA "SafeExamBrowser\Logs"
if (Test-Path $logsPath) {
    Write-Host "  [OK] Logs folder exists: $logsPath" -ForegroundColor Green
    $logFiles = Get-ChildItem $logsPath -Filter "*.log" | Sort-Object LastWriteTime -Descending | Select-Object -First 3
    if ($logFiles) {
        Write-Host "  Recent log files:" -ForegroundColor Cyan
        foreach ($log in $logFiles) {
            Write-Host "    - $($log.Name) ($(($log.LastWriteTime).ToString('yyyy-MM-dd HH:mm')))" -ForegroundColor Gray
        }
    }
} else {
    Write-Host "  [INFO] No logs folder found (TSB hasn't been run yet)" -ForegroundColor Gray
}
Write-Host ""

# Check 6: System Info
Write-Host "[6/6] System Information..." -ForegroundColor Yellow
Write-Host "  OS: $([System.Environment]::OSVersion.VersionString)" -ForegroundColor Gray
Write-Host "  Architecture: $([System.Environment]::Is64BitOperatingSystem ? 'x64' : 'x86')" -ForegroundColor Gray
Write-Host "  .NET Runtime: $([System.Environment]::Version)" -ForegroundColor Gray
Write-Host ""

# Summary
Write-Host "========================================" -ForegroundColor Cyan
Write-Host " Diagnostic Summary" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

if ($issues.Count -eq 0) {
    Write-Host "[OK] All checks passed!" -ForegroundColor Green
    Write-Host ""
    Write-Host "If TSB still shows black screen, the issue might be:" -ForegroundColor Yellow
    Write-Host "  1. Graphics driver problem" -ForegroundColor White
    Write-Host "  2. Antivirus blocking CefSharp" -ForegroundColor White
    Write-Host "  3. Config file issue" -ForegroundColor White
    Write-Host ""
    Write-Host "Try running TSB without a config file:" -ForegroundColor Cyan
    Write-Host "  cd `"C:\Program Files\TopinSecureBrowser\Application`"" -ForegroundColor White
    Write-Host "  .\SafeExamBrowser.exe" -ForegroundColor White
} else {
    Write-Host "[ISSUES FOUND] Please fix these issues:" -ForegroundColor Red
    Write-Host ""
    for ($i = 0; $i -lt $issues.Count; $i++) {
        Write-Host "  $($i+1). $($issues[$i])" -ForegroundColor White
    }
    Write-Host ""
    
    if ($issues -contains "Visual C++ Redistributable x64 2015-2022 missing - CRITICAL!") {
        Write-Host "MOST LIKELY CAUSE OF BLACK SCREEN:" -ForegroundColor Red
        Write-Host "  Visual C++ Redistributable is missing!" -ForegroundColor White
        Write-Host ""
        Write-Host "Download and install from:" -ForegroundColor Cyan
        Write-Host "  https://aka.ms/vs/17/release/vc_redist.x64.exe" -ForegroundColor White
        Write-Host ""
    }
    
    if ($issues -like "*libcef.dll missing*") {
        Write-Host "CRITICAL: CefSharp files are missing!" -ForegroundColor Red
        Write-Host "  This means the browser cannot initialize at all." -ForegroundColor White
        Write-Host "  Reinstall TSB to fix this." -ForegroundColor White
        Write-Host ""
    }
}

Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

