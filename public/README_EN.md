# TTR-SUITE Agent Installation Script

## Overview
This script helps you install agent DLL files into your TTR-SUITE installation automatically. It can handle both loose DLL files and ZIP archives containing agent files.

## Prerequisites
- TTR-SUITE must be installed at `C:\TTR-SUITE\`
- Windows PowerShell (for ZIP extraction)
- Administrative privileges may be required

## How to Use

1. **Download** the installation package containing:
   - `install-agents.bat` - Main installation script
   - `README_EN.md` - This English documentation
   - `README_IT.md` - Italian documentation

2. **Extract** the package to any location on your computer

3. **Prepare your agent files** in one of these formats:
   - **Option A**: Directory containing loose `.dll` files
   - **Option B**: Directory containing `.zip` archives with DLL files inside

4. **Run the script**:
   - Double-click `install-agents.bat`
   - Or run from command prompt: `install-agents.bat`

5. **Follow the prompts**:
   - Enter the path to your agent files directory
   - Review the installation summary
   - Confirm to proceed with installation

## What the Script Does

### If DLL files are found directly:
- Copies all `.dll` files to `C:\TTR-SUITE\AppData\AgentCodes\`
- Verifies each file was copied successfully

### If only ZIP files are found:
- Extracts all ZIP files to a temporary directory
- Searches recursively for `.dll` files in extracted content
- Copies all found DLL files to the destination
- Automatically cleans up temporary files

## Installation Directory
Agent files are installed to:
```
C:\TTR-SUITE\AppData\AgentCodes\
```

This directory will be created automatically if it doesn't exist.

## Error Handling
- Validates TTR-SUITE installation before proceeding
- Checks file permissions and disk space
- Provides detailed error messages for troubleshooting
- Reports successful and failed file operations

## Troubleshooting

**"TTR-SUITE not found"**
- Ensure TTR-SUITE is installed at `C:\TTR-SUITE\`
- Check that the installation is complete

**"Failed to copy files"**
- Run the script as Administrator
- Check available disk space
- Verify source files are not corrupted

**"No DLL files found in ZIP"**
- Ensure ZIP files contain valid agent DLL files
- Check that ZIP files are not corrupted

## Support
For technical support, contact: info@aviolab.ai

## Version
Script Version: 1.0
Compatible with: TTR-SUITE 3.2+

---
© 2025 Aviolab AI - Agent Installation Utility