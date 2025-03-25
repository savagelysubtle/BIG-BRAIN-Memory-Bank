# Export-UsageReport.ps1
# Script to generate a usage report for the memory bank, showing access patterns and common operations.
# Version 1.1.0
# Created: 2025-03-25
# Updated: 2025-03-27 - Updated default output path to use reports directory
# Author: BIG BRAIN

[CmdletBinding()]
param (
  [Parameter(Mandatory = $false)]
  [string]$MemoryBankPath = (Join-Path -Path $PSScriptRoot -ChildPath "../../memory-bank"),

  [Parameter(Mandatory = $false)]
  [string]$StatisticsFile,

  [Parameter(Mandatory = $false)]
  [ValidateSet("Text", "HTML", "JSON")]
  [string]$ReportFormat = "HTML",

  [Parameter(Mandatory = $false)]
  [int]$DaysToAnalyze = 30,

  [Parameter(Mandatory = $false)]
  [string]$OutputPath = (Join-Path -Path $PSScriptRoot -ChildPath "../reports/memory-usage-report.$($ReportFormat.ToLower())")
)

# Import statistics if provided, otherwise generate new ones
if ($StatisticsFile -and (Test-Path $StatisticsFile)) {
  Write-Host "Loading memory bank statistics from $StatisticsFile..."
  $statistics = Get-Content -Path $StatisticsFile -Raw | ConvertFrom-Json
}
else {
  Write-Host "Generating fresh memory bank statistics..."
  $scriptPath = Join-Path -Path $PSScriptRoot -ChildPath "Get-MemoryBankStatistics.ps1"
  $statistics = & $scriptPath -MemoryBankPath $MemoryBankPath -IncludeDetails
}

# Create directory if it doesn't exist
$outputDir = Split-Path -Path $OutputPath -Parent
if (-not (Test-Path -Path $outputDir)) {
  New-Item -Path $outputDir -ItemType Directory -Force | Out-Null
  Write-Host "Created output directory: $outputDir"
}

# Calculate usage patterns
$usagePatterns = @{
  MemoryTypeUsage      = @{
    Active    = $statistics.MemoryTypes.Active.FileCount
    ShortTerm = $statistics.MemoryTypes.ShortTerm.FileCount
    LongTerm  = $statistics.MemoryTypes.LongTerm.FileCount
  }
  FileTypeDistribution = @{
    Markdown = $statistics.FileTypes.Markdown.FileCount
    JSON     = $statistics.FileTypes.JSON.FileCount
    YAML     = $statistics.FileTypes.YAML.FileCount
    Other    = $statistics.FileTypes.Other.FileCount
  }
  ActivityTrends       = @{
    Last24Hours = $statistics.Activity.Last24Hours.FileCount
    Last7Days   = $statistics.Activity.Last7Days.FileCount
    Last30Days  = $statistics.Activity.Last30Days.FileCount
  }
  HealthMetrics        = @{
    MemoryDiversity = $statistics.ComplexityMetrics.MemoryDiversity
    LongTermRatio   = $statistics.ComplexityMetrics.LongTermRatio
    CategoryBalance = $statistics.ComplexityMetrics.CategoryBalance
    ActivityScore   = $statistics.ComplexityMetrics.ActivityScore
    OverallScore    = $statistics.ComplexityMetrics.OverallScore
  }
}

# Generate file activity timeline if details are available
$fileTimeline = @()
if ($statistics.PSObject.Properties.Name -contains "DetailedFileList") {
  # Get files modified in the last N days
  $cutoffDate = (Get-Date).AddDays(-$DaysToAnalyze)
  $recentFiles = $statistics.DetailedFileList | Where-Object { [DateTime]$_.LastModified -gt $cutoffDate }

  # Group by day
  $fileTimeline = $recentFiles | Group-Object { ([DateTime]$_.LastModified).Date } | ForEach-Object {
    [PSCustomObject]@{
      Date  = $_.Name
      Count = $_.Count
      Files = $_.Group | ForEach-Object { $_.Path }
    }
  } | Sort-Object Date
}

# Generate recommendations based on statistics
$recommendations = @()

# Check memory diversity
if ($statistics.ComplexityMetrics.MemoryDiversity -lt 0.5) {
  $recommendations += "Memory types are not balanced. Consider adding more content to underrepresented memory types."
}

# Check long-term memory ratio
if ($statistics.ComplexityMetrics.LongTermRatio -lt 0.3) {
  $recommendations += "Long-term memory representation is low. Consider moving stable knowledge to long-term memory."
}

# Check category balance
if ($statistics.ComplexityMetrics.CategoryBalance -lt 0.5) {
  $recommendations += "Long-term memory categories are not balanced. Consider diversifying content across episodic, semantic, procedural, and creative categories."
}

# Check activity score
if ($statistics.ComplexityMetrics.ActivityScore -lt 20) {
  $recommendations += "Memory bank activity is low. Regular usage and updates are recommended to maintain system health."
}

# Create report object
$report = [PSCustomObject]@{
  GeneratedAt       = Get-Date
  MemoryBankPath    = $statistics.MemoryBankPath
  ReportPeriod      = "$DaysToAnalyze days ($(Get-Date).AddDays(-$DaysToAnalyze) to $(Get-Date))"
  OverallStatistics = [PSCustomObject]@{
    TotalFiles      = $statistics.TotalFiles
    TotalSize       = $statistics.TotalSize
    AverageFileSize = $statistics.AverageFileSize
    NewestFile      = $statistics.NewestFile.Path
    OldestFile      = $statistics.OldestFile.Path
  }
  UsagePatterns     = $usagePatterns
  ActivityTimeline  = $fileTimeline
  Recommendations   = $recommendations
  HealthScore       = [PSCustomObject]@{
    Score  = $statistics.ComplexityMetrics.OverallScore
    Rating = switch ($statistics.ComplexityMetrics.OverallScore) {
      { $_ -ge 80 } { "Excellent" }
      { $_ -ge 60 } { "Good" }
      { $_ -ge 40 } { "Adequate" }
      { $_ -ge 20 } { "Needs Improvement" }
      default { "Critical" }
    }
  }
}

# Generate report based on format
switch ($ReportFormat) {
  "Text" {
    $textReport = @"
MEMORY BANK USAGE REPORT
------------------------
Generated: $($report.GeneratedAt)
Period: $($report.ReportPeriod)

OVERALL STATISTICS
-----------------
Total Files: $($report.OverallStatistics.TotalFiles)
Total Size: $($report.OverallStatistics.TotalSize)
Average File Size: $($report.OverallStatistics.AverageFileSize)
Newest File: $($report.OverallStatistics.NewestFile)
Oldest File: $($report.OverallStatistics.OldestFile)

USAGE PATTERNS
-------------
Memory Type Usage:
  Active: $($report.UsagePatterns.MemoryTypeUsage.Active) files
  Short-Term: $($report.UsagePatterns.MemoryTypeUsage.ShortTerm) files
  Long-Term: $($report.UsagePatterns.MemoryTypeUsage.LongTerm) files

File Type Distribution:
  Markdown: $($report.UsagePatterns.FileTypeDistribution.Markdown) files
  JSON: $($report.UsagePatterns.FileTypeDistribution.JSON) files
  YAML: $($report.UsagePatterns.FileTypeDistribution.YAML) files
  Other: $($report.UsagePatterns.FileTypeDistribution.Other) files

Activity Trends:
  Last 24 Hours: $($report.UsagePatterns.ActivityTrends.Last24Hours) files modified
  Last 7 Days: $($report.UsagePatterns.ActivityTrends.Last7Days) files modified
  Last 30 Days: $($report.UsagePatterns.ActivityTrends.Last30Days) files modified

HEALTH ASSESSMENT
----------------
Overall Health Score: $($report.HealthScore.Score)% ($($report.HealthScore.Rating))
Memory Diversity: $($report.UsagePatterns.HealthMetrics.MemoryDiversity)
Long-Term Ratio: $($report.UsagePatterns.HealthMetrics.LongTermRatio)
Category Balance: $($report.UsagePatterns.HealthMetrics.CategoryBalance)
Activity Score: $($report.UsagePatterns.HealthMetrics.ActivityScore)

RECOMMENDATIONS
--------------
$(if ($report.Recommendations.Count -eq 0) { "No recommendations at this time." } else { $report.Recommendations | ForEach-Object { "- $_" } | Out-String })
"@
    $textReport | Out-File -FilePath $OutputPath -Force
    Write-Host "Text report generated at: $OutputPath"
  }

  "HTML" {
    $activityTimelineHtml = ""
    if ($fileTimeline.Count -gt 0) {
      $activityTimelineHtml = @"
<h3>Activity Timeline</h3>
<table border="1" cellpadding="5" cellspacing="0">
  <tr>
    <th>Date</th>
    <th>Files Modified</th>
  </tr>
$($fileTimeline | ForEach-Object {
  "<tr><td>$($_.Date)</td><td>$($_.Count)</td></tr>"
})
</table>
"@
    }

    $recommendationsHtml = ""
    if ($report.Recommendations.Count -gt 0) {
      $recommendationsHtml = @"
<h2>Recommendations</h2>
<ul>
$($report.Recommendations | ForEach-Object { "<li>$_</li>" })
</ul>
"@
    }
    else {
      $recommendationsHtml = "<h2>Recommendations</h2><p>No recommendations at this time.</p>"
    }

    $healthColorClass = switch ($report.HealthScore.Rating) {
      "Excellent" { "excellent" }
      "Good" { "good" }
      "Adequate" { "adequate" }
      "Needs Improvement" { "needs-improvement" }
      default { "critical" }
    }

    $htmlReport = @"
<!DOCTYPE html>
<html>
<head>
  <title>Memory Bank Usage Report</title>
  <style>
    body { font-family: Arial, sans-serif; line-height: 1.6; margin: 0; padding: 20px; color: #333; }
    h1 { color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 10px; }
    h2 { color: #2c3e50; margin-top: 30px; }
    h3 { color: #2c3e50; }
    table { border-collapse: collapse; width: 100%; margin-bottom: 20px; }
    th { background-color: #3498db; color: white; text-align: left; }
    tr:nth-child(even) { background-color: #f2f2f2; }
    .container { max-width: 1200px; margin: 0 auto; }
    .summary-card { background-color: #f9f9f9; border-radius: 5px; padding: 15px; margin-bottom: 20px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
    .stat-container { display: flex; flex-wrap: wrap; justify-content: space-between; }
    .stat-box { flex-basis: 48%; background-color: white; border-radius: 5px; padding: 15px; margin-bottom: 15px; box-shadow: 0 1px 3px rgba(0,0,0,0.1); }
    .health-score { font-size: 24px; font-weight: bold; text-align: center; padding: 20px; margin: 20px 0; border-radius: 5px; }
    .excellent { background-color: #27ae60; color: white; }
    .good { background-color: #2ecc71; color: white; }
    .adequate { background-color: #f39c12; color: white; }
    .needs-improvement { background-color: #e67e22; color: white; }
    .critical { background-color: #e74c3c; color: white; }
    .recommendations { background-color: #f8f9fa; padding: 15px; border-left: 4px solid #3498db; }
  </style>
</head>
<body>
  <div class="container">
    <h1>Memory Bank Usage Report</h1>
    <p><strong>Generated:</strong> $($report.GeneratedAt)</p>
    <p><strong>Period Analyzed:</strong> $($report.ReportPeriod)</p>

    <div class="summary-card">
      <h2>Overall Statistics</h2>
      <p><strong>Total Files:</strong> $($report.OverallStatistics.TotalFiles)</p>
      <p><strong>Total Size:</strong> $($report.OverallStatistics.TotalSize)</p>
      <p><strong>Average File Size:</strong> $($report.OverallStatistics.AverageFileSize)</p>
      <p><strong>Newest File:</strong> $($report.OverallStatistics.NewestFile)</p>
      <p><strong>Oldest File:</strong> $($report.OverallStatistics.OldestFile)</p>
    </div>

    <h2>Usage Patterns</h2>
    <div class="stat-container">
      <div class="stat-box">
        <h3>Memory Type Distribution</h3>
        <table border="1" cellpadding="5" cellspacing="0">
          <tr><th>Memory Type</th><th>File Count</th></tr>
          <tr><td>Active</td><td>$($report.UsagePatterns.MemoryTypeUsage.Active)</td></tr>
          <tr><td>Short-Term</td><td>$($report.UsagePatterns.MemoryTypeUsage.ShortTerm)</td></tr>
          <tr><td>Long-Term</td><td>$($report.UsagePatterns.MemoryTypeUsage.LongTerm)</td></tr>
        </table>
      </div>
      <div class="stat-box">
        <h3>File Type Distribution</h3>
        <table border="1" cellpadding="5" cellspacing="0">
          <tr><th>File Type</th><th>File Count</th></tr>
          <tr><td>Markdown</td><td>$($report.UsagePatterns.FileTypeDistribution.Markdown)</td></tr>
          <tr><td>JSON</td><td>$($report.UsagePatterns.FileTypeDistribution.JSON)</td></tr>
          <tr><td>YAML</td><td>$($report.UsagePatterns.FileTypeDistribution.YAML)</td></tr>
          <tr><td>Other</td><td>$($report.UsagePatterns.FileTypeDistribution.Other)</td></tr>
        </table>
      </div>
    </div>

    <div class="stat-container">
      <div class="stat-box">
        <h3>Activity Trends</h3>
        <table border="1" cellpadding="5" cellspacing="0">
          <tr><th>Period</th><th>Files Modified</th></tr>
          <tr><td>Last 24 Hours</td><td>$($report.UsagePatterns.ActivityTrends.Last24Hours)</td></tr>
          <tr><td>Last 7 Days</td><td>$($report.UsagePatterns.ActivityTrends.Last7Days)</td></tr>
          <tr><td>Last 30 Days</td><td>$($report.UsagePatterns.ActivityTrends.Last30Days)</td></tr>
        </table>
      </div>
      <div class="stat-box">
        <h3>Health Metrics</h3>
        <table border="1" cellpadding="5" cellspacing="0">
          <tr><th>Metric</th><th>Score</th></tr>
          <tr><td>Memory Diversity</td><td>$($report.UsagePatterns.HealthMetrics.MemoryDiversity)</td></tr>
          <tr><td>Long-Term Ratio</td><td>$($report.UsagePatterns.HealthMetrics.LongTermRatio)</td></tr>
          <tr><td>Category Balance</td><td>$($report.UsagePatterns.HealthMetrics.CategoryBalance)</td></tr>
          <tr><td>Activity Score</td><td>$($report.UsagePatterns.HealthMetrics.ActivityScore)%</td></tr>
        </table>
      </div>
    </div>

    $activityTimelineHtml

    <div class="health-score $healthColorClass">
      Overall Health Score: $($report.HealthScore.Score)% ($($report.HealthScore.Rating))
    </div>

    <div class="recommendations">
      $recommendationsHtml
    </div>

    <p><em>Report generated by BIG memory system.</em></p>
  </div>
</body>
</html>
"@
    $htmlReport | Out-File -FilePath $OutputPath -Force
    Write-Host "HTML report generated at: $OutputPath"
  }

  "JSON" {
    $report | ConvertTo-Json -Depth 10 | Out-File -FilePath $OutputPath -Force
    Write-Host "JSON report generated at: $OutputPath"
  }
}

# Return the report object
return $report
