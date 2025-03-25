# Update

Scripts for updating the memory bank, refreshing configurations, and keeping initialization scripts in sync with repository structure.

## Overview

This directory contains scripts for maintaining and updating the BIG BRAIN Memory Bank system. These scripts are designed to keep the initialization process, memory bank structure, and configuration files in sync as the system evolves.

## Available Scripts

### Core Update Scripts

| Script                            | Description                                                               |
| --------------------------------- | ------------------------------------------------------------------------- |
| `Update-AllScripts.ps1`           | Updates all initialization scripts for the Memory Bank                    |
| `Update-AllScripts.sh`            | Bash version of the all scripts updater                                   |
| `Update-InitializationScript.ps1` | Analyzes repository structure and updates initialization scripts          |
| `Update-InitializationScript.sh`  | Bash version of the initialization script updater                         |
| `Initialize-MemoryBank.ps1`       | Initializes the Memory Bank structure with required directories and files |
| `Initialize-MemoryBank.sh`        | Bash version of the memory bank initializer                               |

### Integration with BIG Command System

These update scripts are now integrated with the BIG Command System through the `BIG-Update.ps1` script. This integration provides a consistent interface for system maintenance tasks with improved logging and error handling.

To use the BIG Command interface for updates:

```powershell
# Update the entire system
.\BIG.ps1 -Category update -Command system

# Update initialization scripts
.\BIG.ps1 -Category update -Command scripts

# Update memory bank structure
.\BIG.ps1 -Category update -Command memory

# Initialize a new memory bank system
.\BIG.ps1 -Category update -Command init
```

## Direct Usage

While using the BIG Command interface is recommended, you can still use these scripts directly:

### PowerShell

```powershell
# Update all scripts
.\Update-AllScripts.ps1

# Update initialization scripts
.\Update-InitializationScript.ps1

# Initialize memory bank
.\Initialize-MemoryBank.ps1
```

### Bash

```bash
# Update all scripts
./Update-AllScripts.sh

# Update initialization scripts
./Update-InitializationScript.sh

# Initialize memory bank
./Initialize-MemoryBank.sh
```

## Directory Structure

- `backup/`: Contains backups of previous initialization scripts
- `Init/`: Contains the latest versions of initialization scripts in an organized structure

## See Also

For more detailed information about the update system, see the [BIG Update Command Documentation](../BIG-Commands/README-Update.md).

