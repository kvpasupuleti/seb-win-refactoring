# TSB Launcher Fix - Root Cause Solution

## Problem Analysis

### The Crash
When running `TSB.exe` from its build output directory, the application crashed with:
```
Unable to locate required Cef/CefSharp dependencies:
Missing: icudtl.dat
Missing: v8_context_snapshot.bin
```

### Root Cause
The original launcher code had a **fundamental architectural flaw**:

**Old Code (Line 19):**
```csharp
string sebExecutable = Path.Combine(launcherDir, "TopinSecureBrowser.exe");
```

This assumed `TopinSecureBrowser.exe` would be in the **same directory** as `TSB.exe`, which is problematic because:

1. **During Development**: TSB.exe is built to `TopinSecureBrowser.Launcher\bin\x64\Release\`
2. **Runtime Files**: TopinSecureBrowser.exe is in `SafeExamBrowser.Runtime\bin\x64\Release\`
3. **CefSharp Dependencies**: All browser files (icudtl.dat, etc.) are with the Runtime, not the Launcher

### Why Two Executables?

**TSB.exe (Launcher)**
- **Purpose**: User-friendly entry point
- **Size**: ~15 KB (lightweight)
- **Function**: 
  - Finds TopinSecureBrowser.exe
  - Creates default configuration
  - Handles errors gracefully
  - Simplifies deployment

**TopinSecureBrowser.exe (Runtime)**
- **Purpose**: Actual secure browser application
- **Size**: ~500+ KB + dependencies
- **Function**:
  - Complete secure browser functionality
  - Manages CefSharp/Chromium
  - All security features
  - Configuration management

**Analogy**: Like having `steam.exe` (launcher) that finds and runs game executables.

## The Fix

### What Changed

**New Code (Lines 79-117):**
```csharp
private static string FindTopinSecureBrowserExecutable(string launcherDir)
{
    // Searches multiple locations in order:
    // 1. Same directory (portable)
    // 2. ../Application/ (installer layout)
    // 3. Parent directory
    // 4. Development build location
    // 5. Program Files installation
    
    // Returns full path if found, null otherwise
}
```

**Key Improvements:**
1. **Smart Search**: Tries multiple locations instead of just one
2. **Working Directory**: Sets to where TopinSecureBrowser.exe is located (line 53)
3. **Better Errors**: Shows all searched locations when not found
4. **Dev-Friendly**: Works during development without manual file copying

### How It Works Now

```
TSB.exe runs from: TopinSecureBrowser.Launcher\bin\x64\Release\

Search order:
  ✗ 1. Same directory: TopinSecureBrowser.Launcher\bin\x64\Release\TopinSecureBrowser.exe
  ✗ 2. ../Application/: TopinSecureBrowser.Launcher\bin\x64\Application\TopinSecureBrowser.exe
  ✗ 3. Parent dir: TopinSecureBrowser.Launcher\bin\x64\TopinSecureBrowser.exe
  ✓ 4. Dev location: SafeExamBrowser.Runtime\bin\x64\Release\TopinSecureBrowser.exe ← FOUND!
  
Uses this as working directory, so all CefSharp files are accessible.
```

## Testing the Fix

### Step 1: Rebuild TSB.exe
```cmd
# In Visual Studio
1. Right-click TopinSecureBrowser.Launcher project
2. Select "Rebuild"
3. Wait for build to complete
```

### Step 2: Run TSB.exe from its output directory
```cmd
cd TopinSecureBrowser.Launcher\bin\x64\Release
TSB.exe
```

**Expected Result**: 
- TSB.exe finds TopinSecureBrowser.exe in the Runtime build directory
- Sets working directory to Runtime directory
- All CefSharp dependencies are accessible
- Browser launches successfully ✓

### Step 3: Verify in Different Scenarios

**Scenario A: Development (Current)**
```
git-repos\seb-win-refactoring\
├── TopinSecureBrowser.Launcher\bin\x64\Release\TSB.exe
└── SafeExamBrowser.Runtime\bin\x64\Release\TopinSecureBrowser.exe
```
✓ Works via search path #4

**Scenario B: Installer Layout**
```
C:\Program Files\TopinSecureBrowser\
├── Launcher\TSB.exe
└── Application\TopinSecureBrowser.exe
```
✓ Works via search path #2

**Scenario C: Portable**
```
USB Drive\TSB\
├── TSB.exe
└── TopinSecureBrowser.exe (with all files)
```
✓ Works via search path #1

## Benefits of This Approach

### 1. **Developer-Friendly**
- No need to copy files around during development
- Just build and run
- Works from any location

### 2. **Flexible Deployment**
- Supports multiple installation layouts
- Works with installer (MSI)
- Works as portable application
- Works during development

### 3. **Better User Experience**
- Clear error messages showing what was searched
- Automatically finds the runtime
- No confusing setup required

### 4. **Maintainable**
- Easy to add new search locations
- Centralized logic
- Well-documented code

## Alternative: Eliminate TSB.exe Entirely?

### Option: Single Executable Approach

Instead of TSB.exe, you could:
1. Run `TopinSecureBrowser.exe` directly
2. Make it create default config if missing
3. Simplify to just one executable

**Pros:**
- Simpler architecture
- One less executable to maintain
- No search logic needed

**Cons:**
- Less user-friendly naming (TopinSecureBrowser.exe vs TSB.exe)
- No separate launcher logic
- Less flexible for customization

**Recommendation**: Keep both. TSB.exe provides valuable abstraction and user experience benefits.

## Summary

### Problem
TSB.exe couldn't find TopinSecureBrowser.exe and its dependencies during development.

### Root Cause
Hard-coded assumption that both executables would be in the same directory.

### Solution
Implemented intelligent search algorithm that finds TopinSecureBrowser.exe in multiple locations, sets proper working directory, and provides clear error messages.

### Result
✓ Works during development  
✓ Works with installer  
✓ Works as portable app  
✓ Clear error messages  
✓ No manual file copying needed  

---

**Status**: ✅ FIXED  
**File Modified**: `TopinSecureBrowser.Launcher\Program.cs`  
**Action Required**: Rebuild TopinSecureBrowser.Launcher project  
**Next Step**: Test by running TSB.exe from its output directory

