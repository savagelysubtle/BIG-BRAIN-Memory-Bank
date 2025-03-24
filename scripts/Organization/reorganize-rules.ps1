# Script to reorganize .cursor/rules folder
# Preserves file naming while organizing by feature type

# Base paths
$rulesPath = ".\.cursor\rules"
$bigBrainPath = "$rulesPath\BIG_BRAIN"
$codebasePath = "$rulesPath\Codebase"

# Create main directory structure
$directories = @(
    "$bigBrainPath\Core\Foundation",
    "$bigBrainPath\Core\Verification",
    "$bigBrainPath\Core\Command",
    "$bigBrainPath\Core\Creative",
    "$bigBrainPath\Core\Checkpoint",
    "$bigBrainPath\Core\Escalation",
    "$bigBrainPath\Identity",
    "$bigBrainPath\Protocols",
    "$bigBrainPath\Utilities",
    "$codebasePath\Languages\Python",
    "$codebasePath\Languages\JavaScript",
    "$codebasePath\Languages\TypeScript",
    "$codebasePath\Frameworks\React",
    "$codebasePath\Frameworks\Django",
    "$codebasePath\Patterns"
)

# Create directories if they don't exist
foreach ($dir in $directories) {
    if (-not (Test-Path $dir)) {
        Write-Host "Creating directory: $dir"
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    } else {
        Write-Host "Directory already exists: $dir"
    }
}

# Define file mappings (source -> destination)
$fileMappings = @{
    # BIG BRAIN Identity
    "$rulesPath\000-big-brain-identity.mdc" = "$bigBrainPath\Identity\000-big-brain-identity.mdc"

    # Foundation Layer
    "$rulesPath\Core\040-enhanced-complexity-framework.mdc" = "$bigBrainPath\Core\Foundation\040-enhanced-complexity-framework.mdc"
    "$rulesPath\Core\050-reference-verification-system.mdc" = "$bigBrainPath\Core\Foundation\050-reference-verification-system.mdc"
    "$rulesPath\Core\060-task-escalation-protocol.mdc" = "$bigBrainPath\Core\Foundation\060-task-escalation-protocol.mdc"
    "$rulesPath\Core\070-section-checkpoint-system.mdc" = "$bigBrainPath\Core\Foundation\070-section-checkpoint-system.mdc"
    "$rulesPath\Core\080-creative-phase-metrics.mdc" = "$bigBrainPath\Core\Foundation\080-creative-phase-metrics.mdc"
    "$rulesPath\Core\090-big-command-protocol.mdc" = "$bigBrainPath\Core\Foundation\090-big-command-protocol.mdc"

    # Verification Framework
    "$rulesPath\Core\100-memory-file-verification.mdc" = "$bigBrainPath\Core\Verification\100-memory-file-verification.mdc"
    "$rulesPath\Core\110-automated-consistency-checks.mdc" = "$bigBrainPath\Core\Verification\110-automated-consistency-checks.mdc"
    "$rulesPath\Core\120-error-recovery-protocols.mdc" = "$bigBrainPath\Core\Verification\120-error-recovery-protocols.mdc"
    "$rulesPath\Core\130-validation-reporting-system.mdc" = "$bigBrainPath\Core\Verification\130-validation-reporting-system.mdc"

    # Command Protocol
    "$rulesPath\Core\140-unified-command-interface.mdc" = "$bigBrainPath\Core\Command\140-unified-command-interface.mdc"
    "$rulesPath\Core\150-standard-initialization-procedure.mdc" = "$bigBrainPath\Core\Command\150-standard-initialization-procedure.mdc"
    "$rulesPath\Core\160-workflow-orchestration.mdc" = "$bigBrainPath\Core\Command\160-workflow-orchestration.mdc"
    "$rulesPath\Core\170-protocol-enforcement-mechanisms.mdc" = "$bigBrainPath\Core\Command\170-protocol-enforcement-mechanisms.mdc"

    # Creative Phase
    "$rulesPath\Core\180-creative-process-structure.mdc" = "$bigBrainPath\Core\Creative\180-creative-process-structure.mdc"
    "$rulesPath\Core\190-evaluation-metrics-system.mdc" = "$bigBrainPath\Core\Creative\190-evaluation-metrics-system.mdc"
    "$rulesPath\Core\200-quality-verification-procedures.mdc" = "$bigBrainPath\Core\Creative\200-quality-verification-procedures.mdc"
    "$rulesPath\Core\210-artifact-management-system.mdc" = "$bigBrainPath\Core\Creative\210-artifact-management-system.mdc"

    # Section Checkpoint
    # Will be added in Phase 5

    # Task Escalation
    # Will be added in Phase 6

    # Keep main.mdc in the root
    # "$rulesPath\main.mdc" remains in place
}

# Copy files to new locations
foreach ($mapping in $fileMappings.GetEnumerator()) {
    $source = $mapping.Key
    $destination = $mapping.Value

    if (Test-Path $source) {
        # Create destination directory if it doesn't exist
        $destinationDir = Split-Path -Path $destination -Parent
        if (-not (Test-Path $destinationDir)) {
            New-Item -ItemType Directory -Path $destinationDir -Force | Out-Null
        }

        Write-Host "Moving file from $source to $destination"
        Copy-Item -Path $source -Destination $destination -Force
    } else {
        Write-Host "Source file not found: $source" -ForegroundColor Yellow
    }
}

# Move language and framework specific files
Write-Host "Processing language and framework specific files..." -ForegroundColor Cyan

# Handle Languages folder
if (Test-Path "$rulesPath\Languages") {
    $languageFiles = Get-ChildItem -Path "$rulesPath\Languages" -Recurse -File
    foreach ($file in $languageFiles) {
        $lang = $file.Name -replace '\..*$', ''
        $targetDir = "$codebasePath\Languages\$lang"

        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }

        $destination = Join-Path -Path $targetDir -ChildPath $file.Name
        Write-Host "Moving language file to $destination"
        Copy-Item -Path $file.FullName -Destination $destination -Force
    }
}

# Handle Frameworks folder
if (Test-Path "$rulesPath\Frameworks") {
    $frameworkFiles = Get-ChildItem -Path "$rulesPath\Frameworks" -Recurse -File
    foreach ($file in $frameworkFiles) {
        $framework = $file.Name -replace '\..*$', ''
        $targetDir = "$codebasePath\Frameworks\$framework"

        if (-not (Test-Path $targetDir)) {
            New-Item -ItemType Directory -Path $targetDir -Force | Out-Null
        }

        $destination = Join-Path -Path $targetDir -ChildPath $file.Name
        Write-Host "Moving framework file to $destination"
        Copy-Item -Path $file.FullName -Destination $destination -Force
    }
}

# Handle Utility folder - move to BIG_BRAIN or Codebase based on content
if (Test-Path "$rulesPath\Utility") {
    $utilityFiles = Get-ChildItem -Path "$rulesPath\Utility" -Recurse -File
    foreach ($file in $utilityFiles) {
        # Determine if this is a BIG BRAIN utility or a codebase utility
        # This is a simplistic approach - you may need more sophisticated logic
        $isBigBrainUtility = $file.Name -match "BIG|BRAIN|memory|checkpoint|validation"

        if ($isBigBrainUtility) {
            $destination = Join-Path -Path "$bigBrainPath\Utilities" -ChildPath $file.Name
            Write-Host "Moving BIG BRAIN utility file to $destination"
        } else {
            $destination = Join-Path -Path "$codebasePath\Patterns" -ChildPath $file.Name
            Write-Host "Moving codebase utility file to $destination"
        }

        Copy-Item -Path $file.FullName -Destination $destination -Force
    }
}

Write-Host "`nReorganization complete!" -ForegroundColor Green
Write-Host "The script has created a new structure with both the original files and the reorganized files."
Write-Host "You can verify the new structure and delete the old folders when ready."
Write-Host "To clean up original folders, run the cleanup script (not included for safety)."