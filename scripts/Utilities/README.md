# BIG BRAIN Utilities

This directory contains utility scripts and functions that are used across the BIG BRAIN Memory Bank system. These utilities provide common functionality to help maintain consistency and reduce code duplication.

## Available Utilities

| Script             | Description                                               |
| ------------------ | --------------------------------------------------------- |
| `Write-BIGLog.ps1` | Centralized logging utility for consistent log formatting |

## Logging Utility

The logging utility provides standardized functions for logging across all BIG BRAIN scripts.

### Functions

| Function           | Description                                                         |
| ------------------ | ------------------------------------------------------------------- |
| `Write-BIGLog`     | Writes a message to the log and console with appropriate formatting |
| `Write-BIGHeader`  | Creates standardized section headers for scripts                    |
| `Start-BIGLogging` | Initializes logging for a script                                    |
| `Stop-BIGLogging`  | Finalizes logging for a script                                      |

### Usage

Add this to the beginning of your script:

```powershell
# Import logging utility
$utilityPath = Join-Path -Path $PSScriptRoot -ChildPath "../Utilities/Write-BIGLog.ps1"
. $utilityPath

# Start logging
$logFile = Start-BIGLogging -ScriptName $MyInvocation.MyCommand.Path

# Log section header
Write-BIGHeader -Title "MY SCRIPT SECTION" -LogFile $logFile

# Log information
Write-BIGLog -Message "Processing started" -Level "INFO" -LogFile $logFile
Write-BIGLog -Message "This is a warning" -Level "WARNING" -LogFile $logFile
Write-BIGLog -Message "An error occurred" -Level "ERROR" -LogFile $logFile
Write-BIGLog -Message "Operation successful" -Level "SUCCESS" -LogFile $logFile

# End logging with duration
$startTime = Get-Date
# ... script operations ...
$duration = (Get-Date) - $startTime
Stop-BIGLogging -ScriptName $MyInvocation.MyCommand.Path -LogFile $logFile -Duration $duration
```

### Log Levels

The logging utility supports the following log levels:

| Level   | Color  | Purpose                            |
| ------- | ------ | ---------------------------------- |
| INFO    | White  | General information                |
| WARNING | Yellow | Warnings that don't stop execution |
| ERROR   | Red    | Errors that might stop execution   |
| DEBUG   | Cyan   | Detailed debugging information     |
| SUCCESS | Green  | Successful operations              |

### Log File Location

By default, logs are stored in the `scripts/logs` directory with the filename format `BIG-Memory-YYYY-MM-DD.log`. You can specify a custom log file path if needed.

## Adding New Utilities

When creating new utility scripts:

1. Follow the naming convention `Verb-BIGNoun.ps1`
2. Include a header comment with description, version, and creation date
3. Document parameters and usage
4. Export functions using `Export-ModuleMember` if needed
5. Update this README with the new utility details

