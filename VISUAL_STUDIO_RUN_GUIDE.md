# SOLUTION: How to Run Topin Secure Browser in Visual Studio

## The Problem

When you click "Start" in Visual Studio, it launches from the **startup project's directory**, not the Runtime directory. This causes SafeExamBrowser.Client.exe to be looked for in the wrong location.

## The Fix I Just Applied

I added a **Post-Build Event** to `SafeExamBrowser.Runtime.csproj` that automatically copies `SafeExamBrowser.Client.exe` to the Runtime output directory after every build.

## What You Need to Do Now

### Step 1: Rebuild the Solution

In Visual Studio:
```
1. Build → Rebuild Solution
2. Wait for build to complete
```

This will:
- Build all projects
- Copy SafeExamBrowser.Client.exe to Runtime directory automatically
- Prepare everything for execution

### Step 2: Set the Correct Startup Project

The issue is that you're starting from the wrong project. You need to run from the **Runtime project**, not the Launcher.

In Visual Studio:
```
1. Right-click on "SafeExamBrowser.Runtime" project in Solution Explorer
2. Select "Set as Startup Project"
3. Click the green "Start" button (or press F5)
```

This will:
- Launch TopinSecureBrowser.exe from the Runtime directory
- All CefSharp dependencies will be in the correct place
- SafeExamBrowser.Client.exe will be in the same directory
- Application will run successfully

## Alternative: Run Without Debugging

If you don't want to change the startup project:

### Option A: Run TopinSecureBrowser.exe Directly
```cmd
1. Open File Explorer
2. Navigate to: SafeExamBrowser.Runtime\bin\x64\Release
3. Double-click: TopinSecureBrowser.exe
```

### Option B: Run from Command Line
```cmd
cd SafeExamBrowser.Runtime\bin\x64\Release
.\TopinSecureBrowser.exe
```

### Option C: Run via TSB Launcher
After my earlier fix to TSB.exe, it should find TopinSecureBrowser.exe automatically:
```cmd
cd TopinSecureBrowser.Launcher\bin\x64\Release  
.\TSB.exe
```

## Why This Happens

### Current Situation:
- You have TSB.Launcher set as startup project
- Visual Studio runs TSB.exe from: `TopinSecureBrowser.Launcher\bin\x64\Release\`
- TSB.exe finds and launches TopinSecureBrowser.exe in Runtime directory
- TopinSecureBrowser.exe tries to find SafeExamBrowser.Client.exe in its **own directory**
- But Client.exe is in: `SafeExamBrowser.Client\bin\x64\Release\`
- **Mismatch!** → Crash

### After Fix:
- Post-build event copies Client.exe to Runtime directory
- TopinSecureBrowser.exe finds Client.exe in the same directory
- All CefSharp files are together
- **Success!** ✓

## Quick Checklist

Before running:
- [ ] Built the entire solution (Rebuild Solution)
- [ ] Post-build event copied SafeExamBrowser.Client.exe (check build output window)
- [ ] SafeExamBrowser.Runtime is set as startup project
- [ ] Configuration is set to Release|x64
- [ ] Press F5 or click Start

## Expected Result

After following these steps:
- TopinSecureBrowser.exe will launch
- Browser window will open with Topin branding
- No CefSharp errors
- Application runs successfully

## Verification

After building, verify the file exists:
```cmd
dir SafeExamBrowser.Runtime\bin\x64\Release\SafeExamBrowser.Client.exe
```

You should see the file listed with a recent timestamp.

---

**TL;DR**: 
1. Rebuild Solution (to run the post-build event)
2. Set SafeExamBrowser.Runtime as startup project  
3. Press F5 to run

This will work! 🎯

