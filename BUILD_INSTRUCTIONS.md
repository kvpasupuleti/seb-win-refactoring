# Topin Secure Browser - Build Instructions

## Overview
Topin Secure Browser (TSB) is a customized version of Safe Exam Browser (SEB) with Topin branding and simplified deployment model. This document provides complete instructions for building and deploying the software.

## Prerequisites

### Required Software
1. **Windows 10/11** (64-bit recommended)
2. **Visual Studio 2019 or 2022**
   - Workloads required:
     - .NET desktop development
     - Desktop development with C++
   - Individual components:
     - .NET Framework 4.7.2 targeting pack
     - .NET Framework 4.7.2 SDK
3. **WiX Toolset v3.11 or newer**
   - Download from: https://github.com/wixtoolset/wix3/releases
   - Install WiX Toolset build tools
   - Install WiX Toolset Visual Studio Extension (optional, for VS integration)
4. **Git** (for version control)

### Optional (For Production)
- **Code Signing Certificate** - For signing executables and installer
  - Sectigo EV Code Signing Certificate recommended
  - Required for Windows SmartScreen reputation

## Project Structure

```
seb-win-refactoring/
├── SafeExamBrowser.Runtime/          → Produces TopinSecureBrowser.exe (Main Runtime)
├── SafeExamBrowser.Client/           → Produces SafeExamBrowser.Client.exe (Browser Client)
├── TopinSecureBrowser.Launcher/      → Produces TSB.exe (User-facing launcher)
├── SafeExamBrowser.Service/          → Produces SafeExamBrowser.Service.exe (Background service)
├── [Other core projects]             → Supporting libraries (DLLs)
├── Setup/                            → WiX installer project
└── BUILD_INSTRUCTIONS.md            → This file
```

## Build Steps

### 1. Clone or Open the Repository
```bash
git clone <repository-url>
cd seb-win-refactoring
```

### 2. Open Solution in Visual Studio
- Open `SafeExamBrowser.sln` in Visual Studio
- Solution should load all projects including:
  - Core libraries
  - SafeExamBrowser.Runtime
  - SafeExamBrowser.Client
  - TopinSecureBrowser.Launcher
  - SafeExamBrowser.Service
  - Setup (WiX installer project)

### 3. Restore NuGet Packages
- Right-click on Solution → "Restore NuGet Packages"
- Wait for all packages to download

### 4. Select Build Configuration
Choose your target platform and configuration:

**For 64-bit systems (Recommended):**
- Configuration: `Release`
- Platform: `x64`

**For 32-bit systems:**
- Configuration: `Release`
- Platform: `x86`

### 5. Build Solution
**Option A: Build All (Including Installer)**
```
Build → Build Solution (Ctrl+Shift+B)
```

**Option B: Build Applications Only (Without Installer)**
- Right-click on each project and select "Build"
- Or use: `Build → Batch Build` and select only application projects

**Important Notes:**
- The Setup project requires WiX Toolset to be installed
- First build may take 5-10 minutes
- Subsequent builds are faster (incremental)

### 6. Locate Build Output

#### Application Files
After building, executable files will be in:
```
SafeExamBrowser.Runtime\bin\x64\Release\TopinSecureBrowser.exe
SafeExamBrowser.Client\bin\x64\Release\SafeExamBrowser.Client.exe
TopinSecureBrowser.Launcher\bin\x64\Release\TSB.exe
SafeExamBrowser.Service\bin\x64\Release\SafeExamBrowser.Service.exe
```

Plus all supporting DLL files in the same directories.

#### Installer (MSI)
If Setup project builds successfully:
```
Setup\bin\x64\Release\Setup.msi
```

## Building the Installer

### Prerequisites Check
Before building the installer, verify:
1. WiX Toolset is installed
2. All application projects have been built successfully
3. Build configuration is set to `Release|x64` or `Release|x86`

### Build Steps
1. In Visual Studio Solution Explorer, right-click on `Setup` project
2. Select "Rebuild"
3. Wait for the build to complete (may take 2-3 minutes)
4. Installer will be created at: `Setup\bin\x64\Release\Setup.msi`

### Installer Contents
The MSI installer will include:
- **Application Directory**: TopinSecureBrowser.exe + all runtime files
- **Launcher Directory**: TSB.exe (user-facing launcher)
- **Service Directory**: SafeExamBrowser.Service.exe
- **Start Menu Shortcut**: "Topin Secure Browser" → launches TSB.exe

### Known Build Issues

#### Issue: "heat.exe not found"
**Solution:** Ensure WiX Toolset is installed and `$(WIX)` environment variable is set
```cmd
echo %WIX%
REM Should output: C:\Program Files (x86)\WiX Toolset v3.11\
```

#### Issue: "Code signing failed"
**Solution:** Code signing is currently disabled in the project. To enable:
1. Obtain a code signing certificate
2. Edit `Setup\Setup.wixproj`
3. Update signtool commands with your certificate details
4. Change `<SignOutput>false</SignOutput>` to `true`

#### Issue: "Main Executable version binding failed"
**Solution:** This is resolved - we use a fixed version number (3.7.0.0) instead of binding

## Deployment Package Structure

### Manual Deployment (Without Installer)
If you want to deploy without the MSI installer, create this structure:

```
TopinSecureBrowser/
├── Application/
│   ├── TopinSecureBrowser.exe       (Main runtime)
│   ├── SafeExamBrowser.Client.exe   (Browser client)
│   └── [All DLLs and dependencies]
├── Launcher/
│   └── TSB.exe                      (User launcher)
├── Service/
│   └── SafeExamBrowser.Service.exe  (Background service)
└── README.txt
```

**Recommended Approach:** Use TSB.exe from Launcher directory as the main entry point

### Files to Distribute
Copy these from build output:

**From SafeExamBrowser.Runtime\bin\x64\Release\:**
- TopinSecureBrowser.exe
- All DLL files
- Language folders (if any)
- CefSharp dependencies

**From TopinSecureBrowser.Launcher\bin\x64\Release\:**
- TSB.exe
- TopinSecureBrowser.ico

**From SafeExamBrowser.Client\bin\x64\Release\:**
- SafeExamBrowser.Client.exe
- All DLL files

**From SafeExamBrowser.Service\bin\x64\Release\:**
- SafeExamBrowser.Service.exe
- All DLL files

## Testing the Build

### 1. Test TSB Launcher
```cmd
cd TopinSecureBrowser.Launcher\bin\x64\Release
TSB.exe
```

**Expected Behavior:**
- TSB.exe launches
- Finds TopinSecureBrowser.exe in Application directory
- Creates topin-default.seb config file (if not exists)
- Launches TopinSecureBrowser.exe
- Secure browser window opens with Topin branding

### 2. Test Direct Runtime
```cmd
cd SafeExamBrowser.Runtime\bin\x64\Release
TopinSecureBrowser.exe
```

**Expected Behavior:**
- Secure browser launches
- Shows Topin branding
- All browser functions work

### 3. Test Installer
```cmd
cd Setup\bin\x64\Release
msiexec /i Setup.msi /l*v install.log
```

**Expected Behavior:**
- Installer UI shows "Topin Secure Browser"
- Installation completes successfully
- Start Menu shortcut is created
- Program installs to: `C:\Program Files\TopinSecureBrowser\`

### 4. Test Installed Application
1. Open Start Menu
2. Search for "Topin Secure Browser"
3. Click the shortcut
4. Application should launch successfully

## Troubleshooting

### Build Errors

#### "Cannot find TopinSecureBrowser.ico"
**Solution:** Ensure the icon file exists in:
- `TopinSecureBrowser.Launcher\TopinSecureBrowser.ico`
- `SafeExamBrowser.Runtime\TopinSecureBrowser.ico`
- `SafeExamBrowser.Client\TopinSecureBrowser.ico`

#### "Target framework '.NETFramework,Version=v4.7.2' not found"
**Solution:** 
1. Open Visual Studio Installer
2. Modify your VS installation
3. Add ".NET Framework 4.7.2 targeting pack"

#### "WiX Toolset not found"
**Solution:**
1. Download WiX v3.11+ from https://github.com/wixtoolset/wix3/releases
2. Install WiX Toolset
3. Restart Visual Studio
4. Rebuild solution

### Runtime Errors

#### "TopinSecureBrowser.exe not found"
**Cause:** TSB.exe cannot find the main runtime
**Solution:** Ensure TopinSecureBrowser.exe is in the same directory as TSB.exe, or adjust the launcher logic

#### "Configuration file error"
**Cause:** Invalid topin-default.seb file
**Solution:** Delete the config file and let TSB.exe recreate it

## Code Signing (Optional)

### Why Sign Code?
- Removes Windows SmartScreen warnings
- Builds user trust
- Required for enterprise deployment

### Signing Process
1. Obtain an EV Code Signing Certificate
   - Recommended: Sectigo, DigiCert
   - Cost: ~$400-500/year

2. Update `Setup\Setup.wixproj`:
   - Set `<SignOutput>true</SignOutput>`
   - Update certificate thumbprint in signtool commands
   - Replace: `ecac9df025f5d208f6190fc4d6f9d329576598c7` with your cert thumbprint

3. Enable PreBuildEvent signing:
   - Uncomment REM lines in PreBuildEvent
   - Update signtool commands

4. Sign the MSI installer:
   ```cmd
   signtool sign /sha1 YOUR_CERT_THUMBPRINT /tr http://timestamp.digicert.com /td sha256 /fd sha256 Setup.msi
   ```

## Version Management

### Updating Version Numbers
Version is controlled in multiple places:

1. **Installer Version** (`Setup\Product.wxs`):
   ```xml
   Version="3.7.0.0"
   ```

2. **Assembly Versions** (each project's `Properties\AssemblyInfo.cs`):
   ```csharp
   [assembly: AssemblyVersion("3.7.0.0")]
   [assembly: AssemblyFileVersion("3.7.0.0")]
   ```

**Best Practice:** Keep all versions synchronized

## CI/CD Integration

### GitHub Actions Example
```yaml
name: Build Topin Secure Browser

on: [push, pull_request]

jobs:
  build:
    runs-on: windows-latest
    steps:
      - uses: actions/checkout@v2
      - name: Setup MSBuild
        uses: microsoft/setup-msbuild@v1
      - name: Setup NuGet
        uses: NuGet/setup-nuget@v1
      - name: Restore NuGet Packages
        run: nuget restore SafeExamBrowser.sln
      - name: Build Solution
        run: msbuild SafeExamBrowser.sln /p:Configuration=Release /p:Platform=x64
      - name: Upload Artifacts
        uses: actions/upload-artifact@v2
        with:
          name: TSB-Build
          path: |
            TopinSecureBrowser.Launcher/bin/x64/Release/
            SafeExamBrowser.Runtime/bin/x64/Release/
```

## License Compliance

### MPL 2.0 Requirements
Topin Secure Browser is based on Safe Exam Browser (MPL 2.0). When distributing:

1. **Include License Files**:
   - MPL 2.0 license text (LICENSE.txt)
   - Attribution to Safe Exam Browser project

2. **Source Code Availability**:
   - SEB components remain open source
   - Provide access to SEB source code
   - Document modifications made

3. **Proprietary Components**:
   - TSB Launcher is proprietary to Topin Tech
   - Topin branding is proprietary
   - Can be distributed under commercial terms

## Support and Contact

For build issues or questions:
- Check existing documentation
- Review error logs
- Contact Topin Tech development team

## Appendix: Quick Reference

### Build Commands (Command Line)
```cmd
REM Restore packages
nuget restore SafeExamBrowser.sln

REM Build Release x64
msbuild SafeExamBrowser.sln /p:Configuration=Release /p:Platform=x64

REM Build Setup project only
msbuild Setup\Setup.wixproj /p:Configuration=Release /p:Platform=x64
```

### Directory Structure After Build
```
bin\x64\Release\
├── TopinSecureBrowser.exe        (Main runtime)
├── TSB.exe                       (Launcher)
├── SafeExamBrowser.Client.exe    (Browser client)
├── SafeExamBrowser.Service.exe   (Service)
├── *.dll                         (All dependencies)
├── locales\                      (Chromium locales)
└── swiftshader\                  (GPU fallback)
```

---
**Last Updated:** November 2025  
**Version:** 1.0.0  
**Maintained by:** Topin Tech Development Team

