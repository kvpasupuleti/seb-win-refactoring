# Topin Secure Browser (TSB) - Troubleshooting Guide

## Issue 1: ✅ FIXED - Recognized as Original SEB

### Problem:
- Windows recognizes TSB as the original Safe Exam Browser
- Shows "newer version available" message
- Conflicts with existing SEB installation

### Root Cause:
The installer used the same `UpgradeCode` as the original SEB, so Windows treats them as the same product.

### Solution Applied:
✅ Changed `UpgradeCode` from `97A8B13E-48FB-4BE1-A7C2-DD1863F95CCB` to `B2C5F19A-7D3E-4A52-9B41-E8F74C6D2A9E`  
✅ Changed Product Name to "Topin Secure Browser"  
✅ Changed Manufacturer to "Topin"  
✅ Changed Install Directory to `C:\Program Files\TopinSecureBrowser\`  
✅ Changed Start Menu folder to "Topin Secure Browser"

**Result:** TSB and SEB can now coexist as separate products!

---

## Issue 2: Black Screen After Launching

### Problem:
After launching TSB with a config file, you see a black screen with nothing visible.

### Possible Causes & Solutions:

#### Cause 1: Browser Disabled in Config File
The `.seb` config file might have the browser disabled.

**Solution:**
1. Check if your config file has `enableSebBrowser` set to `false`
2. If testing without a config file, TSB will use defaults (browser enabled)

#### Cause 2: Invalid or Blocked Start URL
The config file might have:
- An invalid URL
- A blocked URL
- No URL specified

**Solution:**
Test with a simple config that has a valid URL, or create a test config:

```xml
<!-- Simple test config -->
<dict>
    <key>startURL</key>
    <string>https://www.google.com</string>
    <key>enableSebBrowser</key>
    <true/>
</dict>
```

#### Cause 3: Missing WebView2 Runtime
The browser engine (Microsoft Edge WebView2) might not be installed.

**Solution:**
Install Microsoft Edge WebView2 Runtime:
- Download: https://go.microsoft.com/fwlink/p/?LinkId=2124703
- Or install Microsoft Edge browser (includes WebView2)

#### Cause 4: Browser Initialization Failure
The browser might be failing to initialize silently.

**Solution:**
1. Check logs at: `%LocalAppData%\SafeExamBrowser\Logs\`
2. Look for errors related to CefSharp or browser initialization
3. Enable debug logging by adding to your config

#### Cause 5: Display/Graphics Issues in VM
Virtual machine graphics drivers might be incompatible.

**Solution:**
1. Update VM graphics drivers (VMware Tools, VirtualBox Guest Additions, etc.)
2. Try different display settings in VM
3. Enable 3D acceleration in VM settings

---

## Quick Test - Launch Without Config File

To test if TSB works at all:

```powershell
# Navigate to installed location
cd "C:\Program Files\TopinSecureBrowser\Application"

# Launch without config (should open default URL)
.\SafeExamBrowser.exe
```

**Expected behavior:** TSB should launch and show https://www.safeexambrowser.org/start

If this works, the issue is with your config file.  
If this doesn't work, there's a system/dependency issue.

---

## Creating a Test Config File

Create a minimal `.seb` config for testing:

### Method 1: Use the Original SEB Config Tool
1. Open the original SEB Config Tool
2. Set Start URL to `https://www.google.com`
3. Enable Browser
4. Save as `test.seb`
5. Launch TSB with this file

### Method 2: Manual Config (Advanced)
Create a file called `test.seb` with this content:

```xml
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>startURL</key>
    <string>https://www.google.com</string>
    <key>enableSebBrowser</key>
    <true/>
    <key>showMenuBar</key>
    <true/>
    <key>showTaskBar</key>
    <true/>
</dict>
</plist>
```

---

## Checking Logs

TSB creates logs that can help diagnose issues:

### Log Locations:
- **Runtime Log:** `%LocalAppData%\SafeExamBrowser\Logs\SafeExamBrowser_Runtime_[date].log`
- **Client Log:** `%LocalAppData%\SafeExamBrowser\Logs\SafeExamBrowser_Client_[date].log`
- **Browser Log:** `%LocalAppData%\SafeExamBrowser\Logs\SafeExamBrowser_Browser_[date].log`

### To View Logs:
```powershell
# Open logs folder
explorer "%LocalAppData%\SafeExamBrowser\Logs\"

# Or view latest runtime log
Get-Content "$env:LOCALAPPDATA\SafeExamBrowser\Logs\SafeExamBrowser_Runtime_*.log" -Tail 50
```

### What to Look For:
- `ERROR` or `EXCEPTION` messages
- Browser initialization failures
- CefSharp errors
- Display/graphics errors
- Configuration loading errors

---

## Prerequisites Check

Make sure all required components are installed:

### Check .NET Framework 4.8:
```powershell
Get-ItemProperty "HKLM:\SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" | Select-Object Version, Release
```

Should show: Version 4.8 or higher

### Check Visual C++ Redistributable:
Look for "Microsoft Visual C++ 2015-2022 Redistributable" in:
- Control Panel → Programs and Features

### Check WebView2:
```powershell
Get-ItemProperty "HKLM:\SOFTWARE\WOW6432Node\Microsoft\EdgeUpdate\Clients\{F3017226-FE2A-4295-8BDF-00C3A9A7E4C5}" -ErrorAction SilentlyContinue
```

If null/error, WebView2 is not installed.

---

## Common Fixes

### Fix 1: Reinstall Prerequisites
```powershell
# .NET Framework 4.8
Start-Process "https://dotnet.microsoft.com/download/dotnet-framework/net48"

# Visual C++ Redistributable
Start-Process "https://aka.ms/vs/17/release/vc_redist.x64.exe"

# WebView2 Runtime
Start-Process "https://go.microsoft.com/fwlink/p/?LinkId=2124703"
```

### Fix 2: Clean Reinstall TSB
1. Uninstall current version
2. Delete: `C:\Program Files\TopinSecureBrowser\`
3. Delete: `%LocalAppData%\SafeExamBrowser\`
4. Delete: `%AppData%\SafeExamBrowser\`
5. Reinstall from new MSI

### Fix 3: Reset Browser Cache
```powershell
# Delete browser cache
Remove-Item "$env:LOCALAPPDATA\SafeExamBrowser\Cache" -Recurse -Force
```

---

## Testing Checklist

- [ ] Prerequisites installed (.NET, VC++, WebView2)
- [ ] TSB launches without config file
- [ ] Simple test config works
- [ ] Logs don't show errors
- [ ] VM has updated graphics drivers
- [ ] VM has 3D acceleration enabled
- [ ] Firewall/antivirus not blocking TSB
- [ ] No conflicting SEB installation

---

## Need More Help?

### Debug Mode
Launch TSB with debug logging:
```powershell
cd "C:\Program Files\TopinSecureBrowser\Application"
.\SafeExamBrowser.exe --debug
```

### Collect Information:
1. TSB version number
2. Windows version (`winver`)
3. VM software (VMware, VirtualBox, Hyper-V)
4. Log files from `%LocalAppData%\SafeExamBrowser\Logs\`
5. Screenshot of the black screen
6. Config file being used (if any)

---

## Known Issues

### Black Screen in VMware
- **Solution:** Update VMware Tools, enable 3D acceleration

### Black Screen in VirtualBox
- **Solution:** Install VirtualBox Guest Additions, increase video memory

### Black Screen in Hyper-V
- **Solution:** Use Enhanced Session Mode

---

## Quick Summary

1. **SEB Conflict:** FIXED - New UpgradeCode makes TSB separate from SEB
2. **Black Screen:** Likely config file issue or missing WebView2
3. **Test:** Launch TSB without config first
4. **Check:** Logs at `%LocalAppData%\SafeExamBrowser\Logs\`
5. **Install:** WebView2 Runtime if missing

**Rebuild the installer now with `.\build-installer-x64-student.ps1` to get the fixed version!**

