# BIG-Organization.ps1
# Implementation of the BIG organization commands for the Memory Bank system
# Version 1.0.0
# Created: 2025-03-27

param (
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidateSet("reorganize", "categorize", "cleanup")]
    [string]$Command,

    [Parameter(Mandatory = $false)]
    [string]$TargetPath = ".\memory-bank",

    [Parameter(Mandatory = $false)]
    [string]$DestinationPath,

    [Parameter(Mandatory = $false)]
    [string]$Category,

    [Parameter(Mandatory = $false)]
    [switch]$Force,

    [Parameter(Mandatory = $false)]
    [switch]$WhatIf
)

# Set path to memory bank and organization scripts
$projectRoot = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
$memoryBankPath = Join-Path -Path $projectRoot -ChildPath "memory-bank"
$organizationScriptsPath = Join-Path -Path $projectRoot -ChildPath "scripts/Organization"
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

# Execute the specified command
switch ($Command) {
    "reorganize" {
        Write-BIGHeader "MEMORY BANK REORGANIZATION"

        # Run the reorganization script
        Write-Host "Reorganizing memory bank content..." -ForegroundColor Yellow
        $reorganizeScript = Join-Path -Path $organizationScriptsPath -ChildPath "Reorganize-Project.ps1"

        if (-not (Test-Path -Path $reorganizeScript)) {
            Write-Host "Error: Reorganize script not found at $reorganizeScript" -ForegroundColor Red
            exit 1
        }

        $params = @{
            SourcePath      = $TargetPath
            DestinationPath = if ($DestinationPath) { $DestinationPath } else { $TargetPath }
        }

        if ($WhatIf) {
            $params.Add("WhatIf", $true)
        }

        if ($Force) {
            $params.Add("Force", $true)
        }

        $result = Invoke-ScriptSafely -ScriptPath $reorganizeScript -Parameters $params

        # Display summary of results
        Write-Host ""
        Write-Host "Memory Bank Reorganization Complete:" -ForegroundColor Green
        Write-Host "Files Processed: $($result.FilesProcessed)" -ForegroundColor White
        Write-Host "Files Moved: $($result.FilesMoved)" -ForegroundColor White
        Write-Host "Categories Organized: $($result.CategoriesOrganized)" -ForegroundColor White

        # Run a statistics check to show the improvement
        $statsScript = Join-Path -Path $projectRoot -ChildPath "scripts/Analytics/Get-MemoryBankStatistics.ps1"
        if (Test-Path -Path $statsScript) {
            Write-Host ""
            Write-Host "Generating updated memory bank statistics..." -ForegroundColor Yellow
            $stats = & $statsScript -MemoryBankPath $memoryBankPath

            Write-Host ""
            Write-Host "Memory Health After Reorganization:" -ForegroundColor Green
            Write-Host "Memory Diversity: $($stats.ComplexityMetrics.MemoryDiversity)" -ForegroundColor White
            Write-Host "Long-Term Ratio: $($stats.ComplexityMetrics.LongTermRatio)" -ForegroundColor White
            Write-Host "Category Balance: $($stats.ComplexityMetrics.CategoryBalance)" -ForegroundColor White
            Write-Host "Overall Health Score: $($stats.ComplexityMetrics.OverallScore)%" -ForegroundColor White
        }
    }

    "categorize" {
        Write-BIGHeader "MEMORY CATEGORIZATION"

        if (-not $Category) {
            Write-Host "Error: Category parameter is required for the categorize command." -ForegroundColor Red
            Write-Host "Valid categories: episodic, semantic, procedural, creative" -ForegroundColor Yellow
            exit 1
        }

        # Validate category
        $validCategories = @("episodic", "semantic", "procedural", "creative")
        if ($validCategories -notcontains $Category.ToLower()) {
            Write-Host "Error: Invalid category '$Category'." -ForegroundColor Red
            Write-Host "Valid categories: episodic, semantic, procedural, creative" -ForegroundColor Yellow
            exit 1
        }

        # Run the categorization script
        Write-Host "Categorizing content as '$Category'..." -ForegroundColor Yellow
        $categorizeScript = Join-Path -Path $organizationScriptsPath -ChildPath "reorganize-rules.ps1"

        if (-not (Test-Path -Path $categorizeScript)) {
            Write-Host "Error: Categorize script not found at $categorizeScript" -ForegroundColor Red
            exit 1
        }

        $destinationFolder = Join-Path -Path $memoryBankPath -ChildPath "long-term/$($Category.ToLower())"

        $params = @{
            SourcePath      = $TargetPath
            DestinationPath = if ($DestinationPath) { $DestinationPath } else { $destinationFolder }
            Category        = $Category.ToLower()
        }

        if ($WhatIf) {
            $params.Add("WhatIf", $true)
        }

        if ($Force) {
            $params.Add("Force", $true)
        }

        $result = Invoke-ScriptSafely -ScriptPath $categorizeScript -Parameters $params

        # Display summary of results
        Write-Host ""
        Write-Host "Memory Categorization Complete:" -ForegroundColor Green
        Write-Host "Category: $Category" -ForegroundColor White
        Write-Host "Files Processed: $($result.FilesProcessed)" -ForegroundColor White
        Write-Host "Files Categorized: $($result.FilesCategorized)" -ForegroundColor White
    }

    "cleanup" {
        Write-BIGHeader "MEMORY CLEANUP"

        # Run the cleanup script
        Write-Host "Cleaning up memory bank content..." -ForegroundColor Yellow
        $cleanupScript = Join-Path -Path $organizationScriptsPath -ChildPath "delete-original-rules.ps1"

        if (-not (Test-Path -Path $cleanupScript)) {
            Write-Host "Error: Cleanup script not found at $cleanupScript" -ForegroundColor Red
            exit 1
        }

        $params = @{
            Path = $TargetPath
        }

        if ($WhatIf) {
            $params.Add("WhatIf", $true)
        }

        if ($Force) {
            $params.Add("Force", $true)
        }

        $result = Invoke-ScriptSafely -ScriptPath $cleanupScript -Parameters $params

        # Display summary of results
        Write-Host ""
        Write-Host "Memory Cleanup Complete:" -ForegroundColor Green
        Write-Host "Files Processed: $($result.FilesProcessed)" -ForegroundColor White
        Write-Host "Files Removed: $($result.FilesRemoved)" -ForegroundColor White
        Write-Host "Space Recovered: $($result.SpaceRecovered)" -ForegroundColor White

        # Run a statistics check to show the improvement
        $statsScript = Join-Path -Path $projectRoot -ChildPath "scripts/Analytics/Get-MemoryBankStatistics.ps1"
        if (Test-Path -Path $statsScript) {
            Write-Host ""
            Write-Host "Generating updated memory bank statistics..." -ForegroundColor Yellow
            $stats = & $statsScript -MemoryBankPath $memoryBankPath

            Write-Host ""
            Write-Host "Memory Health After Cleanup:" -ForegroundColor Green
            Write-Host "Total Files: $($stats.TotalFiles)" -ForegroundColor White
            Write-Host "Total Size: $($stats.TotalSize)" -ForegroundColor White
            Write-Host "Overall Health Score: $($stats.ComplexityMetrics.OverallScore)%" -ForegroundColor White
        }
    }
}

Write-Host ""