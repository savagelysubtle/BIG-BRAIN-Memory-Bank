# BIG BRAIN Memory Bank System Architecture

## Overview

This document outlines the architectural design of the BIG BRAIN Memory Bank system, including key components, their relationships, and the underlying patterns that guide the system.

## Core Architecture

The Memory Bank architecture follows a cognitive memory model with these key components:

```
memory-bank/
├── active/                      # Primary working directory (current versions)
│   ├── projectbrief.md          # Foundation document defining requirements
│   ├── productContext.md        # Business logic and user experience
│   ├── activeContext.md         # Current work focus and workflow state
│   ├── systemPatterns.md        # Technical architecture and patterns
│   ├── techContext.md           # Technology stack and constraints
│   ├── progress.md              # Project status and roadmap
│   ├── tasks.md                 # Single source of truth for task tracking
│   ├── projectRules.md          # Project intelligence and learned patterns
│   └── analytics/               # Memory bank statistics and usage reports
│
├── short-term/                  # Recent versioned files (1-2 sessions old)
│
└── long-term/                   # Permanent historical record
    ├── episodic/                # Experience-based memory
    │   ├── sessions/            # Session summaries
    │   ├── milestones/          # Project milestones
    │   └── decisions/           # Decision records and justifications
    │
    ├── semantic/                # Knowledge-based memory
    │   ├── domain/              # Domain concepts
    │   ├── apis/                # API documentation
    │   └── features/            # Feature specifications
    │
    ├── procedural/              # Action-based memory
    │   ├── workflows/           # Development processes
    │   ├── guides/              # How-to guides
    │   └── checklists/          # Operational procedures
    │
    └── creative/                # Creative phase outputs
        ├── architecture/        # System architecture designs
        ├── components/          # Component designs
        ├── algorithms/          # Algorithm designs
        └── data-models/         # Data structure designs
```

## System Components

### Memory Core

The central memory storage system with these key characteristics:

- Hierarchical organization across active, short-term, and long-term memory
- File-based storage using Markdown format for portability
- Version control integration for history and collaboration
- Cross-referencing between related pieces of information

### Command System

The interface layer that provides a standardized way to interact with the memory bank:

- Command syntax: `BIG [category] [command] [parameters] [--options]`
- Command categories: memory, workflow, verification, system, bedtime, creative, help
- Parameter conventions: positional and named parameters
- Standardized feedback formats

### Workflow Engine

The process management system that coordinates activities:

- Mode switching between Plan and Act modes
- Complexity level enforcement
- Phase tracking for structured processes
- Transition management between workflows

### Analytics System

The monitoring and evaluation component:

- Statistics gathering on memory usage and distribution
- Health metrics calculation and reporting
- Recommendation generation based on analysis
- Integration with the Bedtime Protocol for regular assessments

## Architectural Patterns

### Documentation-as-Code

- Version-controlled documentation
- Structured review processes
- Consistent formatting and organization
- Explicit linking between related elements

### Cycle-Based Workflow

1. **Memory Reset Handling** → Recover context
2. **Planning Mode** → Analyze and design
3. **Action Mode** → Implement and verify
4. **Documentation Updates** → Record and preserve
5. Back to **Memory Reset Handling** for the next session

### Context Layering

- Project goals and vision (outer layer)
- System architecture and patterns (middle layer)
- Implementation details and decisions (inner layer)

### Single Source of Truth

- Core files contain fundamental information
- Specialized documentation elaborates on specific areas
- All decisions and context are recorded
- External information is internalized

## Integration Points

### Version Control Integration

- Git-based tracking of memory files
- Branch management for stable and development versions
- Branch-specific content for specialized needs

### IDE Integration

- Cursor rules system for automated guidance
- Workflow enforcement via prompts and checks
- Context-aware assistance based on memory state

### Command Line Integration

- PowerShell scripts for Windows environments
- Bash scripts for Unix environments
- Cross-platform compatibility layer

## Version History

- 1.0.0: Initial system architecture documentation (2025-03-25)