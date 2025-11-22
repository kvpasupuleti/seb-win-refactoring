# Source Code Request - Response Template

## Email Template for Source Code Requests

### Template 1: Enterprise Customer Request

```
Subject: Re: Topin Secure Browser Source Code Request

Dear [Customer Name],

Thank you for your interest in reviewing the Topin Secure Browser source code.

As disclosed in our licensing documentation, Topin Secure Browser is built on 
Safe Exam Browser (licensed under MPL 2.0) with proprietary enhancements by 
Topin Tech.

SOURCE CODE ACCESS:
-------------------
Modified Safe Exam Browser files are available at:
[Option A: GitHub link]
[Option B: Private repo with read access - credentials below]

WHAT'S INCLUDED:
- All modified SEB source files
- Build configuration changes
- Modifications documentation (MODIFICATIONS.txt)
- License information (LICENSE.txt)

PROPRIETARY COMPONENTS:
-----------------------
The following Topin Tech proprietary components are not included 
in the open-source portion:

- Custom authentication integrations
- Proprietary exam scheduling features  
- Advanced analytics modules
- [Your specific features]

These proprietary components can be reviewed under a separate NDA 
if required for your security audit.

REPOSITORY STRUCTURE:
--------------------
/SafeExamBrowser.*     - Modified SEB components (MPL 2.0)
/TopinSecureBrowser.*  - Topin proprietary components
/LICENSE.txt           - License information
/MODIFICATIONS.txt     - List of modifications

If you need access to proprietary components for security review, 
please let us know and we'll arrange an NDA.

Best regards,
[Your Name]
Topin Tech
opensource@topin.tech
```

### Template 2: Security Researcher Request

```
Subject: Re: Source Code Request for Security Research

Hello [Researcher Name],

Thank you for your interest in Topin Secure Browser's security.

The modified Safe Exam Browser source code is available at:
[GitHub/Repository Link]

This includes all modifications we've made to the MPL-licensed 
Safe Exam Browser codebase.

RESPONSIBLE DISCLOSURE:
If you discover security vulnerabilities, please report them to:
security@topin.tech

We appreciate security research and will acknowledge contributors 
in our security advisories.

Best regards,
Topin Tech Security Team
```

### Template 3: Competitor/General Request

```
Subject: Re: Source Code Request

Hello,

Topin Secure Browser's modified Safe Exam Browser source code 
is available at:
[Repository Link]

As required by the Mozilla Public License 2.0, all modifications 
to Safe Exam Browser are documented and available.

Please note that "Topin Secure Browser" is a trademark of Topin 
Tech, and proprietary features developed by Topin Tech are not 
included in the open-source distribution.

Best regards,
Topin Tech
```

### Template 4: Polite Decline (Proprietary Parts)

```
Subject: Re: Request for Proprietary Components

Dear [Name],

Thank you for your interest in Topin Secure Browser.

As disclosed in our licensing, Topin Secure Browser consists of:

1. Modified Safe Exam Browser (MPL 2.0) - Available at [link]
2. Topin Tech proprietary components - Not open source

The proprietary components include:
- [Feature 1]
- [Feature 2]
- Business logic and integrations

These are not derived from Safe Exam Browser and are protected 
under separate copyright.

For enterprise customers requiring security review of proprietary 
components, we offer:
- NDA-based code review
- Independent security audit results
- Security architecture documentation

Please contact sales@topin.tech to discuss options.

Best regards,
Topin Tech
```

---

## Setting Up "On-Request" Access

### Option A: Private GitHub with Selective Access

1. Create private repository
2. Add this to README.md in main repo:

```markdown
## Source Code Access

Modified Safe Exam Browser source code is available upon request
in compliance with MPL 2.0.

To request access:
- Email: opensource@topin.tech
- Include: Company name, purpose of request
- We'll provide access within 2 business days
```

3. When someone requests:
   - Add them as collaborator (read-only)
   - Send Template 1 email

### Option B: Automated Download Link

Create a simple form on your website:

```html
<form>
  Name: [input]
  Email: [input]
  Company: [input]
  Purpose: [textarea]
  [Submit]
</form>
```

Auto-send download link or repo access.

---

## What to Prepare Now

### Create Source Package

1. **Clean Repository**
```bash
# Remove binaries, user-specific files
git clean -fdx
```

2. **Add README for Source Distribution**
```markdown
# Topin Secure Browser - Source Code

This repository contains the modified Safe Exam Browser source 
code as required by the Mozilla Public License 2.0.

## What's Included
- All modified SEB files
- Build instructions
- License information
- Modifications documentation

## What's NOT Included  
- Topin Tech proprietary features
- Build artifacts
- Customer configurations

## Building
See BUILD.md for instructions

## License
See LICENSE.txt for licensing information
```

3. **Document Build Process**
```markdown
# BUILD.md

Requirements:
- Visual Studio 2019+
- .NET Framework 4.7.2

Steps:
1. Open SafeExamBrowser.sln
2. Restore NuGet packages
3. Build → Rebuild Solution
4. Output: TopinSecureBrowser.Launcher\bin\x64\Release
```

---

## Quick Setup Checklist

- [ ] Add "Source available on request" to LICENSE.txt ✅ (already done)
- [ ] Create email templates (use above)
- [ ] Set up email: opensource@topin.tech
- [ ] Decide: Public GitHub OR private with access
- [ ] Clean repo (remove binaries, secrets)
- [ ] Add README.md for source distribution
- [ ] Test: Can someone actually build from source?

---

## Expected Annual Effort

**Time Investment:**
- Initial setup: 2 hours
- Per request: 15-30 minutes
- Annual total: 2-6 hours (assuming 5-10 requests)

**Cost:**
- $0 (GitHub free tier for private repos)
- Or minimal ($4-7/month for private repos if needed)

---

## Bottom Line

**Who will ask?**
- Enterprise customers: Sometimes
- SEB creators: Almost never (they don't need it)
- Competitors: Rarely (they already have base SEB)
- End users: Never

**Effort required?**
- Very minimal (1-2 requests per year for small business)
- Quick response: Send link or grant access
- Keeps you legally compliant

**Recommendation:**
Set up "on-request" email (opensource@topin.tech) and be done with it!
Most likely you'll get 0-2 requests in your first year.

