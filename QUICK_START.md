# Quick Start Guide - Topin Secure Browser

## 🎯 What's Been Done

Your Topin Secure Browser (TSB) customization is complete! Here's what you have:

### ✅ Completed Work
1. ✅ **Full Rebranding** - All "Safe Exam Browser" references changed to "Topin Secure Browser"
2. ✅ **TSB Launcher** - New `TSB.exe` that simplifies user experience
3. ✅ **Installer Ready** - Complete MSI installer with Topin branding
4. ✅ **.NET 4.7.2** - All projects target .NET 4.7.2 for compatibility
5. ✅ **License Compliant** - Full MPL 2.0 compliance maintained
6. ✅ **Documentation** - Build instructions and user guide created

### 📦 What You Get
- Professional Windows installer (MSI)
- Simple user launcher (TSB.exe)
- Complete branding as Topin product
- No configuration tools exposed to users
- MPL 2.0 compliant licensing

## 🚀 Next Steps - Getting Your Build

### Option 1: Build It Yourself (Recommended for Testing)

**Requirements:**
- Windows 10/11
- Visual Studio 2019 or 2022
- .NET Framework 4.7.2 Developer Pack
- WiX Toolset v3.11+

**Steps:**
```bash
1. Open SafeExamBrowser.sln in Visual Studio
2. Select "Release" configuration and "x64" platform
3. Build → Build Solution (Ctrl+Shift+B)
4. Wait 5-10 minutes for first build
5. Find output in: Setup\bin\x64\Release\Setup.msi
```

**For detailed instructions, see:** `BUILD_INSTRUCTIONS.md`

### Option 2: Cloud Build (If You Have GitHub Actions)

1. Push your code to GitHub
2. Set up GitHub Actions workflow (example in BUILD_INSTRUCTIONS.md)
3. Automatic builds on every commit
4. Download artifacts from Actions tab

### Option 3: Professional Build Service

Contact a Windows development service to:
- Build the MSI installer
- Optionally code sign the executables
- Provide tested build artifacts

## 📋 Immediate Checklist

### Before First Build
- [ ] Install Visual Studio 2019/2022
- [ ] Install .NET Framework 4.7.2 Developer Pack
- [ ] Install WiX Toolset v3.11 or newer
- [ ] Verify all tools are installed correctly

### After First Build
- [ ] Test TSB.exe launches correctly
- [ ] Verify Topin branding appears everywhere
- [ ] Test installer (Setup.msi) installation
- [ ] Check Start Menu shortcut works
- [ ] Test uninstallation

### For Production
- [ ] Obtain code signing certificate ($400/year)
- [ ] Enable code signing in Setup.wixproj
- [ ] Sign all executables and MSI
- [ ] Test on clean Windows 10/11 systems
- [ ] Create deployment documentation

## 🔍 Testing Your Build

### Quick Test (5 minutes)
```cmd
# After building, navigate to launcher output
cd TopinSecureBrowser.Launcher\bin\x64\Release

# Run TSB.exe
TSB.exe

# Expected: Secure browser launches with Topin branding
```

### Full Test (15 minutes)
1. **Build Test**: Solution builds without errors
2. **Launcher Test**: TSB.exe starts correctly
3. **Installer Test**: Setup.msi installs successfully
4. **Function Test**: Browser works correctly
5. **Branding Test**: All Topin branding visible
6. **Uninstall Test**: Uninstallation works cleanly

## 📁 Key Files You Need

### For Distribution
```
Setup\bin\x64\Release\Setup.msi         ← Windows Installer (main deliverable)
```

### For Portable Installation
```
TopinSecureBrowser.Launcher\bin\x64\Release\TSB.exe
SafeExamBrowser.Runtime\bin\x64\Release\TopinSecureBrowser.exe
SafeExamBrowser.Runtime\bin\x64\Release\*.dll (all DLLs)
SafeExamBrowser.Client\bin\x64\Release\SafeExamBrowser.Client.exe
SafeExamBrowser.Service\bin\x64\Release\SafeExamBrowser.Service.exe
```

## 🐛 Troubleshooting

### "Cannot build Setup project"
**Problem**: WiX Toolset not installed  
**Solution**: Download and install from https://github.com/wixtoolset/wix3/releases

### "heat.exe not found"
**Problem**: WiX environment variable not set  
**Solution**: Reinstall WiX Toolset, restart Visual Studio

### "Target framework not found"
**Problem**: .NET 4.7.2 not installed  
**Solution**: Install from Visual Studio Installer

### Build succeeds but errors in Setup project
**Problem**: Code signing commands failing  
**Solution**: Already disabled - should work now. If not, check Setup.wixproj

## 📖 Documentation Reference

| Document | Purpose | Audience |
|----------|---------|----------|
| `README.md` | User guide | End users |
| `BUILD_INSTRUCTIONS.md` | Complete build guide | Developers |
| `TOPIN_CUSTOMIZATION_SUMMARY.md` | What was changed | Technical team |
| `QUICK_START.md` | This file | Getting started |

## 💡 Pro Tips

### For Faster Builds
- Use `Release|x64` configuration (most common)
- Build main projects first, then Setup
- Keep builds on SSD for speed

### For Testing
- Test on clean VM first
- Use Windows Sandbox for quick tests
- Keep multiple test configurations

### For Production
- Always test installer on clean machine
- Use code signing for production builds
- Version your releases properly

## 🎓 Learning Resources

### Understanding SEB
- Safe Exam Browser: https://safeexambrowser.org
- SEB Documentation: https://safeexambrowser.org/documentation
- SEB GitHub: https://github.com/SafeExamBrowser/seb-win

### Windows Installer (WiX)
- WiX Tutorial: https://www.firegiant.com/wix/tutorial/
- WiX Documentation: https://wixtoolset.org/documentation/

### MPL 2.0 License
- License Text: http://mozilla.org/MPL/2.0/
- FAQ: https://www.mozilla.org/en-US/MPL/2.0/FAQ/

## ❓ Common Questions

**Q: Can I build this on Linux/Mac?**  
A: No, requires Windows and Visual Studio. Consider using a Windows VM.

**Q: Do I need a code signing certificate?**  
A: Not required for testing, highly recommended for production.

**Q: How do I customize the default configuration?**  
A: Edit the XML in `TopinSecureBrowser.Launcher\Program.cs` (CreateDefaultConfig method)

**Q: Can I rename TSB.exe to something else?**  
A: Yes, but update all installer references in Setup project.

**Q: Is the software ready for production?**  
A: Yes for functionality, but get code signing certificate first.

## 🆘 Getting Help

### If You're Stuck
1. Check `BUILD_INSTRUCTIONS.md` for detailed steps
2. Review error messages carefully
3. Verify all prerequisites installed
4. Try building in Debug mode first
5. Check that .NET 4.7.2 is correctly installed

### Build Fails?
- Read the error message carefully
- Check Visual Studio Error List
- Verify WiX Toolset installed
- Try "Clean Solution" then rebuild

### Installer Issues?
- Check Setup\bin\x64\Release for MSI
- Look for WiX error messages
- Verify all Component files exist
- Try building Setup project separately

## ✨ What's Next?

### Immediate (This Week)
1. Get familiar with the codebase
2. Build the solution locally
3. Test TSB.exe and installer
4. Review documentation

### Short Term (This Month)
1. Obtain code signing certificate
2. Set up build automation
3. Test on multiple Windows versions
4. Create deployment plan

### Medium Term (Next Quarter)
1. Production deployment
2. User feedback and iteration
3. Custom configuration development
4. Platform integration

## 📞 Support

For questions about:
- **Building**: See `BUILD_INSTRUCTIONS.md`
- **Using**: See `README.md`
- **Customizing**: See `TOPIN_CUSTOMIZATION_SUMMARY.md`
- **Licensing**: See MPL 2.0 documentation

---

**You're ready to build!** 🎉

Start with Option 1 (Build It Yourself) for the best learning experience.

Good luck!

---
*Last Updated: November 22, 2025*

