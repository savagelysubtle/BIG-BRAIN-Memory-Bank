# BIG Command System

The BIG Command System provides a unified interface for interacting with the BIG BRAIN Memory Bank. It routes commands to appropriate implementation scripts, ensuring consistent logging, error handling, and user experience.

## Command Structure

All BIG commands follow the structure:

```
BIG [category] [command] [parameters] [--options]
```

## Available Categories

| Category       | Purpose                                           | Documentation                                 |
| -------------- | ------------------------------------------------- | --------------------------------------------- |
| `analytics`    | Memory bank health monitoring and reporting       | [Analytics README](README.md)                 |
| `organization` | Content organization, categorization, and cleanup | [Organization README](README-Organization.md) |
| `bedtime`      | End-of-session protocols and transitions          | [Bedtime README](README-Bedtime.md)           |
| `rules`        | Managing rules that govern memory bank operations | [Rules README](README-Rules.md)               |

## Usage Examples

The `BIG.ps1` script serves as the main entry point for all memory bank management operations:

```powershell
# Run a health check on the memory bank
.\BIG.ps1 -Category analytics -Command health

# Generate a report in HTML format
.\BIG.ps1 -Category analytics -Command report -Format HTML

# Reorganize memory content
.\BIG.ps1 -Category organization -Command reorganize

# Start the bedtime protocol
.\BIG.ps1 -Category bedtime -Command start

# List all memory rules
.\BIG.ps1 -Category rules -Command list

# Apply all rules to the memory bank
.\BIG.ps1 -Category rules -Command apply
```

The script validates inputs, routes to implementations, logs execution, and handles errors consistently.

## Common Workflows

### Memory Health Analysis

```powershell
# Get a quick health check
.\BIG.ps1 -Category analytics -Command health

# Get detailed statistics
.\BIG.ps1 -Category analytics -Command stats -IncludeDetails

# Export a health report in HTML format
.\BIG.ps1 -Category analytics -Command report -Format HTML
```

### Content Organization

```powershell
# Reorganize content according to system rules
.\BIG.ps1 -Category organization -Command reorganize

# Clean up obsolete files
.\BIG.ps1 -Category organization -Command cleanup

# Categorize content
.\BIG.ps1 -Category organization -Command categorize
```

### Bedtime Protocol

```powershell
# Start the bedtime protocol
.\BIG.ps1 -Category bedtime -Command start

# Create a session summary
.\BIG.ps1 -Category bedtime -Command create-summary

# Analyze today's activities
.\BIG.ps1 -Category bedtime -Command analyze

# Complete the bedtime protocol
.\BIG.ps1 -Category bedtime -Command complete
```

### Rules Management

```powershell
# List all defined rules
.\BIG.ps1 -Category rules -Command list

# Add a new rule
.\BIG.ps1 -Category rules -Command add -RuleId org-001 -Category organization -Description "Move markdown files to semantic memory" -Pattern "*.md" -Action move-to-semantic

# Apply all rules to the memory bank
.\BIG.ps1 -Category rules -Command apply

# Validate rule consistency
.\BIG.ps1 -Category rules -Command validate
```

## Logging

The BIG Command System uses a centralized logging system that outputs to:
1. The console (with color coding by message level)
2. Daily log files in the `scripts/logs` directory

Log files follow the naming pattern `BIG-Memory-YYYY-MM-DD.log` and include:
- Timestamp
- Log level (INFO, WARNING, ERROR, DEBUG, SUCCESS)
- Source script
- Message

## Error Handling

The system provides consistent error management:
- Input validation before executing commands
- Clear error messages with suggestions for resolution
- Comprehensive logging of errors
- Non-zero exit codes on failure

## Extending the System

To add a new category to the command system:

1. Create a script named `BIG-CategoryName.ps1` in the `scripts/BIG-Commands` directory
2. Implement the command router pattern used in other BIG command scripts
3. Create a README file documenting the commands
4. Update the `BIG.ps1` script to include the new category

## Version History

- 1.1.0: Added rules management (2025-03-28)
- 1.0.0: Initial implementation of unified BIG Command System (2025-03-27)