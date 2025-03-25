---
title: Rules System Inventory
created: 2024-03-24
status: active
complexity: Level 2
memory_type: episodic
memory_category: analysis
---

# Rules System Inventory

> **TL;DR:** This document provides a comprehensive inventory of all rule files
> in the BIG BRAIN Memory Bank system, including their locations, purposes,
> versions, and relationships.

<version>1.0.0</version>

## Rules Directory Structure Overview

The Cursor rules for the BIG BRAIN Memory Bank system follow a hierarchical
structure:

```
.cursor/rules/
├── main.mdc                # Root-level rule definition (v2.0.0)
├── BIG_BRAIN/             # BIG BRAIN specific rules
│   ├── Core/              # Foundational system rules
│   │   ├── Command/       # Command protocol implementation
│   │   ├── Creative/      # Creative process framework
│   │   ├── Documentation/ # Documentation standards
│   │   ├── Checkpoint/    # Progress tracking mechanisms
│   │   ├── Escalation/    # Task escalation procedures
│   │   ├── Foundation/    # Core framework definitions
│   │   ├── Testing/       # Testing procedures
│   │   └── Verification/  # Verification protocols
│   ├── Identity/          # Brand and persona rules
│   ├── Protocols/         # Operational protocols (currently empty)
│   ├── Templates/         # Document templates
│   ├── Utilities/         # Helper functions
│   └── Workflows/         # Process workflows
└── Codebase/              # Project-specific rules
    ├── documentation-standards.mdc
    ├── diagram-standards.mdc
    ├── Patterns/
    ├── Frameworks/
    └── Languages/
```

## Root Level Rules

| File         | Version | Purpose                                                  | Dependencies        |
| ------------ | ------- | -------------------------------------------------------- | ------------------- |
| **main.mdc** | 2.0.0   | Root-level definition of Memory Bank system architecture | All BIG_BRAIN rules |

## BIG_BRAIN Core Rules

### Foundation Layer

| File                                      | Version | Purpose                                       | Dependencies                      |
| ----------------------------------------- | ------- | --------------------------------------------- | --------------------------------- |
| **040-enhanced-complexity-framework.mdc** | 1.0.0   | Framework for assessing task complexity       | None (foundational)               |
| **050-reference-verification-system.mdc** | 1.0.0   | System for verifying memory references        | 040-enhanced-complexity-framework |
| **060-task-escalation-protocol.mdc**      | 1.0.0   | Protocol for escalating task complexity       | 040-enhanced-complexity-framework |
| **070-section-checkpoint-system.mdc**     | 1.0.0   | System for tracking progress with checkpoints | 040-enhanced-complexity-framework |
| **080-creative-phase-metrics.mdc**        | 1.0.0   | Metrics for measuring creative phase success  | 040-enhanced-complexity-framework |
| **090-big-command-protocol.mdc**          | 1.0.0   | Protocol for BIG command implementation       | All foundation layer rules        |

### Command Layer

| File                                          | Version | Purpose                               | Dependencies                          |
| --------------------------------------------- | ------- | ------------------------------------- | ------------------------------------- |
| **140-unified-command-interface.mdc**         | 1.0.0   | Unified interface for commands        | 090-big-command-protocol              |
| **150-standard-initialization-procedure.mdc** | 1.0.0   | Procedures for system initialization  | 140-unified-command-interface         |
| **160-workflow-orchestration.mdc**            | 1.0.0   | Framework for orchestrating workflows | 150-standard-initialization-procedure |
| **170-protocol-enforcement-mechanisms.mdc**   | 1.0.0   | Mechanisms for enforcing protocols    | 160-workflow-orchestration            |

### Other Core Subdirectories

The following subdirectories exist but their contents are not yet fully
explored:

- **Creative/** - Contains rules for creative process implementation
- **Documentation/** - Contains rules for documentation standards
- **Checkpoint/** - Contains rules for checkpoint implementation
- **Escalation/** - Contains rules for escalation procedures
- **Testing/** - Contains rules for testing procedures
- **Verification/** - Contains rules for verification protocols

## BIG_BRAIN Identity Rules

| File                           | Version | Purpose                                | Dependencies        |
| ------------------------------ | ------- | -------------------------------------- | ------------------- |
| **000-big-brain-identity.mdc** | 1.0.0   | Defines BIG BRAIN identity and persona | None (foundational) |

## BIG_BRAIN Workflow Rules

| File                                   | Version | Purpose                        | Dependencies                       |
| -------------------------------------- | ------- | ------------------------------ | ---------------------------------- |
| **800-memory-operations-workflow.mdc** | 1.0.0   | Workflow for memory operations | Foundation and Command layer rules |

## BIG_BRAIN Utility Rules

| File                                   | Version | Purpose                                  | Dependencies                   |
| -------------------------------------- | ------- | ---------------------------------------- | ------------------------------ |
| **500-rule-organization-enforcer.mdc** | 1.0.0   | Enforces rule organization standards     | None (utility)                 |
| **510-memory-diagnostics.mdc**         | 1.0.0   | Diagnostic tools for memory verification | None (utility)                 |
| **520-rule-visibility-system.mdc**     | 1.0.0   | System for controlling rule visibility   | 500-rule-organization-enforcer |

## BIG_BRAIN Template Rules

| File                           | Version | Purpose                                   | Dependencies    |
| ------------------------------ | ------- | ----------------------------------------- | --------------- |
| **900-component-template.mdc** | 1.0.0   | Template for creating new rule components | None (template) |

## Codebase-Specific Rules

| File                            | Version | Purpose                                        | Dependencies                  |
| ------------------------------- | ------- | ---------------------------------------------- | ----------------------------- |
| **documentation-standards.mdc** | 1.0.0   | Project-specific documentation standards       | BIG_BRAIN Documentation rules |
| **diagram-standards.mdc**       | 1.0.0   | Standards for diagram creation and maintenance | BIG_BRAIN Documentation rules |

## Rule Relationship Diagram

Here's a visual representation of the primary rule dependencies:

```
main.mdc
  │
  ├─► 000-big-brain-identity.mdc
  │
  ├─► 040-enhanced-complexity-framework.mdc
  │     │
  │     ├─► 050-reference-verification-system.mdc
  │     ├─► 060-task-escalation-protocol.mdc
  │     ├─► 070-section-checkpoint-system.mdc
  │     └─► 080-creative-phase-metrics.mdc
  │           │
  │           └─► 090-big-command-protocol.mdc
  │                 │
  │                 └─► 140-unified-command-interface.mdc
  │                       │
  │                       └─► 150-standard-initialization-procedure.mdc
  │                             │
  │                             └─► 160-workflow-orchestration.mdc
  │                                   │
  │                                   └─► 170-protocol-enforcement-mechanisms.mdc
  │                                         │
  │                                         └─► 800-memory-operations-workflow.mdc
  │
  ├─► 500-rule-organization-enforcer.mdc
  │     │
  │     └─► 520-rule-visibility-system.mdc
  │
  ├─► 510-memory-diagnostics.mdc
  │
  ├─► 900-component-template.mdc
  │
  └─► Codebase Rules
        ├─► documentation-standards.mdc
        └─► diagram-standards.mdc
```

## Key Findings

Based on this comprehensive rules inventory, several observations can be made:

1. **Hierarchical Rule Structure**: The rules follow a clear hierarchical
   structure with foundation rules providing the base for higher-level
   functionality.

2. **Consistent Naming Convention**: Rules use a numerical prefix system (e.g.,
   040-, 050-) to indicate order and dependencies.

3. **Empty Protocols Directory**: The Protocols directory exists but currently
   contains no rules, suggesting this may be an area for future development.

4. **Incomplete Subdirectories**: Several subdirectories (Testing,
   Documentation, etc.) exist in the Core directory but their contents were not
   fully explored.

5. **Version Consistency**: All rules appear to be at version 1.0.0, with only
   the main.mdc file at version 2.0.0, suggesting a recent major update to the
   overall architecture.

6. **Organized Command Structure**: Command-related rules are well-structured
   with clear dependencies and progression.

## Recommendations

Based on this inventory, the following recommendations are proposed:

1. **Complete Empty Directories**: Consider developing rules for the empty
   Protocols directory, especially for Bedtime Protocol which is a critical
   workflow.

2. **Explore Incomplete Subdirectories**: Fully document the contents of all
   Core subdirectories to ensure complete understanding of the rule system.

3. **Verify Version Consistency**: Ensure all rule versions are aligned with the
   overall system architecture version.

4. **Document Cross-References**: Create explicit cross-references between rules
   and Memory Bank files to improve integration.

5. **Standardize Rule Format**: Ensure all rules follow a consistent format with
   standard sections and metadata.

## Conclusion

This rules inventory provides a comprehensive overview of the current rule
system structure, versions, and relationships. It identifies several areas for
improvement and provides a foundation for subsequent cleanup steps, particularly
the integration of rules with Memory Bank files and the standardization of rule
formats.

## 📝 Version History

| Version | Date       | Author    | Changes                 |
| ------- | ---------- | --------- | ----------------------- |
| 1.0.0   | 2024-03-24 | BIG BRAIN | Initial rules inventory |
