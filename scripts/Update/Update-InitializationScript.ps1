# BIG BRAIN Memory Bank - Initialization Script Updater
# This script analyzes the current repository structure and updates the initialization script.
# Version 1.1.0 (March 25, 2025)

# Define colors for console output
$infoColor = "Cyan"
$successColor = "Green"
$errorColor = "Red"
$highlightColor = "Yellow"

# Print banner
Write-Host "===================================================" -ForegroundColor $infoColor
Write-Host "  BIG BRAIN Memory Bank - Initialization Updater" -ForegroundColor $infoColor
Write-Host "===================================================" -ForegroundColor $infoColor
Write-Host ""

# Configuration
$rootDir = $PSScriptRoot
$parentDir = Split-Path -Parent $rootDir
$initScriptPath = Join-Path -Path $rootDir -ChildPath "Initialize-MemoryBank.ps1"
$initScriptShPath = Join-Path -Path $rootDir -ChildPath "Initialize-MemoryBank.sh"
$tempInitScriptPath = Join-Path -Path $rootDir -ChildPath "Initialize-MemoryBank.ps1.new"
$backupDir = Join-Path -Path $rootDir -ChildPath "backup"

# Define paths to look for initialization scripts in organized folder structure
$initDir = Join-Path -Path $rootDir -ChildPath "Init"
$initScriptPathAlt = Join-Path -Path $initDir -ChildPath "Initialize-MemoryBank.ps1"
$initScriptShPathAlt = Join-Path -Path $initDir -ChildPath "Initialize-MemoryBank.sh"

# Function to find the most appropriate script path
function Find-ScriptPath {
    param (
        [string]$PrimaryPath,
        [string]$AlternativePath
    )

    if (Test-Path -Path $PrimaryPath) {
        return $PrimaryPath
    }
    elseif (Test-Path -Path $AlternativePath) {
        Write-Host "Using script from organized structure: $AlternativePath" -ForegroundColor $highlightColor
        return $AlternativePath
    }
    else {
        Write-Host "Warning: Script not found in either location. Will create new." -ForegroundColor $highlightColor
        return $PrimaryPath # Return primary path as the target location
    }
}

# Find the most appropriate initialization script paths
$initScriptPath = Find-ScriptPath -PrimaryPath $initScriptPath -AlternativePath $initScriptPathAlt
$initScriptShPath = Find-ScriptPath -PrimaryPath $initScriptShPath -AlternativePath $initScriptShPathAlt

# Create backup directory if it doesn't exist
if (-not (Test-Path -Path $backupDir)) {
    New-Item -ItemType Directory -Path $backupDir | Out-Null
    Write-Host "Created backup directory: $backupDir" -ForegroundColor $infoColor
}

# Backup existing scripts
function Backup-Script {
    param (
        [string]$ScriptPath
    )

    if (Test-Path -Path $ScriptPath) {
        $timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
        $fileName = Split-Path -Leaf $ScriptPath
        $backupPath = Join-Path -Path $backupDir -ChildPath "${fileName}.${timestamp}"

        Copy-Item -Path $ScriptPath -Destination $backupPath
        Write-Host "Backed up $ScriptPath to $backupPath" -ForegroundColor $infoColor
    }
}

# Backup existing initialization scripts
Backup-Script -ScriptPath $initScriptPath
Backup-Script -ScriptPath $initScriptShPath

# Analyze repository structure
Write-Host "Analyzing repository structure..." -ForegroundColor $infoColor

# Discover directory structure
function Get-DirectoryStructure {
    param (
        [string]$BasePath,
        [string]$RelativePath = "",
        [int]$MaxDepth = 3,
        [int]$CurrentDepth = 0
    )

    $structure = @{}
    $fullPath = Join-Path -Path $BasePath -ChildPath $RelativePath

    if ($CurrentDepth -ge $MaxDepth) {
        return $structure
    }

    $items = Get-ChildItem -Path $fullPath -Directory

    foreach ($item in $items) {
        $itemRelativePath = if ($RelativePath) { Join-Path -Path $RelativePath -ChildPath $item.Name } else { $item.Name }
        $structure[$item.Name] = Get-DirectoryStructure -BasePath $BasePath -RelativePath $itemRelativePath -MaxDepth $MaxDepth -CurrentDepth ($CurrentDepth + 1)
    }

    return $structure
}

# Get current directory structures
$memoryBankStructure = Get-DirectoryStructure -BasePath $parentDir -RelativePath "memory-bank" -MaxDepth 3
$rulesStructure = Get-DirectoryStructure -BasePath $parentDir -RelativePath ".cursor/rules" -MaxDepth 3

Write-Host "Discovered memory-bank structure:" -ForegroundColor $infoColor
$memoryBankStructure | ConvertTo-Json -Depth 4 | Write-Host -ForegroundColor $highlightColor

Write-Host "Discovered rules structure:" -ForegroundColor $infoColor
$rulesStructure | ConvertTo-Json -Depth 4 | Write-Host -ForegroundColor $highlightColor

# Generate directory creation script
function Generate-DirectoryCreationScript {
    param (
        [hashtable]$Structure,
        [string]$BasePath,
        [string]$BaseVariable,
        [string]$RelativePath = "",
        [string]$CurrentPath = ""
    )

    $script = ""

    foreach ($key in $Structure.Keys) {
        $newRelativePath = if ($RelativePath) { "$RelativePath/$key" } else { $key }
        $newCurrentPath = if ($CurrentPath) { "$CurrentPath$key/" } else { "$BaseVariable" }
        $varName = ($newRelativePath -replace "[^a-zA-Z0-9]", "_") + "Dir"

        $script += "`$$varName = Join-Path -Path $CurrentPath -ChildPath `"$key`"`n"
        $script += "Create-Directory -Path `$$varName`n"

        if ($Structure[$key].Count -gt 0) {
            $script += Generate-DirectoryCreationScript -Structure $Structure[$key] -BasePath $BasePath -BaseVariable $BaseVariable -RelativePath $newRelativePath -CurrentPath "`$$varName"
        }
    }

    return $script
}

# Generate directory creation code for memory-bank
$memoryBankCreationScript = Generate-DirectoryCreationScript -Structure $memoryBankStructure -BasePath "memory-bank" -BaseVariable "`$memoryBankDir"

# Generate directory creation code for rules
$rulesCreationScript = Generate-DirectoryCreationScript -Structure $rulesStructure -BasePath ".cursor/rules" -BaseVariable "`$rulesDir"

# Discover current memory files
$activeMemoryFiles = Get-ChildItem -Path (Join-Path -Path $parentDir -ChildPath "memory-bank/core/active") -File | Where-Object { $_.Extension -eq ".md" }

$memoryFileTemplateScript = ""
foreach ($file in $activeMemoryFiles) {
    $fileName = $file.Name
    $variableName = ($fileName -replace "\.md$", "") + "Template"
    $memoryFileTemplateScript += "`$$variableName = @'"

    # Get first 30 lines of the file as a template, more than that would be excessive
    $fileContent = Get-Content -Path $file.FullName -TotalCount 30
    $memoryFileTemplateScript += "`n" + ($fileContent -join "`n")
    $memoryFileTemplateScript += "`n[... Additional content truncated for template ...]"
    $memoryFileTemplateScript += "`n'@`n`n"
}

# Add file creation script
$fileCreationScript = ""
foreach ($file in $activeMemoryFiles) {
    $fileName = $file.Name
    $variableName = ($fileName -replace "\.md$", "") + "Template"
    $fileCreationScript += "Create-FileIfNotExists -Path (Join-Path -Path `$coreActiveDir -ChildPath `"$fileName`") -Content `$$variableName`n"
}

# Generate new initialization script
$newInitScriptContent = @"
# BIG BRAIN Memory Bank 2.0 Initialization Script
# This script initializes the complete BIG BRAIN Memory Bank structure with all required directories and files.
# Auto-generated on $(Get-Date -Format "yyyy-MM-dd HH:mm:ss")

Write-Host "🧠 BIG BRAIN Memory Bank 2.0 Initialization" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan

# Get the current script directory and parent directory
`$scriptDir = `$PSScriptRoot
`$rootDir = Split-Path -Parent `$scriptDir

# Define directory paths
`$cursorDir = Join-Path -Path `$rootDir -ChildPath ".cursor"
`$rulesDir = Join-Path -Path `$cursorDir -ChildPath "rules"
`$bigBrainRulesDir = Join-Path -Path `$rulesDir -ChildPath "BIG_BRAIN"
`$codebaseRulesDir = Join-Path -Path `$rulesDir -ChildPath "Codebase"

`$memoryBankDir = Join-Path -Path `$rootDir -ChildPath "memory-bank"
`$coreDir = Join-Path -Path `$memoryBankDir -ChildPath "core"
`$coreActiveDir = Join-Path -Path `$coreDir -ChildPath "active"

# Create directory structure function
function Create-Directory {
    param (
        [string]`$Path
    )

    if (-not (Test-Path -Path `$Path)) {
        New-Item -ItemType Directory -Force -Path `$Path | Out-Null
        Write-Host "  Created directory: `$Path" -ForegroundColor Green
    }
    else {
        Write-Host "  Directory already exists: `$Path" -ForegroundColor Yellow
    }
}

# Create all directories
Write-Host "Creating directory structure..." -ForegroundColor Cyan

# Create basic structure
Create-Directory -Path `$cursorDir
Create-Directory -Path `$rulesDir
Create-Directory -Path `$bigBrainRulesDir
Create-Directory -Path `$codebaseRulesDir
Create-Directory -Path `$memoryBankDir
Create-Directory -Path `$coreDir
Create-Directory -Path `$coreActiveDir

# Create memory-bank structure
$memoryBankCreationScript

# Create rules structure
$rulesCreationScript

# Create file function
function Create-FileIfNotExists {
    param (
        [string]`$Path,
        [string]`$Content
    )

    if (-not (Test-Path -Path `$Path)) {
        Set-Content -Path `$Path -Value `$Content
        Write-Host "  Created file: `$Path" -ForegroundColor Green
    }
    else {
        Write-Host "  File already exists: `$Path" -ForegroundColor Yellow
    }
}

# Create memory file templates
$memoryFileTemplateScript

# Create memory files
Write-Host "Creating memory files..." -ForegroundColor Cyan
$fileCreationScript

Write-Host "🎉 BIG BRAIN Memory Bank 2.0 initialization complete!" -ForegroundColor Cyan
Write-Host "You can now use BIG BRAIN with your project." -ForegroundColor Cyan
Write-Host "Remember to use the 'BIG' command to start your interactions." -ForegroundColor Cyan
"@

# Write new initialization script
Set-Content -Path $tempInitScriptPath -Value $newInitScriptContent

# Generate shell script version - simpler approach with basic replacements
$shScriptContent = $newInitScriptContent -replace "Write-Host", "echo" `
                                        -replace "-ForegroundColor \w+", "" `
                                        -replace "\`$PSScriptRoot", '$(dirname "$(readlink -f "$0")")' `
                                        -replace "New-Item -ItemType Directory -Force -Path", "mkdir -p" `
                                        -replace "Set-Content -Path", "cat >" `
                                        -replace "\| Out-Null", "" `
                                        -replace "function ", "" `
                                        -replace "param \(", "() {\n    local " `
                                        -replace "\[string\]", "" `
                                        -replace "\)", "" `
                                        -replace "if \(-not \(Test-Path -Path ", "if [ ! -d " `
                                        -replace "if \(-not \(Test-Path ", "if [ ! -f " `
                                        -replace "\)\)", " ]" `
                                        -replace "else", "    else" `
                                        -replace "Join-Path -Path (.*?) -ChildPath (.*?)", '$1/$2' `
                                        -replace "@'", '"' `
                                        -replace "'@", '"'

# Add the shebang line
$shScriptContent = "#!/bin/bash`n`n" + $shScriptContent

# Create destination directories if they don't exist (in case of organized structure)
$initDir = Join-Path -Path $rootDir -ChildPath "Init"
if (-not (Test-Path -Path $initDir)) {
    New-Item -ItemType Directory -Path $initDir -Force | Out-Null
    Write-Host "Created Init directory: $initDir" -ForegroundColor $infoColor
}

# Check and replace the initialization script
if (Test-Path -Path $tempInitScriptPath) {
    # Update primary script location
    if (Test-Path -Path ($rootDir + "\Initialize-MemoryBank.ps1")) {
        Remove-Item -Path ($rootDir + "\Initialize-MemoryBank.ps1")
    }
    Move-Item -Path $tempInitScriptPath -Destination ($rootDir + "\Initialize-MemoryBank.ps1")

    # Also update the script in the organized structure
    Copy-Item -Path ($rootDir + "\Initialize-MemoryBank.ps1") -Destination (Join-Path -Path $initDir -ChildPath "Initialize-MemoryBank.ps1") -Force

    # Update Bash script at primary location
    Set-Content -Path ($rootDir + "\Initialize-MemoryBank.sh") -Value $shScriptContent

    # Also update the Bash script in the organized structure
    Set-Content -Path (Join-Path -Path $initDir -ChildPath "Initialize-MemoryBank.sh") -Value $shScriptContent

    Write-Host "✅ Successfully updated initialization scripts:" -ForegroundColor $successColor
    Write-Host "  - $rootDir\Initialize-MemoryBank.ps1" -ForegroundColor $successColor
    Write-Host "  - $rootDir\Initialize-MemoryBank.sh" -ForegroundColor $successColor
    Write-Host "  - $initDir\Initialize-MemoryBank.ps1" -ForegroundColor $successColor
    Write-Host "  - $initDir\Initialize-MemoryBank.sh" -ForegroundColor $successColor
}
else {
    Write-Host "❌ Failed to generate updated initialization script." -ForegroundColor $errorColor
}

# Make the shell script executable
$shellScripts = @(
    "$rootDir\Initialize-MemoryBank.sh",
    "$initDir\Initialize-MemoryBank.sh"
)

foreach ($shellScript in $shellScripts) {
    if (Test-Path -Path $shellScript) {
        if ($PSVersionTable.Platform -eq "Unix") {
            try {
                # If on Unix-like system, make the shell script executable
                & chmod +x $shellScript
                Write-Host "✅ Made shell script executable: $shellScript" -ForegroundColor $successColor
            }
            catch {
                Write-Host "⚠️ Unable to make shell script executable: $shellScript - $_" -ForegroundColor $highlightColor
                Write-Host "You may need to manually run: chmod +x $shellScript" -ForegroundColor $highlightColor
            }
        }
    }
}

# Function to detect if PowerShell Core is available
function Test-PowerShellCore {
    try {
        $null = Get-Command pwsh -ErrorAction Stop
        return $true
    }
    catch {
        return $false
    }
}

# Cross-platform functionality
Write-Host "`nCross-Platform Script Information:" -ForegroundColor $infoColor
if ($PSVersionTable.PSEdition -eq "Core") {
    Write-Host "✅ Running on PowerShell Core - scripts will work cross-platform." -ForegroundColor $successColor
}
elseif (Test-PowerShellCore) {
    Write-Host "ℹ️ PowerShell Core is available on this system." -ForegroundColor $infoColor
    Write-Host "   For full cross-platform support, run this script with 'pwsh' instead of 'powershell'." -ForegroundColor $infoColor
}
else {
    Write-Host "⚠️ Running on Windows PowerShell - limited cross-platform capabilities." -ForegroundColor $highlightColor
    Write-Host "   For Unix/Linux systems, use the shell script: $initScriptShPath" -ForegroundColor $highlightColor
}

Write-Host "`nTo see all available scripts and their organization, check ScriptCatalog.md in the scripts folder." -ForegroundColor $infoColor
Write-Host "Initialization script update complete!" -ForegroundColor $successColor