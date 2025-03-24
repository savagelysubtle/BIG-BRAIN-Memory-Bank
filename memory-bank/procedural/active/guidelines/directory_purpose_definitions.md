---
title: Memory Bank Directory Purpose Definitions
created: 2024-03-24
status: active
complexity: Level 3
version: 1.1.0
author: BIG BRAIN
related_files:
  - memory-bank/procedural/active/guidelines/naming_conventions.md
  - memory-bank/procedural/active/guidelines/metadata_standards.md
  - memory-bank/episodic/active/sessions/memory_bank_structure_map.md
---

# Memory Bank Directory Purpose Definitions

> **TL;DR:** This document defines the specific purpose, content types, and
> relationships for each directory within the Memory Bank structure, ensuring
> clear organization, intuitive navigation, and consistent application across
> memory resets.

<version>1.1.0</version>

## Core Principles

The Memory Bank directory structure follows these core organizational
principles:

1. **Memory Type Separation** - Content is separated by memory type (episodic,
   procedural, semantic, etc.)
2. **State Distinction** - Content is distinguished by state (active, archived,
   etc.)
3. **Content Categorization** - Similar content types are grouped together
   within appropriate memory types
4. **Hierarchical Organization** - Directories have clear parent-child
   relationships
5. **Purpose Clarity** - Each directory serves a specific, well-defined purpose
6. **Consistent Naming** - All directory names follow Python-style naming
   conventions (lowercase with underscores)
7. **Intuitive Structure** - Organization promotes easy discovery and navigation

## Root Structure

The Memory Bank root directory contains:

1. **Core Memory Files** - Essential context files that must persist across
   memory resets
2. **Memory Type Directories** - Top-level directories categorizing content by
   memory type
3. **Special Purpose Directories** - Directories serving specific operational
   functions

### Core Memory Files

Core memory files in the root directory provide essential context:

| File Name          | Purpose                                       | Critical | Related To           |
| ------------------ | --------------------------------------------- | -------- | -------------------- |
| active_context.md  | Current focus, recent changes, and next steps | Yes      | All Memory Types     |
| progress.md        | Task completion status and work tracking      | Yes      | Episodic, Procedural |
| system_patterns.md | System architecture and design patterns       | Yes      | Semantic             |
| tech_context.md    | Technical details and environment             | Yes      | Semantic             |
| project_brief.md   | Overall project goals and requirements        | Yes      | All Memory Types     |
| product_context.md | Product vision and user-focused context       | Yes      | Semantic             |

## Memory Type Directories

### `episodic/` - Experience-Based Memory

Purpose: Contains records of specific events, experiences, and time-based
information.

| Subdirectory | Purpose                                                    | Content Types                              |
| ------------ | ---------------------------------------------------------- | ------------------------------------------ |
| active/      | Current and recent episodic memories                       | Sessions, decisions, timeline events       |
| archived/    | Historical episodic memories no longer actively referenced | Past sessions, completed milestones        |
| sessions/    | Individual work session records                            | Session logs, conversation summaries       |
| timeline/    | Chronological project events                               | Major events, version releases, milestones |
| decisions/   | Records of key decisions and their rationale               | Decision logs, alternatives considered     |
| milestones/  | Significant project achievements                           | Milestone definitions, completion records  |
| reflections/ | Analysis of past experiences                               | Lessons learned, retrospectives            |

### `procedural/` - Process-Based Memory

Purpose: Contains workflows, processes, guidelines, and operational procedures.

| Subdirectory | Purpose                                       | Content Types                              |
| ------------ | --------------------------------------------- | ------------------------------------------ |
| active/      | Current procedural knowledge in active use    | Workflows, guidelines, checklists          |
| archived/    | Historical procedures no longer in active use | Deprecated workflows, obsolete processes   |
| workflows/   | Step-by-step processes                        | Workflow definitions, sequence diagrams    |
| guidelines/  | Standards and best practices                  | Coding standards, documentation guidelines |
| checklists/  | Verification tools for processes              | Process checkpoints, verification lists    |
| operations/  | Day-to-day operational procedures             | Maintenance tasks, routine operations      |
| templates/   | Reusable structural patterns                  | Document templates, code templates         |

### `semantic/` - Concept-Based Memory

Purpose: Contains conceptual knowledge, domain understanding, and reference
materials.

| Subdirectory    | Purpose                                                     | Content Types                              |
| --------------- | ----------------------------------------------------------- | ------------------------------------------ |
| active/         | Current semantic knowledge in active use                    | Concepts, architecture, references         |
| archived/       | Historical semantic knowledge no longer actively referenced | Outdated references, deprecated concepts   |
| concepts/       | Fundamental ideas and principles                            | Core concepts, theoretical foundations     |
| architecture/   | System design and structure                                 | Architecture diagrams, component relations |
| knowledge_base/ | Domain-specific information                                 | Domain expertise, specialized knowledge    |
| references/     | External information sources                                | External documentation, citations          |
| glossary/       | Terminology definitions                                     | Term definitions, acronym explanations     |
| models/         | Conceptual and mental models                                | Mental models, analogies, frameworks       |

### `stable/` - Consolidated Unchanging Memory

Purpose: Contains verified, stable information that has been fully consolidated
and rarely or never changes, forming the foundational knowledge of the system.

| Subdirectory    | Purpose                            | Content Types                          |
| --------------- | ---------------------------------- | -------------------------------------- |
| constants/      | Fixed values and parameters        | System constants, configuration values |
| foundations/    | Established foundational knowledge | Core theories, axioms, proven concepts |
| reference_data/ | Stable reference information       | Standard data sets, reference tables   |
| baselines/      | Standard baseline states           | System baselines, comparison points    |

### `bedtime_protocol/` - Memory Persistence

Purpose: Contains mechanisms for preserving memory across resets.

| Subdirectory  | Purpose                                         | Content Types                             |
| ------------- | ----------------------------------------------- | ----------------------------------------- |
| readme.md     | Bedtime Protocol documentation and instructions | Protocol definition, execution steps      |
| procedures/   | Detailed operational procedures                 | Step-by-step protocol execution guides    |
| memory_tools/ | Utilities for memory persistence                | Scripts, tools for memory preservation    |
| templates/    | Templates for memory preservation               | Memory snapshot templates, report formats |
| verification/ | Mechanisms to verify protocol success           | Integrity checks, verification procedures |

## Directory Relationships

### Hierarchical Structure

The Memory Bank follows a hierarchical organization:

```
memory-bank/
├── [Core Memory Files]
├── Memory Type/               # Top-level categorization
│   ├── State/                 # Activity state
│   │   └── Content Category/  # Content type grouping
│   │       └── Specific Items # Individual memory items
```

### Memory Consolidation Path

The Memory Bank models the cognitive memory consolidation process:

```
episodic/ → semantic/ → stable/
(experiences) → (concepts) → (foundational knowledge)
```

This path represents how information transitions from episodic experiences to
semantic understanding and eventually to stable, foundational knowledge.

### Cross-Type Relationships

Directories across memory types have specific relationships:

1. **Episodic → Procedural**: Episodic sessions often trigger procedural
   workflows or follow procedural checklists
2. **Procedural → Semantic**: Procedural workflows reference semantic concepts
   and architecture
3. **Semantic → Stable**: Semantic concepts may eventually stabilize into
   foundational knowledge
4. **All Types → Bedtime Protocol**: All memory types are preserved through
   bedtime protocol

## Directory Structure Patterns

### Standard Subdirectory Organization

Each memory type directory should include:

1. **State Directories**:

   - `active/` - Currently relevant content
   - `archived/` - Historical content

2. **Content Type Directories**:

   - Specific to each memory type (as detailed in sections above)
   - Follows consistent plural naming (e.g., `sessions/`, `workflows/`,
     `concepts/`)

3. **Special Purpose Directories**:
   - `_private/` - Content not intended for general use (prefix with underscore)
   - `_temp/` - Temporary content (prefix with underscore)

### Directory Creation Rules

When adding new directories:

1. Place in appropriate memory type based on content nature
2. Use existing content type subdirectory when possible
3. Create new content type subdirectory only when content doesn't fit existing
   categories
4. Follow Python-style naming conventions
5. Document purpose in this guide

## Special Cases and Clarifications

### Currently Empty Directories

The following directories exist in the structure but currently contain limited
or no content:

1. **`core/`**:

   - **Status**: Marked for removal
   - **Recommendation**: Maintain temporarily but scheduled for removal in the
     final steps of the cleanup plan
   - **Rationale**: Functions are redundant with core memory files in the root
     directory
   - **Priority**: Low - handle as the last step in the cleanup process

2. **`stable/`**:

   - **Status**: Exists but requires population based on cognitive science
     principles
   - **Recommendation**: Populate with foundational knowledge, constants, and
     reference data
   - **Priority**: Medium - implement during Phase 2 restructuring
   - **Scientific Basis**: Cognitive science research shows memory consolidation
     transitions from episodic to semantic to stable over time, with stable
     memory representing fully consolidated, permanent knowledge that forms the
     foundation of a cognitive system

3. **`timeline/`, `decisions/`**:
   - **Status**: Exist under episodic but have no content
   - **Recommendation**: Populate with actual project timeline and key decisions
   - **Priority**: Medium - implement during Phase 2 restructuring

### Mixed Case Directories

The "Bedtime Protocol" directory uses mixed case while other directories use
lowercase:

- **Current**: `Bedtime Protocol/`
- **Target**: `bedtime_protocol/`
- **Transition Plan**: Rename during Phase 2 (Step 8) implementation

## Implementation Timeline

The directory structure standardization will be fully implemented during Phase 2
of the Memory Bank cleanup:

1. Step 7: Create Directory Restructuring Plan
2. Step 8: Implement Directory Restructuring

## Directory Purpose Verification Checklist

When verifying compliance with directory purpose definitions:

1. ✓ Directory is placed under appropriate memory type
2. ✓ Directory name follows Python-style conventions
3. ✓ Directory contains appropriate content types
4. ✓ Content is in active or archived state as appropriate
5. ✓ Special purpose directories are properly prefixed
6. ✓ Empty directories are documented with clear purpose
7. ✓ Relationships with other directories are clear

## Adoption Strategy

To ensure smooth transition to the standardized directory structure:

1. **Documentation First**: Update all documentation to reference the defined
   directory purposes
2. **New Content Compliance**: All new content follows the defined structure
3. **Batch Restructuring**: Plan careful restructuring procedures for Phase 2
4. **Update Cross-References**: Update all references after restructuring
5. **Verification Tools**: Create verification scripts to ensure compliance

## References

- Memory Bank Structure Map
- Memory Bank Naming Conventions
- Memory Bank Cleanup Workflow
- Cognitive Science Research on Memory Consolidation Systems

## 📝 Version History

| Version | Date       | Author    | Changes                                                                         |
| ------- | ---------- | --------- | ------------------------------------------------------------------------------- |
| 1.0.0   | 2024-03-24 | BIG BRAIN | Initial directory purpose definitions                                           |
| 1.1.0   | 2024-03-24 | BIG BRAIN | Enhanced stable/ directory based on cognitive science, marked core/ for removal |
