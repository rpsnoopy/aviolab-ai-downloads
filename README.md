# Aviolab AI Downloads Repository

This repository hosts download files for [aviolab.ai](https://aviolab.ai) website.

## 🗂️ Structure

```
├── public/                    # Public downloads (accessible by everyone)
│   ├── install-agents.zip    # Agent installation script with documentation
│   ├── README_EN.md          # English documentation for install script
│   └── README_IT.md          # Italian documentation for install script
├── clients/                  # Client-specific files (password protected)
│   ├── AEN-TTR/             # Client AEN-TTR files
│   │   ├── TTR-PROBE.zip    # Agent analysis tool
│   │   ├── ANS-003745-agents.zip  # Agent license package
│   │   └── ANS-004833-agents.zip  # Agent license package
│   ├── TEST123/             # Test client files  
│   └── DEMO001/             # Demo client files
└── README.md                # This file
```

## 🔒 Security

- All ZIP files are **password protected**
- Passwords are communicated separately via secure channels
- Public repository ensures reliable hosting and direct links

## 📝 File Management

**Release Management:**
- Large files (>100MB) like TTR-SUITE.zip are served via GitHub releases
- Small files (<100MB) are stored directly in the repository
- Git LFS has been removed to optimize storage and reduce costs

**Agent Installation:**
- `install-agents.zip` contains automated installation script
- Supports both loose DLL files and ZIP archives
- Includes bilingual documentation (English/Italian)
- Automatically extracts and installs agent files to TTR-SUITE

## 🔗 File Access

Files are accessed via:
- **Public files**: GitHub raw links for files under 100MB: `https://github.com/rpsnoopy/aviolab-ai-downloads/raw/main/public/filename.zip`
- **Large files**: GitHub releases for files over 100MB: `https://github.com/rpsnoopy/aviolab-ai-downloads/releases/download/v.3.2.0006/filename.zip`
- **Client files**: GitHub raw links: `https://github.com/rpsnoopy/aviolab-ai-downloads/raw/main/clients/CLIENT-ID/filename.zip`

## 🆕 Recent Updates

**Version 3.2.0006:**
- Added agent installation automation with `install-agents.zip`
- Removed Git LFS to optimize repository performance
- Added bilingual documentation (EN/IT)
- Enhanced client area with new agent license packages
- Updated TTR-SUITE release management system

## 🛠️ Tools Available

> TTR-PROBE is no longer a public download (withdrawn 2026-08-18): the unlicensed
> installation runs the dotation probe on its own, so the standalone tool is not
> distributed to visitors any more.

1. **TTR-SUITE** (484MB) - Complete suite package via releases
2. **Install Agents** - Automated DLL installation script with:
   - ZIP extraction capabilities
   - Recursive file search
   - Bilingual documentation
   - Error handling and verification

## 📞 Support

For technical support or file access issues, contact: info@aviolab.ai

---
**© 2025 Aviolab AI - Intelligent Document Analysis**