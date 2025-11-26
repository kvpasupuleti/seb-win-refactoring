# Topin Secure Browser

## What is Topin Secure Browser?

Topin Secure Browser (TSB) is a secure assessment platform designed to create a controlled testing environment for online examinations. It prevents students from accessing unauthorized resources during exams while maintaining a smooth testing experience.

## Key Features

- **Secure Testing Environment**: Prevents access to other applications and websites during exams
- **Browser Lockdown**: Disables common shortcuts and system functions that could be used to cheat
- **Customizable Configuration**: Administrators can configure allowed websites and browser behavior
- **Professional Branding**: Clean, modern interface with Topin branding
- **Easy Deployment**: Simple installation and launch process

## Installation

### System Requirements

- **Operating System**: Windows 10 or Windows 11 (64-bit recommended)
- **Processor**: Dual-core 2.0 GHz or faster
- **RAM**: 4 GB minimum, 8 GB recommended
- **Disk Space**: 500 MB free space
- **.NET Framework**: 4.7.2 or higher (usually pre-installed on Windows 10/11)

### Installation Steps

1. **Download** the Topin Secure Browser installer (`Setup.msi`)
2. **Run** the installer with administrator privileges
3. **Follow** the installation wizard
4. **Launch** from the Start Menu: "Topin Secure Browser"

### Alternative: Portable Installation

For non-admin users or temporary installations:
1. Extract all files to a folder
2. Run `TSB.exe` from the installation folder
3. No installation required

## Usage

### For Students

1. **Before the Exam**:
   - Ensure Topin Secure Browser is installed
   - Close all other applications
   - Ensure stable internet connection

2. **During the Exam**:
   - Launch "Topin Secure Browser" from Start Menu or desktop
   - Wait for the browser to load
   - Follow your instructor's directions for accessing the exam
   - Do not attempt to exit or switch applications during the exam

3. **Ending the Exam**:
   - Submit your exam as instructed
   - Wait for the exam platform to end the session
   - Follow on-screen instructions to exit safely

### For Administrators

#### Basic Configuration

The browser uses a default configuration file (`topin-default.seb`) that is automatically created on first launch. To customize:

1. Locate the configuration file in the installation directory
2. Modify settings as needed (requires knowledge of SEB configuration format)
3. Distribute custom configuration to students

#### Deployment Methods

**Method 1: MSI Installer**
- Use `Setup.msi` for enterprise deployment
- Supports Group Policy deployment
- Recommended for multiple machines

**Method 2: Portable**
- Copy TSB.exe and related files to a shared location
- Students can run without installation
- Useful for exam centers or temporary setups

## Troubleshooting

### "TSB.exe won't start"

**Possible Causes:**
- Missing .NET Framework 4.7.2
- Antivirus blocking execution
- Corrupted installation

**Solutions:**
1. Install .NET Framework 4.7.2 from Microsoft
2. Add TSB.exe to antivirus exceptions
3. Reinstall Topin Secure Browser

### "TopinSecureBrowser.exe not found"

**Cause:** Launcher cannot find the main application

**Solution:**
1. Verify complete installation
2. Reinstall from MSI
3. Check that all files are in the installation directory

### "Configuration file error"

**Cause:** Invalid or corrupted configuration

**Solution:**
1. Delete `topin-default.seb` from installation directory
2. Restart TSB.exe (will create new default config)

### "Browser won't connect to exam"

**Possible Causes:**
- Network issues
- Firewall blocking connections
- Incorrect exam URL

**Solutions:**
1. Check internet connection
2. Verify firewall allows Topin Secure Browser
3. Confirm exam URL with instructor

### "Can't exit the browser"

**Normal Behavior:** The browser is designed to prevent easy exit during exams

**To Exit:**
1. Complete and submit your exam
2. Follow the exam platform's end session process
3. Use the configured quit password (if set by administrator)
4. For emergency exit: Press Ctrl+Alt+Delete and end process (use only in genuine emergencies)

## Security and Privacy

### What Data Does TSB Collect?

Topin Secure Browser itself does not collect or transmit user data. However:
- Your exam platform may collect exam responses and timing data
- System logs are created locally for troubleshooting
- No telemetry or analytics are sent to Topin Tech

### Can TSB See My Personal Files?

No. Topin Secure Browser:
- Only accesses files necessary for exam delivery
- Does not scan or upload personal documents
- Operates in a sandboxed browser environment

### What Happens After the Exam?

- All browser data (cache, cookies) is typically cleared
- No exam content is retained locally
- Your system returns to normal operation
- You can uninstall TSB if no longer needed

## Differences from Regular Browsers

Topin Secure Browser is **NOT** a regular web browser. It is specifically designed for secure assessments:

| Feature | Regular Browser | Topin Secure Browser |
|---------|----------------|---------------------|
| Access all websites | ✓ | ✗ (Only exam sites) |
| Open multiple tabs | ✓ | ✗ (Restricted) |
| Download files | ✓ | ✗ (Restricted) |
| Use extensions | ✓ | ✗ |
| Print pages | ✓ | ✗ (Restricted) |
| Copy/paste | ✓ | ✗ (Restricted) |
| Switch applications | ✓ | ✗ |

## Uninstallation

### Windows Uninstall

1. Open **Settings** → **Apps** → **Apps & features**
2. Find "Topin Secure Browser"
3. Click **Uninstall**
4. Follow the uninstallation wizard

### Manual Removal (if needed)

If standard uninstall fails:
1. Delete installation folder: `C:\Program Files\TopinSecureBrowser\`
2. Remove Start Menu shortcut
3. Delete registry keys (advanced users only):
   - `HKEY_CURRENT_USER\Software\Topin Tech\Topin Secure Browser`

## Legal and Licensing

### Based on Safe Exam Browser

Topin Secure Browser is based on Safe Exam Browser (SEB), which is open-source software licensed under the Mozilla Public License 2.0.

- **SEB Project**: https://safeexambrowser.org
- **SEB Source Code**: https://github.com/SafeExamBrowser/seb-win

### License Information

- **Safe Exam Browser Components**: Mozilla Public License 2.0 (Open Source)
- **Topin Customizations**: Proprietary to Topin Tech
- **Icons and Branding**: © 2025 Topin Tech. All rights reserved.

### Compliance

This software complies with:
- Mozilla Public License 2.0 requirements
- Safe Exam Browser license terms
- Windows software development guidelines

## Support

### Getting Help

For technical support:
- **Students**: Contact your instructor or IT department
- **Administrators**: Contact Topin Tech support

### Reporting Issues

If you encounter bugs or issues:
1. Note the exact error message
2. Record steps to reproduce the problem
3. Check if issue persists after reinstall
4. Contact your administrator or Topin Tech support

### Community Resources

- Safe Exam Browser documentation: https://safeexambrowser.org/documentation
- Safe Exam Browser forums: Community support available

## FAQ

**Q: Is TSB compatible with Mac or Linux?**  
A: Currently, this version is Windows-only. Safe Exam Browser has Mac and iOS versions available.

**Q: Can I use TSB for regular browsing?**  
A: No, TSB is designed specifically for secure assessments, not general web browsing.

**Q: Will TSB slow down my computer?**  
A: TSB has minimal performance impact. It uses similar resources to a regular web browser.

**Q: Can I use a second monitor?**  
A: Administrator configuration determines whether multiple monitors are allowed.

**Q: What if I have technical issues during an exam?**  
A: Contact your exam proctor immediately. Most exam platforms have support procedures.

**Q: Is TSB required for all exams?**  
A: Only if specified by your instructor or institution.

---

**Version**: 1.0  
**Last Updated**: November 2025  
**Copyright**: © 2025 Topin Tech. All rights reserved.  
**Based on**: Safe Exam Browser (Open Source - MPL 2.0)
