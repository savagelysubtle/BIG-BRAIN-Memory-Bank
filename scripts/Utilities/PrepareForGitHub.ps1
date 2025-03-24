# PrepareForGitHub.ps1
# Script to prepare the BIG BRAIN Memory Bank project for GitHub submission
# Version 2.0.0 (March 24, 2025)

# Define colors for console output
$infoColor = "Cyan"
$successColor = "Green"
$errorColor = "Red"
$warningColor = "Yellow"
$highlightColor = "Magenta"

Write-Host "===================================================" -ForegroundColor $infoColor
Write-Host "  🧠 BIG BRAIN Memory Bank GitHub Preparation" -ForegroundColor $infoColor
Write-Host "===================================================" -ForegroundColor $infoColor
Write-Host ""

# Get script directory and root directory
$scriptDir = $PSScriptRoot
$rootDir = (Get-Item $scriptDir).Parent.Parent.FullName

# Detect environment
Write-Host "Detecting environment..." -ForegroundColor $infoColor
$isWindowsSystem = $PSVersionTable.Platform -eq "Win32NT" -or ($PSVersionTable.PSEdition -eq "Desktop" -or $null -eq $PSVersionTable.Platform)
$isUnixSystem = $PSVersionTable.Platform -eq "Unix"
$isPSCore = $PSVersionTable.PSEdition -eq "Core"

Write-Host "Environment details:" -ForegroundColor $infoColor
Write-Host "  - Operating System: $($isWindowsSystem ? 'Windows' : ($isUnixSystem ? 'Unix/Linux' : 'Unknown'))" -ForegroundColor $infoColor
Write-Host "  - PowerShell Edition: $($isPSCore ? 'Core' : 'Desktop')" -ForegroundColor $infoColor
Write-Host "  - PowerShell Version: $($PSVersionTable.PSVersion)" -ForegroundColor $infoColor
Write-Host "  - Root directory: $rootDir" -ForegroundColor $infoColor
Write-Host ""

# Function to check if a file exists
function Test-FileExists {
    param (
        [string]$FilePath
    )
    $fullPath = Join-Path -Path $rootDir -ChildPath $FilePath
    $exists = Test-Path -Path $fullPath -PathType Leaf
    return $exists
}

# Function to check if a directory exists
function Test-DirectoryExists {
    param (
        [string]$DirPath
    )
    $fullPath = Join-Path -Path $rootDir -ChildPath $DirPath
    $exists = Test-Path -Path $fullPath -PathType Container
    return $exists
}

# Define expected files (updated for current structure)
$expectedFiles = @(
    @{Path = "README.md"; Description = "Main project documentation"},
    @{Path = "LICENSE"; Description = "MIT License file"},
    @{Path = ".gitignore"; Description = "Git ignore configuration"},
    @{Path = ".cursorignore"; Description = "Cursor ignore configuration"},
    @{Path = "CONTRIBUTING.md"; Description = "Contribution guidelines"},
    @{Path = "CODE_OF_CONDUCT.md"; Description = "Code of conduct"},
    @{Path = "CHANGELOG.md"; Description = "Version history tracking"},
    @{Path = "SECURITY.md"; Description = "Security policy"},
    @{Path = "CITATION.cff"; Description = "Citation information"},
    @{Path = "ATTRIBUTION.md"; Description = "Attribution documentation"},
    @{Path = "scripts/Init/Initialize-MemoryBank.ps1"; Description = "PowerShell initialization script"},
    @{Path = "scripts/Init/Initialize-MemoryBank.sh"; Description = "Bash initialization script"},
    @{Path = ".github/pull_request_template.md"; Description = "PR template"},
    @{Path = ".github/ISSUE_TEMPLATE/bug_report.md"; Description = "Bug report template"},
    @{Path = ".github/ISSUE_TEMPLATE/feature_request.md"; Description = "Feature request template"},
    @{Path = ".github/FUNDING.yml"; Description = "Funding information"},
    @{Path = ".github/CODEOWNERS"; Description = "Code ownership definition"},
    @{Path = "docs/index.md"; Description = "Documentation index"},
    @{Path = "docs/Reference/ScriptOrganization.md"; Description = "Script organization reference"}
)

# Define expected directories (updated for current structure)
$expectedDirectories = @(
    @{Path = ".github"; Description = "GitHub configuration files"},
    @{Path = ".github/ISSUE_TEMPLATE"; Description = "Issue templates"},
    @{Path = "memory-bank"; Description = "Main memory bank structure"},
    @{Path = "memory-bank/core"; Description = "Core memory files"},
    @{Path = "memory-bank/episodic"; Description = "Episodic memory files"},
    @{Path = "memory-bank/semantic"; Description = "Semantic memory files"},
    @{Path = "memory-bank/procedural"; Description = "Procedural memory files"},
    @{Path = "memory-bank/Bedtime Protocol"; Description = "Bedtime protocol files"},
    @{Path = ".cursor/rules"; Description = "Cursor rules directory"},
    @{Path = "scripts"; Description = "Scripts directory"},
    @{Path = "scripts/Init"; Description = "Initialization scripts"},
    @{Path = "scripts/Update"; Description = "Update scripts"},
    @{Path = "scripts/Utilities"; Description = "Utility scripts"},
    @{Path = "docs"; Description = "Documentation directory"},
    @{Path = "docs/Guides"; Description = "Documentation guides"},
    @{Path = "docs/Reference"; Description = "Reference documentation"},
    @{Path = "docs/assets"; Description = "Documentation assets"},
    @{Path = "images"; Description = "Image assets"}
)

# Check all expected files
Write-Host "Checking expected files..." -ForegroundColor $highlightColor
$missingFiles = 0
foreach ($file in $expectedFiles) {
    if (Test-FileExists -FilePath $file.Path) {
        Write-Host "✅ Found: $($file.Path) - $($file.Description)" -ForegroundColor $successColor
    } else {
        Write-Host "❌ Missing: $($file.Path) - $($file.Description)" -ForegroundColor $errorColor
        $missingFiles++
    }
}

Write-Host ""
Write-Host "Checking expected directories..." -ForegroundColor $highlightColor
$missingDirs = 0
foreach ($dir in $expectedDirectories) {
    if (Test-DirectoryExists -DirPath $dir.Path) {
        Write-Host "✅ Found: $($dir.Path) - $($dir.Description)" -ForegroundColor $successColor
    } else {
        Write-Host "❌ Missing: $($dir.Path) - $($dir.Description)" -ForegroundColor $errorColor
        $missingDirs++
    }
}

# Check Git setup
Write-Host ""
Write-Host "Checking Git repository setup..." -ForegroundColor $highlightColor
$hasGit = Test-DirectoryExists -DirPath ".git"
if ($hasGit) {
    Write-Host "✅ Git repository is initialized (.git directory exists)" -ForegroundColor $successColor

    # Check for remote
    $gitRemote = git remote -v 2>$null
    if ($gitRemote) {
        Write-Host "✅ Git remote is configured: $gitRemote" -ForegroundColor $successColor
    } else {
        Write-Host "❌ No Git remote configured. You'll need to add a GitHub remote." -ForegroundColor $warningColor
    }

    # Check for commits
    $gitLog = git log --oneline 2>$null
    if ($gitLog) {
        $commitCount = ($gitLog | Measure-Object -Line).Lines
        Write-Host "✅ Repository has $commitCount commit(s)" -ForegroundColor $successColor
    } else {
        Write-Host "❌ No commits yet. You need to create an initial commit." -ForegroundColor $warningColor
    }
} else {
    Write-Host "❌ Git repository not initialized. Run 'git init' first." -ForegroundColor $errorColor
}

# Verify acknowledgments in README
Write-Host ""
Write-Host "Verifying acknowledgments..." -ForegroundColor $highlightColor
$readmeContent = Get-Content -Path (Join-Path -Path $rootDir -ChildPath "README.md") -Raw -ErrorAction SilentlyContinue
if ($null -ne $readmeContent) {
    if ($readmeContent -match "Special thanks to:") {
        Write-Host "✅ README contains acknowledgments section" -ForegroundColor $successColor
    } else {
        Write-Host "❌ README is missing proper acknowledgments section" -ForegroundColor $errorColor
    }

    if ($readmeContent -match "ipenywis") {
        Write-Host "✅ README acknowledges ipenywis" -ForegroundColor $successColor
    } else {
        Write-Host "❌ README is missing acknowledgment to ipenywis" -ForegroundColor $errorColor
    }

    if ($readmeContent -match "Vanzan") {
        Write-Host "✅ README acknowledges Vanzan" -ForegroundColor $successColor
    } else {
        Write-Host "❌ README is missing acknowledgment to Vanzan" -ForegroundColor $errorColor
    }
} else {
    Write-Host "❌ Could not read README.md" -ForegroundColor $errorColor
}

# Check for required Git commands
Write-Host ""
Write-Host "GitHub readiness check:" -ForegroundColor $highlightColor
$missingCount = $missingFiles + $missingDirs

if ($missingCount -gt 0) {
    Write-Host "⚠️ Found $missingCount missing files/directories. Repository is not fully ready." -ForegroundColor $warningColor
} else {
    Write-Host "✅ All expected files and directories are present!" -ForegroundColor $successColor
}

# Final recommendations
Write-Host ""
Write-Host "Recommendations for GitHub submission:" -ForegroundColor $highlightColor
Write-Host "1. Run 'git add .' to stage all files" -ForegroundColor $infoColor
Write-Host "2. Run 'git commit -m \"Initial commit: BIG BRAIN Memory Bank\"' to create initial commit" -ForegroundColor $infoColor
Write-Host "3. Create a GitHub repository at https://github.com/new" -ForegroundColor $infoColor
Write-Host "4. Run 'git remote add origin https://github.com/USERNAME/REPOSITORY.git'" -ForegroundColor $infoColor
Write-Host "5. Run 'git push -u origin master' to push to GitHub" -ForegroundColor $infoColor
Write-Host "6. Verify that all files appear correctly on GitHub" -ForegroundColor $infoColor
Write-Host "7. Enable GitHub Pages in repository settings if desired" -ForegroundColor $infoColor

Write-Host ""
if ($missingCount -eq 0) {
    Write-Host "✅ BIG BRAIN Memory Bank project is ready for GitHub submission!" -ForegroundColor $successColor
} else {
    Write-Host "⚠️ BIG BRAIN Memory Bank project needs attention before GitHub submission." -ForegroundColor $warningColor
    Write-Host "   Please address the missing files/directories noted above." -ForegroundColor $warningColor
}
Write-Host "===================================================" -ForegroundColor $infoColor