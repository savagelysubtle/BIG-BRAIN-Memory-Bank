# BIG Update Command

The BIG Update Command provides a standardized interface for updating and maintaining the BIG BRAIN Memory Bank system. It integrates with the existing update scripts to provide a consistent experience for system maintenance tasks.

## Overview

The BIG Update Command implements the following pattern:

```
BIG update [command] [parameters] [--options]
```

## Available Commands

| Command   | Description                             |
| --------- | --------------------------------------- |
| `system`  | Updates the entire BIG BRAIN system     |
| `scripts` | Updates initialization scripts          |
| `memory`  | Updates memory bank structure and files |
| `rules`   | Updates the rules system                |
| `init`    | Initializes a new memory bank system    |

## Common Parameters

| Parameter     | Description                            | Default |
| ------------- | -------------------------------------- | ------- |
| `-Force`      | Skip confirmation prompts              | `false` |
| `-OutputPath` | Custom output path for generated files |         |
| `-Verbose`    | Show detailed execution information    | `false` |

## Command Details

### system

The `system` command runs a full system update by calling the `Update-AllScripts.ps1` script from the Update folder. This ensures all scripts and configurations are up to date with the latest structure.

```powershell
# Update the entire BIG BRAIN system
.\BIG.ps1 -Category update -Command system

# Update with verbose output
.\BIG.ps1 -Category update -Command system -Verbose
```

### scripts

The `scripts` command updates initialization scripts by calling the `Update-InitializationScript.ps1` script. This analyzes the current repository structure and updates the initialization scripts accordingly.

```powershell
# Update initialization scripts
.\BIG.ps1 -Category update -Command scripts

# Update initialization scripts with a custom output path
.\BIG.ps1 -Category update -Command scripts -OutputPath "C:\path\to\output"
```

### memory

The `memory` command updates the memory bank structure and files by calling the `Initialize-MemoryBank.ps1` script. This ensures the memory bank directories and template files are correctly configured.

```powershell
# Update memory bank structure
.\BIG.ps1 -Category update -Command memory

# Force update of memory bank structure
.\BIG.ps1 -Category update -Command memory -Force
```

### rules

The `rules` command updates the rules system by validating and applying rules using the `BIG-Rules.ps1` script. This ensures all rules are correctly configured and applied to the memory bank.

```powershell
# Update rules system
.\BIG.ps1 -Category update -Command rules
```

### init

The `init` command performs a full initialization of a new memory bank system. It updates initialization scripts, initializes the memory bank, and configures the rules system.

```powershell
# Initialize a new memory bank system
.\BIG.ps1 -Category update -Command init

# Initialize with forced updates
.\BIG.ps1 -Category update -Command init -Force
```

## Integration with Update Scripts

The BIG Update Command integrates with the following update scripts from the `scripts/Update` directory:

1. **Update-AllScripts.ps1**: Updates all initialization scripts for the Memory Bank
2. **Update-InitializationScript.ps1**: Analyzes repository structure and updates initialization scripts
3. **Initialize-MemoryBank.ps1**: Initializes the Memory Bank structure with required directories and files

These scripts are called by the BIG Update Command to perform their respective operations in a consistent manner.

## Common Workflows

### Regular Maintenance

Regular maintenance should include validating and applying rules to keep the memory bank organized:

```powershell
# Update rules system
.\BIG.ps1 -Category update -Command rules
```

### After Structure Changes

After making changes to the memory bank structure or adding new memory types:

```powershell
# Update scripts to reflect new structure
.\BIG.ps1 -Category update -Command scripts

# Update memory bank with new structure
.\BIG.ps1 -Category update -Command memory
```

### Complete System Reset

For a complete system reset or when setting up a new environment:

```powershell
# Initialize a new memory bank system
.\BIG.ps1 -Category update -Command init -Force
```

## Integration with Other BIG Commands

The Update system integrates with other BIG commands:

- **BIG-Analytics**: Update helps maintain the structures analyzed by Analytics
- **BIG-Organization**: Update ensures organization scripts remain aligned with memory structure
- **BIG-Rules**: Update works with Rules to validate and apply rules to the memory bank
- **BIG-Bedtime**: Update can be part of the bedtime protocol to refresh the system

## Troubleshooting

### Common Issues

1. **Missing Update Scripts**: If the update scripts are missing from the `scripts/Update` directory, commands will fail with an error message indicating which scripts are missing.

2. **Permission Issues**: If you encounter permission errors, try running the command with administrative privileges.

3. **Script Execution Policy**: If scripts cannot be executed, you may need to adjust your PowerShell execution policy:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

### Error Messages

```
Error: System update script not found
```
Solution: Ensure the `Update-AllScripts.ps1` script exists in the `scripts/Update` directory.

```
Error: Initialization script updater not found
```
Solution: Ensure the `Update-InitializationScript.ps1` script exists in the `scripts/Update` directory.

```
Error: Memory bank initialization script not found
```
Solution: Ensure the `Initialize-MemoryBank.ps1` script exists in the `scripts/Update` directory.

## Version History

- 1.0.0: Initial implementation of BIG Update command (2025-03-28)