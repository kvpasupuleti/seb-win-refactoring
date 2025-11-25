# ============================================================================
# Safe Exam Browser - Student Edition Installer (x86 only)
# ============================================================================
# This builds the x86 (32-bit) version for legacy systems
# Same as x64 version but for older computers
# ============================================================================

Write-Host ""
Write-Host "============================================" -ForegroundColor Cyan
Write-Host " Safe Exam Browser" -ForegroundColor Cyan
Write-Host " Student Edition Installer (x86)" -ForegroundColor Cyan
Write-Host "============================================" -ForegroundColor Cyan
Write-Host ""

# Check WiX Toolset
Write-Host "[1/3] Checking WiX Toolset..." -ForegroundColor Yellow

$wixPath = "${env:ProgramFiles(x86)}\WiX Toolset v3.14\bin\candle.exe"
if (-not (Test-Path $wixPath)) {
    $wixPath = "${env:ProgramFiles(x86)}\WiX Toolset v3.11\bin\candle.exe"
}

if (-not (Test-Path $wixPath)) {
    Write-Host ""
    Write-Host "ERROR: WiX Toolset not found!" -ForegroundColor Red
    exit 1
}

Write-Host "  Found!" -ForegroundColor Green
Write-Host ""

# Build x86 binaries
Write-Host "[2/3] Building x86 Release binaries..." -ForegroundColor Yellow
Write-Host "  This will take 2-5 minutes..." -ForegroundColor Gray
Write-Host ""

msbuild SafeExamBrowser.sln /p:Configuration=Release /p:Platform=x86 /m /v:minimal /nologo

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Build failed!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "  x86 binaries built!" -ForegroundColor Green
Write-Host ""

# Build MSI
Write-Host "[3/3] Building MSI installer (x86)..." -ForegroundColor Yellow
Write-Host ""

msbuild Setup\Setup.wixproj /p:Configuration=Release /p:Platform=x86 /p:SignOutput=false /v:minimal /nologo

if ($LASTEXITCODE -ne 0) {
    Write-Host ""
    Write-Host "ERROR: Installer build failed!" -ForegroundColor Red
    exit 1
}

Write-Host ""
Write-Host "  Installer built!" -ForegroundColor Green
Write-Host ""

# Show results
$setupMsi = "Setup\bin\x86\Release\Setup.msi"

if (Test-Path $setupMsi) {
    $sizeMB = [math]::Round((Get-Item $setupMsi).Length/1MB, 2)
    
    Write-Host ""
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host " Build Complete!" -ForegroundColor Green
    Write-Host "============================================" -ForegroundColor Cyan
    Write-Host ""
    Write-Host "  File: $setupMsi" -ForegroundColor White
    Write-Host "  Size: $sizeMB MB" -ForegroundColor Gray
    Write-Host "  Architecture: x86 (32-bit)" -ForegroundColor Gray
    Write-Host ""
}

