============================================================
  TOPIN SECURE BROWSER - Version 1.0.0
  Secure Assessment Platform
  Copyright © 2025 Topin Tech
  https://topin.tech
============================================================

SYSTEM REQUIREMENTS
-------------------
- Windows 10 or Windows 11 (64-bit)
- .NET Framework 4.7.2 or higher
- Minimum 4GB RAM
- 500MB free disk space


INSTALLATION INSTRUCTIONS
--------------------------

1. Extract the ZIP file to a folder of your choice
   Recommended: C:\Program Files\TopinSecureBrowser

2. Run TSB.exe to start the application

3. (Optional) Create a desktop shortcut:
   - Right-click TSB.exe
   - Send to → Desktop (create shortcut)


FIRST RUN
---------
On first launch, the application will create configuration 
folders in:
  %LocalAppData%\TopinSecureBrowser
  %AppData%\TopinSecureBrowser

These folders contain:
- Logs (for troubleshooting)
- Cache (browser data)
- Configuration files


USAGE
-----
1. Launch TSB.exe
2. The secure browser will start automatically
3. Follow your exam administrator's instructions
4. To exit: Use the quit password provided by your administrator


TROUBLESHOOTING
---------------

Q: Application won't start?
A: Ensure .NET Framework 4.7.2 is installed
   Download from: https://dotnet.microsoft.com/download/dotnet-framework

Q: Where are the log files?
A: %LocalAppData%\TopinSecureBrowser\Logs

Q: Security warnings during installation?
A: This is normal for unsigned applications. The production 
   version will be digitally signed.

Q: Antivirus flags the application?
A: Some antivirus software may flag kiosk mode applications.
   This is a false positive. Add an exception if needed.


FILES INCLUDED
--------------
TSB.exe                         - Main launcher
TopinSecureBrowser.exe         - Runtime component
SafeExamBrowser.Client.exe     - Client component
*.dll                          - Required libraries
CefSharp.BrowserSubprocess.exe - Browser engine


SUPPORT
-------
For support and documentation, visit:
https://topin.tech

For technical issues, contact:
support@topin.tech


LICENSE
-------
This application is subject to the terms of the Mozilla Public 
License, version 2.0. See LICENSE.txt for details.


SECURITY & PRIVACY
------------------
- All exam data is encrypted
- No data is sent to Topin servers without configuration
- Your exam administrator controls all settings
- Logs contain no personal information


VERSION HISTORY
---------------
1.0.0 (2025-11-19)
- Initial release
- Rebranded from Safe Exam Browser
- Full kiosk mode support
- Secure browser environment
- Configuration management


============================================================
  © 2025 Topin Tech - All Rights Reserved
============================================================

