# BIG.ps1
# Main command interface for the BIG BRAIN Memory Bank system
# Version 1.1.0
# Created: 2025-03-27
# Updated: 2025-03-28 - Added rules category

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("analytics", "organization", "bedtime", "rules")]
    [string]$Category,

    [Parameter(Mandatory = $true, Position = 1)]
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

# Function to execute a script with parameters
function Invoke-BIGScript {
    [CmdletBinding()]
    param (
        [string]$ScriptPath,
        [string]$Command,
        [string[]]$Parameters
    )

    $scriptParams = @("-Command", $Command)

    if ($Parameters -and $Parameters.Count -gt 0) {
        $scriptParams += $Parameters
    }

    Write-BIGLog -Message "Executing: $ScriptPath $scriptParams" -Level "DEBUG" -LogFile $logFile

    try {
        & $ScriptPath @scriptParams
        $success = $true
    }
    catch {
        Write-BIGLog -Message "Error executing script: $_" -Level "ERROR" -LogFile $logFile
        $success = $false
    }

    return $success
}

# Main command router
Write-BIGHeader -Title "BIG BRAIN COMMAND" -LogFile $logFile

Write-BIGLog -Message "Category: $Category, Command: $Command, Arguments: $($RemainingArgs -join ' ')" -Level "INFO" -LogFile $logFile

$startTime = Get-Date
$success = $false

switch ($Category) {
    "analytics" {
        if (-not (Test-Path -Path $analyticsScript)) {
            Write-BIGLog -Message "Analytics script not found at $analyticsScript" -Level "ERROR" -LogFile $logFile
            break
        }

        $validCommands = @("stats", "report", "health")
        if (-not ($validCommands -contains $Command)) {
            Write-BIGLog -Message "Invalid analytics command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
            break
        }

        $success = Invoke-BIGScript -ScriptPath $analyticsScript -Command $Command -Parameters $RemainingArgs
    }

    "organization" {
        if (-not (Test-Path -Path $organizationScript)) {
            Write-BIGLog -Message "Organization script not found at $organizationScript" -Level "ERROR" -LogFile $logFile
            break
        }

        $validCommands = @("reorganize", "categorize", "cleanup")
        if (-not ($validCommands -contains $Command)) {
            Write-BIGLog -Message "Invalid organization command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
            break
        }

        $success = Invoke-BIGScript -ScriptPath $organizationScript -Command $Command -Parameters $RemainingArgs
    }

    "bedtime" {
        if (-not (Test-Path -Path $bedtimeScript)) {
            Write-BIGLog -Message "Bedtime script not found at $bedtimeScript" -Level "ERROR" -LogFile $logFile
            break
        }

        $validCommands = @("start", "create-summary", "analyze", "transition", "complete")
        if (-not ($validCommands -contains $Command)) {
            Write-BIGLog -Message "Invalid bedtime command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
            break
        }

        $success = Invoke-BIGScript -ScriptPath $bedtimeScript -Command $Command -Parameters $RemainingArgs
    }

    "rules" {
        if (-not (Test-Path -Path $rulesScript)) {
            Write-BIGLog -Message "Rules script not found at $rulesScript" -Level "ERROR" -LogFile $logFile
            break
        }

        $validCommands = @("list", "add", "update", "remove", "apply", "validate")
        if (-not ($validCommands -contains $Command)) {
            Write-BIGLog -Message "Invalid rules command: $Command. Valid commands: $($validCommands -join ', ')" -Level "ERROR" -LogFile $logFile
            break
        }

        $success = Invoke-BIGScript -ScriptPath $rulesScript -Command $Command -Parameters $RemainingArgs
    }

    default {
        Write-BIGLog -Message "Invalid category: $Category" -Level "ERROR" -LogFile $logFile
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