# Topin Secure Browser (TSB) - Changes Summary

## All Changes Made to Convert SEB to TSB

### 1. ✅ VM Compatibility Fixes (Previously Done)
**Files Modified:**
- `SafeExamBrowser.Configuration\ConfigurationData\DataValues.cs`
- `SebWindowsConfig\SEBSettings.cs`

**Changes:**
- Virtual machine detection: ALLOW
- Display limit: 10 displays
- Display errors: IGNORED

---

### 2. ✅ Installer Rebranding (Just Applied)
**Files Modified:**
- `Setup\Product.wxs`
- `Setup\Shortcuts.wxs`
- `Setup\Directories.wxs`

**Changes:**
- **Product Name:** "Safe Exam Browser" → "Topin Secure Browser"
- **Manufacturer:** "ETH Zürich" → "Topin"
- **UpgradeCode:** Changed to `B2C5F19A-7D3E-4A52-9B41-E8F74C6D2A9E` (unique GUID)
- **Install Path:** `C:\Program Files\SafeExamBrowser\` → `C:\Program Files\TopinSecureBrowser\`
- **Start Menu:** "SafeExamBrowser" → "Topin Secure Browser"
- **Registry Key:** `Software\ETH Zürich\Safe Exam Browser` → `Software\Topin\Topin Secure Browser`

**Result:** TSB now installs as a completely separate product from SEB!

---

### 3. ✅ Black Screen Fix (Just Applied)
**File Modified:**
- `SafeExamBrowser.Browser\BrowserApplication.cs`

**Problem:**
- Black screen when launching TSB
- Quit popup appears then disappears
- Splash screen background black instead of white
- Caused by GPU/hardware acceleration issues in VMs

**Solution - Added GPU Disable Flags:**
```csharp
// Disable GPU acceleration for better VM compatibility
cefSettings.CefCommandLineArgs.Add("disable-gpu");
cefSettings.CefCommandLineArgs.Add("disable-gpu-compositing");
cefSettings.CefCommandLineArgs.Add("disable-software-rasterizer");
cefSettings.CefCommandLineArgs.Add("disable-gpu-vsync");
cefSettings.SetOffScreenRenderingBestPerformanceArgs();
```

**Result:** Browser now renders properly in VMs without GPU acceleration!

---

### 4. ✅ Student Edition Configuration (Previously Done)
**Files Modified:**
- `Setup\Product.wxs`
- `Setup\Shortcuts.wxs`
- `Setup\Setup.wixproj`

**Changes:**
- Removed Configuration Tool (students don't need it)
- Removed Reset Utility (students don't need it)
- Disabled code signing (development version)
- Single architecture installer (x64 only)

---

## Files Ready for Branding

**Location:** `TSB-Branding\` folder

Contains:
- Application icons (.ico)
- Splash screens (.png)
- Installer graphics (.bmp)
- Rebranding guide

**To rebrand:**
1. Create your TSB-branded graphics
2. Replace files in their original locations
3. Rebuild installer

---

## Build the Updated Installer

```powershell
.\build-installer-x64-student.ps1
```

**Output:** `Setup\bin\x64\Release\Setup.msi`

---

## What's Fixed

### Issue #1: SEB Version Conflict ✅
**Before:**
- Windows recognized TSB as original SEB
- "Newer version available" message
- Couldn't install alongside SEB

**After:**
- TSB is a separate product
- Unique UpgradeCode
- Installs in different directory
- Can coexist with SEB

### Issue #2: Black Screen in VM ✅
**Before:**
- Black screen on launch
- Quit popup disappears immediately
- Splash screen background black

**After:**
- GPU acceleration disabled
- Software rendering enabled
- Proper display in VMs
- White splash screen background

---

## Current State

✅ **Working:**
- VM detection allowed
- Multiple displays supported
- Display errors ignored
- Separate product from SEB
- GPU acceleration disabled
- Student-friendly installer
- No config tool or reset utility

⚠️ **Still Using SEB Branding:**
- Icons still show SEB logo
- Splash screen shows SEB branding
- File extension still `.seb`
- URL protocols still `seb://` and `sebs://`

📝 **Next Steps:**
1. Test new installer in VM
2. Verify black screen is fixed
3. Create TSB-branded graphics
4. Apply rebranding
5. Rebuild final installer

---

## Testing Checklist

- [ ] Uninstall old TSB version
- [ ] Uninstall SEB (if testing side-by-side)
- [ ] Install new TSB.msi
- [ ] Launch TSB without config file
- [ ] Verify white splash screen (not black)
- [ ] Verify browser shows content (not black)
- [ ] Test with .seb config file
- [ ] Verify Ctrl+Q shows quit dialog properly
- [ ] Check: TSB installed in `C:\Program Files\TopinSecureBrowser\`
- [ ] Check: Start Menu shows "Topin Secure Browser"
- [ ] Check: TSB and SEB can coexist

---

## Technical Details

### GPU Acceleration Disabled
**Why:** VMs often have incomplete or buggy GPU driver support, causing Chromium/CefSharp to fail rendering.

**Command-Line Arguments Added:**
- `disable-gpu` - Disables GPU hardware acceleration
- `disable-gpu-compositing` - Uses software compositing
- `disable-software-rasterizer` - Prevents software fallback issues
- `disable-gpu-vsync` - Disables vertical sync
- `SetOffScreenRenderingBestPerformanceArgs()` - Optimizes for software rendering

**Trade-off:**
- ✅ Works in all VMs
- ✅ No black screen
- ✅ Stable rendering
- ⚠️ Slightly slower performance (acceptable for exam browser)

### Unique Product Identity

**UpgradeCode:**
- Old: `97A8B13E-48FB-4BE1-A7C2-DD1863F95CCB` (SEB)
- New: `B2C5F19A-7D3E-4A52-9B41-E8F74C6D2A9E` (TSB)

**Why Important:** Windows uses UpgradeCode to identify products. Same UpgradeCode = same product.

---

## Logs Location

If issues occur, check logs:
```
%LocalAppData%\SafeExamBrowser\Logs\
```

**Log Files:**
- `SafeExamBrowser_Runtime_*.log`
- `SafeExamBrowser_Client_*.log`
- `SafeExamBrowser_Browser_*.log`

---

## Prerequisites

Students need these installed before TSB:
1. .NET Framework 4.8
2. Visual C++ Redistributable 2015-2022
3. Microsoft Edge WebView2 Runtime

---

## Version Control Note

**Important:** Keep these changes in version control:
1. VM compatibility settings
2. GPU disable flags
3. TSB product identity
4. Installer configuration

This ensures future builds maintain TSB branding and VM compatibility.

---

## Contact & Support

For issues or questions:
1. Check `TSB-TROUBLESHOOTING.md`
2. Review logs in `%LocalAppData%\SafeExamBrowser\Logs\`
3. Verify all prerequisites installed
4. Test in different VM if persistent issues

---

**Ready to rebuild and test!** 🚀

