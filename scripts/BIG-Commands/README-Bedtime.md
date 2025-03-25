# BIG Bedtime Protocol Command

The BIG Bedtime Protocol Command provides a standardized interface for executing the end-of-session process for the BIG BRAIN Memory Bank. It helps maintain memory health by properly organizing, summarizing, and transitioning content at the end of work sessions.

## Overview

The BIG Bedtime Protocol Command implements the following pattern:

```
BIG bedtime [command] [parameters] [--options]
```

## Available Commands

| Command          | Description                                                              |
| ---------------- | ------------------------------------------------------------------------ |
| `start`          | Initiates a new bedtime protocol and creates session tracking            |
| `create-summary` | Generates a summary of the current session with recent activity          |
| `analyze`        | Analyzes memory bank health and generates reports                        |
| `transition`     | Prepares for memory transition, moving content to appropriate categories |
| `complete`       | Finalizes the bedtime protocol and prepares for the next session         |

## Common Parameters

| Parameter           | Description                           | Default                                       |
| ------------------- | ------------------------------------- | --------------------------------------------- |
| `-OutputPath`       | Custom path for generated summaries   | `memory-bank/active/summaries/<datestamp>.md` |
| `-SessionName`      | Name for the session or summary       | Auto-generated with date                      |
| `-Days`             | Number of days of activity to include | `1`                                           |
| `-IncludeHealth`    | Include health metrics in summaries   | `false`                                       |
| `-SkipConfirmation` | Skip confirmation prompts             | `false`                                       |

## Usage Examples

### Starting the Bedtime Protocol

```powershell
# Start a new bedtime protocol session
.\BIG-Bedtime.ps1 -Command start

# Start with custom session name
.\BIG-Bedtime.ps1 -Command start -SessionName "feature-development"
```

### Creating Session Summaries

```powershell
# Create a summary of the current session
.\BIG-Bedtime.ps1 -Command create-summary

# Create a summary with health metrics included
.\BIG-Bedtime.ps1 -Command create-summary -IncludeHealth

# Create a summary of the last 3 days
.\BIG-Bedtime.ps1 -Command create-summary -Days 3 -SessionName "weekly-progress"
```

### Analyzing Memory Health

```powershell
# Run a complete analysis of memory health
.\BIG-Bedtime.ps1 -Command analyze

# Analyze with a custom time period
.\BIG-Bedtime.ps1 -Command analyze -Days 7
```

### Transitioning Memory Content

```powershell
# Prepare memory content for transition
.\BIG-Bedtime.ps1 -Command transition

# Skip confirmation prompts during transition
.\BIG-Bedtime.ps1 -Command transition -SkipConfirmation
```

### Completing the Protocol

```powershell
# Complete the bedtime protocol
.\BIG-Bedtime.ps1 -Command complete

# Complete without confirmation prompts
.\BIG-Bedtime.ps1 -Command complete -SkipConfirmation
```

## The Complete Bedtime Protocol Workflow

The recommended workflow for the Bedtime Protocol follows these steps:

1. **Start the Protocol**
   ```powershell
   .\BIG-Bedtime.ps1 -Command start
   ```
   This creates a new session tracking file and performs an initial health check.

2. **Create a Session Summary**
   ```powershell
   .\BIG-Bedtime.ps1 -Command create-summary -IncludeHealth
   ```
   This generates a summary of the session with health metrics and recent activity.

3. **Analyze Memory Health**
   ```powershell
   .\BIG-Bedtime.ps1 -Command analyze
   ```
   This performs a detailed analysis of memory bank health and generates reports.

4. **Transition Memory Content**
   ```powershell
   .\BIG-Bedtime.ps1 -Command transition
   ```
   This prepares for memory transition, moving content to appropriate categories.

5. **Complete the Protocol**
   ```powershell
   .\BIG-Bedtime.ps1 -Command complete
   ```
   This finalizes the bedtime protocol and prepares for the next session.

## Automated Session Files

The following files are automatically generated during the bedtime protocol:

### Session Tracking File (at start)
```markdown
# Session: <session-name>
Date: <date>
Time: <time>

## Session Overview
*This is an automatically generated session file for the bedtime protocol.*

## Session Goals
-

## Key Activities
-

## Decisions Made
-

## Next Steps
-
```

### Session Summary File (at create-summary)
```markdown
# Session Summary: <session-name>
Date: <date>
Time: <time>

## Overview
*This is an automatically generated summary for the bedtime protocol.*

## Session Activities
Recent files modified:
- <file1> (<directory>)
- <file2> (<directory>)
...

## Memory Health
Memory Metrics:
- Total Files: <count>
- Memory Diversity: <score>
- Long-Term Ratio: <score>
- Category Balance: <score>
- Activity Score: <percentage>%
- Overall Health: <percentage>%

## Key Learnings
-

## Decisions Made
-

## Next Steps
-

## Notes
-
```

## Integration with Other BIG Commands

The Bedtime Protocol integrates with other BIG commands:

- **BIG-Analytics**: Used for health checks and generating reports
- **BIG-Organization**: Used for reorganizing and categorizing content

## Troubleshooting

### Common Issues

1. **Missing Files**: Ensure the Bedtime scripts exist in the scripts/Bedtime directory
2. **Summary Not Generated**: Check write permissions for the output directory
3. **Analysis Errors**: Verify that the Analytics scripts are properly updated

### Potential Errors

```
Error: Transition script not found
```
Solution: Verify that Prepare-SessionTransition.ps1 exists in the scripts/Bedtime directory.

```
Error: Bedtime protocol script not found
```
Solution: Verify that Invoke-BedtimeProtocol.ps1 exists in the scripts/Bedtime directory.

## Version History

- 1.0.0: Initial implementation of BIG Bedtime Protocol commands (2025-03-27)