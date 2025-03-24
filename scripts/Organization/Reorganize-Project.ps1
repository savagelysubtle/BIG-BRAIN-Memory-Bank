# Reorganize-Project.ps1
# Script to reorganize BIG BRAIN Memory Bank project files according to the suggested GitHub structure
# This script will:
# 1. Create the suggested directory structure if it doesn't exist
# 2. Move files to their suggested locations
# 3. Skip files that are already in the correct place
# 4. Not overwrite existing files

# Set error action preference
$ErrorActionPreference = "Stop"

# Define project root
$projectRoot = "D:\Coding\Python_Projects\TheMemoryBank"
Set-Location $projectRoot

# Function to create directory if it doesn't exist
function Create-DirectoryIfNotExists {
    param(
        [string]$path
    )

    if (-not (Test-Path $path)) {
        Write-Host "Creating directory: $path"
        New-Item -Path $path -ItemType Directory -Force | Out-Null
        return $true
    } else {
        Write-Host "Directory already exists: $path" -ForegroundColor Yellow
        return $false
    }
}

# Function to move file if it doesn't exist at destination
function Move-FileIfNotExists {
    param(
        [string]$source,
        [string]$destination
    )

    if (Test-Path $source) {
        $destDir = Split-Path $destination -Parent

        # Ensure destination directory exists
        if (-not (Test-Path $destDir)) {
            New-Item -Path $destDir -ItemType Directory -Force | Out-Null
        }

        if (Test-Path $destination) {
            Write-Host "Destination file already exists: $destination" -ForegroundColor Yellow
            return $false
        } else {
            Write-Host "Moving: $source -> $destination"
            Move-Item -Path $source -Destination $destination
            return $true
        }
    } else {
        Write-Host "Source file doesn't exist: $source" -ForegroundColor Red
        return $false
    }
}

# Create main directory structure
Write-Host "Creating main directory structure..." -ForegroundColor Cyan
$directories = @(
    "docs\Guides",
    "docs\research",
    "scripts",
    "examples",
    "inspiration\original-concepts",
    "inspiration\related-implementations"
)

foreach ($dir in $directories) {
    Create-DirectoryIfNotExists -path (Join-Path $projectRoot $dir)
}

# Move scripts to their appropriate location
Write-Host "`nMoving scripts..." -ForegroundColor Cyan
Move-FileIfNotExists -source (Join-Path $projectRoot "Initialize-MemoryBank.ps1") -destination (Join-Path $projectRoot "scripts\Initialize-MemoryBank.ps1")
Move-FileIfNotExists -source (Join-Path $projectRoot "Initialize-MemoryBank.sh") -destination (Join-Path $projectRoot "scripts\Initialize-MemoryBank.sh")
Move-FileIfNotExists -source (Join-Path $projectRoot "PrepareForGitHub.ps1") -destination (Join-Path $projectRoot "scripts\PrepareForGitHub.ps1")

# Move documentation files
Write-Host "`nMoving documentation files..." -ForegroundColor Cyan
# Create ATTRIBUTION.md if it doesn't exist
if (-not (Test-Path (Join-Path $projectRoot "ATTRIBUTION.md"))) {
    Write-Host "Creating ATTRIBUTION.md placeholder"
    @"
# Attribution

BIG BRAIN Memory Bank was inspired by and builds upon the work of:

## Original Concept
- **Memory Bank Concept** by [ipenywis](https://github.com/ipenywis)
  - Original gist: [Cursor Memory Bank](https://gist.github.com/ipenywis/1bdb541c3a612dbac4a14e1e3f4341ab)
  - License: MIT

## Related Implementations
- **Cursor Memory Bank** by [vanzan01](https://github.com/vanzan01)
  - Repository: [cursor-memory-bank](https://github.com/vanzan01/cursor-memory-bank)
  - License: MIT

While inspired by these excellent projects, BIG BRAIN Memory Bank has evolved significantly with:
- [List your major innovations and differences]
- [Highlight your unique contributions]

All contributors are gratefully acknowledged for their foundational work.
"@ | Out-File -FilePath (Join-Path $projectRoot "ATTRIBUTION.md") -Encoding utf8
}

# Move files from REPO/docs to docs if they exist
if (Test-Path (Join-Path $projectRoot "REPO\docs")) {
    Write-Host "Moving REPO/docs contents to docs directory"
    $repoDocsPath = Join-Path $projectRoot "REPO\docs"
    $docsPath = Join-Path $projectRoot "docs"

    # Get all files and directories in REPO/docs
    $repoDocsItems = Get-ChildItem -Path $repoDocsPath -Recurse

    foreach ($item in $repoDocsItems) {
        $relativePath = $item.FullName.Substring($repoDocsPath.Length)
        $destPath = Join-Path $docsPath $relativePath

        if ($item.PSIsContainer) {
            Create-DirectoryIfNotExists -path $destPath
        } else {
            Move-FileIfNotExists -source $item.FullName -destination $destPath
        }
    }
}

# Move archive to inspiration
Write-Host "`nMoving archive contents to inspiration..." -ForegroundColor Cyan
if (Test-Path (Join-Path $projectRoot "archive\My-memory-bank")) {
    Write-Host "Moving My-memory-bank to inspiration/original-concepts"
    $srcPath = Join-Path $projectRoot "archive\My-memory-bank"
    $destPath = Join-Path $projectRoot "inspiration\original-concepts\My-memory-bank"

    if (-not (Test-Path $destPath)) {
        New-Item -Path $destPath -ItemType Directory -Force | Out-Null

        # Get all files and directories in the source
        $items = Get-ChildItem -Path $srcPath -Recurse

        foreach ($item in $items) {
            $relativePath = $item.FullName.Substring($srcPath.Length)
            $itemDestPath = Join-Path $destPath $relativePath

            if ($item.PSIsContainer) {
                Create-DirectoryIfNotExists -path $itemDestPath
            } else {
                Move-FileIfNotExists -source $item.FullName -destination $itemDestPath
            }
        }
    }
}

if (Test-Path (Join-Path $projectRoot "archive\Vanzan-memory-bank")) {
    Write-Host "Moving Vanzan-memory-bank to inspiration/related-implementations"
    $srcPath = Join-Path $projectRoot "archive\Vanzan-memory-bank"
    $destPath = Join-Path $projectRoot "inspiration\related-implementations\Vanzan-memory-bank"

    if (-not (Test-Path $destPath)) {
        New-Item -Path $destPath -ItemType Directory -Force | Out-Null

        # Get all files and directories in the source
        $items = Get-ChildItem -Path $srcPath -Recurse

        foreach ($item in $items) {
            $relativePath = $item.FullName.Substring($srcPath.Length)
            $itemDestPath = Join-Path $destPath $relativePath

            if ($item.PSIsContainer) {
                Create-DirectoryIfNotExists -path $itemDestPath
            } else {
                Move-FileIfNotExists -source $item.FullName -destination $itemDestPath
            }
        }
    }
}

# Update README.md to include attribution section if it doesn't already have it
Write-Host "`nChecking README.md for attribution section..." -ForegroundColor Cyan
$readmePath = Join-Path $projectRoot "README.md"
if (Test-Path $readmePath) {
    $readmeContent = Get-Content $readmePath -Raw

    if (-not ($readmeContent -match "## Origins & Acknowledgments")) {
        Write-Host "Adding attribution section to README.md"
        $attributionSection = @"

## Origins & Acknowledgments

BIG BRAIN Memory Bank builds upon the Memory Bank concept initially developed by [ipenywis](https://github.com/ipenywis) and further implemented by [vanzan01](https://github.com/vanzan01/cursor-memory-bank). While inspired by these projects, BIG BRAIN Memory Bank has evolved into a distinct implementation with significant enhancements to the architecture, workflow systems, and memory management protocols.

We gratefully acknowledge these original creators whose work provided valuable inspiration.
"@
        $readmeContent += $attributionSection
        $readmeContent | Out-File -FilePath $readmePath -Encoding utf8
    } else {
        Write-Host "README.md already has an attribution section" -ForegroundColor Yellow
    }
}

Write-Host "`nProject reorganization complete!" -ForegroundColor Green
Write-Host "Please review the changes and make any necessary adjustments." -ForegroundColor Cyan