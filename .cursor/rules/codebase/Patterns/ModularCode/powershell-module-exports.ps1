# Rule: PowerShell Module Exports
# Description: Pattern for conditional function exports in PowerShell modules
# Author: BIG-BRAIN System
# Created: 2025-03-25
# Version: 1.0.0

# Define utility functions
function Get-SomeValue {
    param (
        [Parameter(Mandatory = $true)]
        [string]$InputParameter
    )

    # Function implementation
    return "Processed: $InputParameter"
}

function Set-SomeValue {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Name,

        [Parameter(Mandatory = $true)]
        [object]$Value
    )

    # Function implementation
    Write-Host "Setting $Name to $Value"
}

function New-SomeObject {
    param (
        [Parameter(Mandatory = $true)]
        [string]$Type
    )

    # Function implementation
    return [PSCustomObject]@{
        Type    = $Type
        Created = Get-Date
    }
}

# Export functions only when being imported as a module
# This prevents errors when the script is dot-sourced directly
if ($MyInvocation.MyCommand.ScriptBlock.Module) {
    Export-ModuleMember -Function Get-SomeValue, Set-SomeValue, New-SomeObject
}
else {
    Write-Verbose "Script loaded directly - functions available but not exported as module members"
}