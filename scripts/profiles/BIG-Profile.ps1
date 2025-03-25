# BIG-Profile.ps1
# PowerShell profile with BIG command aliases
# Version 1.0.0
# Created: 2025-03-29

# This file should be sourced from your PowerShell profile or added to:
# $PROFILE.CurrentUserAllHosts

# Define the path to the BIG script directory
$bigRoot = Join-Path -Path $PSScriptRoot -ChildPath ".."
$bigWrapper = Join-Path -Path $bigRoot -ChildPath "BIG-Commands/BIG-Wrapper.ps1"

# Create a function to run BIG commands
function Invoke-BIG {
    param (
        [Parameter(Position = 0, ValueFromRemainingArguments = $true)]
        [string[]]$Arguments
    )

    & $bigWrapper @Arguments
}

# Add aliases for common BIG operations
Set-Alias -Name big -Value Invoke-BIG
Set-Alias -Name mb -Value Invoke-BIG
Set-Alias -Name brain -Value Invoke-BIG

# Create shortcuts for common commands
function Start-BIGDay { & $bigWrapper start @args }
function Get-BIGHealth { & $bigWrapper health @args }
function Get-BIGStats { & $bigWrapper stats @args }
function Start-BIGBedtime { & $bigWrapper bedtime @args }
function Complete-BIGBedtime { & $bigWrapper sleep @args }
function Start-BIGUpdate { & $bigWrapper update @args }

# Export the functions and aliases
Export-ModuleMember -Function Invoke-BIG, Start-BIGDay, Get-BIGHealth, Get-BIGStats, Start-BIGBedtime, Complete-BIGBedtime, Start-BIGUpdate
Export-ModuleMember -Alias big, mb, brain

# Add tab completion for BIG commands
Register-ArgumentCompleter -CommandName Invoke-BIG, big, mb, brain -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    # Define the list of valid commands
    $validCommands = @(
        "start", "today", "daily",
        "status", "health", "stats", "report",
        "organize", "cleanup", "categorize",
        "bedtime", "sleep", "summary",
        "rules", "add-rule", "apply-rules",
        "update", "refresh",
        "weekly", "monthly", "full",
        "help", "?"
    )

    # Return matching commands
    $validCommands | Where-Object { $_ -like "$wordToComplete*" } | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

# Display a welcome message when the profile is loaded
Write-Host "BIG Memory Bank System commands loaded. Type 'big help' for available commands." -ForegroundColor Cyan