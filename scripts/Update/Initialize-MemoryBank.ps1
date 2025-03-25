# BIG BRAIN Memory Bank 2.0 Initialization Script
# This script initializes the complete BIG BRAIN Memory Bank structure with all required directories and files.
# Auto-generated on 2025-03-25 02:11:06

Write-Host "🧠 BIG BRAIN Memory Bank 2.0 Initialization" -ForegroundColor Cyan
Write-Host "=================================================" -ForegroundColor Cyan

# Get the current script directory and parent directory
$scriptDir = $PSScriptRoot
$rootDir = Split-Path -Parent $scriptDir

# Define directory paths
$cursorDir = Join-Path -Path $rootDir -ChildPath ".cursor"
$rulesDir = Join-Path -Path $cursorDir -ChildPath "rules"
$bigBrainRulesDir = Join-Path -Path $rulesDir -ChildPath "BIG_BRAIN"
$codebaseRulesDir = Join-Path -Path $rulesDir -ChildPath "Codebase"

$memoryBankDir = Join-Path -Path $rootDir -ChildPath "memory-bank"
$coreDir = Join-Path -Path $memoryBankDir -ChildPath "core"
$coreActiveDir = Join-Path -Path $coreDir -ChildPath "active"

# Create directory structure function
function Create-Directory {
  param (
    [string]$Path
  )

  if (-not (Test-Path -Path $Path)) {
    New-Item -ItemType Directory -Force -Path $Path | Out-Null
    Write-Host "  Created directory: $Path" -ForegroundColor Green
  }
  else {
    Write-Host "  Directory already exists: $Path" -ForegroundColor Yellow
  }
}

# Create all directories
Write-Host "Creating directory structure..." -ForegroundColor Cyan

# Create basic structure
Create-Directory -Path $cursorDir
Create-Directory -Path $rulesDir
Create-Directory -Path $bigBrainRulesDir
Create-Directory -Path $codebaseRulesDir
Create-Directory -Path $memoryBankDir
Create-Directory -Path $coreDir
Create-Directory -Path $coreActiveDir

# Create memory-bank structure
$coreDir = Join-Path -Path $memoryBankDir -ChildPath "core"
Create-Directory -Path $coreDir
$core_activeDir = Join-Path -Path $coreDir -ChildPath "active"
Create-Directory -Path $core_activeDir


# Create rules structure


# Create file function
function Create-FileIfNotExists {
  param (
    [string]$Path,
    [string]$Content
  )

  if (-not (Test-Path -Path $Path)) {
    Set-Content -Path $Path -Value $Content
    Write-Host "  Created file: $Path" -ForegroundColor Green
  }
  else {
    Write-Host "  File already exists: $Path" -ForegroundColor Yellow
  }
}

# Create memory file templates
$activeContextTemplate = @'
# Active Context

## _Last Updated: March 24, 2025_

## Current Focus

Implementing BIG BRAIN Memory Bank 2.0 enhancements - Phase 5: Section
Checkpoint System (Complexity Level 4) with enhanced system visualization using
standardized Mermaid diagrams

## Recent Changes

The BIG BRAIN Memory Bank system is being enhanced with components from the
Vanzan Memory Bank system through a Level 4 implementation plan. The major
enhancements include:

- Added comprehensive Mermaid diagram support:
  - Created diagram standards rule to establish formatting and styling
    conventions
  - Developed five key system architecture diagrams (system architecture, memory
    bank structure, rule system, command protocol, workflow orchestration)
  - Implemented PowerShell script for automated diagram generation
  - Updated documentation to reference visual architecture representations
  - Added directory structure and README for diagram management
- Completed Phase 4: Creative Phase Enhancements with four major components:
  - Creative Process Structure for systematic approaches to design-intensive
    tasks
  - Evaluation Metrics System for objective assessment of design solutions
  - Quality Verification Procedures for validating designs against requirements
  - Artifact Management System for organizing and preserving design knowledge
[... Additional content truncated for template ...]
'@

$productContextTemplate = @'
# Product Context

## 🔍 Problem Statement

AI assistants suffer from memory limitations that prevent them from maintaining
context between sessions, resulting in repeated explanations, lost project
context, and diminished productivity. The "AI amnesia problem" requires users to
constantly reexplain their requirements, previous decisions, and project
details - creating frustration and inefficiency when working on complex projects
over time.

## 👥 User Personas

### Software Developer with Long-Running Projects

- **Background**: Professional developer working on complex projects spanning
  weeks or months
- **Goals**: Maintain continuity in AI assistance across many sessions, preserve
  architectural decisions
- **Frustrations**: Constantly reexplaining project context, repeating
  requirements, losing decision history
- **How Our Product Helps**: Provides structured memory system that preserves
  all project context between sessions

### Technical Writer or Documentation Specialist

- **Background**: Creates and maintains comprehensive documentation for software
  projects
- **Goals**: Ensure consistent documentation style and approach across long-term
  projects
[... Additional content truncated for template ...]
'@

$progressTemplate = @'
# Progress Tracking

## 📊 SECTION CHECKPOINT: Foundation Layer Implementation

**Status**: COMPLETE **Verification**: VERIFIED

### 📌 Section Summary

Successfully implemented the Foundation Layer of the BIG BRAIN Memory Bank 2.0,
establishing the core infrastructure for the enhanced system. This phase created
the essential components that will support all other layers in the architecture.

### 🔍 Key Implementation Details

- Created six rule files implementing each foundation layer component:
  - Enhanced Complexity Framework (040-enhanced-complexity-framework.mdc)
  - Reference Verification System (050-reference-verification-system.mdc)
  - Task Escalation Protocol (060-task-escalation-protocol.mdc)
  - Section Checkpoint System (070-section-checkpoint-system.mdc)
  - Creative Phase Metrics (080-creative-phase-metrics.mdc)
  - BIG Command Protocol (090-big-command-protocol.mdc)
- Updated main.mdc to reflect the new layered architecture
- Updated systemPatterns.md with comprehensive system diagram
- Updated activeContext.md with current implementation status
- Established clear interfaces between all foundation components

### 📋 Verification Steps

- [✓] All foundation layer rule files created with proper MDC format
- [✓] Each component follows consistent documentation standards
[... Additional content truncated for template ...]
'@

$projectbriefTemplate = @'
# Project Brief

## 📋 Project Overview

The BIG BRAIN Memory Bank is a comprehensive framework designed to solve the AI
assistant amnesia problem by creating a structured external memory system. The
project aims to create a GitHub repository containing the complete
implementation, documentation, and examples of the BIG BRAIN Memory Bank system,
making it accessible to the broader developer community while properly
attributing original inspirations.

With recent enhancements, the system now includes a scientifically-grounded
cognitive memory model, comprehensive command system, platform awareness
capabilities, memory diagnostics, and enhanced creative processes - providing a
complete framework for AI memory management across sessions.

## 🎯 Core Requirements

- Create a well-organized GitHub repository with the BIG BRAIN Memory Bank
  implementation
- Provide proper attribution to original works by Vanzan and ipenywis
- Include comprehensive documentation on using and implementing the system
- Maintain a clear directory structure that separates public content from
  personal implementations
- Create a system that preserves AI memory across sessions with minimal user
  effort
- Implement a scientifically-grounded cognitive memory model for improved
  information management
- Provide a comprehensive command system for memory operations
- Support cross-platform compatibility through platform awareness
[... Additional content truncated for template ...]
'@

$projectRulesTemplate = @'
# Project Rules and Learned Patterns

## 🧠 Project Intelligence

This document captures learned patterns, conventions, and preferences specific
to this project. It evolves throughout the project lifecycle as new insights are
discovered.

## 🔍 Code Conventions

### Naming Conventions

- **Files**: [Pattern for file naming]
- **Classes**: [Pattern for class naming]
- **Functions/Methods**: [Pattern for function naming]
- **Variables**: [Pattern for variable naming]
- **Constants**: [Pattern for constant naming]

### Formatting Standards

- **Indentation**: [Tab/Spaces, count]
- **Line Length**: [Maximum characters]
- **Comments**: [Style and frequency expectations]
- **Whitespace**: [Rules for whitespace usage]

## 🏗️ Project-Specific Patterns

### Architecture Patterns

- **[Pattern 1]**: [Description and usage examples]
[... Additional content truncated for template ...]
'@

$systemPatternsTemplate = @'
# System Patterns

This document outlines the system architecture, technical decisions, and
component relationships for the BIG BRAIN Memory Bank system.

## System Diagram

The BIG BRAIN Memory Bank 2.0 implements a hierarchical, modular architecture
composed of seven main layers that work together to maintain perfect context
between sessions. The architecture combines the original BIG BRAIN memory
framework with enhanced components to create a robust, adaptable memory
structure.

The system architecture is documented using standardized Mermaid diagrams
located in the `/images` directory, with generated image files in
`/docs/assets`. These diagrams follow the styling conventions defined in the
diagram standards rule.

![System Architecture](../../../docs/assets/system-architecture.png)

Key architectural diagrams include:

- **System Architecture**: High-level view of all architectural layers
- **Memory Bank Structure**: Organization of memory files and directories
- **Rule System Structure**: Rule categories and relationships
- **Command Protocol**: Command structure and processing flow
- **Workflow Orchestration**: Workflow types and execution processes

These diagrams are maintained in Mermaid format (.mermaid) to ensure they can be
easily updated, versioned, and regenerated as the system evolves.
[... Additional content truncated for template ...]
'@

$techContextTemplate = @'
# Technical Context

## 🛠️ Technology Stack

### Core Implementation

- **Language**: Markdown for memory files, MDC for cursor rules
- **File System**: Platform-agnostic file-based storage
- **Integration**: Cursor IDE rule system
- **Configuration**: JSON for memory tool configuration
- **Command System**: XML-structured command processing with hierarchical
  organization
- **Memory Model**: Cognitive memory architecture with scientifically-grounded
  memory types
- **Platform Support**: Multi-platform abstractions for cross-OS compatibility

### Tools

- **Memory Manager**: Python-based tool for memory file management
- **Setup Scripts**: PowerShell (Windows) and Bash (Unix) for initialization
- **Version Control**: Git for repository management
- **Documentation**: Markdown for all documentation
- **Memory Diagnostics**: Integrated tools for memory bank verification
- **Rule Debugging**: Utilities for rule visibility and glob pattern analysis

### Integration Points

- **Cursor IDE**: Primary integration through .cursor/rules system
- **GitHub**: Repository hosting and distribution
- **Local File System**: Storage of memory files
[... Additional content truncated for template ...]
'@



# Create memory files
Write-Host "Creating memory files..." -ForegroundColor Cyan
Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "activeContext.md") -Content $activeContextTemplate
Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "productContext.md") -Content $productContextTemplate
Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "progress.md") -Content $progressTemplate
Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "projectbrief.md") -Content $projectbriefTemplate
Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "projectRules.md") -Content $projectRulesTemplate
Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "systemPatterns.md") -Content $systemPatternsTemplate
Create-FileIfNotExists -Path (Join-Path -Path $coreActiveDir -ChildPath "techContext.md") -Content $techContextTemplate


Write-Host "🎉 BIG BRAIN Memory Bank 2.0 initialization complete!" -ForegroundColor Cyan
Write-Host "You can now use BIG BRAIN with your project." -ForegroundColor Cyan
Write-Host "Remember to use the 'BIG' command to start your interactions." -ForegroundColor Cyan
