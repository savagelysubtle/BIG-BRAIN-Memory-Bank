# Get-MemoryBankStatistics.ps1
# Script to gather statistics about the memory bank, including file counts, sizes, and complexity metrics.
# Version 1.1.0
# Created: 2023-03-25
# Updated: 2025-03-27 - Updated default output path to use reports directory

[CmdletBinding()]
param (
    [Parameter(Mandatory = $false)]
    [string]$MemoryBankPath = (Join-Path -Path $PSScriptRoot -ChildPath "../../memory-bank"),

    [Parameter(Mandatory = $false)]
    [switch]$IncludeDetails,

    [Parameter(Mandatory = $false)]
    [switch]$ExportJson,

    [Parameter(Mandatory = $false)]
    [string]$OutputPath = (Join-Path -Path $PSScriptRoot -ChildPath "../reports/memory-statistics.json")
)

function Format-FileSize {
    param ([long]$Size)

    if ($Size -gt 1GB) { return "{0:N2} GB" -f ($Size / 1GB) }
    if ($Size -gt 1MB) { return "{0:N2} MB" -f ($Size / 1MB) }
    if ($Size -gt 1KB) { return "{0:N2} KB" -f ($Size / 1KB) }
    return "$Size bytes"
}

# Verify memory bank exists
if (-not (Test-Path -Path $MemoryBankPath)) {
    Write-Error "Memory bank directory not found at: $MemoryBankPath"
    exit 1
}

# Add this function to fix directory scanning issue
function Get-DirectoryStats {
    param (
        [string]$Path,
        [string]$Type
    )

    if (!(Test-Path $Path)) {
        return @{
            Count = 0
            Size  = 0
            Files = @()
        }
    }

    $files = Get-ChildItem -Path $Path -Recurse -File -ErrorAction SilentlyContinue

    # Fix: Ensure we're actually finding files even in deeply nested subdirectories
    if ($null -eq $files) {
        $files = @()
    }

    $totalSize = ($files | Measure-Object -Property Length -Sum).Sum

    return @{
        Count = $files.Count
        Size  = $totalSize
        Files = $files
    }
}

# Replace existing memory type scanning code with this
$memoryBankFullPath = Resolve-Path $MemoryBankPath
$activePath = Join-Path $memoryBankFullPath "active"
$shortTermPath = Join-Path $memoryBankFullPath "short-term"
$longTermPath = Join-Path $memoryBankFullPath "long-term"

# Get stats for each memory type (with fixed recursive scanning)
$activeStats = Get-DirectoryStats -Path $activePath -Type "Active"
$shortTermStats = Get-DirectoryStats -Path $shortTermPath -Type "ShortTerm"
$longTermStats = Get-DirectoryStats -Path $longTermPath -Type "LongTerm"

# Analyze long-term categories
$episodicPath = Join-Path $longTermPath "episodic"
$semanticPath = Join-Path $longTermPath "semantic"
$proceduralPath = Join-Path $longTermPath "procedural"
$creativePath = Join-Path $longTermPath "creative"

$episodicStats = Get-DirectoryStats -Path $episodicPath -Type "Episodic"
$semanticStats = Get-DirectoryStats -Path $semanticPath -Type "Semantic"
$proceduralStats = Get-DirectoryStats -Path $proceduralPath -Type "Procedural"
$creativeStats = Get-DirectoryStats -Path $creativePath -Type "Creative"

# Fix calculation of health metrics
$totalFiles = $activeStats.Count + $shortTermStats.Count + $longTermStats.Count
$longTermCategories = @($episodicStats.Count, $semanticStats.Count, $proceduralStats.Count, $creativeStats.Count)

# Prepare file lists for activity calculations
$filesLast24Hours = ($activeStats.Files + $shortTermStats.Files) | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-1) }
$filesLast7Days = ($activeStats.Files + $shortTermStats.Files) | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-7) }
$filesLast30Days = ($activeStats.Files + $shortTermStats.Files) | Where-Object { $_.LastWriteTime -gt (Get-Date).AddDays(-30) }

# Basic statistics
$totalSize = ($activeStats.Size + $shortTermStats.Size + $longTermStats.Size)
$avgFileSize = if ($totalFiles -gt 0) { $totalSize / $totalFiles } else { 0 }
$largestFile = $activeStats.Files + $shortTermStats.Files + $longTermStats.Files | Sort-Object -Property Length -Descending | Select-Object -First 1
$newestFile = $activeStats.Files + $shortTermStats.Files + $longTermStats.Files | Sort-Object -Property LastWriteTime -Descending | Select-Object -First 1
$oldestFile = $activeStats.Files + $shortTermStats.Files + $longTermStats.Files | Sort-Object -Property LastWriteTime | Select-Object -First 1

# Calculate complexity metrics
$complexityMetrics = @{
    MemoryDiversity = [math]::Round(($activeStats.Count + $shortTermStats.Count + $longTermStats.Count) / 3, 2)
    LongTermRatio   = if ($totalFiles -gt 0) { [math]::Round($longTermStats.Count / $totalFiles, 2) } else { 0 }
    CategoryBalance = if ($longTermStats.Count -gt 0) {
        $nonZeroCategories = $longTermCategories | Where-Object { $_ -gt 0 } | Measure-Object | Select-Object -ExpandProperty Count
        [math]::Round($nonZeroCategories / 4, 2)
    }
    else { 0 }
    ActivityScore   = if ($totalFiles -gt 0) {
        [math]::Round(($filesLast7Days | Measure-Object).Count / $totalFiles * 100, 2)
    }
    else { 0 }
}

# Calculate overall score
$overallScore = [math]::Round(($complexityMetrics.MemoryDiversity + $complexityMetrics.LongTermRatio +
        $complexityMetrics.CategoryBalance + ($complexityMetrics.ActivityScore / 100)) / 4 * 100, 2)

# Create statistics object
$statistics = [PSCustomObject]@{
    GeneratedAt          = Get-Date
    MemoryBankPath       = $MemoryBankPath
    TotalFiles           = $totalFiles
    TotalSize            = Format-FileSize -Size $totalSize
    TotalSizeBytes       = $totalSize
    AverageFileSize      = Format-FileSize -Size $avgFileSize
    AverageFileSizeBytes = $avgFileSize
    LargestFile          = if ($largestFile) {
        [PSCustomObject]@{
            Name      = $largestFile.Name
            Path      = $largestFile.FullName.Replace($MemoryBankPath, "memory-bank")
            Size      = Format-FileSize -Size $largestFile.Length
            SizeBytes = $largestFile.Length
        }
    }
    else { $null }
    NewestFile           = if ($newestFile) {
        [PSCustomObject]@{
            Name         = $newestFile.Name
            Path         = $newestFile.FullName.Replace($MemoryBankPath, "memory-bank")
            LastModified = $newestFile.LastWriteTime
        }
    }
    else { $null }
    OldestFile           = if ($oldestFile) {
        [PSCustomObject]@{
            Name         = $oldestFile.Name
            Path         = $oldestFile.FullName.Replace($MemoryBankPath, "memory-bank")
            LastModified = $oldestFile.LastWriteTime
        }
    }
    else { $null }
    MemoryTypes          = [PSCustomObject]@{
        Active    = [PSCustomObject]@{
            FileCount      = $activeStats.Count
            TotalSize      = Format-FileSize -Size $activeStats.Size
            TotalSizeBytes = $activeStats.Size
        }
        ShortTerm = [PSCustomObject]@{
            FileCount      = $shortTermStats.Count
            TotalSize      = Format-FileSize -Size $shortTermStats.Size
            TotalSizeBytes = $shortTermStats.Size
        }
        LongTerm  = [PSCustomObject]@{
            FileCount      = $longTermStats.Count
            TotalSize      = Format-FileSize -Size $longTermStats.Size
            TotalSizeBytes = $longTermStats.Size
            Categories     = [PSCustomObject]@{
                Episodic   = [PSCustomObject]@{
                    FileCount      = $episodicStats.Count
                    TotalSize      = Format-FileSize -Size $episodicStats.Size
                    TotalSizeBytes = $episodicStats.Size
                }
                Semantic   = [PSCustomObject]@{
                    FileCount      = $semanticStats.Count
                    TotalSize      = Format-FileSize -Size $semanticStats.Size
                    TotalSizeBytes = $semanticStats.Size
                }
                Procedural = [PSCustomObject]@{
                    FileCount      = $proceduralStats.Count
                    TotalSize      = Format-FileSize -Size $proceduralStats.Size
                    TotalSizeBytes = $proceduralStats.Size
                }
                Creative   = [PSCustomObject]@{
                    FileCount      = $creativeStats.Count
                    TotalSize      = Format-FileSize -Size $creativeStats.Size
                    TotalSizeBytes = $creativeStats.Size
                }
            }
        }
    }
    Activity             = [PSCustomObject]@{
        Last24Hours = [PSCustomObject]@{
            FileCount  = ($filesLast24Hours | Measure-Object).Count
            Percentage = if ($totalFiles -gt 0) { [math]::Round(($filesLast24Hours | Measure-Object).Count / $totalFiles * 100, 2) } else { 0 }
        }
        Last7Days   = [PSCustomObject]@{
            FileCount  = ($filesLast7Days | Measure-Object).Count
            Percentage = if ($totalFiles -gt 0) { [math]::Round(($filesLast7Days | Measure-Object).Count / $totalFiles * 100, 2) } else { 0 }
        }
        Last30Days  = [PSCustomObject]@{
            FileCount  = ($filesLast30Days | Measure-Object).Count
            Percentage = if ($totalFiles -gt 0) { [math]::Round(($filesLast30Days | Measure-Object).Count / $totalFiles * 100, 2) } else { 0 }
        }
    }
    ComplexityMetrics    = [PSCustomObject]@{
        MemoryDiversity = $complexityMetrics.MemoryDiversity
        LongTermRatio   = $complexityMetrics.LongTermRatio
        CategoryBalance = $complexityMetrics.CategoryBalance
        ActivityScore   = $complexityMetrics.ActivityScore
        OverallScore    = $overallScore
    }
}

# Include details if requested
if ($IncludeDetails) {
    $allFiles = $activeStats.Files + $shortTermStats.Files + $longTermStats.Files
    $statistics | Add-Member -MemberType NoteProperty -Name "DetailedFileList" -Value @(
        $allFiles | ForEach-Object {
            [PSCustomObject]@{
                Name         = $_.Name
                Path         = $_.FullName.Replace($MemoryBankPath, "memory-bank")
                Size         = Format-FileSize -Size $_.Length
                SizeBytes    = $_.Length
                LastModified = $_.LastWriteTime
                Extension    = $_.Extension
            }
        }
    )
}

# Export to JSON if requested
if ($ExportJson) {
    # Ensure directory exists
    $outputDir = Split-Path -Path $OutputPath -Parent
    if (-not (Test-Path -Path $outputDir)) {
        New-Item -Path $outputDir -ItemType Directory -Force | Out-Null
        Write-Host "Created output directory: $outputDir"
    }

    $statistics | ConvertTo-Json -Depth 10 | Out-File -FilePath $OutputPath
    Write-Host "Statistics exported to: $OutputPath"
}

# Return statistics object
return $statistics

