# BIG BRAIN Rules Organization

This document explains the organization of the BIG BRAIN Memory Bank rule
system.

## Directory Structure

The rules are organized into a hierarchical structure that separates BIG BRAIN
features from codebase-specific rules:

```
.cursor/rules/
├── BIG_BRAIN/             # All BIG BRAIN specific rules
│   ├── Core/              # Core BIG BRAIN functionality
│   │   ├── Foundation/    # Foundation layer components (Phase 1)
│   │   ├── Verification/  # Verification framework components (Phase 2)
│   │   ├── Command/       # Command protocol components (Phase 3)
│   │   ├── Creative/      # Creative phase components (Phase 4)
│   │   ├── Checkpoint/    # Checkpoint system components (Phase 5)
│   │   └── Escalation/    # Task escalation components (Phase 6)
│   ├── Identity/          # BIG BRAIN identity definition
│   ├── Protocols/         # Protocol-specific rules
│   └── Utilities/         # BIG BRAIN utility functions
├── Codebase/              # All codebase-related rules
│   ├── Languages/         # Language-specific rules
│   │   ├── Python/
│   │   ├── JavaScript/
│   │   └── ...
│   ├── Frameworks/        # Framework-specific rules
│   │   ├── React/
│   │   ├── Django/
│   │   └── ...
│   └── Patterns/          # Code pattern rules
└── main.mdc               # Main rule file
```

## File Naming Convention

All BIG BRAIN rule files follow this naming convention:

`XXX-descriptive-name.mdc`

Where:

- `XXX` is a three-digit number indicating the rule's position in the processing
  sequence
- `descriptive-name` describes the rule's purpose using kebab-case
- `.mdc` is the file extension for Markdown with code

## Organization Principles

1. **Feature-Based Categorization**: Rules are organized by the BIG BRAIN
   feature they implement
2. **Separation of Concerns**: BIG BRAIN rules are separate from codebase rules
3. **Implementation Sequence**: Numbering reflects the implementation sequence
   and dependencies
4. **Modularity**: Each feature area is self-contained in its own directory
5. **Discoverability**: Naming and structure make it easy to find specific rules

## BIG BRAIN Core Components

The Core directory contains the main BIG BRAIN functionality, organized by
implementation phase:

1. **Foundation Layer (040-090)**: Basic infrastructure components
2. **Verification Framework (100-130)**: Memory integrity and validation
3. **Command Protocol (140-170)**: Unified interface and workflow management
4. **Creative Phase (180-210)**: Design processes and evaluation
5. **Checkpoint System (220-250)**: Progress tracking and verification
6. **Task Escalation (260-290)**: Complexity handling and escalation

## Codebase Rules

The Codebase directory contains rules specific to programming languages,
frameworks, and coding patterns. These are separated from BIG BRAIN rules to
maintain clear boundaries between system functionality and code-specific
guidance.

## How to Add New Rules

1. **BIG BRAIN Rules**:

   - Identify the appropriate feature category
   - Use the next available number in that category's sequence
   - Place in the corresponding subdirectory

2. **Codebase Rules**:
   - Place in the appropriate language or framework directory
   - Use descriptive names without numbering

## Implementation Tools

Two PowerShell scripts help manage this organization:

1. `reorganize-rules.ps1`: Reorganizes existing rules into the new structure
2. `delete-original-rules.ps1`: Removes original files after reorganization is
   verified

## Maintaining the System

When adding new BIG BRAIN features:

1. Create a new subdirectory if it represents a major new feature area
2. Follow the established numbering convention
3. Ensure integration with existing components
4. Update this README if the organization principles change

## Version History

| Version | Date       | Author    | Description                |
| ------- | ---------- | --------- | -------------------------- |
| 1.0.0   | 2025-03-24 | BIG BRAIN | Initial organization setup |
