# Memory Analytics Feature

## Overview

The Memory Analytics feature provides comprehensive monitoring and analysis of the BIG BRAIN Memory Bank system's health and usage patterns. This feature helps users maintain a well-organized memory structure and identify areas for improvement.

## Key Components

### Statistics Gathering

- **Get-MemoryBankStatistics.ps1**: PowerShell script that collects statistics about the memory bank
  - Tracks file counts and sizes across memory types
  - Records modification dates and activity metrics
  - Calculates health metrics and complexity scores
  - Supports detailed file listing for in-depth analysis
  - Exports data to JSON format

### Reporting System

- **Export-UsageReport.ps1**: PowerShell script that generates formatted reports
  - Creates HTML reports with visualizations
  - Offers text reports for console output
  - Provides JSON reports for system integration
  - Includes timestamps and period analysis
  - Generates actionable recommendations

### Health Metrics

Five key metrics are calculated to assess memory bank health:

1. **Memory Diversity (0-1)**: Measures balance between Active, Short-Term, and Long-Term memory
2. **Long-Term Ratio (0-1)**: Proportion of content in long-term memory
3. **Category Balance (0-1)**: Distribution across long-term categories (episodic, semantic, procedural, creative)
4. **Activity Score (0-100%)**: Percentage of files modified in the last 7 days
5. **Overall Score (0-100%)**: Combined health rating with status categories:
   - 80-100%: Excellent
   - 60-79%: Good
   - 40-59%: Adequate
   - 20-39%: Needs Improvement
   - 0-19%: Critical

### Command Integration

The feature integrates with the BIG command system through:

- **BIG-Analytics.ps1**: Command script implementing the analytics commands:
  - `BIG analytics stats [--include-details] [--output-path <path>]`
  - `BIG analytics report [--format <Text|HTML|JSON>] [--days <number>] [--output-path <path>]`
  - `BIG analytics health [--threshold <number>]`

### Storage Structure

Analytics data is stored in standardized locations:

- Statistics: `memory-bank/active/memory-statistics.json`
- Reports: `memory-bank/active/analytics/memory-usage-report.<format>`

## Integration Points

### Bedtime Protocol Integration

The analytics feature is integrated with the Bedtime Protocol workflow:

1. First step in Bedtime Protocol is running analytics
2. Health metrics are included in session summaries
3. Recommendations inform memory organization during archival
4. Reports are stored as part of the preservation process

### Long-Term Memory Management

Analytics assist with long-term memory management:

- Identifies content suitable for long-term storage
- Highlights imbalances in category distribution
- Recommends reorganization to improve health metrics
- Provides historical data on memory evolution

### Memory Diagnostics

The feature supports memory diagnostics by:

- Providing quantitative metrics for system health
- Identifying specific areas for improvement
- Tracking changes in health over time
- Offering targeted recommendations

## Usage Patterns

### Regular Health Checks

Recommended usage pattern for regular health monitoring:

```
BIG analytics health --threshold 60
```

This performs a quick health check and alerts if the score falls below 60%.

### Weekly Full Report

Recommended pattern for periodic comprehensive analysis:

```
BIG analytics report --format HTML
```

This generates a full HTML report with visualizations and recommendations.

### Pre-Bedtime Analysis

Pattern for use immediately before the Bedtime Protocol:

```
BIG analytics stats --include-details
BIG analytics report --format HTML
BIG analytics health --threshold 60
```

## Version History

- 1.0.0: Initial feature documentation (2025-03-25)