# Rule: PowerShell Parameter Handling
# Description: Standard pattern for PowerShell scripts with robust parameter handling
# Author: BIG-BRAIN System
# Created: 2025-03-25
# Version: 1.0.0

# Example of best practice parameter handling for PowerShell scripts
[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("validValue1", "validValue2")]
    [string]$RequiredParameter,

    [Parameter(Mandatory = $false)]
    [string]$OptionalParameter,

    [Parameter(Mandatory = $false)]
    [switch]$TestMode,

    [Parameter(Mandatory = $false)]
    [switch]$NoOutput
)

# Initialize with debug output
if (-not $NoOutput) {
    Write-Host "Script starting with parameters:" -ForegroundColor Cyan
    Write-Host "  Required: $RequiredParameter" -ForegroundColor Cyan
    if ($OptionalParameter) { Write-Host "  Optional: $OptionalParameter" -ForegroundColor Cyan }
    if ($TestMode) { Write-Host "  Running in TEST MODE" -ForegroundColor Magenta }
}

# Script body goes here

# Always use robust error handling
try {
    # Operation code
}
catch {
    Write-Host "Error executing operation: $_" -ForegroundColor Red
    Write-Host "Details: $($_.ScriptStackTrace)" -ForegroundColor Red
    exit 1
}

# End with status message
if (-not $NoOutput) {
    Write-Host "Script completed successfully!" -ForegroundColor Green
}