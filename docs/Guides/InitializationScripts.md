# Initialization Scripts Guide

## Overview

Initialization scripts are essential components of the BIG BRAIN Memory Bank
system, responsible for creating the required directory structure, setting up
core memory files, and establishing the rule framework. These scripts ensure
that the system can be quickly deployed in a consistent manner across different
environments.

## Available Initialization Scripts

The BIG BRAIN Memory Bank system provides initialization scripts in both
PowerShell and Bash formats:

| Script                      | Location                       | Description                      |
| --------------------------- | ------------------------------ | -------------------------------- |
| `Initialize-MemoryBank.ps1` | `scripts/` and `scripts/Init/` | PowerShell initialization script |
| `Initialize-MemoryBank.sh`  | `scripts/` and `scripts/Init/` | Bash initialization script       |

These scripts are maintained in two locations for backward compatibility and
accessibility.

## Running Initialization Scripts

### PowerShell Initialization

To initialize the system using PowerShell:

```powershell
# From the root directory
./scripts/Initialize-MemoryBank.ps1

# Or using the categorized path
./scripts/Init/Initialize-MemoryBank.ps1
```

### Bash Initialization

To initialize the system using Bash:

```bash
# From the root directory
./scripts/Initialize-MemoryBank.sh

# Or using the categorized path
./scripts/Init/Initialize-MemoryBank.sh
```

## Initialization Options

The initialization scripts support the following options:

| Option      | Description                                                  |
| ----------- | ------------------------------------------------------------ |
| `-Force`    | Overwrite existing files (PowerShell only)                   |
| `-NoPrompt` | Skip confirmation prompts (PowerShell only)                  |
| `-Minimal`  | Create only the essential directory structure and core files |
| `-Full`     | Create the complete directory structure with example files   |
| `-LogLevel` | Set the level of log detail (Normal, Verbose, Debug)         |

Example usage with options:

```powershell
./scripts/Initialize-MemoryBank.ps1 -Full -NoPrompt
```

## What Gets Initialized

The initialization scripts create:

1. **Directory Structure**:

   - `memory-bank/` - The main memory bank directory
   - `memory-bank/core/` - Core memory components
   - `memory-bank/core/active/` - Active memory files
   - `memory-bank/core/short-term/` - Short-term memory storage
   - `memory-bank/core/long-term/` - Long-term memory storage
   - `.cursor/rules/` - Rules directory structure
   - `docs/` - Documentation structure

2. **Core Memory Files**:

   - `activeContext.md` - Current work focus and recent changes
   - `systemPatterns.md` - System architecture and design patterns
   - `techContext.md` - Technologies and technical setup
   - `progress.md` - Progress tracking
   - `projectbrief.md` - Core requirements and goals
   - `productContext.md` - Project purpose and user experience goals

3. **Rule Framework**:

   - Base rule structure
   - System behavior rules
   - Core framework rules
   - Workflow rules

4. **Documentation Files**:
   - Index file
   - Essential guides
   - Reference documentation

## Updating Initialization Scripts

The initialization scripts are maintained by the
`Update-InitializationScript.ps1` script, which:

1. Analyzes the current repository structure
2. Updates both PowerShell and Bash initialization scripts
3. Ensures compatibility with the most recent system organization

To update the initialization scripts:

```powershell
./scripts/Update/Update-InitializationScript.ps1
```

## Script Organization Integration

The initialization scripts work seamlessly with the script organization
structure:

1. **Path Resolution**: The initialization scripts use path resolution to find
   and execute other scripts regardless of where they are stored
2. **Dual Location**: Critical initialization scripts are maintained in both the
   root `scripts/` directory and the `scripts/Init/` category for backward
   compatibility
3. **Cross-Platform Support**: Both PowerShell and Bash versions are provided
   for cross-platform initialization

## Troubleshooting

If you encounter issues with initialization:

1. **Permission Issues**: Ensure you have appropriate permissions to create
   directories and files

   ```bash
   # For Bash scripts
   chmod +x ./scripts/Initialize-MemoryBank.sh
   ```

2. **Path Resolution**: If the initialization script cannot find referenced
   files, ensure the script organization structure is intact

   ```powershell
   # Run the script organization script first
   ./scripts/Organize-ScriptsFolder.ps1
   ```

3. **Missing Templates**: If template files are missing, run the initialization
   script updater
   ```powershell
   ./scripts/Update/Update-InitializationScript.ps1
   ```

## Version History

| Version | Date       | Changes                                       |
| ------- | ---------- | --------------------------------------------- |
| 1.0.0   | 2025-01-15 | Initial implementation                        |
| 2.0.0   | 2025-03-24 | Enhanced with script organization integration |
| 2.1.0   | 2025-03-25 | Updated with cross-platform improvements      |
