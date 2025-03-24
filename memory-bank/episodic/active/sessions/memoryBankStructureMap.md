---
title: Memory Bank Structure Map
created: 2024-03-24
status: active
complexity: Level 2
memory_type: episodic
memory_category: analysis
---

# Memory Bank Structure Map

> **TL;DR:** This document provides a comprehensive inventory of the Memory Bank
> structure, including all files, their locations, cross-references, and
> visualizations of the hierarchical organization.

<version>1.0.0</version>

## Directory Structure Overview

The Memory Bank follows a cognitive memory model with specialized directories
for different types of memory:

```
memory-bank/
├── activeContext.md          # Current focus and state
├── progress.md               # Working features and pending tasks
├── systemPatterns.md         # Architectural patterns and design decisions
├── techContext.md            # Technology and environment context
├── core/                     # Currently unused - purpose to be defined
├── episodic/                 # Event-based memory (sessions, decisions, timeline)
│   └── active/
│       ├── sessions/         # Session-specific information
│       │   └── memoryCleanupAnalysis.md
│       │   └── memoryBankStructureMap.md (this file)
│       ├── timeline/         # Time-ordered events
│       ├── decisions/        # Decision records
│       └── milestones/       # Major achievement records
├── procedural/               # Process and operational knowledge
│   └── active/
│       ├── workflows/        # Process workflows
│       │   └── memoryCleanupWorkflow.md
│       ├── checklists/       # Verification checklists
│       │   └── memoryCleanupCheckpoints.md
│       ├── guidelines/       # Standards and guidelines
│       ├── operations/       # Operational procedures
│       └── memoryCleanupPlan.md
├── semantic/                 # Conceptual and factual knowledge
│   └── active/
│       ├── templates/        # Document templates
│       │   └── creative-phase/
│       │       └── exploration/
│       │           └── architecture-exploration.md
│       ├── architecture/     # System architecture documentation
│       ├── knowledge-base/   # General knowledge repository
│       ├── references/       # Reference materials
│       └── concepts/         # Concept definitions
├── stable/                   # Currently empty - purpose to be defined
└── Bedtime Protocol/         # Critical memory preservation procedures
    ├── README.md             # Protocol documentation
    └── memory-tools/         # Memory management utilities
```

## Root-Level Core Files

These files form the foundation of the Memory Bank system:

| File                  | Purpose                                                                         | Cross-References                                                               |
| --------------------- | ------------------------------------------------------------------------------- | ------------------------------------------------------------------------------ |
| **activeContext.md**  | Documents current focus, recent changes, impact, open questions, and next steps | References workflows, systemPatterns.md, progress.md, and implementation plans |
| **progress.md**       | Tracks working features, pending development, and known issues                  | References workflows, implementation status, and activeContext.md              |
| **systemPatterns.md** | Documents architectural patterns and design decisions                           | References implementation details, workflows, and structure patterns           |
| **techContext.md**    | Documents development environment, tools, and constraints                       | References repository structure, implementation details, and workflows         |

## Episodic Memory

Contains event-based memory organized chronologically:

### Sessions

| File                          | Purpose                                        | Cross-References                                     |
| ----------------------------- | ---------------------------------------------- | ---------------------------------------------------- |
| **memoryCleanupAnalysis.md**  | Analysis of Memory Bank and rules optimization | References memoryCleanupPlan.md and memory structure |
| **memoryBankStructureMap.md** | This document - maps Memory Bank structure     | References all Memory Bank components                |

### Timeline (Main Files)

_No files currently in this directory_

### Decisions (Main Files)

_No files currently in this directory_

### Milestones (Main Files)

_No files currently in this directory_

## Procedural Memory

Contains process and operational knowledge:

### Workflows

| File                         | Purpose                                    | Cross-References                                                           |
| ---------------------------- | ------------------------------------------ | -------------------------------------------------------------------------- |
| **memoryCleanupWorkflow.md** | Detailed step-by-step workflow for cleanup | References memoryCleanupPlan.md, memoryCleanupCheckpoints.md, and analysis |

### Checklists

| File                            | Purpose                               | Cross-References                                       |
| ------------------------------- | ------------------------------------- | ------------------------------------------------------ |
| **memoryCleanupCheckpoints.md** | Tracking progress of cleanup workflow | References memoryCleanupWorkflow.md and workflow steps |

### Guidelines (Main Files)

_No files currently in this directory_

### Operations (Main Files)

_No files currently in this directory_

### Root Procedural Files

| File                     | Purpose                                    | Cross-References                                                    |
| ------------------------ | ------------------------------------------ | ------------------------------------------------------------------- |
| **memoryCleanupPlan.md** | Comprehensive plan for Memory Bank cleanup | References system structure, workflows, and verification approaches |

## Semantic Memory

Contains conceptual and factual knowledge:

### Templates

| File                                                       | Purpose                                | Cross-References                 |
| ---------------------------------------------------------- | -------------------------------------- | -------------------------------- |
| **creative-phase/exploration/architecture-exploration.md** | Template for architectural exploration | Referenced by workflow documents |

### Architecture (Main Files)

_No files currently in this directory_

### Knowledge Base (Main Files)

_No files currently in this directory_

### References (Main Files)

_No files currently in this directory_

### Concepts (Main Files)

_No files currently in this directory_

## Bedtime Protocol

Contains critical memory preservation procedures:

| File              | Purpose                                        | Cross-References                                         |
| ----------------- | ---------------------------------------------- | -------------------------------------------------------- |
| **README.md**     | Detailed instructions for Bedtime Protocol     | Referenced by workflowDocumentation and activeContext.md |
| **memory-tools/** | Directory with utilities for memory management | Referenced by README.md                                  |

## Unclear/Undefined Directories

These directories have unclear or undefined purposes:

| Directory   | Current Status                                 | Documentation References                                         |
| ----------- | ---------------------------------------------- | ---------------------------------------------------------------- |
| **core/**   | Appears unused but referenced in documentation | systemPatterns.md mentions this as part of Memory Bank structure |
| **stable/** | Empty directory with undefined purpose         | systemPatterns.md references this as part of structure           |

## Cross-Reference Map

The following diagram shows the primary cross-references between key files:

```
activeContext.md ───────┐
                        │
                        ▼
progress.md ───────► systemPatterns.md ◄─── techContext.md
     │                   │                       │
     │                   │                       │
     ▼                   ▼                       ▼
memoryCleanupPlan.md ◄─────────────────────────────────┐
     │                                                  │
     ├───► memoryCleanupWorkflow.md ────┐              │
     │                │                  │              │
     │                ▼                  ▼              │
     └───► memoryCleanupAnalysis.md   memoryCleanupCheckpoints.md
                                                        │
                                                        ▼
                                                 memoryBankStructureMap.md
```

## Required Core Files Verification

Based on documentation in systemPatterns.md, these core files are required:

| Required File         | Status     | Notes                          |
| --------------------- | ---------- | ------------------------------ |
| **projectbrief.md**   | ❌ Missing | Not found in current structure |
| **productContext.md** | ❌ Missing | Not found in current structure |
| **activeContext.md**  | ✅ Present | Located at root level          |
| **systemPatterns.md** | ✅ Present | Located at root level          |
| **techContext.md**    | ✅ Present | Located at root level          |
| **progress.md**       | ✅ Present | Located at root level          |

## Cursor Rules Structure

The rules directory has this structure:

```
.cursor/rules/
├── main.mdc                # Root-level rule definition
├── BIG_BRAIN/             # BIG BRAIN specific rules
│   ├── Core/              # Foundational system rules
│   │   ├── Command/
│   │   ├── Creative/
│   │   ├── Checkpoint/
│   │   ├── Documentation/
│   │   ├── Escalation/
│   │   ├── Foundation/
│   │   ├── Testing/
│   │   └── Verification/
│   ├── Identity/          # Brand and persona rules
│   ├── Protocols/         # Operational protocols
│   ├── Templates/         # Document templates
│   ├── Utilities/         # Helper functions
│   └── Workflows/         # Process workflows
└── Codebase/              # Project-specific rules
```

## Structure Issues and Recommendations

Based on this comprehensive mapping, several structure issues have been
identified:

1. **Inconsistent Directory Naming**: "Bedtime Protocol" uses mixed case while
   other directories use lowercase
2. **Missing Required Core Files**: projectbrief.md and productContext.md are
   referenced but missing
3. **Unclear Directory Purposes**: core/ and stable/ directories exist but have
   unclear purposes
4. **Metadata Inconsistency**: Files use varying metadata formats in headers
5. **Limited Cross-Referencing**: Many files lack explicit cross-references to
   related documents

## Conclusion

This structure mapping provides a comprehensive inventory of the Memory Bank
organization, files, and relationships. It identifies several structural issues
that should be addressed in subsequent steps of the cleanup workflow,
particularly the naming inconsistencies, missing core files, and unclear
directory purposes.

## 📝 Version History

| Version | Date       | Author    | Changes                   |
| ------- | ---------- | --------- | ------------------------- |
| 1.0.0   | 2024-03-24 | BIG BRAIN | Initial structure mapping |
