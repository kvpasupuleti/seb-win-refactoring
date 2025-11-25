# Building Student Edition Installer

## Summary of Changes Made

Your installer has been customized for **student distribution**:

### ✅ What's Included:
- Safe Exam Browser (main application)
- Windows Service
- .seb file association
- seb:// and sebs:// URL protocols
- Your VM-friendly changes (allows VM, 10 displays, ignores display errors)

### ❌ What's Removed:
- Configuration Tool (students don't need to edit configs)
- Reset Utility (students don't need this)
- No code signing (not ready for production)
- Smaller file size

### 📦 Available Installers:

| Script | Output | Size | Best For |
|--------|--------|------|----------|
| `build-installer-x64-student.ps1` | x64 MSI only | ~100-150 MB | **Recommended** - Modern computers (64-bit) |
| `build-installer-x86-student.ps1` | x86 MSI only | ~100-150 MB | Legacy computers (32-bit) |

---

## Quick Start

### Build x64 Installer (Recommended):

```powershell
cd "C:\Users\krish\OneDrive\Desktop\git-repos\seb-win-refactoring"
.\build-installer-x64-student.ps1
```

**Output:** `Setup\bin\x64\Release\Setup.msi`

---

## Prerequisites for Students

Students will need these installed **before** running your MSI:

1. **.NET Framework 4.8**
   - Download: https://dotnet.microsoft.com/download/dotnet-framework/net48

2. **Visual C++ Redistributable 2015-2022**
   - Download: https://aka.ms/vs/17/release/vc_redist.x64.exe

3. **Microsoft Edge WebView2 Runtime**
   - Download: https://go.microsoft.com/fwlink/p/?LinkId=2124703

### Option: Create a prerequisites installer
You could create a simple batch script that installs these automatically.

---

## File Size Comparison

| Installer Type | Size | What's Included |
|----------------|------|-----------------|
| Your x64 MSI (student edition) | ~100-150 MB | App only, students install prerequisites separately |
| Original Bundle (both architectures) | ~200-300 MB | Everything including prerequisites, both x86 and x64 |

**Your choice reduces file size by ~50%!**

---

## Installation Instructions for Students

1. Ensure prerequisites are installed (see above)
2. Download `Setup.msi`
3. Double-click to install
4. Accept UAC prompt
5. Follow installation wizard
6. Safe Exam Browser will be in Start Menu

---

## Distribution Options

### Option 1: MSI Only (What you have now)
- Distribute `Setup.msi` (~100-150 MB)
- Students install prerequisites separately
- Smaller download
- More technical

### Option 2: Create a Simple Bundle
If you want one-click installation with prerequisites, you can:
1. Keep your current setup (no config tool, no reset utility)
2. Build the SetupBundle which includes prerequisites
3. File will be larger (~200 MB) but easier for students

Let me know if you want Option 2!

---

## Testing

Test in your VM:
```powershell
# After building
msiexec /i "Setup\bin\x64\Release\Setup.msi"
```

Or just double-click the MSI file.

---

## Important Notes

- ✅ No code signing (as requested)
- ✅ VM-friendly (allows virtual machines)
- ✅ No Config Tool (students can't modify settings)
- ✅ No Reset Utility (students can't reset)
- ✅ Only installs what students need
- ⚠️ Windows will show security warning (unsigned installer)
- ⚠️ Students need prerequisites installed first

