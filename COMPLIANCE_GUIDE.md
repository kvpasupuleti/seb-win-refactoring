# MPL 2.0 Compliance Guide for Topin Secure Browser

## Quick Summary: What You Need to Do

### ✅ **Required Actions**

1. **Include License Files** (in every distribution)
   - ✅ `LICENSE.txt` - Main license information
   - ✅ `MODIFICATIONS.txt` - List of what you changed
   - ✅ Both files in the ZIP package

2. **Make Modified Source Available**
   - Option A: Public GitHub repo
   - Option B: Private repo with access on request
   - Option C: Provide via email/download link

3. **Keep Copyright Notices**
   - Don't remove ETH Zürich copyright from SEB files
   - Add your own copyright for modifications

### ❌ **What You DON'T Need to Do**

- ❌ Open-source your entire product
- ❌ Share source code publicly (can be on request)
- ❌ Include source code with every installation
- ❌ Make your new custom features open-source
- ❌ Pay royalties or fees
- ❌ Ask permission to sell it

---

## Detailed Compliance Steps

### Step 1: Include License Files ✅ DONE

**These files are now in your repository:**
- `LICENSE.txt` - Describes the licensing
- `MODIFICATIONS.txt` - Lists what you changed

**Action Required:**
```
✅ Add both files to your distribution ZIP
✅ Include in any installer you create
✅ Reference them in your documentation
```

### Step 2: Source Code Availability

**Choose one option:**

#### Option A: Public GitHub Repository (Recommended)
```bash
# Create a public repo
git init
git add .
git commit -m "Initial commit"
git remote add origin https://github.com/topintech/topin-secure-browser
git push -u origin main
```

**Pros:**
- ✅ Fully compliant
- ✅ Shows transparency
- ✅ Easy to maintain
- ✅ No ongoing effort

**Cons:**
- ⚠️ Code is visible to competitors
- ⚠️ But they can't use your branding/name

#### Option B: Private Repository with Access on Request
```
1. Keep code in private GitHub/GitLab
2. Add this to LICENSE.txt:
   "Source code available by request: opensource@topin.tech"
3. When someone requests it, give them access
```

**Pros:**
- ✅ Compliant
- ✅ Code stays semi-private
- ✅ Most companies choose this

**Cons:**
- ⚠️ Need to respond to requests (rare)
- ⚠️ Still must provide when asked

#### Option C: Source Code in Documentation
```
Include a download link in your user manual/website:
"Modified source code: https://topin.tech/downloads/source"
```

### Step 3: Add Source Code Notice to Your Distribution

**Edit DISTRIBUTION_README.txt to include:**

```txt
SOURCE CODE
-----------
Topin Secure Browser is based on Safe Exam Browser, which is 
licensed under the Mozilla Public License 2.0.

Modified source code is available at:
https://github.com/topintech/topin-secure-browser

Or by request: opensource@topin.tech
```

---

## What Can You Keep Proprietary?

### ✅ **Your Proprietary Code (Can be Closed-Source)**

1. **New Files You Create**
   - Custom modules
   - New features
   - Additional tools
   - Launcher code (if completely new)

2. **Configuration Files**
   - Your custom `.seb` configurations
   - Internal exam settings
   - Proprietary algorithms

3. **Integration Code**
   - API integrations
   - Custom authentication
   - Proprietary proctoring features

4. **Business Logic**
   - Exam scheduling
   - User management
   - Reporting systems

### ⚠️ **Must Stay Open-Source (MPL Files You Modified)**

1. **Core SEB Files You Changed**
   - UI text changes
   - Branding modifications
   - Configuration tweaks
   - Build scripts that modify SEB code

2. **Only the Parts You Modified**
   - Not the entire file if you changed 1 line
   - But the whole file must be available

---

## Real-World Scenarios

### Scenario 1: Customer Asks for Source Code

**What they can ask for:**
- Source of MPL files you modified
- The modified SEB codebase

**What they CANNOT demand:**
- Your proprietary new features
- Your business logic
- Your configuration secrets
- Your customer database

**How to respond:**
```
"Thank you for your interest. Topin Secure Browser is based on 
Safe Exam Browser (MPL 2.0). The source code for modified files 
is available at [GitHub link] or can be provided upon request.

Our proprietary enhancements and integrations are not derived 
from Safe Exam Browser and are not subject to the same license."
```

### Scenario 2: Competitor Copies Your Code

**What they CAN do:**
- ✅ Use the MPL-licensed SEB code
- ✅ Use your modifications to SEB
- ✅ Create their own competing product

**What they CANNOT do:**
- ❌ Use your "Topin Secure Browser" name/brand
- ❌ Copy your proprietary new features
- ❌ Use your customer lists
- ❌ Copy your documentation/marketing

**Your Protection:**
- Trademark "Topin Secure Browser" name
- Patent unique features (expensive)
- Copyright your original code
- Trade secrets for business logic

### Scenario 3: Selling to Enterprise Customers

**They might ask:**
- "Is this open-source?"
  → **Answer:** "It's based on open-source (MPL 2.0) with proprietary enhancements"

- "Can we audit the code?"
  → **Answer:** "Yes, the core SEB code is available. Our proprietary features are under NDA."

- "What about security?"
  → **Answer:** "The open-source base is regularly audited. Our modifications are documented."

---

## Common Misconceptions

### ❌ **WRONG:** "MPL means I can't sell it"
**✅ CORRECT:** You can sell it! MPL allows commercial use.

### ❌ **WRONG:** "I must open-source everything"
**✅ CORRECT:** Only the MPL files you modified. New files can be proprietary.

### ❌ **WRONG:** "I must give source to everyone"
**✅ CORRECT:** Only to people who receive your software, and only the MPL parts.

### ❌ **WRONG:** "I can't add proprietary features"
**✅ CORRECT:** You can add as many proprietary features as you want in new files.

### ❌ **WRONG:** "Competitors can steal my product"
**✅ CORRECT:** They can use SEB code, but not your brand, proprietary features, or business model.

---

## Compliance Checklist

Before each release:

- [ ] LICENSE.txt included in distribution
- [ ] MODIFICATIONS.txt included in distribution
- [ ] Source code available (GitHub or on-request)
- [ ] README mentions MPL and source availability
- [ ] Original SEB copyright notices intact
- [ ] Your copyright added to modified files
- [ ] Proprietary code in separate files (if any)
- [ ] Documentation mentions "based on Safe Exam Browser"

---

## Risk Assessment

### **Low Risk (You're Fine)**
- Selling the software
- Adding proprietary features
- Using closed-source plugins
- Restricting access to your platform
- Not including source in installations

### **Medium Risk (Be Careful)**
- Modifying many SEB files without tracking
- Not documenting what you changed
- Unclear separation of proprietary code
- No source code availability plan

### **High Risk (Don't Do This)**
- ❌ Removing MPL license from SEB files
- ❌ Claiming you wrote everything
- ❌ Refusing source code requests from customers
- ❌ Not acknowledging Safe Exam Browser
- ❌ Using more restrictive license on SEB files

---

## Recommended Approach

**For Your Business:**

1. **Public GitHub Repo** (Best option)
   - Shows confidence and transparency
   - Meets all requirements automatically
   - Attracts community contributions
   - No ongoing compliance effort

2. **Add Proprietary Layer**
   ```
   [Topin Secure Browser]
          ↓
   [Your Proprietary Features] ← Closed source
          ↓
   [Modified SEB Core] ← Open source (MPL)
   ```

3. **Document Everything**
   - What's open vs. closed
   - What value you add
   - Why customers should choose you

4. **Market Your Value-Add**
   - "Built on trusted open-source foundation"
   - "Enhanced with proprietary features"
   - "Professional support and updates"

---

## Getting Help

**Legal Questions:**
- Consult with an IP lawyer (1-hour consultation: $200-500)
- Mozilla's MPL FAQ: https://www.mozilla.org/en-US/MPL/2.0/FAQ/

**Technical Questions:**
- Safe Exam Browser community forums
- GitHub issues on SEB repository

**Your Obligations Summary:**
1. Include LICENSE.txt and MODIFICATIONS.txt
2. Make modified source available
3. Keep copyright notices
4. That's it!

---

## You're Already 95% Compliant!

✅ License files created
✅ Modifications documented  
✅ Copyright notices intact
✅ Clear separation of changes

**Just need to:**
- Add license files to distribution ZIP
- Choose source code distribution method (recommend public GitHub)
- Update documentation with source availability

**You're good to go!** 🚀

