# How to Properly Build and Run Topin Secure Browser

## The Problem You're Experiencing

Your error logs show that TopinSecureBrowser.exe is trying to launch SafeExamBrowser.Client.exe from the wrong directory. This is happening because:

1. **You only built the Launcher project** (TSB.exe)
2. **You didn't build the full solution** (Runtime + Client + Service)
3. The executables are in different directories during development

## The Correct Build Process

### Step 1: Build the ENTIRE Solution

In Visual Studio:

```
1. Open SafeExamBrowser.sln
2. Select configuration: Release | x64
3. Build → Rebuild Solution (NOT just one project!)
4. Wait for ALL projects to compile (~5-10 minutes first time)
```

OR use command line:
```cmd
cd C:\Users\krish\Desktop\git-repos\seb-win-refactoring
msbuild SafeExamBrowser.sln /p:Configuration=Release /p:Platform=x64
```

### Step 2: Verify Build Output

After building, check that these files exist:

```cmd
# Runtime (Main application)
dir SafeExamBrowser.Runtime\bin\x64\Release\TopinSecureBrowser.exe

# Client (Browser component)  
dir SafeExamBrowser.Runtime\bin\x64\Release\SafeExamBrowser.Client.exe

# Launcher
dir TopinSecureBrowser.Launcher\bin\x64\Release\TSB.exe

# Service
dir SafeExamBrowser.Service\bin\x64\Release\SafeExamBrowser.Service.exe
```

## Why You're Getting the Error

### Current State
```
✗ SafeExamBrowser.Runtime\bin\x64\Release\TopinSecureBrowser.exe - MISSING!
✗ SafeExamBrowser.Runtime\bin\x64\Release\SafeExamBrowser.Client.exe - MISSING!
✓ TopinSecureBrowser.Launcher\bin\x64\Release\TSB.exe - EXISTS (but can't find anything)
```

### Expected State After Full Build
```
✓ SafeExamBrowser.Runtime\bin\x64\Release\TopinSecureBrowser.exe - Main app
✓ SafeExamBrowser.Runtime\bin\x64\Release\SafeExamBrowser.Client.exe - Browser
✓ SafeExamBrowser.Runtime\bin\x64\Release\*.dll - All dependencies
✓ SafeExamBrowser.Runtime\bin\x64\Release\locales\ - Chromium locales
✓ SafeExamBrowser.Runtime\bin\x64\Release\swiftshader\ - GPU support
✓ TopinSecureBrowser.Launcher\bin\x64\Release\TSB.exe - Launcher
```

## Testing After Build

### Option 1: Run TopinSecureBrowser.exe Directly (Simplest)

```cmd
cd SafeExamBrowser.Runtime\bin\x64\Release
.\TopinSecureBrowser.exe
```

This will:
- Use default settings
- Launch without configuration file
- Open to blank page or default URL

### Option 2: Run with Configuration File

```cmd
cd SafeExamBrowser.Runtime\bin\x64\Release
.\TopinSecureBrowser.exe "C:\path\to\topin-default.seb"
```

### Option 3: Run via TSB Launcher

After my earlier fix, TSB.exe will find TopinSecureBrowser.exe automatically:

```cmd
cd TopinSecureBrowser.Launcher\bin\x64\Release
.\TSB.exe
```

## Why Building Only One Project Doesn't Work

When you right-click a project and select "Build", Visual Studio only builds **that specific project**, not its dependencies or related projects.

### What Happens When You Only Build Launcher:
1. ✓ TSB.exe is built
2. ✗ TopinSecureBrowser.exe is NOT built (separate project)
3. ✗ SafeExamBrowser.Client.exe is NOT built (separate project)  
4. ✗ CefSharp dependencies are NOT copied
5. Result: TSB.exe can't find anything to launch!

### What Happens When You Build Entire Solution:
1. ✓ All 48 projects are built
2. ✓ TopinSecureBrowser.exe is created
3. ✓ SafeExamBrowser.Client.exe is created
4. ✓ All DLLs are copied to output directories
5. ✓ CefSharp dependencies are in place
6. Result: Everything works!

## Common Mistakes

### Mistake 1: Building Individual Projects
```
✗ Right-click "TopinSecureBrowser.Launcher" → Build
```

**Correct:**
```
✓ Build → Rebuild Solution
```

### Mistake 2: Running from Wrong Directory
```
✗ Running TopinSecureBrowser.exe from anywhere except Runtime\bin\x64\Release
```

**Correct:**
```
✓ Run from: SafeExamBrowser.Runtime\bin\x64\Release
```

### Mistake 3: Forgetting Platform Selection
```
✗ Building with "Any CPU" or "x86" when CefSharp requires specific architecture
```

**Correct:**
```
✓ Select "x64" in Visual Studio toolbar (if on 64-bit Windows)
```

## Build Time Expectations

### First Build (Clean Solution)
- **Time**: 5-10 minutes
- **What's happening**: 
  - Compiling 48 projects
  - Restoring NuGet packages
  - Downloading CefSharp binaries (~300 MB)
  - Copying dependencies

### Subsequent Builds (Incremental)
- **Time**: 30 seconds - 2 minutes
- **What's happening**:
  - Only recompiling changed projects
  - Copying updated files

## Quick Checklist

Before trying to run the application:

- [ ] Opened SafeExamBrowser.sln in Visual Studio
- [ ] Selected "Release" configuration
- [ ] Selected "x64" platform
- [ ] Clicked Build → Rebuild Solution
- [ ] Waited for "Build succeeded" message
- [ ] Verified TopinSecureBrowser.exe exists in Runtime output
- [ ] Verified SafeExamBrowser.Client.exe exists in Runtime output
- [ ] Verified CefSharp DLLs exist in Runtime output
- [ ] Navigated to Runtime\bin\x64\Release directory
- [ ] Ran .\TopinSecureBrowser.exe from that directory

## What to Do Now

### Immediate Action Required:

1. **Open Visual Studio**
2. **Select configuration: Release | x64**
3. **Click: Build → Rebuild Solution**
4. **Wait for completion**
5. **Then test by running TopinSecureBrowser.exe from its output directory**

### Expected Result:

After building the full solution:
- TopinSecureBrowser.exe will exist
- SafeExamBrowser.Client.exe will be in the same directory
- All CefSharp files will be present
- Application will launch successfully

---

**TL;DR**: You need to build the **entire solution**, not just the Launcher project. Use "Build → Rebuild Solution" in Visual Studio.

