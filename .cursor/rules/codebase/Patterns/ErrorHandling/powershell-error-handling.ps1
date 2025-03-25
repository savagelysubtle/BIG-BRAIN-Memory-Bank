# Rule: PowerShell Error Handling
# Description: Standard pattern for robust error handling in PowerShell scripts
# Author: BIG-BRAIN System
# Created: 2025-03-25
# Version: 1.0.0

# Basic error handling
try {
    # Operation code
    $result = Invoke-SomeOperation
}
catch {
    Write-Host "Error executing operation: $_" -ForegroundColor Red
    Write-Host "Details: $($_.ScriptStackTrace)" -ForegroundColor Red
    exit 1
}

# Advanced error handling with logging
function Invoke-WithErrorHandling {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true)]
        [scriptblock]$ScriptBlock,

        [Parameter(Mandatory = $false)]
        [string]$OperationName = "operation",

        [Parameter(Mandatory = $false)]
        [string]$LogFile,

        [Parameter(Mandatory = $false)]
        [switch]$ContinueOnError
    )

    try {
        # Execute the provided script block
        & $ScriptBlock
        return $true
    }
    catch {
        $errorMessage = "Error executing $OperationName: $($_.Exception.Message)"

        # Log the error if a log file is provided
        if ($LogFile) {
            Add-Content -Path $LogFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [ERROR] $errorMessage"
            Add-Content -Path $LogFile -Value "$(Get-Date -Format 'yyyy-MM-dd HH:mm:ss') [ERROR] $($_.ScriptStackTrace)"
        }

        # Display the error
        Write-Host $errorMessage -ForegroundColor Red
        Write-Host "Details: $($_.ScriptStackTrace)" -ForegroundColor Red

        # Handle the error according to the ContinueOnError parameter
        if ($ContinueOnError) {
            Write-Warning "Continuing execution despite error..."
            return $false
        }
        else {
            Write-Host "Terminating execution due to error." -ForegroundColor Red
            exit 1
        }
    }
}