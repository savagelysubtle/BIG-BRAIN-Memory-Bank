# BIG.ps1
# Main command interface for the BIG BRAIN Memory Bank system
# Version 1.5.0
# Created: 2025-03-27
# Updated: 2025-03-28 - Added rules category
# Updated: 2025-03-28 - Added update category
# Updated: 2025-03-28 - Added autonomous category
# Updated: 2025-03-29 - Fixed parameter passing to child scripts
# Updated: 2025-03-30 - Added codebase category for integration with .cursor rules

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("analytics", "organization", "bedtime", "rules", "update", "autonomous", "codebase", "help")]
    [string]$Category,

    [Parameter(Mandatory = $false, Position = 1)]
    [string]$Command,

    [Parameter(ValueFromRemainingArguments = $true)]
    [string[]]$RemainingArgs
)

# Import logging utility
$utilityPath = Join-Path -Path $PSScriptRoot -ChildPath "../Utilities/Write-BIGLog.ps1"
. $utilityPath

# Start logging
$logFile = Start-BIGLogging -ScriptName $MyInvocation.MyCommand.Path

# Define paths to command scripts
$scriptsDir = $PSScriptRoot
$analyticsScript = Join-Path -Path $scriptsDir -ChildPath "BIG-Analytics.ps1"
$organizationScript = Join-Path -Path $scriptsDir -ChildPath "BIG-Organization.ps1"
$bedtimeScript = Join-Path -Path $scriptsDir -ChildPath "BIG-Bedtime.ps1"
$rulesScript = Join-Path -Path $scriptsDir -ChildPath "BIG-Rules.ps1"
$updateScript = Join-Path -Path $scriptsDir -ChildPath "BIG-Update.ps1"
$autonomousScript = Join-Path -Path $scriptsDir -ChildPath "BIG-Autonomous.ps1"
$codebaseScript = Join-Path -Path $scriptsDir -ChildPath "BIG-Codebase.ps1"

# Function to display help information
function Show-Help {
    param (
        [string]$Category = "",
        [string]$Command = ""
    )

    if ([string]::IsNullOrEmpty($Category)) {
        Write-Host "`nBIG Command System Help" -ForegroundColor Cyan
        Write-Host "======================" -ForegroundColor Cyan
        Write-Host "`nUsage: BIG [category] [command] [parameters]`n"
        Write-Host "Available categories:"
        Write-Host "  analytics     - Memory statistics and health monitoring"
        Write-Host "  organization  - Memory structure organization"
        Write-Host "  bedtime       - End-of-day organization protocols"
        Write-Host "  rules         - Memory rules management"
        Write-Host "  update        - System updates and maintenance"
        Write-Host "  autonomous    - Automated operations sequences"
        Write-Host "  codebase      - Integration with .cursor rules"
        Write-Host "  help          - Display help information"
        Write-Host "`nFor category help: BIG help [category]"
        return
    }

    # Category-specific help
    switch ($Category.ToLower()) {
        "codebase" {
            Write-Host "`nBIG Codebase Commands" -ForegroundColor Cyan
            Write-Host "====================" -ForegroundColor Cyan
            Write-Host "`nCommands for codebase integration with .cursor rules:"
            Write-Host "  analyze     - Analyze codebase against coding standards"
            Write-Host "  validate    - Validate code against standard rules"
            Write-Host "  apply       - Apply coding standards to codebase"
            Write-Host "  learn       - Learn from existing codebase"
            Write-Host "  search      - Search for patterns in codebase"
            Write-Host ""
            Write-Host "Parameters:"
            Write-Host "  -TargetPath     - Path to the codebase (default: current directory)"
            Write-Host "  -RuleCategory   - Rule category to use (Languages, Patterns, etc.)"
            Write-Host "  -Language       - Target language (PowerShell, Python, etc.)"
            Write-Host "  -Pattern        - Search pattern (required for search command)"
            Write-Host "  -TestMode       - Run in test mode without making changes"
            Write-Host "  -Detailed       - Show detailed output"
            Write-Host ""
            Write-Host "Examples:"
            Write-Host "  BIG codebase analyze -Language PowerShell"
            Write-Host "  BIG codebase search -Pattern 'function.*Test' -Language PowerShell"
            Write-Host "  BIG codebase validate -TestMode"
            return
        }
        # Other category help would go here
    }

    # If we get here, no specific help was found
    Write-Host "`nNo detailed help available for category: $Category" -ForegroundColor Yellow
    Show-Help # Show general help instead
}

# Function to execute a script with parameters
function Invoke-BIGScript {
    [CmdletBinding()]
    param (
        [string]$ScriptPath,
        [string]$Command,
        [string[]]$Parameters
    )

    if (-not (Test-Path -Path $ScriptPath)) {
        Write-BIGLog -Message "Script not found at $ScriptPath" -Level "ERROR" -LogFile $logFile
        return $false
    }

    try {
        # Handle parameter passing differently based on script name
        $scriptName = Split-Path -Leaf $ScriptPath

        Write-BIGLog -Message "Executing script: $scriptName with Command: $Command" -Level "DEBUG" -LogFile $logFile

        # Expanded special handling for all BIG-*.ps1 scripts to fix parameter passing issues
        if ($scriptName -match "BIG-\w+\.ps1") {
            # For all BIG scripts, use named parameter for Command
            $paramString = "-Command '$Command'"

            # Add any additional parameters
            if ($Parameters -and $Parameters.Count -gt 0) {
                $paramString += " " + ($Parameters -join " ")
            }

            Write-BIGLog -Message "Executing: $ScriptPath $paramString" -Level "DEBUG" -LogFile $logFile

            # Use Invoke-Expression to handle the command properly
            $scriptCmd = "$ScriptPath $paramString"
            Invoke-Expression $scriptCmd
        }
        else {
            # Standard approach for other scripts
            $argList = @($Command) + $Parameters

            Write-BIGLog -Message "Executing: $ScriptPath with args: $argList" -Level "DEBUG" -LogFile $logFile
            & $ScriptPath @argList
        }

        if ($LASTEXITCODE -eq $null -or $LASTEXITCODE -eq 0) {
            return $true
        }
        return $false
    }
    catch {
        Write-BIGLog -Message "Error executing script: $_" -Level "ERROR" -LogFile $logFile
        return $false
    }
}

# Main command router
Write-BIGHeader -Title "BIG BRAIN COMMAND" -LogFile $logFile

Write-BIGLog -Message "Category: $Category, Command: $Command, Arguments: $($RemainingArgs -join ' ')" -Level "INFO" -LogFile $logFile

$startTime = Get-Date
$success = $false

# Handle help requests
if ($Category -eq "help") {
    Show-Help -Category $Command
    $success = $true
}
else {
    switch ($Category) {
        "analytics" {
            $validCommands = @("stats", "report", "health")
            if (-not [string]::IsNullOrEmpty($Command) -and -not ($validCommands -contains $Command)) {
                Write-BIGLog -Message "Invalid analytics command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
                break
            }

            $success = Invoke-BIGScript -ScriptPath $analyticsScript -Command $Command -Parameters $RemainingArgs
        }

        "organization" {
            $validCommands = @("reorganize", "categorize", "cleanup")
            if (-not [string]::IsNullOrEmpty($Command) -and -not ($validCommands -contains $Command)) {
                Write-BIGLog -Message "Invalid organization command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
                break
            }

            $success = Invoke-BIGScript -ScriptPath $organizationScript -Command $Command -Parameters $RemainingArgs
        }

        "bedtime" {
            $validCommands = @("start", "create-summary", "analyze", "transition", "complete")
            if (-not [string]::IsNullOrEmpty($Command) -and -not ($validCommands -contains $Command)) {
                Write-BIGLog -Message "Invalid bedtime command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
                break
            }

            $success = Invoke-BIGScript -ScriptPath $bedtimeScript -Command $Command -Parameters $RemainingArgs
        }

        "rules" {
            $validCommands = @("list", "add", "update", "remove", "apply", "validate")
            if (-not [string]::IsNullOrEmpty($Command) -and -not ($validCommands -contains $Command)) {
                Write-BIGLog -Message "Invalid rules command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
                break
            }

            $success = Invoke-BIGScript -ScriptPath $rulesScript -Command $Command -Parameters $RemainingArgs
        }

        "update" {
            $validCommands = @("system", "scripts", "memory", "rules", "init")
            if (-not [string]::IsNullOrEmpty($Command) -and -not ($validCommands -contains $Command)) {
                Write-BIGLog -Message "Invalid update command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
                break
            }

            $success = Invoke-BIGScript -ScriptPath $updateScript -Command $Command -Parameters $RemainingArgs
        }

        "autonomous" {
            $validCommands = @("daily", "weekly", "monthly", "refresh", "full")
            if (-not [string]::IsNullOrEmpty($Command) -and -not ($validCommands -contains $Command)) {
                Write-BIGLog -Message "Invalid autonomous command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
                break
            }

            $success = Invoke-BIGScript -ScriptPath $autonomousScript -Command $Command -Parameters $RemainingArgs
        }

        "codebase" {
            $validCommands = @("analyze", "apply", "validate", "learn", "search")
            if (-not [string]::IsNullOrEmpty($Command) -and -not ($validCommands -contains $Command)) {
                Write-BIGLog -Message "Invalid codebase command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
                break
            }

            $success = Invoke-BIGScript -ScriptPath $codebaseScript -Command $Command -Parameters $RemainingArgs
        }

        default {
            Write-BIGLog -Message "Invalid category: $Category" -Level "ERROR" -LogFile $logFile
        }
    }
}

$duration = (Get-Date) - $startTime

if ($success) {
    Write-BIGLog -Message "Command completed successfully (Duration: $duration)" -Level "SUCCESS" -LogFile $logFile
}
else {
    Write-BIGLog -Message "Command failed (Duration: $duration)" -Level "ERROR" -LogFile $logFile
}

# End logging
Stop-BIGLogging -ScriptName $MyInvocation.MyCommand.Path -LogFile $logFile -Duration $duration

# Return proper exit code
if ($success) { exit 0 } else { exit 1 }