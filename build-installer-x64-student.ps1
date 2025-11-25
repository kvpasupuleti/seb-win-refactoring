# ============================================================================
# Safe Exam Browser - Student Edition Installer (x64 only)
# ============================================================================
# This script builds a streamlined installer for students:
# - Only x64 version (most systems are 64-bit)
# - No Configuration Tool (students don't configure)
# - No Reset Utility (students don't need this)
# - Not code-signed (development version)
# - Smaller file size
#
# What's included:
# - SafeExamBrowser.exe (main application)
# - SafeExamBrowser.Service.exe (Windows service)
# - All required DLLs and dependencies
# - .seb file association
# - seb:// and sebs:// URL protocols
#
# Output: Setup\bin\x64\Release\Setup.msi (MSI installer)
# ============================================================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Safe Exam Browser" -ForegroundColor Cyan
Write-Host " Student Edition Installer (x64)" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# Check WiX Toolset
# ============================================================================
Write-Host "[1/3] Checking WiX Toolset installation..." -ForegroundColor Yellow

$wixPath = "${env:ProgramFiles(x86)}\WiX Toolset v3.14\bin\candle.exe"
if (-not (Test-Path $wixPath)) {
    $wixPath = "${env:ProgramFiles(x86)}\WiX Toolset v3.11\bin\candle.exe"
}

if (-not (Test-Path $wixPath)) {
    Write-Host ""
    Write-Host "ERROR: WiX Toolset not found!" -ForegroundColor Red
    Write-Host "Download from: https://github.com/wixtoolset/wix3/releases/download/wix314rtm/wix314.exe" -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

Write-Host "  Found WiX Toolset!" -ForegroundColor Green
Write-Host ""

# ============================================================================
# Build x64 Release binaries
# ============================================================================
Write-Host "[2/3] Building x64 Release binaries..." -ForegroundColor Yellow
Write-Host "  Building SafeExamBrowser.exe and dependencies..." -ForegroundColor Gray
Write-Host "  This will take 2-5 minutes..." -ForegroundColor Gray
Write-Host ""

$solutionFile = "SafeExamBrowser.sln"

# Find MSBuild
$msbuild = "C:\Program Files\Microsoft Visual Studio\2022\Community\MSBuild\Current\Bin\MSBuild.exe"
if (-not (Test-Path $msbuild)) {
    $msbuild = Get-ChildItem "C:\Program Files\Microsoft Visual Studio" -Recurse -Filter "MSBuild.exe" -ErrorAction SilentlyContinue | Select-Object -First 1 -ExpandProperty FullName
}

& $msbuild $solutionFile /p:Configuration=Release /p:Platform=x64 /m /v:minimal /nologo

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Failed to build x64 binaries!" -ForegroundColor Red
    Write-Host "Check the output above for errors." -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "  x64 binaries built successfully!" -ForegroundColor Green
Write-Host ""

# ============================================================================
# Build MSI Installer (x64 only, no code signing)
# ============================================================================
Write-Host "[3/3] Building MSI installer (x64)..." -ForegroundColor Yellow
Write-Host "  Creating installer package..." -ForegroundColor Gray
Write-Host ""

# Build through solution so $(SolutionDir) is defined
& $msbuild $solutionFile /t:Setup /p:Configuration=Release /p:Platform=x64 /p:SignOutput=false /v:minimal /nologo

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Failed to build installer!" -ForegroundColor Red
    Write-Host "Check the output above for errors." -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "  Installer built successfully!" -ForegroundColor Green
Write-Host ""

# ============================================================================
# Show Results
# ============================================================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Build Complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$setupMsi = "Setup\bin\x64\Release\Setup.msi"

if (Test-Path $setupMsi) {
    $fileInfo = Get-Item $setupMsi
    $sizeMB = [math]::Round($fileInfo.Length/1MB, 2)
    
    Write-Host "Your installer is ready:" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  File: $setupMsi" -ForegroundColor White
    Write-Host "  Size: $sizeMB MB" -ForegroundColor Gray
    Write-Host "  Architecture: x64 (64-bit)" -ForegroundColor Gray
    Write-Host ""
    
    Write-Host "What is included:" -ForegroundColor Cyan
    Write-Host "  [✓] Safe Exam Browser (main application)" -ForegroundColor Green
    Write-Host "  [✓] Windows Service" -ForegroundColor Green
    Write-Host "  [✓] .seb file association" -ForegroundColor Green
    Write-Host "  [✓] seb:// and sebs:// URL protocols" -ForegroundColor Green
    Write-Host "  [✓] Start Menu shortcut" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "What is NOT included:" -ForegroundColor Cyan
    Write-Host "  [✗] Configuration Tool (not needed for students)" -ForegroundColor Yellow
    Write-Host "  [✗] Reset Utility (not needed for students)" -ForegroundColor Yellow
    Write-Host "  [✗] x86 version (smaller file size)" -ForegroundColor Yellow
    Write-Host ""
    
    Write-Host "Your VM-friendly changes:" -ForegroundColor Cyan
    Write-Host "  [✓] Virtual machine: ALLOWED" -ForegroundColor Green
    Write-Host "  [✓] Display limit: 10 displays" -ForegroundColor Green
    Write-Host "  [✓] Display errors: IGNORED" -ForegroundColor Green
    Write-Host ""
    
    Write-Host "Prerequisites required (not bundled):" -ForegroundColor Cyan
    Write-Host "  - .NET Framework 4.8" -ForegroundColor Yellow
    Write-Host "  - Visual C++ Redistributable 2015-2022" -ForegroundColor Yellow
    Write-Host "  - Microsoft Edge WebView2 Runtime" -ForegroundColor Yellow
    Write-Host ""
    Write-Host "  NOTE: Students need to install these manually first." -ForegroundColor Yellow
    Write-Host "  Or you can distribute them separately." -ForegroundColor Yellow
    Write-Host ""
    
    Write-Host "To install:" -ForegroundColor Cyan
    Write-Host "  Double-click: $setupMsi" -ForegroundColor White
    Write-Host "  Or command line: msiexec /i `"$setupMsi`"" -ForegroundColor White
    Write-Host ""
    
    Write-Host "NOTE: This installer is NOT code-signed." -ForegroundColor Yellow
    Write-Host "Windows will show a security warning - this is expected." -ForegroundColor Yellow
    Write-Host ""
    
} else {
    Write-Host "ERROR: Installer not found at: $setupMsi" -ForegroundColor Red
    Write-Host ""
}

