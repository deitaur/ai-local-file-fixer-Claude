# FOR CLAIDE
# AI Local File Fixer (NTFS to Linux Mount)

This tool solves the common **"Input/output error"** and visibility issues when accessing Windows NTFS folders/files from Linux environments, WSL, or AI tools like Claude AI and Cursor.

## ⚠️ The Problem
When using AI tools or WSL to analyze local files, directories (especially those with deep nesting or datasets) often become inaccessible or appear empty. Even if they are visible in Windows Explorer, Linux mounts may report `Input/output error`. This happens because Windows retains specific NTFS metadata or ACL restrictions that prevent Linux/AI access.

## 🚀 How This Script Fixes It
The script performs a "Deep Refresh" of the NTFS Master File Table (MFT) and security descriptors up to 4+ levels deep:
1. **Unlocks AI Access:** Strips restricted attributes from datasets, books, and archives, making them readable for local AI agents.
2. **Takes Ownership:** Recursively grants ownership to the current user.
3. **Resets ACLs:** Grants "Everyone" full access (maps to `777` in Linux mounts).
4. **Forces MFT Re-indexing:** Safely "touches" file metadata without changing content to force Windows to rebuild the index.

## 🛠️ Usage
1. Download `Deep_Index_Fix.cmd`.
2. Right-click the file and select **Run as Administrator**.
3. Drag and drop the problematic folder (e.g., your dataset or books directory) into the console window and press Enter.
4. Wait for the "SUCCESS" message.
5. Refresh your Linux mount or AI project interface.

## 🔒 Safety
This script only modifies file metadata (dates) and access permissions. It **does not** alter or delete the actual contents of your files.
