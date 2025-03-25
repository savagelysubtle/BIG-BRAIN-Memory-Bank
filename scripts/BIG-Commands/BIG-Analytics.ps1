# BIG-Analytics.ps1
# Implementation of the BIG analytics commands for the Memory Bank system
# Version 1.2.0
# Created: 2025-03-25
# Updated: 2025-03-26 - Improved error handling and compatibility with updated statistics script
# Updated: 2025-03-27 - Changed default output location to reports directory
# Updated: 2025-03-29 - Fixed parameter handling for compatibility with BIG-Autonomous

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("stats", "report", "health")]
    [string]$Command,

    [Parameter(Mandatory = $false)]
    [string]$OutputPath,

    [Parameter(Mandatory = $false)]
    [switch]$IncludeDetails,

    [Parameter(Mandatory = $false)]
    [ValidateSet("Text", "HTML", "JSON")]
    [string]$Format = "HTML",

    [Parameter(Mandatory = $false)]
    [int]$Days = 30,

    [Parameter(Mandatory = $false)]
    [int]$Threshold = 60
)

# Write startup information
Write-Host "BIG-Analytics running with command: $Command" -ForegroundColor Cyan
if ($OutputPath) { Write-Host "  Output path: $OutputPath" -ForegroundColor Cyan }
if ($Format) { Write-Host "  Format: $Format" -ForegroundColor Cyan }

# Set path to memory bank and analytics scripts
$projectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$memoryBankPath = Join-Path -Path $projectRoot -ChildPath "memory-bank"
$analyticsScriptsPath = Join-Path -Path $projectRoot -ChildPath "scripts/Analytics"
$reportsDir = Join-Path -Path $projectRoot -ChildPath "scripts/reports"

# Define default file paths
$defaultStatsPath = Join-Path -Path $reportsDir -ChildPath "memory-statistics.json"
$defaultReportPath = Join-Path -Path $reportsDir -ChildPath "memory-usage-report.$($Format.ToLower())"

# Ensure reports directory exists
if (-not (Test-Path -Path $reportsDir)) {
    New-Item -Path $reportsDir -ItemType Directory -Force | Out-Null
    Write-Host "Created reports directory: $reportsDir"
}

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

# Format health score with color
function Format-HealthScore {
    param ([double]$Score)

    # Ensure the score is treated as a number
    $scoreNumber = [math]::Round($Score, 2)

    $color = switch ($scoreNumber) {
        { $_ -ge 80 } { "Green" }
        { $_ -ge 60 } { "Cyan" }
        { $_ -ge 40 } { "Yellow" }
        { $_ -ge 20 } { "DarkYellow" }
        default { "Red" }
    }

    $rating = switch ($scoreNumber) {
        { $_ -ge 80 } { "EXCELLENT" }
        { $_ -ge 60 } { "GOOD" }
        { $_ -ge 40 } { "ADEQUATE" }
        { $_ -ge 20 } { "NEEDS IMPROVEMENT" }
        default { "CRITICAL" }
    }

    Write-Host "Health Score: " -NoNewline
    Write-Host "$scoreNumber% " -ForegroundColor $color -NoNewline
    Write-Host "($rating)" -ForegroundColor $color
}

# Display long-term memory categories
function Show-LongTermCategories {
    param ([PSObject]$Categories)

    Write-Host "    Long-Term Categories:" -ForegroundColor White
    Write-Host "      - Episodic: $($Categories.Episodic.FileCount) files" -ForegroundColor White
    Write-Host "      - Semantic: $($Categories.Semantic.FileCount) files" -ForegroundColor White
    Write-Host "      - Procedural: $($Categories.Procedural.FileCount) files" -ForegroundColor White
    Write-Host "      - Creative: $($Categories.Creative.FileCount) files" -ForegroundColor White
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

# Execute the specified command
switch ($Command) {
    "stats" {
        Write-BIGHeader "MEMORY BANK STATISTICS"

        # Set output path
        $statsOutputPath = if ($OutputPath) { $OutputPath } else { Join-Path -Path $reportsDir -ChildPath "memory-statistics.json" }

        # Run the statistics script
        Write-Host "Gathering memory bank statistics..." -ForegroundColor Yellow
        $statsScript = Join-Path -Path $analyticsScriptsPath -ChildPath "Get-MemoryBankStatistics.ps1"

        if (-not (Test-Path -Path $statsScript)) {
            Write-Host "Error: Statistics script not found at $statsScript" -ForegroundColor Red
            exit 1
        }

        $params = @{
            MemoryBankPath = $memoryBankPath
            ExportJson     = $true
            OutputPath     = $statsOutputPath
        }

        if ($IncludeDetails) {
            $params.Add("IncludeDetails", $true)
        }

        $stats = Invoke-ScriptSafely -ScriptPath $statsScript -Parameters $params

        # Display summary of results
        Write-Host ""
        Write-Host "Memory Bank Statistics Summary:" -ForegroundColor Green
        Write-Host "Total Files: $($stats.TotalFiles)" -ForegroundColor White
        Write-Host "Total Size: $($stats.TotalSize)" -ForegroundColor White
        Write-Host "Memory Types:" -ForegroundColor White
        Write-Host "  - Active: $($stats.MemoryTypes.Active.FileCount) files" -ForegroundColor White
        Write-Host "  - Short-Term: $($stats.MemoryTypes.ShortTerm.FileCount) files" -ForegroundColor White
        Write-Host "  - Long-Term: $($stats.MemoryTypes.LongTerm.FileCount) files" -ForegroundColor White

        # Display long-term categories if they exist
        if ($stats.MemoryTypes.LongTerm.FileCount -gt 0) {
            Show-LongTermCategories -Categories $stats.MemoryTypes.LongTerm.Categories
        }

        Format-HealthScore -Score $stats.ComplexityMetrics.OverallScore

        Write-Host ""
        Write-Host "Statistics saved to: $statsOutputPath" -ForegroundColor Green
    }

    "report" {
        Write-BIGHeader "MEMORY BANK USAGE REPORT"

        # Set output path
        $reportOutputPath = if ($OutputPath) { $OutputPath } else { Join-Path -Path $reportsDir -ChildPath "memory-usage-report.$($Format.ToLower())" }

        # Check if stats file exists, if not create it
        if (-not (Test-Path $defaultStatsPath)) {
            Write-Host "No existing statistics found. Generating new statistics..." -ForegroundColor Yellow
            $statsScript = Join-Path -Path $analyticsScriptsPath -ChildPath "Get-MemoryBankStatistics.ps1"

            if (-not (Test-Path -Path $statsScript)) {
                Write-Host "Error: Statistics script not found at $statsScript" -ForegroundColor Red
                exit 1
            }

            $statsParams = @{
                MemoryBankPath = $memoryBankPath
                ExportJson     = $true
                OutputPath     = $defaultStatsPath
                IncludeDetails = $true
            }

            $stats = Invoke-ScriptSafely -ScriptPath $statsScript -Parameters $statsParams
            Write-Host "Statistics generated and saved to: $defaultStatsPath" -ForegroundColor Green
        }

        # Run the report script
        Write-Host "Generating memory bank usage report..." -ForegroundColor Yellow
        $reportScript = Join-Path -Path $analyticsScriptsPath -ChildPath "Export-UsageReport.ps1"

        if (-not (Test-Path -Path $reportScript)) {
            Write-Host "Error: Report script not found at $reportScript" -ForegroundColor Red
            exit 1
        }

        $params = @{
            MemoryBankPath = $memoryBankPath
            StatisticsFile = $defaultStatsPath
            ReportFormat   = $Format
            DaysToAnalyze  = $Days
            OutputPath     = $reportOutputPath
        }

        $report = Invoke-ScriptSafely -ScriptPath $reportScript -Parameters $params

        # Display summary of results
        Write-Host ""
        Write-Host "Memory Bank Usage Report Generated:" -ForegroundColor Green
        Write-Host "Report Period: $($report.ReportPeriod)" -ForegroundColor White
        Format-HealthScore -Score $report.HealthScore.Score

        if ($report.Recommendations.Count -gt 0) {
            Write-Host ""
            Write-Host "Recommendations:" -ForegroundColor Yellow
            foreach ($recommendation in $report.Recommendations) {
                Write-Host "  - $recommendation" -ForegroundColor White
            }
        }

        Write-Host ""
        Write-Host "Report saved to: $reportOutputPath" -ForegroundColor Green

        # Open the report if it's HTML
        if ($Format -eq "HTML") {
            Write-Host "Opening HTML report..." -ForegroundColor Yellow
            try {
                Start-Process $reportOutputPath
            }
            catch {
                Write-Host "Could not open HTML report automatically. Please open it manually at: $reportOutputPath" -ForegroundColor Yellow
            }
        }
    }

    "health" {
        Write-BIGHeader "MEMORY BANK HEALTH CHECK"

        # Check if stats file exists, if not create it
        if (-not (Test-Path $defaultStatsPath)) {
            Write-Host "No existing statistics found. Generating new statistics..." -ForegroundColor Yellow
            $statsScript = Join-Path -Path $analyticsScriptsPath -ChildPath "Get-MemoryBankStatistics.ps1"

            if (-not (Test-Path -Path $statsScript)) {
                Write-Host "Error: Statistics script not found at $statsScript" -ForegroundColor Red
                exit 1
            }

            $statsParams = @{
                MemoryBankPath = $memoryBankPath
                ExportJson     = $true
                OutputPath     = $defaultStatsPath
            }

            $stats = Invoke-ScriptSafely -ScriptPath $statsScript -Parameters $statsParams
            Write-Host "Statistics generated and saved to: $defaultStatsPath" -ForegroundColor Green
        }
        else {
            # Load existing stats
            try {
                $stats = Get-Content -Path $defaultStatsPath -Raw | ConvertFrom-Json
            }
            catch {
                Write-Host "Error reading statistics file. Generating new statistics..." -ForegroundColor Yellow
                $statsScript = Join-Path -Path $analyticsScriptsPath -ChildPath "Get-MemoryBankStatistics.ps1"

                if (-not (Test-Path -Path $statsScript)) {
                    Write-Host "Error: Statistics script not found at $statsScript" -ForegroundColor Red
                    exit 1
                }

                $statsParams = @{
                    MemoryBankPath = $memoryBankPath
                    ExportJson     = $true
                    OutputPath     = $defaultStatsPath
                }

                $stats = Invoke-ScriptSafely -ScriptPath $statsScript -Parameters $statsParams
            }
        }

        # Perform health check
        $overallScore = $stats.ComplexityMetrics.OverallScore
        $status = switch ($overallScore) {
            { $_ -ge 80 } { "EXCELLENT" }
            { $_ -ge 60 } { "GOOD" }
            { $_ -ge 40 } { "ADEQUATE" }
            { $_ -ge 20 } { "NEEDS IMPROVEMENT" }
            default { "CRITICAL" }
        }

        $recommendations = @()

        # Generate recommendations based on health metrics
        if ($stats.ComplexityMetrics.MemoryDiversity -lt 0.5) {
            $recommendations += "Memory types are not balanced. Consider adding more content to underrepresented memory types."
        }

        if ($stats.ComplexityMetrics.LongTermRatio -lt 0.3) {
            $recommendations += "Long-term memory representation is low. Consider moving stable knowledge to long-term memory."
        }

        if ($stats.ComplexityMetrics.CategoryBalance -lt 0.5) {
            $recommendations += "Long-term memory categories are not balanced. Consider diversifying content across episodic, semantic, procedural, and creative categories."
        }

        if ($stats.ComplexityMetrics.ActivityScore -lt 20) {
            $recommendations += "Memory bank activity is low. Regular usage and updates are recommended."
        }

        # Display health check results
        Write-Host ""
        Format-HealthScore -Score $overallScore
        Write-Host ""

        Write-Host "Health Metrics:" -ForegroundColor White
        Write-Host "Memory Diversity: $($stats.ComplexityMetrics.MemoryDiversity)" -ForegroundColor White
        Write-Host "Long-Term Ratio: $($stats.ComplexityMetrics.LongTermRatio)" -ForegroundColor White
        Write-Host "Category Balance: $($stats.ComplexityMetrics.CategoryBalance)" -ForegroundColor White
        Write-Host "Activity Score: $($stats.ComplexityMetrics.ActivityScore)%" -ForegroundColor White

        # Display memory type counts
        Write-Host ""
        Write-Host "Memory Distribution:" -ForegroundColor White
        Write-Host "  - Active: $($stats.MemoryTypes.Active.FileCount) files" -ForegroundColor White
        Write-Host "  - Short-Term: $($stats.MemoryTypes.ShortTerm.FileCount) files" -ForegroundColor White
        Write-Host "  - Long-Term: $($stats.MemoryTypes.LongTerm.FileCount) files" -ForegroundColor White

        # Display long-term categories if they exist
        if ($stats.MemoryTypes.LongTerm.FileCount -gt 0) {
            Show-LongTermCategories -Categories $stats.MemoryTypes.LongTerm.Categories
        }

        # Display recommendations if score is below threshold
        if ($overallScore -lt $Threshold) {
            Write-Host ""
            Write-Host "ACTION REQUIRED: Memory health is below threshold of $Threshold%" -ForegroundColor Red
            Write-Host ""
            Write-Host "Recommendations:" -ForegroundColor Yellow

            if ($recommendations.Count -gt 0) {
                foreach ($recommendation in $recommendations) {
                    Write-Host "  - $recommendation" -ForegroundColor White
                }
            }
            else {
                Write-Host "  - Run a full memory report for detailed analysis: BIG analytics report" -ForegroundColor White
            }
        }
        else {
            Write-Host ""
            Write-Host "Memory health is above threshold of $Threshold%" -ForegroundColor Green
        }
    }
}

Write-Host ""