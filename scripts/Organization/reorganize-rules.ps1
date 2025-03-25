# Script to reorganize .cursor/rules folder based on BIG BRAIN Memory System hierarchical design
# Implements the standardized naming convention and directory structure

# Base paths
$rulesPath = ".\.cursor\rules"
$bigBrainPath = "$rulesPath\BIG_BRAIN"

# Create main directory structure
$directories = @(
    # Core components (0000-0999)
    "$bigBrainPath\core",

    # Memory system components (1000-1999)
    "$bigBrainPath\memory-system",
    "$bigBrainPath\memory-system\active",
    "$bigBrainPath\memory-system\short-term",
    "$bigBrainPath\memory-system\long-term",
    "$bigBrainPath\memory-system\workflows",
    "$bigBrainPath\memory-system\plan",
    "$bigBrainPath\memory-system\act",
    "$bigBrainPath\memory-system\testing",
    "$bigBrainPath\memory-system\tools",
    "$bigBrainPath\memory-system\tools\maintenance",
    "$bigBrainPath\memory-system\tools\verify",

    # Documentation standards (400-499)
    "$rulesPath\documentation",

    # Rule guidelines
    "$rulesPath\rule_guidelines",

    # Templates (900-999)
    "$rulesPath\templates"
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
# Format: "existing_path" = "new_path_with_new_name"
$fileMappings = @{
    # BIG BRAIN Core (0000-0999)
    "$rulesPath\000-big-brain-identity.mdc" = "$bigBrainPath\core\0000-big-brain-identity.mdc"
    "$rulesPath\Core\150-standard-initialization-procedure.mdc" = "$bigBrainPath\core\0010-standard-initialization-procedure.mdc"
    "$rulesPath\Core\170-protocol-enforcement-mechanisms.mdc" = "$bigBrainPath\core\0020-protocol-enforcement-mechanisms.mdc"
    "$rulesPath\Core\090-big-command-protocol.mdc" = "$bigBrainPath\core\0050-big-command-protocol.mdc"
    "$rulesPath\Core\140-unified-command-interface.mdc" = "$bigBrainPath\core\0060-unified-command-interface.mdc"

    # Memory System Core (1000-1099)
    "$bigBrainPath\memory-system\0050-big-brain-memory-system.mdc" = "$bigBrainPath\memory-system\1000-memory-core-system.mdc"

    # Memory Reading & Writing (1010-1099)
    "$rulesPath\Core\100-memory-file-verification.mdc" = "$bigBrainPath\memory-system\1010-memory-reading-protocol.mdc"
    "$rulesPath\Core\110-automated-consistency-checks.mdc" = "$bigBrainPath\memory-system\1020-memory-writing-protocol.mdc"

    # Memory File Types (1100-1199)
    # Create new files for these

    # Memory Operations (1200-1299)
    "$rulesPath\Core\120-error-recovery-protocols.mdc" = "$bigBrainPath\memory-system\tools\maintenance\1200-error-recovery-protocols.mdc"

    # Planning Aspects (1400-1499)
    "$rulesPath\Core\040-enhanced-complexity-framework.mdc" = "$bigBrainPath\memory-system\plan\1400-complexity-framework.mdc"
    "$rulesPath\Core\180-creative-process-structure.mdc" = "$bigBrainPath\memory-system\plan\1410-creative-process.mdc"
    "$rulesPath\Core\080-creative-phase-metrics.mdc" = "$bigBrainPath\memory-system\plan\1420-creative-phase-metrics.mdc"

    # Action Aspects (1500-1599)
    "$rulesPath\Core\190-evaluation-metrics-system.mdc" = "$bigBrainPath\memory-system\act\1500-evaluation-metrics.mdc"
    "$rulesPath\Core\210-artifact-management-system.mdc" = "$bigBrainPath\memory-system\act\1510-artifact-management.mdc"

    # Testing (1600-1699)
    "$rulesPath\Core\130-validation-reporting-system.mdc" = "$bigBrainPath\memory-system\testing\1600-testing-standards.mdc"

    # Tools (1700-1799)
    "$rulesPath\Core\200-quality-verification-procedures.mdc" = "$bigBrainPath\memory-system\tools\1700-quality-verification.mdc"
    "$rulesPath\Core\050-reference-verification-system.mdc" = "$bigBrainPath\memory-system\tools\verify\1710-reference-verification.mdc"

    # Workflows (1800-1899)
    "$rulesPath\Core\160-workflow-orchestration.mdc" = "$bigBrainPath\memory-system\workflows\1800-memory-operations.mdc"
    "$rulesPath\Core\070-section-checkpoint-system.mdc" = "$bigBrainPath\memory-system\tools\maintenance\1810-section-checkpoint.mdc"
    "$rulesPath\Core\060-task-escalation-protocol.mdc" = "$bigBrainPath\memory-system\1820-task-escalation-protocol.mdc"

    # Documentation standards
    # Rule guidelines files should stay in place

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

        # Read the content of the source file
        $content = Get-Content -Path $source -Raw

        # Update the file content to match new naming conventions and context
        # This is a simplified transformation - complex files might need more specific handling
        $newFileName = Split-Path -Path $destination -Leaf
        $fileNumber = $newFileName.Substring(0, 4)

        # Update metadata in file content based on number range
        if ($fileNumber -like "0*") {
            # Core BIG BRAIN rule
            $content = $content -replace 'description: .*', "description: BIG BRAIN Core Standard: $(Split-Path -Path $destination -Leaf -Resolve)"
        }
        elseif ($fileNumber -like "1*") {
            # Memory system rule
            $content = $content -replace 'description: .*', "description: Memory System: $(Split-Path -Path $destination -Leaf -Resolve)"
        }

        # Write updated content to the destination
        Set-Content -Path $destination -Value $content -Force

    } else {
        Write-Host "Source file not found: $source" -ForegroundColor Yellow
    }
}

# Create critical new files that don't exist yet
$newFiles = @{
    # Active Memory Management
    "$bigBrainPath\memory-system\active\1100-active-memory-management.mdc" = @"
---
description: Primary rules for managing active memory files in the memory-bank
globs:
  - "memory-bank/active/**/*.md"
alwaysApply: false
---

<version>1.0.0</version>

<context>
  This rule governs how active memory files are managed within the BIG BRAIN memory system.
  Active memory represents the current working context and is the most frequently accessed memory type.
</context>

<requirements>
  <requirement>Maintain all active memory files with current, accurate information</requirement>
  <requirement>Update active files when significant new information is discovered</requirement>
  <requirement>Ensure consistent formatting and organization across active files</requirement>
  <requirement>Preserve important active file content during the Bedtime Protocol</requirement>
</requirements>

<rule>
## Active Memory Management Protocol

1. Active Memory Files:
   - projectbrief.md: Project foundation and requirements
   - productContext.md: Business and user perspective
   - activeContext.md: Current work focus and state
   - systemPatterns.md: Technical architecture patterns
   - techContext.md: Technology stack and environment
   - progress.md: Project status and roadmap
   - tasks.md: Task tracking and assignments
   - projectRules.md: Project-specific patterns and rules

2. Active Memory Operations:
   - Begin each significant task by reviewing all active memory files
   - Update activeContext.md at the start of each new work session
   - Add new technical patterns to systemPatterns.md as they emerge
   - Update progress.md when features are completed or milestones reached
   - Maintain tasks.md as the single source of truth for task tracking

3. Active Memory Maintenance:
   - Keep active memory files concise and focused on current information
   - Remove outdated information by moving it to appropriate long-term storage
   - Maintain consistent formatting within each active file
   - Verify active memory integrity after significant updates
</rule>
"@

    # Short-term Memory Management
    "$bigBrainPath\memory-system\short-term\1200-short-term-memory-management.mdc" = @"
---
description: Guidelines for managing short-term memory in the memory-bank
globs:
  - "memory-bank/short-term/**/*.md"
alwaysApply: false
---

<version>1.0.0</version>

<context>
  This rule governs how short-term memory files are managed within the BIG BRAIN memory system.
  Short-term memory represents recently used information that is not part of the current active context.
</context>

<requirements>
  <requirement>Maintain versions of recently modified active files</requirement>
  <requirement>Implement proper versioning for files moved to short-term memory</requirement>
  <requirement>Periodically review short-term memory for archival to long-term memory</requirement>
</requirements>

<rule>
## Short-term Memory Management Protocol

1. Short-term Memory Purpose:
   - Store previous versions of active files (1-2 sessions old)
   - Maintain temporary information pending categorization
   - Hold recent session summaries before permanent archival

2. Versioning Protocol:
   - When an active file is significantly modified, move the previous version to short-term memory
   - Use date-based versioning: filename_YYYY-MM-DD.md
   - Maintain a maximum of 3 versions of each file in short-term memory

3. Short-term to Long-term Transition:
   - Review short-term memory files after 3 sessions
   - Consolidate important information to appropriate long-term memory locations
   - Archive complete session summaries to episodic memory
</rule>
"@

    # Long-term Memory Management
    "$bigBrainPath\memory-system\long-term\1300-long-term-memory-management.mdc" = @"
---
description: Guidelines for managing long-term memory in the memory-bank
globs:
  - "memory-bank/long-term/**/*.md"
alwaysApply: false
---

<version>1.0.0</version>

<context>
  This rule governs how long-term memory files are organized and managed within the BIG BRAIN memory system.
  Long-term memory represents archived information categorized by cognitive memory type.
</context>

<requirements>
  <requirement>Categorize all long-term memory by appropriate memory type</requirement>
  <requirement>Maintain consistent organization within each memory type</requirement>
  <requirement>Implement proper cross-referencing between related memory items</requirement>
</requirements>

<rule>
## Long-term Memory Management Protocol

1. Long-term Memory Categories:
   - Episodic Memory (experience-based):
     * sessions/: Session summaries and experiences
     * milestones/: Project milestone records
     * decisions/: Decision records and justifications

   - Semantic Memory (knowledge-based):
     * domain/: Domain concepts and terminology
     * apis/: API documentation and usage patterns
     * features/: Feature specifications and requirements

   - Procedural Memory (action-based):
     * workflows/: Development and operational processes
     * guides/: How-to guides and tutorials
     * checklists/: Operational procedures and checklists

   - Creative Memory (design outputs):
     * architecture/: System architecture designs
     * components/: Component designs and patterns
     * algorithms/: Algorithm designs and implementations
     * data-models/: Data structure designs

2. Long-term Memory Operations:
   - Add information to long-term memory only after verification
   - Categorize information based on content type, not source
   - Maintain consistent file organization within each memory type
   - Create cross-references between related memory items

3. Memory Retrieval Protocol:
   - Access episodic memory for historical context and decisions
   - Use semantic memory for domain knowledge and feature information
   - Reference procedural memory for "how-to" guidance
   - Leverage creative memory for design patterns and solutions
</rule>
"@

    # Bedtime Protocol
    "$bigBrainPath\memory-system\workflows\1810-bedtime-protocol.mdc" = @"
---
description: CRITICAL: Bedtime Protocol procedures for memory preservation. CONSULT before ending sessions.
globs:
  - "memory-bank/**/*.md"
alwaysApply: false
---

<version>1.0.0</version>

<context>
  The Bedtime Protocol is a critical workflow that ensures proper memory preservation between sessions.
  It must be executed completely before ending any significant work session.
</context>

<requirements>
  <requirement>Update all core memory files with latest information</requirement>
  <requirement>Create session summary in activeContext.md</requirement>
  <requirement>Archive important information to appropriate memory types</requirement>
  <requirement>Verify memory consistency across all files</requirement>
</requirements>

<rule>
## Bedtime Protocol Workflow

1. Memory Update Phase:
   - Update the following core files with latest information:
     * activeContext.md: Current focus and state
     * progress.md: Working features and known issues
     * tasks.md: Current task status and next actions
     * systemPatterns.md: If architectural changes were made
     * techContext.md: If technology changes were made
     * projectRules.md: If new patterns or preferences were established

2. Session Summary Creation:
   - Create a session summary in activeContext.md using this format:
     ```markdown
     ## 📊 SESSION SUMMARY (YYYY-MM-DD)

     ### Accomplishments
     - [Brief description of completed work]

     ### Current State
     - [Description of the current system state]
     - [Current task progress: N%]

     ### Next Actions
     1. [Specific next step with detailed context]
     2. [Another specific next step]

     ### Open Questions
     - [Question that needs resolution]
     - [Decision that needs to be made]

     ### Critical Notes
     - [Any information essential for continuation]
     ```

3. Memory Archival Phase:
   - Version active files that have changed:
     * Copy to short-term/ directory with date suffix
   - Archive important information to long-term/:
     * Move session summary to episodic/sessions/
     * Add new discoveries to semantic/domain/
     * Document new workflows in procedural/workflows/
     * Archive design decisions in creative/

4. Verification Phase:
   - Verify consistency across all memory files
   - Ensure all architectural decisions are documented
   - Confirm current state is accurately reflected
   - Validate working features and issues are up-to-date

5. Completion Confirmation:
   - Provide final confirmation:
     ```markdown
     ## ✅ BEDTIME PROTOCOL COMPLETE

     The memory preservation protocol has been successfully executed. All critical
     information has been documented and the system state has been preserved.

     Memory files updated:
     - [list of updated files]

     Continuation point established in activeContext.md

     You may safely end this session.
     ```
</rule>
"@
}

# Create new files
foreach ($newFile in $newFiles.GetEnumerator()) {
    $path = $newFile.Key
    $content = $newFile.Value

    # Create directory if it doesn't exist
    $dir = Split-Path -Path $path -Parent
    if (-not (Test-Path $dir)) {
        New-Item -ItemType Directory -Path $dir -Force | Out-Null
    }

    Write-Host "Creating new file: $path"
    Set-Content -Path $path -Value $content -Force
}

Write-Host "`nReorganization complete!" -ForegroundColor Green
Write-Host "The script has created a new hierarchical memory system rules structure."
Write-Host "Original files have been kept in their locations."
Write-Host "To clean up original files, run the delete-original-rules.ps1 script after verification."