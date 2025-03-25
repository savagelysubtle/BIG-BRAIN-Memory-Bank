# BIG-Autonomous Command

## Overview
The BIG-Autonomous command provides a streamlined way to run multiple operations across different BIG command categories in a single automated sequence. It serves as a "one-stop shop" for comprehensive system maintenance and organization tasks, eliminating the need to run multiple commands manually.

This command is designed to maximize autonomy of the BIG BRAIN Memory Bank by chaining together operations in a structured, logical way while providing feedback and error handling.

## Command Structure
```
BIG autonomous [command] [parameters]
```

The BIG-Autonomous command coordinates operations across multiple categories:
- Health checks from the analytics category
- Rule validation and application from the rules category
- Content organization from the organization category
- Reports and statistics generation
- System updates
- Bedtime protocols

## Available Commands

| Command   | Description                                                                                                                                                             |
| --------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `daily`   | Performs essential daily operations including health checks, rule application, content reorganization, and daily summary report generation.                             |
| `weekly`  | Executes a more comprehensive set of operations including system updates, rule validation, content reorganization, cleanup, and detailed report generation.             |
| `monthly` | Conducts a full system maintenance cycle including script and memory structure updates, complete rules validation, content categorization, and comprehensive reporting. |
| `refresh` | Performs a quick refresh of the memory bank with minimal operations: health check, rule application, and basic reorganization.                                          |
| `full`    | Executes all available operations in sequence for complete system maintenance and organization - the most comprehensive command.                                        |

## Common Parameters

| Parameter          | Type   | Description                                                                                |
| ------------------ | ------ | ------------------------------------------------------------------------------------------ |
| `-Command`         | String | **Required.** The command to execute (`daily`, `weekly`, `monthly`, `refresh`, or `full`). |
| `-OutputPath`      | String | Optional. Custom path where reports should be saved.                                       |
| `-SkipHealthCheck` | Switch | Skip health check operations.                                                              |
| `-SkipReorganize`  | Switch | Skip content organization operations.                                                      |
| `-SkipRules`       | Switch | Skip rule validation and application operations.                                           |
| `-SkipReports`     | Switch | Skip report generation operations.                                                         |
| `-SkipUpdate`      | Switch | Skip system update operations.                                                             |
| `-NoInteraction`   | Switch | Run without prompting for confirmation between steps.                                      |
| `-Verbose`         | Switch | Display detailed progress information.                                                     |

## Command Workflows

### Daily Operations
The `daily` command runs a streamlined sequence of basic operations:
1. Health check (analytics)
2. Apply memory rules
3. Reorganize memory content
4. Generate daily summary report

### Weekly Operations
The `weekly` command builds on the daily operations with additional steps:
1. Update system scripts
2. Validate and apply memory rules
3. Reorganize content and clean up obsolete files
4. Generate comprehensive HTML and JSON reports/statistics

### Monthly Operations
The `monthly` command provides a full system maintenance:
1. Update initialization scripts and memory bank structure
2. Complete rules validation and application
3. Categorize and reorganize content, clean up obsolete files
4. Generate comprehensive HTML, JSON, and text reports

### Refresh Operations
The `refresh` command performs a quick health check and basic maintenance:
1. Health check
2. Apply memory rules
3. Quick reorganize of memory content

### Full Operations
The `full` command executes the most comprehensive sequence:
1. Update the entire system, initialization scripts, and memory structure
2. Validate and apply memory rules
3. Complete health check and gather detailed statistics
4. Categorize, reorganize, and clean up memory content
5. Generate comprehensive HTML, JSON, and statistics reports
6. Execute complete bedtime protocol to finalize operations

## Usage Examples

### Running Daily Operations
```powershell
# Basic daily operations
.\BIG.ps1 -Category autonomous -Command daily

# Daily operations with a custom output path
.\BIG.ps1 -Category autonomous -Command daily -OutputPath "C:\MemoryReports"

# Daily operations without interaction prompts
.\BIG.ps1 -Category autonomous -Command daily -NoInteraction
```

### Running Weekly Operations
```powershell
# Standard weekly maintenance
.\BIG.ps1 -Category autonomous -Command weekly

# Weekly maintenance skipping update steps
.\BIG.ps1 -Category autonomous -Command weekly -SkipUpdate
```

### Running Monthly Operations
```powershell
# Full monthly maintenance
.\BIG.ps1 -Category autonomous -Command monthly

# Monthly maintenance focused on organization only
.\BIG.ps1 -Category autonomous -Command monthly -SkipUpdate -SkipReports
```

### Quick Refresh
```powershell
# Quick system refresh
.\BIG.ps1 -Category autonomous -Command refresh
```

### Full System Operations
```powershell
# Complete system maintenance
.\BIG.ps1 -Category autonomous -Command full

# Full maintenance without interaction (for scheduled tasks)
.\BIG.ps1 -Category autonomous -Command full -NoInteraction
```

## Logs and Reports

All autonomous operations are logged using the centralized logging system. Log files are created in the `scripts/logs` directory with detailed information about each step executed.

Reports are generated in the `scripts/reports` directory by default, or in the custom location specified with the `-OutputPath` parameter. Reports include:

- Daily summary reports (JSON)
- Weekly reports (HTML and JSON statistics)
- Monthly reports (HTML, JSON, and text)
- Full system reports (HTML, JSON, and statistics)

## Error Handling

The autonomous command includes comprehensive error handling:

1. Each step is executed in sequence with appropriate error checking
2. Critical errors can abort the sequence to prevent further issues
3. Non-critical errors allow continuing with subsequent operations
4. Interactive prompts between steps (unless `-NoInteraction` is specified)
5. Detailed logging of all operations, successes, and failures

## Integration with Other BIG Commands

The BIG-Autonomous command serves as an orchestrator that calls other BIG commands:
- `BIG-Analytics.ps1` for health checks and reports
- `BIG-Organization.ps1` for content organization
- `BIG-Rules.ps1` for rule validation and application
- `BIG-Update.ps1` for system updates
- `BIG-Bedtime.ps1` for end-of-session protocols

## Troubleshooting

### Common Issues

1. **Operation sequence aborts unexpectedly**
   - Check logs for specific error messages
   - Run with `-Verbose` for more detailed output
   - Try running individual category commands to isolate the issue

2. **Reports not being generated**
   - Verify write permissions to the output directory
   - Check if the `-SkipReports` parameter is being used
   - Review logs for specific report generation errors

3. **Steps taking too long**
   - Large memory banks may require more processing time
   - Consider using more specific commands for large systems
   - Use `-SkipReorganize` to bypass the most time-consuming operations

### When to Use Each Command

- `daily`: For routine maintenance - quick and essential operations only
- `weekly`: For end-of-week cleanup - more thorough maintenance
- `monthly`: For comprehensive system maintenance - full reorganization
- `refresh`: For quick health checks without extensive operations
- `full`: For complete system overhaul - use when significant updates needed

## Version History

| Version | Date       | Changes                                                     |
| ------- | ---------- | ----------------------------------------------------------- |
| 1.0.0   | 2025-03-28 | Initial implementation of the BIG-Autonomous command system |