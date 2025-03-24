#!/usr/bin/env pwsh
# BIG BRAIN Memory Bank 2.0 Bootstrapper
# This script initializes the complete BIG BRAIN Memory Bank structure in the user's project
# with an interactive questionnaire to personalize the setup.

#region Script Configuration
$script:Version = "1.0.0"
$script:Colors = @{
    Title = "Cyan"
    Subtitle = "Magenta"
    Success = "Green"
    Warning = "Yellow"
    Error = "Red"
    Question = "Blue"
    Info = "Gray"
}
#endregion

#region Banner Functions
function Show-Banner {
    Clear-Host
    Write-Host "=====================================================================" -ForegroundColor $Colors.Title
    Write-Host "                  BIG BRAIN Memory Bank 2.0 Setup                    " -ForegroundColor $Colors.Title
    Write-Host "=====================================================================" -ForegroundColor $Colors.Title
    Write-Host ""
    Write-Host " This script will initialize the BIG BRAIN Memory Bank system in your" -ForegroundColor $Colors.Info
    Write-Host " project, creating all necessary directories and files with personalized" -ForegroundColor $Colors.Info
    Write-Host " information based on your responses." -ForegroundColor $Colors.Info
    Write-Host ""
    Write-Host " Version ${Version} | $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')" -ForegroundColor $Colors.Subtitle
    Write-Host "=====================================================================" -ForegroundColor $Colors.Title
    Write-Host ""
}
#endregion

#region Project Questionnaire
function Get-ProjectInfo {
    Write-Host "PROJECT QUESTIONNAIRE" -ForegroundColor $Colors.Subtitle
    Write-Host "Please provide some information about your project to personalize your Memory Bank." -ForegroundColor $Colors.Info
    Write-Host ""

    $projectInfo = @{}

    # Project name
    $projectInfo.Name = Read-UserInput "Project name" "MyProject"

    # Project description
    $projectInfo.Description = Read-UserInput "Project description" "A software project using BIG BRAIN Memory Bank"

    # Project primary language/framework
    $projectInfo.PrimaryTech = Read-UserInput "Primary technology (language/framework)" "Python/Django"

    # Project complexity (1-4)
    $complexityDefault = 2
    do {
        $complexityInput = Read-UserInput "Project complexity (1-4, where 4 is most complex)" $complexityDefault
        $complexity = 0
        if ([int]::TryParse($complexityInput, [ref]$complexity) -and $complexity -ge 1 -and $complexity -le 4) {
            $projectInfo.Complexity = $complexity
            $validComplexity = $true
        } else {
            Write-Host "Please enter a number between 1 and 4." -ForegroundColor $Colors.Warning
            $validComplexity = $false
        }
    } while (-not $validComplexity)

    # Project owner
    $projectInfo.Owner = Read-UserInput "Project owner/team" "Your Name/Team"

    # Project goals
    $projectInfo.Goals = Read-UserInput "Primary project goal" "Build a functional application with comprehensive documentation"

    Write-Host ""
    Write-Host "Thank you for providing your project information!" -ForegroundColor $Colors.Success
    Write-Host ""

    return $projectInfo
}

function Read-UserInput {
    param (
        [string]$Prompt,
        [string]$Default
    )

    Write-Host "$Prompt" -ForegroundColor $Colors.Question -NoNewline
    if ($Default) {
        Write-Host " (default: $Default): " -ForegroundColor $Colors.Info -NoNewline
    } else {
        Write-Host ": " -ForegroundColor $Colors.Info -NoNewline
    }

    $input = Read-Host

    if ([string]::IsNullOrWhiteSpace($input) -and $Default) {
        return $Default
    }

    return $input
}
#endregion

#region Utility Functions
function Create-DirectoryIfNotExists {
    param (
        [string]$Path,
        [string]$Description = "directory"
    )

    if (-not (Test-Path -Path $Path)) {
        New-Item -ItemType Directory -Force -Path $Path | Out-Null
        Write-Host "  Created ${Description}: $Path" -ForegroundColor $Colors.Success
        return $true
    } else {
        Write-Host "  ${Description} already exists: $Path" -ForegroundColor $Colors.Warning
        return $false
    }
}

function Create-FileIfNotExists {
    param (
        [string]$Path,
        [string]$Content,
        [string]$Description = "file"
    )

    if (-not (Test-Path -Path $Path)) {
        Set-Content -Path $Path -Value $Content -Encoding UTF8
        Write-Host "  Created ${Description}: $Path" -ForegroundColor $Colors.Success
        return $true
    } else {
        Write-Host "  ${Description} already exists: $Path" -ForegroundColor $Colors.Warning
        return $false
    }
}

function Update-GitIgnore {
    # Check if .gitignore exists, create if not
    if (-not (Test-Path -Path ".gitignore")) {
        Write-Host "  Creating .gitignore file..." -ForegroundColor $Colors.Info
        New-Item -ItemType File -Path ".gitignore" | Out-Null
    }

    # Check if memory-bank already exists in .gitignore
    $memoryBankIgnored = $false
    if (Test-Path -Path ".gitignore") {
        $memoryBankIgnored = Get-Content ".gitignore" -ErrorAction SilentlyContinue | Where-Object { $_ -match "memory-bank/\*" }
    }

    if (-not $memoryBankIgnored) {
        Write-Host "  Adding memory-bank to .gitignore..." -ForegroundColor $Colors.Info
        Add-Content -Path ".gitignore" -Value "`n# BIG BRAIN Memory Bank files`nmemory-bank/*`n!memory-bank/.gitkeep`n"

        # Commit the updated .gitignore if git repository exists
        if (Test-Path -Path ".git") {
            $commitChanges = Read-UserInput "Commit .gitignore changes? (y/n)" "y"
            if ($commitChanges -eq "y") {
                git add .gitignore
                git commit -m "Update .gitignore for BIG BRAIN Memory Bank"
                Write-Host "  Committed .gitignore changes" -ForegroundColor $Colors.Success
            }
        }
    }
}
#endregion

#region Template Generation Functions
function Generate-TemplateContent {
    param (
        [hashtable]$ProjectInfo
    )

    $templates = @{}

    # projectbrief.md
    $templates.ProjectBrief = @"
# Project Brief

## 📋 Project Overview

$($ProjectInfo.Description)

This project aims to create a comprehensive solution that meets the
requirements and goals outlined below while maintaining high standards of
quality and documentation.

## 🎯 Core Requirements

- Create a robust $($ProjectInfo.PrimaryTech) application
- Implement all required functionality
- Ensure comprehensive documentation
- Establish a maintainable codebase
- Build with scalability in mind

## 📱 Major Features

- [Feature 1: Description]
- [Feature 2: Description]
- [Feature 3: Description]
- [Additional features as required]

## 🔬 Target Users/Audience

- [User Group 1: Description]
- [User Group 2: Description]
- [User Group 3: Description]

## 🛠️ Development Constraints

- Timeline: [Specify project timeline]
- Budget: [Budget constraints if applicable]
- Technical constraints: [Any technical limitations]
- Integration requirements: [Required third-party integrations]

## 📏 Success Criteria

- [Criterion 1: How will we measure success?]
- [Criterion 2: Performance expectations]
- [Criterion 3: Quality benchmarks]
- [Criterion 4: User satisfaction metrics]

## 📈 Project Complexity Analysis

This project has been assessed as Complexity Level $($ProjectInfo.Complexity) (on a scale of 1-4). This
means:

- [Corresponding process rigor level]
- [Documentation requirements]
- [Verification standards]
- [Planning intensity]
"@

    # productContext.md
    $templates.ProductContext = @"
# Product Context

## 🔍 Problem Statement

[Describe the problem this project is solving]

## 👥 User Personas

### [Primary User Type]

- **Background**: [Typical background of this user type]
- **Goals**: [What they want to accomplish]
- **Frustrations**: [Pain points this product addresses]
- **How Our Product Helps**: [How we solve their problems]

### [Secondary User Type]

- **Background**: [Typical background of this user type]
- **Goals**: [What they want to accomplish]
- **Frustrations**: [Pain points this product addresses]
- **How Our Product Helps**: [How we solve their problems]

## 🎯 Key User Stories

- As a [user type], I want to [action] so that [benefit].
- As a [user type], I want to [action] so that [benefit].
- As a [user type], I want to [action] so that [benefit].

## 🔄 Business Process Impact

- [How does this product change existing processes?]
- [What workflows are being automated or improved?]
- [Key metrics that will be impacted]

## 🏆 Business Value Proposition

- [Revenue impact]
- [Cost reduction]
- [Efficiency improvements]
- [Competitive advantage]

## 🧩 Product Ecosystem

- [How does this fit with other products/systems?]
- [Dependencies on other systems]
- [Products that depend on this]

## 📌 Product Roadmap

### Current Phase
- [Key features and focus]

### Future Phases
- [Planned enhancements]
- [Expansion opportunities]
- [Long-term vision]
"@

    # activeContext.md
    $templates.ActiveContext = @"
# Active Context

## _Last Updated: $(Get-Date -Format "MMMM d, yyyy")_

## Current Focus

[Describe the current focus of development work]

## Recent Changes

[List of recent changes made to the project, most recent first]

- Initialized BIG BRAIN Memory Bank system
- [Other recent changes]

## Development Status

- **Current Branch**: [Active development branch]
- **Active Feature**: [Feature currently being worked on]
- **Blockers**: [Any blocking issues]
- **Next Up**: [What's coming next]

## Current Sprint/Milestone

- **Sprint**: [Current sprint number/name]
- **Key Deliverables**: [Main deliverables for this sprint]
- **Deadline**: [Sprint end date]
- **Progress**: [Status update on sprint goals]

## Active Tasks

1. [Task 1 description and status]
2. [Task 2 description and status]
3. [Task 3 description and status]

## Recent Decisions

- [Decision 1: Description and rationale]
- [Decision 2: Description and rationale]
- [Decision 3: Description and rationale]

## Development Environment

- **Environment**: [Local, staging, production, etc.]
- **Special Configuration**: [Any special env setup needed]
- **Test Data**: [Status of test data]

## Current Complexity Level: ${ProjectInfo.Complexity}

[Implications of the current complexity level]
"@

    # systemPatterns.md
    $templates.SystemPatterns = @"
# System Patterns

This document outlines the system architecture, technical decisions, and component relationships for the $($ProjectInfo.Name) project.

## System Architecture

[Describe the high-level architecture of the system]

```
[Optional: Include a diagram representation of the architecture]
```

## Component Breakdown

### [Component 1]
- **Purpose**: [What this component does]
- **Responsibilities**: [List of responsibilities]
- **Interactions**: [How it interacts with other components]
- **Technical Details**: [Technologies used, special patterns]

### [Component 2]
- **Purpose**: [What this component does]
- **Responsibilities**: [List of responsibilities]
- **Interactions**: [How it interacts with other components]
- **Technical Details**: [Technologies used, special patterns]

### [Component 3]
- **Purpose**: [What this component does]
- **Responsibilities**: [List of responsibilities]
- **Interactions**: [How it interacts with other components]
- **Technical Details**: [Technologies used, special patterns]

## Data Flow

[Describe how data flows through the system]

## API Patterns

[Describe any API patterns or standards used]

## Error Handling Strategy

[Describe the approach to error handling]

## Security Patterns

[Describe security measures and patterns]

## Performance Optimization

[Describe performance optimization techniques]

## Testing Strategy

[Describe the approach to testing]
"@

    # techContext.md
    $templates.TechContext = @"
# Technical Context

## 🛠️ Technology Stack

### Core Implementation

- **Language(s)**: $($ProjectInfo.PrimaryTech)
- **Framework(s)**: [List of frameworks]
- **Database**: [Database technology]
- **Front-end**: [Front-end technologies]
- **Back-end**: [Back-end technologies]

### Infrastructure

- **Hosting**: [Hosting platform]
- **CI/CD**: [CI/CD tools and processes]
- **Monitoring**: [Monitoring tools]
- **Scalability**: [Scaling approach]

### Third-Party Services

- [Service 1: Purpose and integration details]
- [Service 2: Purpose and integration details]
- [Service 3: Purpose and integration details]

## 💻 Development Environment

### Required Tools

- [Tool 1: Version, purpose]
- [Tool 2: Version, purpose]
- [Tool 3: Version, purpose]

### Setup Process

1. [Step 1]
2. [Step 2]
3. [Step 3]

### Environment Variables

- `VARIABLE_1`: [Purpose]
- `VARIABLE_2`: [Purpose]
- `VARIABLE_3`: [Purpose]

## 🔨 Build Process

1. [Step 1]
2. [Step 2]
3. [Step 3]

## 🚀 Deployment Process

1. [Step 1]
2. [Step 2]
3. [Step 3]

## 🧪 Testing Approach

- **Unit Tests**: [Framework and approach]
- **Integration Tests**: [Framework and approach]
- **End-to-End Tests**: [Framework and approach]
- **Performance Tests**: [Framework and approach]

## 🔐 Security Considerations

- [Security consideration 1]
- [Security consideration 2]
- [Security consideration 3]

## 🧮 Performance Considerations

- [Performance consideration 1]
- [Performance consideration 2]
- [Performance consideration 3]

## 📏 Coding Standards

- [Standard 1]
- [Standard 2]
- [Standard 3]
"@

    # progress.md
    $templates.Progress = @"
# Progress Tracking

## 📊 Project Status Overview

**Project**: $($ProjectInfo.Name)
**Status**: Initializing
**Last Updated**: $(Get-Date -Format "MMMM d, yyyy")

## 🏆 Completed Features

- Project initialization
- BIG BRAIN Memory Bank setup

## 🔄 Features In Progress

- [Feature 1: % complete, current focus]
- [Feature 2: % complete, current focus]
- [Feature 3: % complete, current focus]

## 📝 Pending Features

- [Feature 4: not started]
- [Feature 5: not started]
- [Feature 6: not started]

## 🐛 Known Issues

- [Issue 1: description, severity, workaround if available]
- [Issue 2: description, severity, workaround if available]
- [Issue 3: description, severity, workaround if available]

## 🧪 Testing Status

- [Test suite 1: % passing]
- [Test suite 2: % passing]
- [Test suite 3: % passing]

## 📈 Metrics

- [Metric 1: current value, target]
- [Metric 2: current value, target]
- [Metric 3: current value, target]

## 🚧 Technical Debt

- [Item 1: description, impact, plan to address]
- [Item 2: description, impact, plan to address]
- [Item 3: description, impact, plan to address]

## 🗓️ Upcoming Milestones

- [Milestone 1: target date, key deliverables]
- [Milestone 2: target date, key deliverables]
- [Milestone 3: target date, key deliverables]
"@

    # Bedtime Protocol README
    $templates.BedtimeProtocolREADME = @"
# Bedtime Protocol

## Overview

The Bedtime Protocol is a critical process for preserving BIG BRAIN's memory between sessions. This protocol must be followed precisely at the end of each working session to ensure all context is properly saved and will be available in future sessions.

## When to Use

Execute the Bedtime Protocol:
- At the end of each working session
- Before closing Cursor
- When switching to a different task or project that requires a different context

## Protocol Steps

1. **Memory Bank Update**
   - Review and update all core memory files
   - Ensure activeContext.md reflects current status
   - Update progress.md with latest accomplishments
   - Document any new patterns in systemPatterns.md

2. **Memory Archival**
   - Archive important session information to episodic memory
   - Store key decisions in semantic memory
   - Document any new processes in procedural memory

3. **Verification**
   - Verify all memory files are consistent
   - Check for any missing information
   - Ensure all critical context is captured

4. **Memory Indexing**
   - Update memory indexes for faster retrieval
   - Tag important information appropriately
   - Create links between related information

5. **Confirmation**
   - Confirm the Bedtime Protocol completion
   - Verify BIG BRAIN can access all required information

## Automated Tools

The memory-tools directory contains utilities to assist with the Bedtime Protocol:

- memory_manager.py: Tool for managing memory files
- Additional tools for memory verification and indexing

## Execution

To execute the Bedtime Protocol at the end of a session, give the command:

```
BIG execute bedtime protocol
```

This will guide you through the necessary steps to preserve BIG BRAIN's memory.
"@

    return $templates
}
#endregion

#region Directory Creation
function Create-MemoryBankStructure {
    param (
        [string]$RootDir,
        [hashtable]$Templates
    )

    Write-Host "Creating Memory Bank structure..." -ForegroundColor $Colors.Subtitle

    # Create memory-bank and core directories
    $memoryBankDir = Join-Path -Path $RootDir -ChildPath "memory-bank"
    Create-DirectoryIfNotExists -Path $memoryBankDir -Description "memory-bank directory"

    # Create .gitkeep to ensure empty directories are tracked
    $gitkeepPath = Join-Path -Path $memoryBankDir -ChildPath ".gitkeep"
    Create-FileIfNotExists -Path $gitkeepPath -Content "" -Description ".gitkeep file"

    # Create core directory structure
    $coreDir = Join-Path -Path $memoryBankDir -ChildPath "core"
    Create-DirectoryIfNotExists -Path $coreDir -Description "core directory"

    $coreActiveDir = Join-Path -Path $coreDir -ChildPath "active"
    Create-DirectoryIfNotExists -Path $coreActiveDir -Description "core/active directory"

    # Create primary memory files
    Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "projectbrief.md") -Content $Templates.ProjectBrief -Description "projectbrief.md"
    Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "productContext.md") -Content $Templates.ProductContext -Description "productContext.md"
    Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "activeContext.md") -Content $Templates.ActiveContext -Description "activeContext.md"
    Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "systemPatterns.md") -Content $Templates.SystemPatterns -Description "systemPatterns.md"
    Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "techContext.md") -Content $Templates.TechContext -Description "techContext.md"
    Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "progress.md") -Content $Templates.Progress -Description "progress.md"

    # Create additional memory type directories
    $episodicDir = Join-Path -Path $memoryBankDir -ChildPath "episodic"
    Create-DirectoryIfNotExists -Path $episodicDir -Description "episodic directory"
    Create-DirectoryIfNotExists -Path (Join-Path -Path $episodicDir -ChildPath "active") -Description "episodic/active directory"

    $proceduralDir = Join-Path -Path $memoryBankDir -ChildPath "procedural"
    Create-DirectoryIfNotExists -Path $proceduralDir -Description "procedural directory"
    Create-DirectoryIfNotExists -Path (Join-Path -Path $proceduralDir -ChildPath "active") -Description "procedural/active directory"

    $semanticDir = Join-Path -Path $memoryBankDir -ChildPath "semantic"
    Create-DirectoryIfNotExists -Path $semanticDir -Description "semantic directory"
    Create-DirectoryIfNotExists -Path (Join-Path -Path $semanticDir -ChildPath "active") -Description "semantic/active directory"

    # Create Bedtime Protocol directory and files
    $bedtimeDir = Join-Path -Path $memoryBankDir -ChildPath "Bedtime Protocol"
    Create-DirectoryIfNotExists -Path $bedtimeDir -Description "Bedtime Protocol directory"
    Create-FileIfNotExists -Path (Join-Path -Path $bedtimeDir -ChildPath "README.md") -Content $Templates.BedtimeProtocolREADME -Description "Bedtime Protocol README.md"

    # Create memory tools directory
    $memoryToolsDir = Join-Path -Path $bedtimeDir -ChildPath "memory-tools"
    Create-DirectoryIfNotExists -Path $memoryToolsDir -Description "memory-tools directory"
    Create-DirectoryIfNotExists -Path (Join-Path -Path $memoryToolsDir -ChildPath "config_templates") -Description "config_templates directory"
    Create-DirectoryIfNotExists -Path (Join-Path -Path $memoryToolsDir -ChildPath "templates") -Description "templates directory"
    Create-DirectoryIfNotExists -Path (Join-Path -Path $memoryToolsDir -ChildPath "logs") -Description "logs directory"

    Write-Host "Memory Bank structure created successfully!" -ForegroundColor $Colors.Success
}
#endregion

#region Rules Creation
function Create-CursorRules {
    param (
        [string]$RootDir
    )

    Write-Host "Setting up Cursor IDE rules..." -ForegroundColor $Colors.Subtitle

    # Create .cursor/rules directory structure
    $cursorDir = Join-Path -Path $RootDir -ChildPath ".cursor"
    Create-DirectoryIfNotExists -Path $cursorDir -Description ".cursor directory"

    $rulesDir = Join-Path -Path $cursorDir -ChildPath "rules"
    Create-DirectoryIfNotExists -Path $rulesDir -Description "rules directory"

    # Check for existing BIG_BRAIN rules
    $bigBrainRulesDir = Join-Path -Path $rulesDir -ChildPath "BIG_BRAIN"
    $bigBrainRulesDirCreated = Create-DirectoryIfNotExists -Path $bigBrainRulesDir -Description "BIG_BRAIN rules directory"

    # If rules directory exists but we didn't create it, offer to check for conflicts
    if (-not $bigBrainRulesDirCreated -and (Test-Path -Path $bigBrainRulesDir)) {
        $existingRules = @(Get-ChildItem -Path $bigBrainRulesDir -Recurse -File | Select-Object -ExpandProperty FullName)

        if ($existingRules.Count -gt 0) {
            Write-Host "⚠️ Existing BIG BRAIN rules detected:" -ForegroundColor $Colors.Warning
            foreach ($rule in $existingRules) {
                Write-Host "  - $rule" -ForegroundColor $Colors.Warning
            }

            $overwrite = Read-UserInput "Overwrite existing BIG BRAIN rules? (y/n)" "n"
            if ($overwrite -ne "y") {
                Write-Host "Skipping rules creation to preserve existing rules." -ForegroundColor $Colors.Info
                return
            }
        }
    }

    # Create basic rules
    $mainRulePath = Join-Path -Path $bigBrainRulesDir -ChildPath "main.mdc"
    $mainRuleContent = @"
---
title: BIG BRAIN Core Rule
description: The primary rule for BIG BRAIN Memory Bank system.
---

When a user message starts with "BIG" (case-insensitive), you should read all the files in the memory-bank/core/active directory to understand the current project context before responding to their request.

This triggers your full memory bank integration protocol:

1. Always read ALL memory files at the start of EVERY task
2. Pay particular attention to activeContext.md which has the most recent information
3. Ensure your response is consistent with all information in the memory bank
4. If the command includes "update memory bank", review ALL memory bank files, even if some don't require updates

Remember: After every memory reset between sessions, you begin completely fresh. The Memory Bank is your ONLY link to previous work.
"@

    Create-FileIfNotExists -Path $mainRulePath -Content $mainRuleContent -Description "main.mdc rule"

    # Create workflow rules
    $workflowsDir = Join-Path -Path $bigBrainRulesDir -ChildPath "Workflows"
    Create-DirectoryIfNotExists -Path $workflowsDir -Description "Workflows rules directory"

    $planModeRulePath = Join-Path -Path $workflowsDir -ChildPath "plan-mode.mdc"
    $planModeRuleContent = @"
---
title: Plan Mode
description: Workflow for strategic planning and design.
---

When the user invokes "BIG switch to plan mode" or similar, you enter a thorough planning mode:

1. Read ALL memory bank files to ensure complete context
2. Focus on requirements analysis, solution design, and implementation planning
3. Think comprehensively about problem exploration before proposing solutions
4. Create detailed implementation plans with well-defined steps
5. Consider future implications and potential challenges
6. Document your planning process clearly for future reference
7. Update activeContext.md to reflect the Plan Mode status
"@

    Create-FileIfNotExists -Path $planModeRulePath -Content $planModeRuleContent -Description "plan-mode.mdc rule"

    $actModeRulePath = Join-Path -Path $workflowsDir -ChildPath "act-mode.mdc"
    $actModeRuleContent = @"
---
title: Act Mode
description: Workflow for implementation and execution.
---

When the user invokes "BIG switch to act mode" or similar, you enter an implementation-focused mode:

1. Read ALL memory bank files to ensure complete context
2. Focus on efficient execution of well-defined plans
3. Produce code, documentation, or content based on established plans
4. Maintain consistency with existing patterns and standards
5. Document changes made during implementation
6. Verify implementation meets requirements
7. Update activeContext.md to reflect the Act Mode status
"@

    Create-FileIfNotExists -Path $actModeRulePath -Content $actModeRuleContent -Description "act-mode.mdc rule"

    # Create Bedtime Protocol rule
    $bedtimeRulePath = Join-Path -Path $bigBrainRulesDir -ChildPath "bedtime-protocol.mdc"
    $bedtimeRuleContent = @"
---
title: Bedtime Protocol
description: End-of-session memory preservation protocol.
---

When the user mentions "Bedtime Protocol", you must:

1. Immediately locate and read memory-bank/Bedtime Protocol/README.md
2. Follow EXACTLY the step-by-step process outlined in that document
3. Execute all required steps with careful attention to detail
4. Update all necessary memory files to preserve context between sessions
5. Ensure all critical information is captured in the appropriate memory files
6. Provide a summary of all updates made during the protocol
7. Confirm the protocol completion to the user

This protocol is CRITICAL for preserving memory between sessions and must be followed precisely.
"@

    Create-FileIfNotExists -Path $bedtimeRulePath -Content $bedtimeRuleContent -Description "bedtime-protocol.mdc rule"

    Write-Host "Cursor IDE rules created successfully!" -ForegroundColor $Colors.Success
}
#endregion

#region Main Script Execution
# Execute the script
try {
    Show-Banner

    # Get project directory
    $rootDir = Get-Location
    Write-Host "Installing BIG BRAIN Memory Bank in: $rootDir" -ForegroundColor $Colors.Info
    Write-Host ""

    # Run project questionnaire
    $projectInfo = Get-ProjectInfo

    # Create memory bank structure with templates
    $templates = Generate-TemplateContent -ProjectInfo $projectInfo
    Create-MemoryBankStructure -RootDir $rootDir -Templates $templates

    # Create cursor rules
    Create-CursorRules -RootDir $rootDir

    # Update .gitignore
    Write-Host "Updating .gitignore..." -ForegroundColor $Colors.Subtitle
    Update-GitIgnore

    Write-Host ""
    Write-Host "=====================================================================" -ForegroundColor $Colors.Success
    Write-Host "                 BIG BRAIN Memory Bank Setup Complete!                " -ForegroundColor $Colors.Success
    Write-Host "=====================================================================" -ForegroundColor $Colors.Success
    Write-Host ""
    Write-Host " To start using BIG BRAIN, type a command beginning with 'BIG', such as:" -ForegroundColor $Colors.Info
    Write-Host " > BIG tell me about this project" -ForegroundColor $Colors.Question
    Write-Host " > BIG switch to plan mode" -ForegroundColor $Colors.Question
    Write-Host " > BIG update memory bank" -ForegroundColor $Colors.Question
    Write-Host ""
    Write-Host " At the end of your session, don't forget to run:" -ForegroundColor $Colors.Info
    Write-Host " > BIG execute bedtime protocol" -ForegroundColor $Colors.Question
    Write-Host ""
    Write-Host "=====================================================================" -ForegroundColor $Colors.Success

} catch {
    Write-Host "Error during setup: $_" -ForegroundColor $Colors.Error
    Write-Host "Stack trace: $($_.ScriptStackTrace)" -ForegroundColor $Colors.Error
}
#endregion