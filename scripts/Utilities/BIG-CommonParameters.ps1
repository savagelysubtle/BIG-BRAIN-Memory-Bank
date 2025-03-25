# BIG-CommonParameters.ps1
# Common parameter definitions for BIG command scripts
# Version 1.0.0
# Created: 2025-03-29

# This module provides standardized parameter definitions that can be used
# across the various BIG command scripts to ensure consistent behavior.

# Common Output Parameters
function Get-OutputParameters {
    return @(
        [Parameter()]
        [string]$OutputPath,

        [Parameter()]
        [ValidateSet("Text", "HTML", "JSON", "All")]
        [string]$Format = "HTML",

        [Parameter()]
        [switch]$IncludeDetails
    )
}

# Common Time Range Parameters
function Get-TimeRangeParameters {
    return @(
        [Parameter()]
        [int]$Days = 30,

        [Parameter()]
        [DateTime]$StartDate,

        [Parameter()]
        [DateTime]$EndDate
    )
}

# Common Filtering Parameters
function Get-FilterParameters {
    return @(
        [Parameter()]
        [string]$Category,

        [Parameter()]
        [string[]]$Tags,

        [Parameter()]
        [string]$SearchPattern
    )
}

# Common Health Check Parameters
function Get-HealthParameters {
    return @(
        [Parameter()]
        [int]$Threshold = 60,

        [Parameter()]
        [switch]$IncludeRecommendations,

        [Parameter()]
        [switch]$FixIssues
    )
}

# Common UI Parameters
function Get-UIParameters {
    return @(
        [Parameter()]
        [switch]$NoInteraction,

        [Parameter()]
        [ValidateSet("Minimal", "Normal", "Detailed")]
        [string]$Verbosity = "Normal",

        [Parameter()]
        [switch]$Silent
    )
}

# Helper function to apply common parameters to a script
function Apply-CommonParameters {
    param (
        [hashtable]$TargetParameters,
        [hashtable]$SourceParameters,
        [string[]]$ParamNames
    )

    foreach ($param in $ParamNames) {
        if ($SourceParameters.ContainsKey($param)) {
            $TargetParameters[$param] = $SourceParameters[$param]
        }
    }

    return $TargetParameters
}

# Helper function to validate parameters and ensure compatibility
function Test-ParameterCompatibility {
    param (
        [hashtable]$Parameters,
        [string[]]$MutuallyExclusiveParams,
        [string[]]$RequiredParams
    )

    # Check for mutually exclusive parameters
    $foundExclusiveParams = $MutuallyExclusiveParams | Where-Object { $Parameters.ContainsKey($_) -and $Parameters[$_] }
    if ($foundExclusiveParams.Count -gt 1) {
        throw "The following parameters cannot be used together: $($foundExclusiveParams -join ', ')"
    }

    # Check for required parameters
    $missingParams = $RequiredParams | Where-Object { -not $Parameters.ContainsKey($_) -or $null -eq $Parameters[$_] }
    if ($missingParams.Count -gt 0) {
        throw "The following required parameters are missing: $($missingParams -join ', ')"
    }

    return $true
}

# Export functions
Export-ModuleMember -Function Get-OutputParameters, Get-TimeRangeParameters,
Get-FilterParameters, Get-HealthParameters, Get-UIParameters,
Apply-CommonParameters, Test-ParameterCompatibility