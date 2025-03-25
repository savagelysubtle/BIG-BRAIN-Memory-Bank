# BIG-Wrapper.ps1
# User-friendly wrapper for BIG commands
# Version 1.0.0
# Created: 2025-03-29

[CmdletBinding()]
param (
    [Parameter(Position = 0)]
    [string]$Command,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

# Define shortcuts
$shortcuts = @{
    # Daily operations
    "start"       = @("autonomous", "daily")
    "today"       = @("autonomous", "daily")
    "daily"       = @("autonomous", "daily")

    # Health and status
    "status"      = @("analytics", "health")
    "health"      = @("analytics", "health")
    "stats"       = @("analytics", "stats")
    "report"      = @("analytics", "report")

    # Organization
    "organize"    = @("organization", "reorganize")
    "cleanup"     = @("organization", "cleanup")
    "categorize"  = @("organization", "categorize")

    # Bedtime protocol
    "bedtime"     = @("bedtime", "start")
    "sleep"       = @("bedtime", "complete")
    "summary"     = @("bedtime", "create-summary")

    # Rules management
    "rules"       = @("rules", "list")
    "add-rule"    = @("rules", "add")
    "apply-rules" = @("rules", "apply")

    # Updates
    "update"      = @("update", "system")
    "refresh"     = @("autonomous", "refresh")

    # Comprehensive operations
    "weekly"      = @("autonomous", "weekly")
    "monthly"     = @("autonomous", "monthly")
    "full"        = @("autonomous", "full")

    # Help
    "help"        = @("help")
    "?"           = @("help")
}

# Default command if none provided
if ([string]::IsNullOrEmpty($Command)) {
    $Command = "status"
}

# Path to the main BIG script
$bigScript = Join-Path -Path $PSScriptRoot -ChildPath "BIG.ps1"

# Check if the command is a known shortcut
if ($shortcuts.ContainsKey($Command.ToLower())) {
    $expandedCommand = $shortcuts[$Command.ToLower()]

    # Build the full command
    $category = $expandedCommand[0]
    $subCommand = if ($expandedCommand.Length -gt 1) { $expandedCommand[1] } else { $null }

    $argList = @($category)
    if ($subCommand) {
        $argList += $subCommand
    }
    if ($RemainingArgs) {
        $argList += $RemainingArgs
    }

    # Display what's being executed
    Write-Host "Executing: BIG $($argList -join ' ')" -ForegroundColor Cyan

    # Execute the command
    & $bigScript @argList
}
else {
    # Assume the user entered a category
    $argList = @($Command)
    if ($RemainingArgs) {
        $argList += $RemainingArgs
    }

    # Display what's being executed
    Write-Host "Executing: BIG $($argList -join ' ')" -ForegroundColor Cyan

    # Execute the command
    & $bigScript @argList
}

# Return the same exit code as the main script
exit $LASTEXITCODE