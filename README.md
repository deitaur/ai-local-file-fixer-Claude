# Claude Desktop File Access Fixer

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![Platform: Windows](https://img.shields.io/badge/Platform-Windows-blue.svg)]()

A targeted batch script to resolve the exact issue where the **Claude Desktop App for Windows** fails to read specific local folders or files (throwing `Input/output error`, showing folders as empty, or failing to index files for Projects).

## 🛑 The Specific Problem

When trying to upload local directories or datasets into Claude Desktop, the app may silently fail or throw an I/O error. This happens because Claude's local file-reading mechanisms get blocked by desynchronized NTFS indexing, lingering read-only attributes, or strict Windows ACLs on deep folder structures. 

This script is designed to solve **only this specific problem** by forcing Windows to flush the Master File Table (MFT) and normalize permissions for the target directory.

## 🚀 Usage Instructions

1. Download the `Deep_Index_Fix.cmd` script.
2. Right-click the file and select **Run as Administrator**.
3. Drag and drop the problematic folder into the console window and press Enter. Wait for the "SUCCESS" message.
4. **CRITICAL STEP: Completely restart Claude Desktop.**
   - Do not just close the window.
   - Go to your Windows system tray (the area next to the clock in the bottom right corner).
   - Find the **Claude** icon.
   - Right-click the icon and select **Quit** (Выйти).
5. Open the Claude app again. The files will now be visible and accessible.

## 🛠️ How It Works

The script executes a 4-step deep initialization:
- **Ownership Reset:** Claims administrative ownership (`takeown`).
- **ACL Normalization:** Grants `Everyone` full access (`icacls`) to bypass restrictive permissions that block Claude's processes.
- **MFT Flush:** Forces a native MFT re-index via a recursive directory rename loop.
- **Metadata Touch:** Executes a non-destructive `copy /b` to update file timestamps and break OS-level process locks.
