# BIG BRAIN Memory Bank 2.0 - Diagram Generation Script
# This script converts Mermaid diagram files to PNG/SVG images
# Version 1.0.0 (March 24, 2025)

# Define colors for console output
$infoColor = "Cyan"
$successColor = "Green"
$errorColor = "Red"
$highlightColor = "Yellow"

# Print banner
Write-Host "===================================================" -ForegroundColor $infoColor
Write-Host "  BIG BRAIN Memory Bank - Diagram Generator" -ForegroundColor $infoColor
Write-Host "===================================================" -ForegroundColor $infoColor
Write-Host ""

# Configuration
$imageDir = "../images"
$outputDir = "../images"
$docsAssetsDir = "../docs/assets"

# Function to check if a command is available
function Test-CommandExists {
    param ($command)

    $exists = $false
    try {
        if (Get-Command $command -ErrorAction Stop) {
            $exists = $true
        }
    }
    catch {
        $exists = $false
    }
    return $exists
}

# Check if Node.js is installed
if (-not (Test-CommandExists "node")) {
    Write-Host "Node.js is not installed. Please install Node.js:" -ForegroundColor $errorColor
    Write-Host "1. Visit https://nodejs.org/" -ForegroundColor $highlightColor
    Write-Host "2. Download and install the LTS version" -ForegroundColor $highlightColor
    Write-Host "3. Restart this script after installation" -ForegroundColor $highlightColor
    exit 1
}

# Check if mmdc (Mermaid CLI) is installed
if (-not (Test-CommandExists "mmdc")) {
    Write-Host "Mermaid CLI is not installed. Would you like to install it now? (Y/N)" -ForegroundColor $highlightColor
    $response = Read-Host

    if ($response -eq "Y" -or $response -eq "y") {
        Write-Host "Installing Mermaid CLI..." -ForegroundColor $infoColor
        npm install -g @mermaid-js/mermaid-cli

        # Verify installation
        if (-not (Test-CommandExists "mmdc")) {
            Write-Host "Installation failed. Please install manually:" -ForegroundColor $errorColor
            Write-Host "npm install -g @mermaid-js/mermaid-cli" -ForegroundColor $highlightColor
            exit 1
        }

        Write-Host "Mermaid CLI installed successfully!" -ForegroundColor $successColor
    }
    else {
        Write-Host "Please install Mermaid CLI manually and rerun this script:" -ForegroundColor $errorColor
        Write-Host "npm install -g @mermaid-js/mermaid-cli" -ForegroundColor $highlightColor
        exit 1
    }
}

# Ensure output directories exist
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
    Write-Host "Created output directory: $outputDir" -ForegroundColor $infoColor
}

if (-not (Test-Path $docsAssetsDir)) {
    New-Item -ItemType Directory -Path $docsAssetsDir | Out-Null
    Write-Host "Created docs assets directory: $docsAssetsDir" -ForegroundColor $infoColor
}

# Get all Mermaid files
$mermaidFiles = Get-ChildItem -Path $imageDir -Filter "*.mermaid"

if ($mermaidFiles.Count -eq 0) {
    Write-Host "No Mermaid files found in $imageDir" -ForegroundColor $errorColor
    exit 1
}

Write-Host "Found $($mermaidFiles.Count) Mermaid files to process" -ForegroundColor $infoColor
Write-Host ""

# Process each Mermaid file
foreach ($file in $mermaidFiles) {
    $baseName = $file.BaseName
    $inputPath = $file.FullName
    $pngOutputPath = Join-Path -Path $outputDir -ChildPath "$baseName.png"
    $svgOutputPath = Join-Path -Path $outputDir -ChildPath "$baseName.svg"
    $docsAssetsOutputPath = Join-Path -Path $docsAssetsDir -ChildPath "$baseName.png"

    Write-Host "Processing: $baseName" -ForegroundColor $infoColor

    # Generate PNG
    Write-Host "  Generating PNG..." -NoNewline
    mmdc -i $inputPath -o $pngOutputPath -b transparent

    if (Test-Path $pngOutputPath) {
        Write-Host "Success!" -ForegroundColor $successColor

        # Copy to docs/assets if needed
        if (-not (Test-Path $docsAssetsDir)) {
            New-Item -ItemType Directory -Path $docsAssetsDir -Force | Out-Null
        }

        Copy-Item -Path $pngOutputPath -Destination $docsAssetsOutputPath -Force
        Write-Host "  Copied to docs/assets directory" -ForegroundColor $infoColor
    }
    else {
        Write-Host "Failed!" -ForegroundColor $errorColor
    }

    # Generate SVG
    Write-Host "  Generating SVG..." -NoNewline
    mmdc -i $inputPath -o $svgOutputPath -b transparent

    if (Test-Path $svgOutputPath) {
        Write-Host "Success!" -ForegroundColor $successColor
    }
    else {
        Write-Host "Failed!" -ForegroundColor $errorColor
    }

    Write-Host ""
}

Write-Host "All diagrams processed successfully!" -ForegroundColor $successColor
Write-Host ""
Write-Host "Generated files:" -ForegroundColor $infoColor

# List generated files
foreach ($file in $mermaidFiles) {
    $baseName = $file.BaseName
    $pngPath = Join-Path -Path $outputDir -ChildPath "$baseName.png"
    $svgPath = Join-Path -Path $outputDir -ChildPath "$baseName.svg"

    if (Test-Path $pngPath) {
        $pngInfo = Get-Item $pngPath
        Write-Host "  $($pngInfo.Name) ($('{0:N2}' -f ($pngInfo.Length / 1KB)) KB)" -ForegroundColor $highlightColor
    }

    if (Test-Path $svgPath) {
        $svgInfo = Get-Item $svgPath
        Write-Host "  $($svgInfo.Name) ($('{0:N2}' -f ($svgInfo.Length / 1KB)) KB)" -ForegroundColor $highlightColor
    }
}

Write-Host ""
Write-Host "To use these diagrams in documentation, use the following markdown:" -ForegroundColor $infoColor
Write-Host "![Diagram Description](../images/$baseName.png)" -ForegroundColor $highlightColor
Write-Host ""
Write-Host "Diagram generation complete!" -ForegroundColor $successColor