# BIG BRAIN Memory Bank Scripts

This directory contains all scripts for managing, maintaining, and interacting with the BIG BRAIN Memory Bank system. These scripts provide functionality for analytics, organization, bedtime protocols, system updates, and more.

## Directory Structure

| Directory       | Purpose                                                               |
| --------------- | --------------------------------------------------------------------- |
| `Analytics`     | Scripts for analyzing memory bank health and generating usage reports |
| `BIG-Commands`  | Unified command system for all memory bank operations                 |
| `Bedtime`       | End-of-session protocols and transitions                              |
| `CI`            | Continuous Integration scripts for automated testing                  |
| `Core`          | Core functionality for memory bank operations                         |
| `Examples`      | Example scripts and templates                                         |
| `Init`          | Initialization scripts for setting up memory bank                     |
| `Migration`     | Scripts for migrating between memory bank versions                    |
| `Organization`  | Scripts for organizing and categorizing memory content                |
| `Rules`         | Rules definitions for memory bank governance                          |
| `Update`        | Scripts for updating the memory bank system                           |
| `Utilities`     | Utility scripts used across multiple components                       |
| `Verification`  | Scripts for verifying memory bank integrity                           |
| `Visualization` | Scripts for visualizing memory bank structure and data                |
| `backup`        | Backup scripts and storage                                            |
| `memory-bank`   | Core memory bank content and structure                                |
| `reports`       | Generated reports and analytics output                                |

## Getting Started

### Prerequisites

- PowerShell 5.1 or higher (PowerShell Core 7.x recommended)
- Bash (for Linux/macOS users)
- Git (for version control operations)

### Initial Setup

To set up the memory bank for the first time:

```powershell
# Navigate to the scripts directory
cd path\to\scripts

# Initialize the memory bank system
.\BIG-Commands\BIG.ps1 -Category update -Command init
```

This initializes the directory structure, creates necessary files, and sets up the rules system.

## Using the BIG Command System

The BIG Command System provides a unified interface for all memory bank operations. All commands follow this pattern:

```
BIG [category] [command] [parameters] [--options]
```

### Common Operations

#### Health Check

```powershell
# Run a health check on the memory bank
.\BIG-Commands\BIG.ps1 -Category analytics -Command health
```

#### Generate Statistics

```powershell
# Generate detailed statistics about the memory bank
.\BIG-Commands\BIG.ps1 -Category analytics -Command stats -IncludeDetails
```

#### Create Reports

```powershell
# Generate an HTML report
.\BIG-Commands\BIG.ps1 -Category analytics -Command report -Format HTML
```

#### Organize Content

```powershell
# Reorganize content based on rules
.\BIG-Commands\BIG.ps1 -Category organization -Command reorganize
```

#### Manage Rules

```powershell
# List all rules
.\BIG-Commands\BIG.ps1 -Category rules -Command list

# Add a new rule
.\BIG-Commands\BIG.ps1 -Category rules -Command add -RuleId org-001 -Category organization -Description "Move markdown files to semantic memory" -Pattern "*.md" -Action move-to-semantic
```

#### End-of-Session Protocol

```powershell
# Start the bedtime protocol
.\BIG-Commands\BIG.ps1 -Category bedtime -Command start

# Complete the bedtime protocol
.\BIG-Commands\BIG.ps1 -Category bedtime -Command complete
```

#### System Updates

```powershell
# Update the system
.\BIG-Commands\BIG.ps1 -Category update -Command system
```

## Step-by-Step Workflows

### Daily Usage Workflow

1. **Start your session**:
   ```powershell
   cd path\to\scripts
   ```

2. **Check memory bank health**:
   ```powershell
   .\BIG-Commands\BIG.ps1 -Category analytics -Command health
   ```

3. **Organize content** (if needed):
   ```powershell
   .\BIG-Commands\BIG.ps1 -Category organization -Command reorganize
   ```

4. **Work with your memory bank** (add files, update content, etc.)

5. **End your session**:
   ```powershell
   .\BIG-Commands\BIG.ps1 -Category bedtime -Command start
   # Review the summary
   .\BIG-Commands\BIG.ps1 -Category bedtime -Command complete
   ```

### Weekly Maintenance Workflow

1. **Update the system**:
   ```powershell
   .\BIG-Commands\BIG.ps1 -Category update -Command system
   ```

2. **Validate rules**:
   ```powershell
   .\BIG-Commands\BIG.ps1 -Category rules -Command validate
   ```

3. **Apply rules**:
   ```powershell
   .\BIG-Commands\BIG.ps1 -Category rules -Command apply
   ```

4. **Generate a comprehensive report**:
   ```powershell
   .\BIG-Commands\BIG.ps1 -Category analytics -Command report -Format HTML
   ```

5. **Clean up unnecessary files**:
   ```powershell
   .\BIG-Commands\BIG.ps1 -Category organization -Command cleanup
   ```

## Utility Batch Files

The scripts directory also contains several batch files for specific operations:

- `update_docs.bat`: Updates documentation
- `protect-branch-content.bat`: Protects branch content during Git operations
- `merge-to-main.bat`: Merges changes to the main branch

## Advanced Usage

For advanced usage and detailed information about each command category, refer to the respective README files:

- [BIG Command System](BIG-Commands/README-Main.md)
- [Analytics Commands](BIG-Commands/README.md)
- [Organization Commands](BIG-Commands/README-Organization.md)
- [Bedtime Protocol](BIG-Commands/README-Bedtime.md)
- [Rules System](BIG-Commands/README-Rules.md)
- [Update System](BIG-Commands/README-Update.md)

## Extending the System

To extend the system with new functionality:

1. Create new scripts in the appropriate directory
2. If adding a new command category, create a script named `BIG-CategoryName.ps1` in the `BIG-Commands` directory
3. Create a README file documenting the commands
4. Update the `BIG.ps1` script to include the new category

## Troubleshooting

If you encounter issues:

1. Check the log files in the `logs` directory
2. Verify that you have the required permissions for file operations
3. Ensure all dependencies are installed
4. For PowerShell scripts, you may need to adjust the execution policy:
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

## See Also

For a comprehensive understanding of the BIG BRAIN Memory Bank system, refer to the main [README](../README.md) file.