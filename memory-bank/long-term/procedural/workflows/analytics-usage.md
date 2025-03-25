# Memory Bank Analytics Usage Guide

## Overview

This document provides step-by-step instructions for using the Memory Bank Analytics features to monitor and improve the health of your memory system. The analytics tools help track memory organization, identify issues, and provide recommendations for optimization.

## Prerequisites

- PowerShell 5.1 or higher
- BIG BRAIN Memory Bank system
- Appropriate permissions to read and write to the memory-bank directory

## Basic Commands

### Generating Memory Statistics

```powershell
# Basic statistics generation
Get-MemoryBankStatistics -MemoryBankPath "path/to/memory-bank"

# With detailed file listings
Get-MemoryBankStatistics -MemoryBankPath "path/to/memory-bank" -IncludeDetails

# Export to JSON file
Get-MemoryBankStatistics -MemoryBankPath "path/to/memory-bank" -ExportJson -OutputPath "path/to/output.json"
```

### Creating Usage Reports

```powershell
# Generate HTML report
Export-UsageReport -MemoryBankPath "path/to/memory-bank" -Format HTML -OutputPath "path/to/report.html"

# Generate text report
Export-UsageReport -MemoryBankPath "path/to/memory-bank" -Format Text

# Generate JSON report
Export-UsageReport -MemoryBankPath "path/to/memory-bank" -Format JSON -OutputPath "path/to/report.json"

# Specify days to analyze
Export-UsageReport -MemoryBankPath "path/to/memory-bank" -Format HTML -Days 30
```

### Using the BIG Analytics Command

```powershell
# Generate statistics
BIG-Analytics.ps1 -Command stats

# Generate statistics with details
BIG-Analytics.ps1 -Command stats -IncludeDetails

# Generate report
BIG-Analytics.ps1 -Command report -Format HTML

# Check health with threshold
BIG-Analytics.ps1 -Command health -Threshold 60
```

## Common Workflows

### Regular Health Monitoring

1. Open PowerShell in your Memory Bank directory
2. Run the health check command:
   ```powershell
   BIG-Analytics.ps1 -Command health -Threshold 60
   ```
3. If the health score is below the threshold, proceed to the detailed analysis

### Detailed Analysis

1. Generate detailed statistics:
   ```powershell
   BIG-Analytics.ps1 -Command stats -IncludeDetails
   ```
2. Review the output to identify specific issues
3. Generate a full HTML report for visualization:
   ```powershell
   BIG-Analytics.ps1 -Command report -Format HTML
   ```
4. Open the generated HTML report in your browser
5. Review the recommendations section for specific actions

### Pre-Bedtime Analysis

1. Run the full analytics workflow:
   ```powershell
   BIG-Analytics.ps1 -Command stats -IncludeDetails
   BIG-Analytics.ps1 -Command report -Format HTML
   BIG-Analytics.ps1 -Command health -Threshold 60
   ```
2. Record the health score in your session summary
3. Address critical recommendations before completing the Bedtime Protocol
4. Archive the generated reports using the Bedtime Protocol

## Interpreting Results

### Understanding Health Metrics

1. **Memory Diversity (0-1)**
   - Measures balance between memory types
   - Higher scores indicate better distribution
   - Target: > 0.7

2. **Long-Term Ratio (0-1)**
   - Proportion of content in long-term storage
   - Higher scores indicate better long-term preservation
   - Target: > 0.5

3. **Category Balance (0-1)**
   - Distribution across episodic, semantic, procedural, and creative
   - Higher scores indicate even distribution
   - Target: > 0.8

4. **Activity Score (0-100%)**
   - Percentage of files modified in last 7 days
   - Higher scores indicate active usage
   - Target: > 40%

5. **Overall Health (0-100%)**
   - Combined weighted score
   - Status categories:
     - 80-100%: Excellent
     - 60-79%: Good
     - 40-59%: Adequate
     - 20-39%: Needs Improvement
     - 0-19%: Critical

### Acting on Recommendations

1. **Memory Imbalance**
   - Move frequently-accessed stable content to long-term memory
   - Clean up outdated content from active memory
   - Ensure content is distributed across all long-term categories

2. **Missing Categories**
   - Create files in any empty long-term memory categories
   - Document procedures, concepts, and designs appropriately
   - Record important sessions in episodic memory

3. **Activity Issues**
   - Regularly review and update core files
   - Archive outdated information rather than deleting
   - Maintain consistent usage patterns

## Troubleshooting

### Common Issues

1. **Low Health Score Despite Organization**
   - Check that files are in the correct directories
   - Verify file extensions are recognized (.md, .json, etc.)
   - Ensure file timestamps are preserved during moves

2. **Report Generation Errors**
   - Verify the memory-bank path is correct
   - Check permissions for writing to the output directory
   - Ensure PowerShell has appropriate execution policy

3. **Missing Statistics**
   - Verify the memory-bank structure follows the expected convention
   - Check for hidden files or alternate data streams
   - Run with `-Verbose` for additional diagnostic information

## Advanced Usage

### Custom Metrics

You can extend the analytics system with custom metrics by:

1. Editing the `Get-MemoryBankStatistics.ps1` script
2. Adding new properties to the statistics object
3. Implementing calculation logic in the appropriate section
4. Updating the health score calculation to include the new metric

### Scheduled Analysis

Set up scheduled analysis using Windows Task Scheduler:

1. Create a new scheduled task
2. Set the action to run PowerShell with the command:
   ```
   -ExecutionPolicy Bypass -File "path/to/BIG-Analytics.ps1" -Command health -Threshold 60
   ```
3. Configure the trigger for your preferred schedule
4. Set conditions and settings as needed

## Version History

- 1.0.0: Initial documentation (2025-03-25)