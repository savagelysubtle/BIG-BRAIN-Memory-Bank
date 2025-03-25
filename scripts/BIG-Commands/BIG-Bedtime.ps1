# BIG-Bedtime.ps1
# Implementation of the BIG bedtime protocol commands for the Memory Bank system
# Version 1.0.0
# Created: 2025-03-27

param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("start", "create-summary", "analyze", "transition", "complete")]
    [string]$Command,

    [Parameter(Mandatory = $false)]
    [string]$OutputPath,

    [Parameter(Mandatory = $false)]
    [string]$SessionName,

    [Parameter(Mandatory = $false)]
    [int]$Days = 1,

    [Parameter(Mandatory = $false)]
    [switch]$IncludeHealth,

    [Parameter(Mandatory = $false)]
    [switch]$SkipConfirmation
)

# Set path to memory bank and bedtime scripts
$projectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$memoryBankPath = Join-Path -Path $projectRoot -ChildPath "memory-bank"
$bedtimeScriptsPath = Join-Path -Path $projectRoot -ChildPath "scripts/Bedtime"
$reportsDir = Join-Path -Path $projectRoot -ChildPath "scripts/reports"

# Create a nice header for the command output
function Write-BIGHeader {
    param([string]$Title)

    $width = 60
    $padding = [math]::Max(0, ($width - $Title.Length - 10) / 2)
    $leftPad = [math]::Floor($padding)
    $rightPad = [math]::Ceiling($padding)

    Write-Host ""
    Write-Host ("=" * $width) -ForegroundColor Cyan
    Write-Host ("#" * $leftPad) -ForegroundColor Cyan -NoNewline
    Write-Host "  $Title  " -ForegroundColor Yellow -NoNewline
    Write-Host ("#" * $rightPad) -ForegroundColor Cyan
    Write-Host ("=" * $width) -ForegroundColor Cyan
    Write-Host ""
}

# Handle script errors gracefully
function Invoke-ScriptSafely {
    param (
        [string]$ScriptPath,
        [hashtable]$Parameters
    )

    try {
        & $ScriptPath @Parameters
    }
    catch {
        Write-Host "Error executing $ScriptPath" -ForegroundColor Red
        Write-Host "Error details: $_" -ForegroundColor Red
        Write-Host "Parameters: $($Parameters | ConvertTo-Json -Depth 1)" -ForegroundColor Red
        Write-Host ""
        Write-Host "Please check that the script exists and has been properly updated." -ForegroundColor Yellow
        exit 1
    }
}

# Get date suffix for files
function Get-DateSuffix {
    return (Get-Date -Format "yyyy-MM-dd")
}

# Execute the specified command
switch ($Command) {
    "start" {
        Write-BIGHeader "BEDTIME PROTOCOL - START"

        # Default session name if not provided
        if (-not $SessionName) {
            $SessionName = "session-$(Get-DateSuffix)"
        }

        Write-Host "Starting bedtime protocol for session: $SessionName" -ForegroundColor Yellow

        # Create session tracking file
        $sessionFile = Join-Path -Path $memoryBankPath -ChildPath "active/sessions/$SessionName.md"
        $sessionDir = Split-Path -Parent $sessionFile

        if (-not (Test-Path -Path $sessionDir)) {
            New-Item -Path $sessionDir -ItemType Directory -Force | Out-Null
            Write-Host "Created sessions directory: $sessionDir" -ForegroundColor Green
        }

        $sessionContent = @"
# Session: $SessionName
Date: $(Get-Date -Format "yyyy-MM-dd")
Time: $(Get-Date -Format "HH:mm:ss")

## Session Overview

*This is an automatically generated session file for the bedtime protocol.*

## Session Goals

-

## Key Activities

-

## Decisions Made

-

## Next Steps

-
"@

        $sessionContent | Out-File -FilePath $sessionFile -Force
        Write-Host "Created session file: $sessionFile" -ForegroundColor Green

        # Run initial health check
        $analyticsCommand = Join-Path -Path $projectRoot -ChildPath "scripts/BIG-Commands/BIG-Analytics.ps1"
        if (Test-Path -Path $analyticsCommand) {
            Write-Host ""
            Write-Host "Performing initial health check..." -ForegroundColor Yellow
            & $analyticsCommand -Command health

            # Generate statistics file
            & $analyticsCommand -Command stats
        }

        Write-Host ""
        Write-Host "Bedtime Protocol Started!" -ForegroundColor Green
        Write-Host "Use 'BIG-Bedtime.ps1 -Command create-summary' to create a session summary." -ForegroundColor Yellow
    }

    "create-summary" {
        Write-BIGHeader "BEDTIME PROTOCOL - SUMMARY CREATION"

        # Default session name if not provided
        if (-not $SessionName) {
            $SessionName = "summary-$(Get-DateSuffix)"
        }

        # Default output path if not provided
        if (-not $OutputPath) {
            $OutputPath = Join-Path -Path $memoryBankPath -ChildPath "active/summaries/$SessionName.md"
        }

        $outputDir = Split-Path -Parent $OutputPath
        if (-not (Test-Path -Path $outputDir)) {
            New-Item -Path $outputDir -ItemType Directory -Force | Out-Null
            Write-Host "Created summaries directory: $outputDir" -ForegroundColor Green
        }

        Write-Host "Generating session summary..." -ForegroundColor Yellow

        # Get recent statistics
        $statsScript = Join-Path -Path $projectRoot -ChildPath "scripts/Analytics/Get-MemoryBankStatistics.ps1"
        if (Test-Path -Path $statsScript) {
            $stats = & $statsScript -MemoryBankPath $memoryBankPath
        }

        # Get recent activity
        $recentFiles = Get-ChildItem -Path $memoryBankPath -Recurse -File |
        Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-$Days) } |
        Sort-Object LastWriteTime -Descending

        # Generate summary content
        $summaryContent = @"
# Session Summary: $SessionName
Date: $(Get-Date -Format "yyyy-MM-dd")
Time: $(Get-Date -Format "HH:mm:ss")

## Overview

*This is an automatically generated summary for the bedtime protocol.*

## Session Activities

Recent files modified:

$(foreach ($file in $recentFiles | Select-Object -First 10) {
    "- $($file.Name) ($(Split-Path -Parent $file.FullName | Split-Path -Leaf))"
})

## Memory Health

"@

        # Add health metrics if requested
        if ($IncludeHealth -and $stats) {
            $summaryContent += @"
Memory Metrics:
- Total Files: $($stats.TotalFiles)
- Memory Diversity: $($stats.ComplexityMetrics.MemoryDiversity)
- Long-Term Ratio: $($stats.ComplexityMetrics.LongTermRatio)
- Category Balance: $($stats.ComplexityMetrics.CategoryBalance)
- Activity Score: $($stats.ComplexityMetrics.ActivityScore)%
- Overall Health: $($stats.ComplexityMetrics.OverallScore)%

"@
        }

        # Add additional sections
        $summaryContent += @"
## Key Learnings

-

## Decisions Made

-

## Next Steps

-

## Notes

-
"@

        $summaryContent | Out-File -FilePath $OutputPath -Force
        Write-Host "Summary created at: $OutputPath" -ForegroundColor Green

        # Open the file for editing
        try {
            Start-Process $OutputPath
        }
        catch {
            Write-Host "Could not open summary file automatically. Please open it manually at: $OutputPath" -ForegroundColor Yellow
        }
    }

    "analyze" {
        Write-BIGHeader "BEDTIME PROTOCOL - MEMORY ANALYSIS"

        Write-Host "Analyzing memory bank health and activity..." -ForegroundColor Yellow

        # Run health check and generate reports
        $analyticsCommand = Join-Path -Path $projectRoot -ChildPath "scripts/BIG-Commands/BIG-Analytics.ps1"
        if (Test-Path -Path $analyticsCommand) {
            # Generate health report
            & $analyticsCommand -Command health

            # Generate statistics
            & $analyticsCommand -Command stats -IncludeDetails

            # Generate usage report
            & $analyticsCommand -Command report -Format HTML -Days $Days
        }
        else {
            Write-Host "Error: Analytics command not found at $analyticsCommand" -ForegroundColor Red
            exit 1
        }

        Write-Host ""
        Write-Host "Memory analysis complete!" -ForegroundColor Green
        Write-Host "Use 'BIG-Bedtime.ps1 -Command transition' to prepare for memory transition." -ForegroundColor Yellow
    }

    "transition" {
        Write-BIGHeader "BEDTIME PROTOCOL - MEMORY TRANSITION"

        Write-Host "Preparing for memory transition..." -ForegroundColor Yellow

        # Run the transition script
        $transitionScript = Join-Path -Path $bedtimeScriptsPath -ChildPath "Prepare-SessionTransition.ps1"
        if (-not (Test-Path -Path $transitionScript)) {
            Write-Host "Error: Transition script not found at $transitionScript" -ForegroundColor Red
            exit 1
        }

        $params = @{
            MemoryBankPath = $memoryBankPath
        }

        if ($SkipConfirmation) {
            $params.Add("Force", $true)
        }

        Invoke-ScriptSafely -ScriptPath $transitionScript -Parameters $params

        # Run organization to ensure proper memory placement
        $organizationCommand = Join-Path -Path $projectRoot -ChildPath "scripts/BIG-Commands/BIG-Organization.ps1"
        if (Test-Path -Path $organizationCommand) {
            Write-Host ""
            Write-Host "Organizing memory content..." -ForegroundColor Yellow
            & $organizationCommand -Command reorganize
        }

        Write-Host ""
        Write-Host "Memory transition preparation complete!" -ForegroundColor Green
        Write-Host "Use 'BIG-Bedtime.ps1 -Command complete' to finalize the bedtime protocol." -ForegroundColor Yellow
    }

    "complete" {
        Write-BIGHeader "BEDTIME PROTOCOL - COMPLETION"

        Write-Host "Finalizing bedtime protocol..." -ForegroundColor Yellow

        # Run the bedtime protocol script
        $bedtimeScript = Join-Path -Path $bedtimeScriptsPath -ChildPath "Invoke-BedtimeProtocol.ps1"
        if (-not (Test-Path -Path $bedtimeScript)) {
            Write-Host "Error: Bedtime protocol script not found at $bedtimeScript" -ForegroundColor Red
            exit 1
        }

        $params = @{
            MemoryBankPath = $memoryBankPath
        }

        if ($SkipConfirmation) {
            $params.Add("Force", $true)
        }

        Invoke-ScriptSafely -ScriptPath $bedtimeScript -Parameters $params

        # Run final health check
        $analyticsCommand = Join-Path -Path $projectRoot -ChildPath "scripts/BIG-Commands/BIG-Analytics.ps1"
        if (Test-Path -Path $analyticsCommand) {
            Write-Host ""
            Write-Host "Performing final health check..." -ForegroundColor Yellow
            & $analyticsCommand -Command health
        }

        Write-Host ""
        Write-Host "Bedtime Protocol Completed Successfully!" -ForegroundColor Green
        Write-Host "The memory bank is now ready for the next session." -ForegroundColor Yellow
    }
}

Write-Host ""