# BIG Command System: Quick Reference Guide

## Simple Commands

Use the streamlined wrapper for common tasks:

```powershell
# Start your day with automatic daily protocol
big start

# Check system health status
big status

# Generate a memory bank report
big report

# Run the bedtime protocol
big bedtime

# Apply memory organization rules
big apply-rules

# Get command help
big help
```

## Command Structure

The BIG command system follows this pattern:

```
BIG [category] [command] [parameters] [--options]
```

Example:
```powershell
big analytics report -Format HTML -Days 7 -OutputPath "C:\path\to\report.html"
```

## Categories and Commands

| Category     | Commands                                   | Description                    |
| ------------ | ------------------------------------------ | ------------------------------ |
| analytics    | stats, report, health                      | Statistics and health metrics  |
| organization | reorganize, categorize, cleanup            | Memory structure organization  |
| bedtime      | start, create-summary, analyze, complete   | End-of-day memory protocols    |
| rules        | list, add, update, remove, apply, validate | Memory organization rules      |
| update       | system, scripts, memory, rules, init       | System updates and maintenance |
| autonomous   | daily, weekly, monthly, refresh, full      | Automated operation sequences  |
| help         | [category], [command]                      | Display help information       |

## Common Shortcuts

| Shortcut       | Equivalent              | Description                  |
| -------------- | ----------------------- | ---------------------------- |
| start, today   | autonomous daily        | Run daily operations         |
| status, health | analytics health        | Check memory health          |
| stats          | analytics stats         | Gather memory statistics     |
| organize       | organization reorganize | Reorganize memory content    |
| cleanup        | organization cleanup    | Clean up obsolete content    |
| categorize     | organization categorize | Categorize memory content    |
| bedtime        | bedtime start           | Start bedtime protocol       |
| sleep          | bedtime complete        | Complete bedtime protocol    |
| summary        | bedtime create-summary  | Create a memory summary      |
| rules          | rules list              | List active memory rules     |
| add-rule       | rules add               | Add a new memory rule        |
| apply-rules    | rules apply             | Apply memory rules           |
| update         | update system           | Update the system            |
| refresh        | autonomous refresh      | Quick memory refresh         |
| weekly         | autonomous weekly       | Run weekly operations        |
| monthly        | autonomous monthly      | Run monthly operations       |
| full           | autonomous full         | Run comprehensive operations |

## Common Parameters

Most commands support these standard parameters:

| Parameter       | Description                                 | Used With           |
| --------------- | ------------------------------------------- | ------------------- |
| -OutputPath     | Custom path for output files                | report, stats       |
| -Format         | Output format (Text, HTML, JSON, All)       | report              |
| -IncludeDetails | Include detailed information                | report, stats       |
| -Days           | Number of days to analyze                   | report, stats       |
| -StartDate      | Start date for analysis                     | report, stats       |
| -EndDate        | End date for analysis                       | report, stats       |
| -Threshold      | Minimum acceptable health score             | health              |
| -FixIssues      | Automatically fix identified issues         | health              |
| -NoInteraction  | Run without user prompts                    | autonomous commands |
| -Skip*          | Skip specific steps (e.g., SkipHealthCheck) | autonomous commands |

## PowerShell Integration

Add these commands to your PowerShell profile:

```powershell
# Add to your profile (run: notepad $PROFILE)
. "D:\Coding\Python_Projects\TheMemoryBank\scripts\profiles\BIG-Profile.ps1"
```

Then use the convenience functions:

```powershell
# Start your day
Start-BIGDay

# Check memory health
Get-BIGHealth

# Get memory statistics
Get-BIGStats

# Begin bedtime protocol
Start-BIGBedtime

# Complete bedtime protocol
Complete-BIGBedtime

# Update system
Start-BIGUpdate
```

## Examples

### Daily Workflow

```powershell
# Morning: Start your day
big start

# Throughout day: Check status
big status

# Evening: Run bedtime protocol
big bedtime

# Generate a summary
big summary

# Complete the protocol
big sleep
```

### Advanced Usage

```powershell
# Generate a detailed HTML report for the past week
big analytics report -Format HTML -Days 7 -IncludeDetails

# Run organization with specific parameters
big organization reorganize -Category "creative" -NoInteraction

# Apply rules to specific memory categories
big rules apply -Category "long-term" -Tags "project,reference"

# Run a health check and fix issues
big health -FixIssues -Threshold 75

# Run full system operations with custom options
big autonomous full -SkipReports -SkipUpdate
```

## Troubleshooting

If you encounter issues:

1. Check the logs in `scripts/logs/`
2. Run `big health` to check system health
3. Try `big refresh` to restore normal operation
4. For parameter errors, check command syntax with `big help [category] [command]`

For persistent issues, run `big update system` to update the system.