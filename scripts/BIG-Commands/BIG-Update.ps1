# BIG-Update.ps1
# Implementation of BIG BRAIN Memory Bank update commands
# Version 1.0.0
# Created: 2025-03-28

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("system", "scripts", "memory", "rules", "init")]
    [string]$Command,

    [Parameter()]
    [switch]$Force,

    [Parameter()]
    [string]$OutputPath
)

#-----------------------------------------------------------
# Import logging utility
#-----------------------------------------------------------
$utilityPath = Join-Path -Path $PSScriptRoot -ChildPath "../Utilities/Write-BIGLog.ps1"
. $utilityPath

# Start logging
$logFile = Start-BIGLogging -ScriptName $MyInvocation.MyCommand.Path

#-----------------------------------------------------------
# Set up paths to update scripts
#-----------------------------------------------------------
$projectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$updateDir = Join-Path -Path $projectRoot -ChildPath "scripts/Update"

# Update scripts paths
$updateAllScripts = Join-Path -Path $updateDir -ChildPath "Update-AllScripts.ps1"
$updateInitScript = Join-Path -Path $updateDir -ChildPath "Update-InitializationScript.ps1"
$initMemoryBank = Join-Path -Path $updateDir -ChildPath "Initialize-MemoryBank.ps1"

# Verify existence of update scripts
$missingScripts = @()
if (-not (Test-Path -Path $updateAllScripts)) { $missingScripts += "Update-AllScripts.ps1" }
if (-not (Test-Path -Path $updateInitScript)) { $missingScripts += "Update-InitializationScript.ps1" }
if (-not (Test-Path -Path $initMemoryBank)) { $missingScripts += "Initialize-MemoryBank.ps1" }

if ($missingScripts.Count -gt 0) {
    Write-BIGLog -Message "Missing update scripts: $($missingScripts -join ', ')" -Level "WARNING" -LogFile $logFile
    Write-Host "Warning: Some update scripts are missing from $updateDir" -ForegroundColor Yellow
    Write-Host "Missing scripts: $($missingScripts -join ', ')" -ForegroundColor Yellow
    Write-Host "Some commands may not function correctly." -ForegroundColor Yellow
    Write-Host ""
}

#-----------------------------------------------------------
# Command functions
#-----------------------------------------------------------

# Command: system - Update entire BIG BRAIN system
function Invoke-SystemUpdate {
    Write-BIGHeader -Title "UPDATING BIG BRAIN SYSTEM" -LogFile $logFile

    # Call the Update-AllScripts script
    if (Test-Path -Path $updateAllScripts) {
        Write-BIGLog -Message "Executing Update-AllScripts.ps1" -Level "INFO" -LogFile $logFile
        Write-Host "Updating all system scripts..." -ForegroundColor Cyan

        try {
            # Execute the script in a new scope with parameters if provided
            $params = @{}
            if ($Force) { $params['Force'] = $true }

            & $updateAllScripts @params

            Write-BIGLog -Message "System update completed successfully" -Level "SUCCESS" -LogFile $logFile
            Write-Host "System update completed successfully." -ForegroundColor Green
        }
        catch {
            Write-BIGLog -Message "Error executing system update: $_" -Level "ERROR" -LogFile $logFile
            Write-Host "Error executing system update: $_" -ForegroundColor Red
        }
    }
    else {
        Write-BIGLog -Message "System update script not found: $updateAllScripts" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: System update script not found: $updateAllScripts" -ForegroundColor Red
    }
}

# Command: scripts - Update initialization scripts
function Invoke-ScriptsUpdate {
    Write-BIGHeader -Title "UPDATING INITIALIZATION SCRIPTS" -LogFile $logFile

    # Call the Update-InitializationScript.ps1 script
    if (Test-Path -Path $updateInitScript) {
        Write-BIGLog -Message "Executing Update-InitializationScript.ps1" -Level "INFO" -LogFile $logFile
        Write-Host "Updating initialization scripts..." -ForegroundColor Cyan

        try {
            # Execute the script in a new scope with parameters if provided
            $params = @{}
            if ($Force) { $params['Force'] = $true }
            if ($OutputPath) { $params['OutputPath'] = $OutputPath }

            & $updateInitScript @params

            Write-BIGLog -Message "Initialization scripts update completed successfully" -Level "SUCCESS" -LogFile $logFile
            Write-Host "Initialization scripts update completed successfully." -ForegroundColor Green
        }
        catch {
            Write-BIGLog -Message "Error updating initialization scripts: $_" -Level "ERROR" -LogFile $logFile
            Write-Host "Error updating initialization scripts: $_" -ForegroundColor Red
        }
    }
    else {
        Write-BIGLog -Message "Initialization script updater not found: $updateInitScript" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Initialization script updater not found: $updateInitScript" -ForegroundColor Red
    }
}

# Command: memory - Update memory bank structure and files
function Invoke-MemoryUpdate {
    Write-BIGHeader -Title "UPDATING MEMORY BANK" -LogFile $logFile

    # Call the Initialize-MemoryBank.ps1 script to refresh the memory bank
    if (Test-Path -Path $initMemoryBank) {
        Write-BIGLog -Message "Executing Initialize-MemoryBank.ps1" -Level "INFO" -LogFile $logFile
        Write-Host "Updating memory bank structure..." -ForegroundColor Cyan

        try {
            # Execute the script in a new scope with parameters if provided
            $params = @{}
            if ($Force) { $params['Force'] = $true }

            & $initMemoryBank @params

            Write-BIGLog -Message "Memory bank update completed successfully" -Level "SUCCESS" -LogFile $logFile
            Write-Host "Memory bank update completed successfully." -ForegroundColor Green
        }
        catch {
            Write-BIGLog -Message "Error updating memory bank: $_" -Level "ERROR" -LogFile $logFile
            Write-Host "Error updating memory bank: $_" -ForegroundColor Red
        }
    }
    else {
        Write-BIGLog -Message "Memory bank initialization script not found: $initMemoryBank" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Memory bank initialization script not found: $initMemoryBank" -ForegroundColor Red
    }
}

# Command: rules - Update the rules system
function Invoke-RulesUpdate {
    Write-BIGHeader -Title "UPDATING RULES SYSTEM" -LogFile $logFile

    # Path to the BIG-Rules.ps1 script
    $rulesScript = Join-Path -Path $PSScriptRoot -ChildPath "BIG-Rules.ps1"

    if (Test-Path -Path $rulesScript) {
        Write-BIGLog -Message "Using BIG-Rules.ps1 to validate rules" -Level "INFO" -LogFile $logFile
        Write-Host "Validating memory bank rules..." -ForegroundColor Cyan

        try {
            # Validate rules first
            & $rulesScript -Command validate

            # Apply rules
            Write-Host "`nApplying memory bank rules..." -ForegroundColor Cyan
            & $rulesScript -Command apply

            Write-BIGLog -Message "Rules system update completed successfully" -Level "SUCCESS" -LogFile $logFile
            Write-Host "Rules system update completed successfully." -ForegroundColor Green
        }
        catch {
            Write-BIGLog -Message "Error updating rules system: $_" -Level "ERROR" -LogFile $logFile
            Write-Host "Error updating rules system: $_" -ForegroundColor Red
        }
    }
    else {
        Write-BIGLog -Message "Rules script not found: $rulesScript" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Rules script not found: $rulesScript" -ForegroundColor Red
    }
}

# Command: init - Initialize a new memory bank system
function Invoke-InitCommand {
    Write-BIGHeader -Title "INITIALIZING NEW MEMORY BANK" -LogFile $logFile

    # First run Update-InitializationScript.ps1 to ensure initialization scripts are up to date
    if (Test-Path -Path $updateInitScript) {
        Write-BIGLog -Message "Updating initialization scripts" -Level "INFO" -LogFile $logFile
        Write-Host "Updating initialization scripts before initializing..." -ForegroundColor Cyan

        try {
            # Execute the update script first
            $params = @{}
            if ($Force) { $params['Force'] = $true }

            & $updateInitScript @params

            # Now run the initialization script
            if (Test-Path -Path $initMemoryBank) {
                Write-BIGLog -Message "Initializing memory bank" -Level "INFO" -LogFile $logFile
                Write-Host "`nInitializing memory bank..." -ForegroundColor Cyan

                & $initMemoryBank @params

                # After initialization, update rules
                $rulesScript = Join-Path -Path $PSScriptRoot -ChildPath "BIG-Rules.ps1"
                if (Test-Path -Path $rulesScript) {
                    Write-Host "`nConfiguring memory bank rules..." -ForegroundColor Cyan
                    & $rulesScript -Command validate
                    & $rulesScript -Command apply
                }

                Write-BIGLog -Message "Memory bank initialization completed successfully" -Level "SUCCESS" -LogFile $logFile
                Write-Host "Memory bank initialization completed successfully." -ForegroundColor Green
            }
            else {
                Write-BIGLog -Message "Initialization script not found: $initMemoryBank" -Level "ERROR" -LogFile $logFile
                Write-Host "Error: Initialization script not found: $initMemoryBank" -ForegroundColor Red
            }
        }
        catch {
            Write-BIGLog -Message "Error during initialization: $_" -Level "ERROR" -LogFile $logFile
            Write-Host "Error during initialization: $_" -ForegroundColor Red
        }
    }
    else {
        Write-BIGLog -Message "Update initialization script not found: $updateInitScript" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Update initialization script not found: $updateInitScript" -ForegroundColor Red
    }
}

#-----------------------------------------------------------
# Execute the specified command
#-----------------------------------------------------------
Write-BIGHeader -Title "BIG UPDATE COMMAND: $Command" -LogFile $logFile

switch ($Command) {
    "system" {
        Invoke-SystemUpdate
    }
    "scripts" {
        Invoke-ScriptsUpdate
    }
    "memory" {
        Invoke-MemoryUpdate
    }
    "rules" {
        Invoke-RulesUpdate
    }
    "init" {
        Invoke-InitCommand
    }
    default {
        Write-BIGLog -Message "Invalid command: $Command" -Level "ERROR" -LogFile $logFile
        Write-Host "Error: Invalid command: $Command" -ForegroundColor Red
    }
}

# End logging
Stop-BIGLogging -ScriptName $MyInvocation.MyCommand.Path -LogFile $logFile