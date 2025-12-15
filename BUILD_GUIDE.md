# Topin Secure Browser - Build Guide

## Prerequisites
- Visual Studio 2022 with .NET Framework 4.8
- WiX Toolset v3.14 installed
- Windows 10/11 x64

**Note**: The project requires .NET Framework 4.8 due to NuGet package dependencies. While older systems may have .NET 4.7.x, .NET 4.8 is widely available and provides better compatibility.

## Quick Build Commands

### 1. Build Release Application for x64 (Replace x64 with x86 for such platforms)
```powershell
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" SafeExamBrowser.sln /p:Configuration=Release /p:Platform=x64
```

### 2. Build MSI Installer
```powershell
$env:WIX = "C:\Program Files (x86)\WiX Toolset v3.14\"
& "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" SafeExamBrowser.sln /p:Configuration=Release /p:Platform=x64 /t:Setup
```

### 3. Build EXE Bundle
```powershell
 & "C:\Program Files\Microsoft Visual Studio\2022\Professional\MSBuild\Current\Bin\MSBuild.exe" `
SetupBundle\SetupBundle.wixproj /p:Configuration=Release /p:Platform=x64 `
/p:SolutionDir="C:\Users\krish\Desktop\git-repos\seb-win-refactoring\"
```

## Output Locations
- **Application**: `SafeExamBrowser.Runtime\bin\x64\Release\SafeExamBrowser.exe`
- **MSI Installer**: `Setup\bin\x64\Release\TSB.msi`
- **EXE Bundle**: `SetupBundle\bin\x64\Release\TSB.exe`

## Key Modifications Made
- ✅ Anti-rebranding restrictions bypassed (To avoid Black screen issue)
- ✅ Code signing disabled (re-enable with your certificate)
- ✅ x64 and x86 platforms configured
- ✅ Configuration and Reset tools removed from installer

## Code Signing (Optional)
```powershell
signtool sign /f "YourCertificate.pfx" /p "password" /t http://timestamp.digicert.com "Setup.msi"
```

## Silent Installation
```powershell
msiexec /i Setup.msi /quiet
```
