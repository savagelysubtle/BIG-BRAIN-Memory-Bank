# Analytics Scripts

Scripts for analyzing memory bank usage, gathering statistics, and generating reports.

## Overview

The Analytics directory contains PowerShell scripts to gather statistics about the memory bank, generate usage reports, and monitor system health. These scripts can be run directly or through the BIG analytics command interface.

## Scripts

### Get-MemoryBankStatistics.ps1

Gathers comprehensive statistics about the memory bank system.

**Features:**
- Collects file counts, sizes, and modification dates across all memory types
- Categorizes files by memory type (Active, Short-Term, Long-Term)
- Calculates health metrics including Memory Diversity, Long-Term Ratio, Category Balance, and Activity Score
- Supports optional detailed file listing
- Can export results to JSON for further analysis

**Usage:**
```powershell
# Basic usage
.\Get-MemoryBankStatistics.ps1

# With detailed file listing and JSON export
.\Get-MemoryBankStatistics.ps1 -IncludeDetails -ExportJson -OutputPath "path/to/output.json"

# Specifying memory bank path
.\Get-MemoryBankStatistics.ps1 -MemoryBankPath "D:/Projects/MyProject/memory-bank"
```

### Export-UsageReport.ps1

Generates formatted reports about memory bank usage based on statistics.

**Features:**
- Creates visually appealing HTML reports with CSS styling
- Offers plain text reports for console or log viewing
- Generates structured JSON reports for integration with other tools
- Provides actionable recommendations to improve memory health
- Includes activity timeline and usage patterns

**Usage:**
```powershell
# Generate HTML report (default)
.\Export-UsageReport.ps1

# Generate text or JSON report
.\Export-UsageReport.ps1 -ReportFormat Text
.\Export-UsageReport.ps1 -ReportFormat JSON -OutputPath "path/to/report.json"

# Use existing statistics file
.\Export-UsageReport.ps1 -StatisticsFile "path/to/stats.json"

# Analyze specific time period
.\Export-UsageReport.ps1 -DaysToAnalyze 14
```

## Integration with BIG Command System

These scripts are integrated with the BIG command system through the `BIG-Analytics.ps1` script in the `scripts/BIG-Commands` directory, which implements the following commands:

```
BIG analytics stats [--include-details] [--output-path <path>]
BIG analytics report [--format <Text|HTML|JSON>] [--days <number>] [--output-path <path>]
BIG analytics health [--threshold <number>]
```

## Report Interpretation

The generated reports include several key health metrics:

1. **Memory Diversity (0-1)**: Measures balance between Active, Short-Term, and Long-Term memory. Higher values indicate better distribution.

2. **Long-Term Ratio (0-1)**: Proportion of content in long-term memory. Higher values indicate better knowledge preservation.

3. **Category Balance (0-1)**: Distribution across long-term categories (episodic, semantic, procedural, creative). Higher values indicate better organization.

4. **Activity Score (0-100%)**: Percentage of files modified in the last 7 days. Higher values indicate more active usage.

5. **Overall Score (0-100%)**: Combined health rating with status categories:
   - 80-100%: Excellent
   - 60-79%: Good
   - 40-59%: Adequate
   - 20-39%: Needs Improvement
   - 0-19%: Critical

## Report Location

HTML reports are stored in `memory-bank/active/analytics/memory-usage-report.html` by default.

Latest Report: [memory-usage-report.html](file:///D:/Coding/Python_Projects/TheMemoryBank/memory-bank/active/analytics/memory-usage-report.html)

