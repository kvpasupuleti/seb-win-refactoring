# ============================================================================
# Safe Exam Browser - Installer Build Script (No Code Signing)
# ============================================================================
# This script builds a complete Windows installer for Safe Exam Browser
# including all dependencies and components.
#
# What this script does:
# 1. Checks if WiX Toolset is installed
# 2. Builds the main application (x64 and x86 versions)
# 3. Creates MSI installer packages
# 4. Creates a final bundle installer with all prerequisites
#
# Output: SetupBundle\bin\x64\Release\SetupBundle.exe
# ============================================================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Safe Exam Browser - Installer Builder" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# STEP 1: Check if WiX Toolset is installed
# ============================================================================
Write-Host "[Step 1/5] Checking WiX Toolset installation..." -ForegroundColor Yellow

$wixPath = "${env:ProgramFiles(x86)}\WiX Toolset v3.14\bin\candle.exe"
if (-not (Test-Path $wixPath)) {
    # Try v3.11 if v3.14 not found
    $wixPath = "${env:ProgramFiles(x86)}\WiX Toolset v3.11\bin\candle.exe"
}

if (-not (Test-Path $wixPath)) {
    Write-Host ""
    Write-Host "ERROR: WiX Toolset not found!" -ForegroundColor Red
    Write-Host "Please install WiX Toolset v3.11 or newer from:" -ForegroundColor Yellow
    Write-Host "https://github.com/wixtoolset/wix3/releases/download/wix314rtm/wix314.exe" -ForegroundColor White
    Write-Host ""
    exit 1
}

Write-Host "  Found: $wixPath" -ForegroundColor Green
Write-Host ""

# ============================================================================
# STEP 2: Build x64 Release binaries
# ============================================================================
# This builds all the .exe and .dll files for 64-bit Windows
# Components built:
# - SafeExamBrowser.exe (main application)
# - SafeExamBrowser.Client.exe (client component)
# - SebWindowsConfig.exe (configuration tool)
# - SafeExamBrowser.Service.exe (Windows service)
# - SafeExamBrowser.ResetUtility.exe (reset utility)
# - All supporting DLL libraries
# ============================================================================

Write-Host "[Step 2/5] Building x64 Release binaries..." -ForegroundColor Yellow
Write-Host "  This may take 2-5 minutes depending on your computer..." -ForegroundColor Gray
Write-Host ""

$solutionFile = "SafeExamBrowser.sln"

msbuild $solutionFile /p:Configuration=Release /p:Platform=x64 /m /v:minimal /nologo

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Failed to build x64 binaries!" -ForegroundColor Red
    Write-Host "Check the output above for error messages." -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "  x64 binaries built successfully!" -ForegroundColor Green
Write-Host ""

# ============================================================================
# STEP 3: Build x86 Release binaries
# ============================================================================
# This builds all components for 32-bit Windows
# Same components as x64 but compiled for 32-bit systems
# ============================================================================

Write-Host "[Step 3/5] Building x86 Release binaries..." -ForegroundColor Yellow
Write-Host "  This may take 2-5 minutes..." -ForegroundColor Gray
Write-Host ""

msbuild $solutionFile /p:Configuration=Release /p:Platform=x86 /m /v:minimal /nologo

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Failed to build x86 binaries!" -ForegroundColor Red
    Write-Host "Check the output above for error messages." -ForegroundColor Yellow
    Write-Host ""
    exit 1
}

Write-Host ""
Write-Host "  x86 binaries built successfully!" -ForegroundColor Green
Write-Host ""

# ============================================================================
# STEP 4: Build MSI Installer Packages
# ============================================================================
# MSI (Microsoft Installer) packages are the standard Windows installer format
# We create two MSI files:
# - Setup-x64.msi: For 64-bit Windows (most modern systems)
# - Setup-x86.msi: For 32-bit Windows (legacy systems)
#
# These MSI files contain:
# - All application files
# - Registry entries for file associations (.seb files)
# - Registry entries for URL protocols (seb:// and sebs://)
# - Start Menu shortcuts
# - Uninstaller
# ============================================================================

Write-Host "[Step 4/5] Building MSI installer packages..." -ForegroundColor Yellow
Write-Host ""

$setupProject = "Setup\Setup.wixproj"

# Build x64 MSI
Write-Host "  Building x64 MSI..." -ForegroundColor Gray
msbuild $setupProject /p:Configuration=Release /p:Platform=x64 /p:SignOutput=false /v:minimal /nologo

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Failed to build x64 MSI!" -ForegroundColor Red
    exit 1
}

Write-Host "  x64 MSI built successfully!" -ForegroundColor Green
Write-Host ""

# Build x86 MSI
Write-Host "  Building x86 MSI..." -ForegroundColor Gray
msbuild $setupProject /p:Configuration=Release /p:Platform=x86 /p:SignOutput=false /v:minimal /nologo

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Failed to build x86 MSI!" -ForegroundColor Red
    exit 1
}

Write-Host "  x86 MSI built successfully!" -ForegroundColor Green
Write-Host ""

# ============================================================================
# STEP 5: Build SetupBundle (Final Installer)
# ============================================================================
# The SetupBundle is a "bootstrapper" that combines:
# - The x64 and x86 MSI packages
# - .NET Framework 4.8 installer (prerequisite)
# - Visual C++ Redistributable (prerequisite)
# - Microsoft Edge WebView2 Runtime (prerequisite)
#
# When a user runs SetupBundle.exe, it will:
# 1. Detect if prerequisites are installed
# 2. Install missing prerequisites automatically
# 3. Detect if system is 64-bit or 32-bit
# 4. Install the appropriate MSI package
#
# This makes it a "one-click" installer for end users!
# ============================================================================

Write-Host "[Step 5/5] Building SetupBundle (final installer)..." -ForegroundColor Yellow
Write-Host "  Creating all-in-one installer with prerequisites..." -ForegroundColor Gray
Write-Host ""

$bundleProject = "SetupBundle\SetupBundle.wixproj"
msbuild $bundleProject /p:Configuration=Release /p:Platform=x64 /p:SignOutput=false /v:minimal /nologo

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Failed to build SetupBundle!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "  SetupBundle built successfully!" -ForegroundColor Green
Write-Host ""

# ============================================================================
# BUILD COMPLETE - Show Results
# ============================================================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Build Complete!" -ForegroundColor Green
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

$bundleExe = "SetupBundle\bin\x64\Release\SetupBundle.exe"
$setupX64 = "Setup\bin\x64\Release\Setup.msi"
$setupX86 = "Setup\bin\x86\Release\Setup.msi"

Write-Host "Your installer files are ready:" -ForegroundColor Cyan
Write-Host ""

# Check if files exist and display them
if (Test-Path $bundleExe) {
    $fileInfo = Get-Item $bundleExe
    $sizeMB = [math]::Round($fileInfo.Length/1MB, 2)
    Write-Host "  [RECOMMENDED] All-in-one installer:" -ForegroundColor Green
    Write-Host "    Location: $bundleExe" -ForegroundColor White
    Write-Host "    Size: $sizeMB MB" -ForegroundColor Gray
    Write-Host "    Includes: App + .NET Framework + VC++ Runtime + WebView2" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host "  [!] Bundle not found: $bundleExe" -ForegroundColor Red
}

if (Test-Path $setupX64) {
    $fileInfo = Get-Item $setupX64
    $sizeMB = [math]::Round($fileInfo.Length/1MB, 2)
    Write-Host "  [ALTERNATIVE] x64 MSI only:" -ForegroundColor Yellow
    Write-Host "    Location: $setupX64" -ForegroundColor White
    Write-Host "    Size: $sizeMB MB" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host "  [!] x64 MSI not found: $setupX64" -ForegroundColor Red
}

if (Test-Path $setupX86) {
    $fileInfo = Get-Item $setupX86
    $sizeMB = [math]::Round($fileInfo.Length/1MB, 2)
    Write-Host "  [ALTERNATIVE] x86 MSI only:" -ForegroundColor Yellow
    Write-Host "    Location: $setupX86" -ForegroundColor White
    Write-Host "    Size: $sizeMB MB" -ForegroundColor Gray
    Write-Host ""
} else {
    Write-Host "  [!] x86 MSI not found: $setupX86" -ForegroundColor Red
}

# ============================================================================
# What the installer will do
# ============================================================================

Write-Host "When users run the installer, it will:" -ForegroundColor Cyan
Write-Host "  1. Install Safe Exam Browser to Program Files" -ForegroundColor White
Write-Host "  2. Register .seb file extension" -ForegroundColor White
Write-Host "  3. Register seb:// and sebs:// URL protocols" -ForegroundColor White
Write-Host "  4. Create Start Menu shortcuts" -ForegroundColor White
Write-Host "  5. Install prerequisites (.NET, VC++, WebView2)" -ForegroundColor White
Write-Host ""

Write-Host "Your VM-friendly changes are included:" -ForegroundColor Cyan
Write-Host "  - Virtual machine detection: ALLOWED" -ForegroundColor Green
Write-Host "  - Display count limit: 10 displays" -ForegroundColor Green
Write-Host "  - Display errors: IGNORED" -ForegroundColor Green
Write-Host ""

# ============================================================================
# Next steps
# ============================================================================

if (Test-Path $bundleExe) {
    Write-Host "To install, run:" -ForegroundColor Cyan
    Write-Host "  $bundleExe" -ForegroundColor White
    Write-Host ""
    Write-Host "Or from command line:" -ForegroundColor Cyan
    Write-Host "  Start-Process '$bundleExe'" -ForegroundColor White
    Write-Host ""
}

Write-Host "NOTE: This installer is NOT code-signed." -ForegroundColor Yellow
Write-Host "Windows may show a security warning - this is normal for development builds." -ForegroundColor Yellow
Write-Host ""

