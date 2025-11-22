# Creating a Professional Installer for Topin Secure Browser

## Quick Setup Guide

### Prerequisites
1. **Visual Studio Installer Projects Extension**
   - Open Visual Studio
   - Extensions → Manage Extensions
   - Search for "Microsoft Visual Studio Installer Projects"
   - Install and restart Visual Studio

### Method 1: Using the Existing Setup Project (Recommended)

The solution already has a Setup project. We just need to configure it for Topin:

#### Step 1: Update Setup Project
1. Open `Setup/Setup.vdproj` in a text editor
2. Find and replace:
   - "Safe Exam Browser" → "Topin Secure Browser"
   - "SafeExamBrowser" → "TopinSecureBrowser"
3. Save the file

#### Step 2: Build the Installer
1. Open the solution in Visual Studio
2. Right-click the `Setup` project
3. Select "Build"
4. Find the installer at: `Setup/Release/Setup.msi`

#### Step 3: What the Installer Does
- ✅ Installs to Program Files
- ✅ Creates Start Menu shortcuts
- ✅ Adds to Add/Remove Programs
- ✅ Associates .seb files
- ✅ Includes uninstaller

---

## Method 2: WiX Toolset (Advanced - More Control)

### Install WiX
1. Download from: https://wixtoolset.org/
2. Install WiX Toolset v3.11 or later
3. Install WiX Visual Studio extension

### Create Installer Script

Save this as `TopinSecureBrowser.wxs`:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<Wix xmlns="http://schemas.microsoft.com/wix/2006/wi">
  <Product Id="*" 
           Name="Topin Secure Browser" 
           Language="1033" 
           Version="1.0.0.0" 
           Manufacturer="Topin Tech" 
           UpgradeCode="PUT-YOUR-GUID-HERE">
    
    <Package InstallerVersion="200" Compressed="yes" InstallScope="perMachine" />
    
    <MajorUpgrade DowngradeErrorMessage="A newer version is already installed." />
    <MediaTemplate EmbedCab="yes" />

    <Feature Id="ProductFeature" Title="Topin Secure Browser" Level="1">
      <ComponentGroupRef Id="ProductComponents" />
    </Feature>

    <Directory Id="TARGETDIR" Name="SourceDir">
      <Directory Id="ProgramFiles64Folder">
        <Directory Id="INSTALLFOLDER" Name="Topin Secure Browser" />
      </Directory>
      <Directory Id="ProgramMenuFolder">
        <Directory Id="ApplicationProgramsFolder" Name="Topin Secure Browser"/>
      </Directory>
    </Directory>

    <ComponentGroup Id="ProductComponents" Directory="INSTALLFOLDER">
      <Component Id="MainExecutable" Guid="PUT-YOUR-GUID-HERE">
        <File Id="TSB.exe" 
              Source="$(var.SourceDir)\TSB.exe" 
              KeyPath="yes"
              Checksum="yes">
          <Shortcut Id="StartMenuShortcut"
                    Directory="ApplicationProgramsFolder"
                    Name="Topin Secure Browser"
                    WorkingDirectory="INSTALLFOLDER"
                    Icon="TSB.exe"
                    IconIndex="0"
                    Advertise="yes" />
        </File>
      </Component>
      
      <!-- Add all other files here -->
      <Component Id="RuntimeFiles" Guid="PUT-YOUR-GUID-HERE">
        <File Source="$(var.SourceDir)\TopinSecureBrowser.exe" />
        <File Source="$(var.SourceDir)\SafeExamBrowser.Client.exe" />
        <!-- Add remaining DLLs and dependencies -->
      </Component>
    </ComponentGroup>

    <Icon Id="TSB.exe" SourceFile="$(var.SourceDir)\TSB.exe"/>
  </Product>
</Wix>
```

### Build WiX Installer
```bash
candle.exe TopinSecureBrowser.wxs -dSourceDir="path\to\release"
light.exe TopinSecureBrowser.wixobj -out TopinSecureBrowser.msi
```

---

## Method 3: Inno Setup (User-Friendly Alternative)

### Install Inno Setup
1. Download from: https://jrsoftware.org/isinfo.php
2. Install Inno Setup 6.x

### Create Install Script

Save this as `TopinSecureBrowser.iss`:

```pascal
#define MyAppName "Topin Secure Browser"
#define MyAppVersion "1.0.0"
#define MyAppPublisher "Topin Tech"
#define MyAppURL "https://topin.tech"
#define MyAppExeName "TSB.exe"

[Setup]
AppId={{YOUR-GUID-HERE}
AppName={#MyAppName}
AppVersion={#MyAppVersion}
AppPublisher={#MyAppPublisher}
AppPublisherURL={#MyAppURL}
DefaultDirName={autopf}\{#MyAppName}
DefaultGroupName={#MyAppName}
OutputDir=Output
OutputBaseFilename=TopinSecureBrowser-Setup-{#MyAppVersion}
Compression=lzma2
SolidCompression=yes
ArchitecturesInstallIn64BitMode=x64
SetupIconFile=TopinSecureBrowser.ico
UninstallDisplayIcon={app}\{#MyAppExeName}
WizardStyle=modern

[Languages]
Name: "english"; MessagesFile: "compiler:Default.isl"

[Tasks]
Name: "desktopicon"; Description: "Create a desktop shortcut"; GroupDescription: "Additional icons:"

[Files]
Source: "bin\x64\Release\*"; DestDir: "{app}"; Flags: ignoreversion recursesubdirs createallsubdirs

[Icons]
Name: "{group}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"
Name: "{group}\Uninstall {#MyAppName}"; Filename: "{uninstallexe}"
Name: "{autodesktop}\{#MyAppName}"; Filename: "{app}\{#MyAppExeName}"; Tasks: desktopicon

[Run]
Filename: "{app}\{#MyAppExeName}"; Description: "Launch Topin Secure Browser"; Flags: nowait postinstall skipifsilent
```

### Build with Inno Setup
1. Open Inno Setup
2. File → Open → Select `TopinSecureBrowser.iss`
3. Build → Compile
4. Find installer in `Output/TopinSecureBrowser-Setup-1.0.0.exe`

---

## Comparison of Methods

| Method | Difficulty | Features | Best For |
|--------|-----------|----------|----------|
| **ZIP** | ⭐ Easy | Basic | Internal testing |
| **VS Setup** | ⭐⭐ Medium | Standard | Quick deployment |
| **WiX** | ⭐⭐⭐ Hard | Professional | Enterprise |
| **Inno Setup** | ⭐⭐ Medium | User-friendly | General use |

## Digital Signing (Recommended for Production)

After creating your installer, sign it:

```bash
signtool sign /f YourCertificate.pfx /p password /t http://timestamp.sectigo.com TopinSecureBrowser-Setup.exe
```

Benefits:
- ✅ No "Unknown Publisher" warnings
- ✅ Users trust the installer
- ✅ Required for some enterprise environments

---

## Distribution Checklist

- [ ] Build Release version
- [ ] Test on clean Windows machine
- [ ] Create installer (MSI or EXE)
- [ ] Sign installer (if you have certificate)
- [ ] Test installation process
- [ ] Create user documentation
- [ ] Set up download location
- [ ] Monitor feedback

---

## Quick Start Recommendation

**For your first release:**
1. ✅ Use the ZIP file I created (ready now!)
2. Share with test users
3. Get feedback
4. Then create professional installer with Inno Setup

**For production:**
1. Get code signing certificate from Sectigo
2. Create installer with Inno Setup
3. Sign the installer
4. Host on your website


