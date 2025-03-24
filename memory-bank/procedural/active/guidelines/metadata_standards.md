---
title: Memory Bank Metadata Standards
created: 2024-03-24
status: active
complexity: Level 4
version: 1.0.0
author: BIG BRAIN
related_files:
  - memory-bank/procedural/active/guidelines/naming_conventions.md
  - .cursor/rules/BIG_BRAIN/Core/Documentation/400-documentation-standards.mdc
---

# Memory Bank Metadata Standards

> **TL;DR:** This document defines standardized metadata formats for all Memory
> Bank files, ensuring consistent structure, efficient cross-referencing, and
> optimal rule integration capabilities to support perfect memory preservation
> between sessions.

<version>1.0.0</version>

## Core Metadata Principles

1. **Consistency** - All files of the same type use identical metadata structure
2. **Completeness** - All required fields are present and properly populated
3. **Clarity** - Metadata is well-organized and easy to understand
4. **Connectivity** - Cross-references between related files are explicitly
   defined
5. **Compatibility** - Metadata supports integration with Cursor rules
6. **Context Preservation** - Metadata captures essential context for memory
   persistence
7. **Compliance** - All metadata adheres to Python-style naming conventions

## Standard Metadata Structure

All Memory Bank files must include a metadata header enclosed in triple-dashed
sections at the top of the file:

```markdown
---
[metadata fields here]
---
```

### Required Core Fields

Every Memory Bank file must include these fields:

| Field      | Description                  | Format                            | Example                           |
| ---------- | ---------------------------- | --------------------------------- | --------------------------------- |
| title      | Descriptive name of the file | Sentence case                     | `title: Memory Bank Cleanup Plan` |
| created    | Creation date                | YYYY-MM-DD                        | `created: 2024-03-24`             |
| status     | Current file status          | active, archived, draft, obsolete | `status: active`                  |
| complexity | Complexity level             | Level N (1-4)                     | `complexity: Level 3`             |
| version    | Semantic version number      | MAJOR.MINOR.PATCH                 | `version: 1.0.0`                  |
| author     | Original file creator        | Name                              | `author: BIG BRAIN`               |

### Optional Core Fields

These fields should be included when relevant:

| Field           | Description             | Format                    | Example                                        |
| --------------- | ----------------------- | ------------------------- | ---------------------------------------------- |
| updated         | Last update date        | YYYY-MM-DD                | `updated: 2024-03-25`                          |
| contributors    | Additional contributors | Comma-separated list      | `contributors: USER, BIG BRAIN`                |
| summary         | Brief description       | One-sentence summary      | `summary: Defines consistent metadata formats` |
| tags            | Categorization tags     | Comma-separated list      | `tags: metadata, standards, documentation`     |
| related_files   | Related files           | Yaml list with full paths | See "File Cross-Referencing" section           |
| rule_references | Associated rules        | Yaml list with full paths | See "Rule Integration" section                 |
| deprecated      | Deprecation indicator   | true/false                | `deprecated: false`                            |
| superseded_by   | Replacement file        | Full path to replacement  | `superseded_by: path/to/replacement_file.md`   |

## File Type-Specific Metadata

### Core Memory Files

Core memory files at the root level require these additional fields:

| Field             | Description                                     | Required |
| ----------------- | ----------------------------------------------- | -------- |
| last_memory_reset | Last time memory was reset                      | Yes      |
| critical          | Whether file is critical for memory persistence | Yes      |
| next_update       | Scheduled next update                           | No       |

### Documentation Files

Documentation files in procedural/guidelines, etc. require:

| Field          | Description              | Required |
| -------------- | ------------------------ | -------- |
| implementation | Implementation status    | Yes      |
| review_status  | Review completion status | Yes      |
| review_date    | Date of last review      | No       |
| reviewer       | Person who last reviewed | No       |

### Analysis Files

Analysis and inventory documents require:

| Field           | Description                    | Required |
| --------------- | ------------------------------ | -------- |
| analysis_target | What was analyzed              | Yes      |
| analysis_date   | When analysis was performed    | Yes      |
| analysis_method | How analysis was conducted     | No       |
| accuracy_level  | Confidence in analysis results | No       |

### Workflow Files

Workflow documentation requires:

| Field          | Description                     | Required |
| -------------- | ------------------------------- | -------- |
| workflow_type  | Type of workflow                | Yes      |
| participants   | Who performs the workflow       | Yes      |
| frequency      | How often workflow is executed  | No       |
| dependencies   | Other workflows this depends on | No       |
| estimated_time | Estimated completion time       | No       |

### Template Files

Template files require:

| Field            | Description              | Required |
| ---------------- | ------------------------ | -------- |
| template_for     | What the template is for | Yes      |
| template_version | Version of the template  | Yes      |
| usage_steps      | Brief usage instructions | No       |

## File Cross-Referencing

Memory Bank files must explicitly reference related files using the
`related_files` field in the metadata header:

```yaml
related_files:
  - path/to/first_related_file.md
  - path/to/second_related_file.md
```

For more detailed relationships, use the expanded format:

```yaml
related_files:
  - path: path/to/file.md
    relationship: parent
    description: 'Contains higher-level plan'
  - path: path/to/other_file.md
    relationship: child
    description: 'Implements details from this file'
```

### Relationship Types

Standard relationship types include:

| Relationship Type | Description                                     |
| ----------------- | ----------------------------------------------- |
| parent            | Higher-level document that this derives from    |
| child             | Lower-level document implementing this          |
| predecessor       | Document that came before this one              |
| successor         | Document that follows this one                  |
| depends_on        | This document depends on the referenced one     |
| dependency_for    | Referenced document depends on this one         |
| related           | General relationship without specific hierarchy |
| implements        | Implements concepts from referenced document    |
| extends           | Extends concepts from referenced document       |

### In-Line Cross-References

Within document content, use this syntax for cross-references:

```markdown
See [File Title](path/to/file.md) for more details.
```

For references to specific sections within files:

```markdown
See [File Title: Section Name](path/to/file.md#section-anchor) for
implementation details.
```

## Rule Integration

### Rule References in Metadata

Memory Bank files can explicitly reference related rules using the
`rule_references` field:

```yaml
rule_references:
  - .cursor/rules/BIG_BRAIN/Core/Documentation/400-documentation-standards.mdc
  - .cursor/rules/BIG_BRAIN/Workflows/800-memory-operations-workflow.mdc
```

For more detailed rule relationships:

```yaml
rule_references:
  - path: .cursor/rules/BIG_BRAIN/Core/Documentation/400-documentation-standards.mdc
    relationship: implements
    description: 'Implements documentation standards from rule'
  - path: .cursor/rules/BIG_BRAIN/Workflows/800-bedtime-protocol.mdc
    relationship: triggers
    description: 'Triggers bedtime protocol workflow'
```

### File Attachment in Rules

Rules can reference Memory Bank files using the `@file` directive within rule
content:

```mdc
WHEN working on memory bank files
ENSURE you follow the conventions in @file(memory-bank/procedural/active/guidelines/naming_conventions.md)
```

### Using Glob Patterns for File References

Rules can reference multiple files using glob patterns:

```mdc
WHEN working on memory bank core files
ENSURE you include context from @file(memory-bank/*.md)
```

Common glob patterns for the Memory Bank:

| Pattern                                         | Description                 | Example Usage                      |
| ----------------------------------------------- | --------------------------- | ---------------------------------- |
| `memory-bank/*.md`                              | All MD files in root        | General core file context          |
| `memory-bank/procedural/active/guidelines/*.md` | All guideline files         | Standards and conventions          |
| `memory-bank/episodic/active/sessions/*_map.md` | All mapping files           | Structure and inventory context    |
| `memory-bank/**/*.md`                           | All MD files in Memory Bank | Complete context for major changes |

## Metadata Templates by File Type

### Standard Markdown File

```yaml
---
title: [Title in Sentence Case]
created: YYYY-MM-DD
status: active
complexity: Level [1-4]
version: 1.0.0
author: BIG BRAIN
summary: [Brief one-sentence description]
tags: [comma, separated, tags]
related_files:
  - [path/to/related_file1.md]
  - [path/to/related_file2.md]
---
```

### Core Memory File

```yaml
---
title: [Title in Sentence Case]
created: YYYY-MM-DD
updated: YYYY-MM-DD
status: active
complexity: Level [1-4]
version: [X.Y.Z]
author: BIG BRAIN
critical: true
last_memory_reset: YYYY-MM-DD
related_files:
  - [list of related files]
rule_references:
  - [list of related rules]
---
```

### Documentation Standards File

```yaml
---
title: [Standards Name]
created: YYYY-MM-DD
status: active
complexity: Level [1-4]
version: [X.Y.Z]
author: BIG BRAIN
implementation: complete
review_status: verified
review_date: YYYY-MM-DD
reviewer: USER
related_files:
  - [list of related files]
rule_references:
  - [list of related rules]
---
```

### Analysis Document

```yaml
---
title: [Analysis Title]
created: YYYY-MM-DD
status: active
complexity: Level [1-4]
version: [X.Y.Z]
author: BIG BRAIN
analysis_target: [System/Component Analyzed]
analysis_date: YYYY-MM-DD
analysis_method: [Method Used]
accuracy_level: high
related_files:
  - [list of related files]
---
```

### Workflow Document

```yaml
---
title: [Workflow Name]
created: YYYY-MM-DD
status: active
complexity: Level [1-4]
version: [X.Y.Z]
author: BIG BRAIN
workflow_type: [procedural/operational/maintenance]
participants: [BIG BRAIN, USER]
frequency: [as-needed/daily/weekly]
estimated_time: [time estimate]
dependencies:
  - [dependent workflow 1]
  - [dependent workflow 2]
related_files:
  - [list of related files]
rule_references:
  - [list of related rules]
---
```

### Template File

```yaml
---
title: [Template Name]
created: YYYY-MM-DD
status: active
complexity: Level [1-4]
version: [X.Y.Z]
author: BIG BRAIN
template_for: [usage purpose]
template_version: [X.Y.Z]
usage_steps: [Brief usage instructions]
related_files:
  - [list of related files]
---
```

## Implementation Strategy

The metadata standardization will be implemented in two phases:

### Phase 1: Documentation and Templates (Current Step)

1. Create and document standardized metadata formats
2. Develop templates for each file type
3. Establish file cross-referencing conventions
4. Define rule integration patterns
5. Create verification tools

### Phase 2: Implementation (Steps 9-10)

1. Create inventory of files requiring updates
2. Develop detailed implementation plan
3. Implement batch updates by file type
4. Update rules to reference Memory Bank files
5. Verify correct implementation

## Cross-Reference Implementation Examples

### Example 1: Workflow File with Multiple References

```yaml
---
title: Memory Cleanup Workflow
created: 2024-03-24
status: active
complexity: Level 3
version: 1.0.0
author: BIG BRAIN
workflow_type: procedural
participants: [BIG BRAIN, USER]
frequency: as-needed
related_files:
  - path: memory-bank/procedural/active/plans/memory_cleanup_plan.md
    relationship: parent
    description: 'Overall plan this workflow implements'
  - path: memory-bank/episodic/active/sessions/memory_bank_structure_map.md
    relationship: depends_on
    description: 'Structure mapping required for workflow steps'
  - path: memory-bank/procedural/active/checklists/memory_cleanup_checkpoints.md
    relationship: implements
    description: 'Checkpoints for tracking workflow progress'
rule_references:
  - path: .cursor/rules/BIG_BRAIN/Workflows/800-memory-operations-workflow.mdc
    relationship: extends
    description: 'Extends base memory operations workflow'
---
```

### Example 2: Rule Referencing Multiple Files

```mdc
---
description: WHEN implementing Bedtime Protocol ENSURE consistency with workflow documentation
globs: ["**/*.mdc", "**/*bedtime*.md"]
alwaysApply: true
---

WHEN implementing the Bedtime Protocol
ENSURE consistency with:
- @file(memory-bank/bedtime_protocol/readme.md)
- @file(memory-bank/procedural/active/workflows/bedtime_protocol_workflow.md)
- @file(memory-bank/episodic/active/sessions/bedtime_protocol_session_log.md)
```

### Example 3: Using Glob Patterns in Rules

```mdc
---
description: WHEN working on any Memory Bank file ENSURE core principles are followed
globs: ["memory-bank/**/*.md"]
alwaysApply: true
---

WHEN working on any Memory Bank file
ENSURE you maintain consistency with the core principles defined in:
- @file(memory-bank/procedural/active/guidelines/*.md)
```

## Verification Process

To verify metadata compliance:

1. Check presence of all required fields for file type
2. Validate field format (dates, version numbers, etc.)
3. Verify cross-references point to valid files
4. Ensure related files correctly link back (bidirectional)
5. Validate rule references
6. Check version history is up to date

## Migration Plan

To migrate existing files to the new metadata standard:

1. Begin with core memory files
2. Prioritize active documents over archived ones
3. Update guidelines and standards documents next
4. Process workflow and template files
5. Finally update analysis and session documents
6. Verify cross-references after all updates

## References

- Memory Bank Naming Conventions
- Documentation Standards Rule (400-documentation-standards.mdc)
- Cursor MDC Rule Format Guidelines
- Memory Bank Structure Map

## 📝 Version History

| Version | Date       | Author    | Changes                               |
| ------- | ---------- | --------- | ------------------------------------- |
| 1.0.0   | 2024-03-24 | BIG BRAIN | Initial metadata standards definition |
