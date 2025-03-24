---
title: Memory Bank Naming Conventions
created: 2024-03-24
status: active
complexity: Level 2
---

# Memory Bank Naming Conventions

> **TL;DR:** This document defines the standard naming conventions for all
> Memory Bank files and directories, following Python-style naming principles to
> ensure consistency and maintainability.

<version>1.0.1</version>

## Core Principles

The Memory Bank system will follow these core naming principles:

1. **All lowercase letters** for directory and file names
2. **Separate words with underscores** when needed for readability
3. **Avoid special symbols, dots, or hyphens** in directory and file names
4. **Short, descriptive names** for directories and files
5. **Prefix internal/private components** with an underscore
6. **Maintain consistency** across the entire Memory Bank structure

## Directory Naming Standards

### Regular Directories

- Use all lowercase letters
- Use underscores to separate words if needed for readability
- Keep directory names short and descriptive
- Examples: `core`, `episodic`, `procedural`, `semantic`

### Internal/Private Directories

- Prefix with an underscore
- Otherwise follow the same conventions as regular directories
- Examples: `_private`, `_internal`, `_temp`

### Package Directories

- Use all lowercase without underscores when possible
- Include an `__init__.md` file where appropriate
- Examples: `core`, `workflows`, `tools`

## File Naming Standards

### Markdown Files

- Use all lowercase letters
- Separate words with underscores for readability
- Always use the `.md` extension
- Examples: `active_context.md`, `system_patterns.md`, `tech_context.md`

### Rule Files (MDC)

- Follow numerical prefix convention as specified in the rules guide
- Use all lowercase letters for the descriptive portion
- Separate words with underscores
- Always use the `.mdc` extension
- Examples: `040-enhanced_complexity_framework.mdc`,
  `800-memory_operations_workflow.mdc`

### Script Files

- Use all lowercase letters
- Separate words with underscores
- Use appropriate extension for the language (e.g., `.ps1`, `.sh`, `.py`)
- Examples: `generate_diagrams.ps1`, `initialize_memory_bank.sh`

## Detailed File Naming Patterns

### Core Memory Files

| Purpose                    | Current Name      | New Standard Name  |
| -------------------------- | ----------------- | ------------------ |
| Active context information | activeContext.md  | active_context.md  |
| System patterns            | systemPatterns.md | system_patterns.md |
| Technical context          | techContext.md    | tech_context.md    |
| Project brief              | projectbrief.md   | project_brief.md   |
| Product context            | productContext.md | product_context.md |
| Progress tracking          | progress.md       | progress.md        |

### Memory Type Directories

| Memory Type      | Current Name      | New Standard Name |
| ---------------- | ----------------- | ----------------- |
| Episodic         | episodic/         | episodic/         |
| Procedural       | procedural/       | procedural/       |
| Semantic         | semantic/         | semantic/         |
| Core             | core/             | core/             |
| Stable           | stable/           | stable/           |
| Bedtime Protocol | Bedtime Protocol/ | bedtime_protocol/ |

### Subdirectory Patterns

| Type                | Pattern                     | Example                                  |
| ------------------- | --------------------------- | ---------------------------------------- |
| Memory state        | `{state}/`                  | `active/`, `archived/`                   |
| Content types       | `{descriptor}s/`            | `sessions/`, `workflows/`, `guidelines/` |
| Special purpose     | `{purpose}/`                | `templates/`, `tools/`                   |
| Specialized content | `{category}_{subcategory}/` | `knowledge_base/`, `user_guides/`        |
| Hidden/internal     | `_{purpose}/`               | `_temp/`, `_internal/`                   |

### File Patterns by Category

#### Documentation Files

| Category               | Pattern                    | Examples                        |
| ---------------------- | -------------------------- | ------------------------------- |
| Analysis documents     | `{topic}_analysis.md`      | `memory_cleanup_analysis.md`    |
| Maps and inventories   | `{subject}_{type}_map.md`  | `memory_bank_structure_map.md`  |
| Plans                  | `{subject}_plan.md`        | `memory_cleanup_plan.md`        |
| Workflow documentation | `{subject}_workflow.md`    | `memory_cleanup_workflow.md`    |
| Checkpoints            | `{subject}_checkpoints.md` | `memory_cleanup_checkpoints.md` |
| Standards              | `{subject}_standards.md`   | `documentation_standards.md`    |
| Guidelines             | `{subject}_guidelines.md`  | `naming_conventions.md`         |
| Templates              | `{subject}_template.md`    | `session_template.md`           |

#### Rule Files

| Category          | Pattern                         | Examples                             |
| ----------------- | ------------------------------- | ------------------------------------ |
| Core standards    | `0XX-{subject}.mdc`             | `010-security_principles.mdc`        |
| Tool configs      | `1XX-{tool}_{purpose}.mdc`      | `100-eslint_rules.mdc`               |
| Testing standards | `3XX-{test_type}.mdc`           | `300-unit_testing.mdc`               |
| Documentation     | `4XX-{doc_type}.mdc`            | `400-code_comments.mdc`              |
| Language rules    | `1XXX-{language}_{aspect}.mdc`  | `1000-javascript_standards.mdc`      |
| Framework rules   | `2XXX-{framework}_{aspect}.mdc` | `2000-react_components.mdc`          |
| Workflows         | `8XX-{workflow_name}.mdc`       | `800-memory_operations_workflow.mdc` |
| Templates         | `9XX-{component}_template.mdc`  | `900-component_template.mdc`         |

#### Script Files

| Category           | Pattern                 | Examples                    |
| ------------------ | ----------------------- | --------------------------- |
| PowerShell scripts | `{action}_{target}.ps1` | `generate_diagrams.ps1`     |
| Bash scripts       | `{action}_{target}.sh`  | `initialize_memory_bank.sh` |
| Python scripts     | `{action}_{target}.py`  | `analyze_structure.py`      |
| Utility scripts    | `{utility_name}.{ext}`  | `file_renamer.ps1`          |

## Special Case: Core Memory Files

The core memory files at the root level will follow the same conventions:

- `active_context.md` (formerly activeContext.md)
- `project_brief.md` (formerly projectbrief.md)
- `product_context.md` (formerly productContext.md)
- `system_patterns.md` (formerly systemPatterns.md)
- `tech_context.md` (formerly techContext.md)
- `progress.md` (remains unchanged as it's already compliant)

## Directory Structure Example

Based on these conventions, the Memory Bank structure would be organized as
follows:

```
memory_bank/
├── active_context.md
├── progress.md
├── system_patterns.md
├── tech_context.md
├── project_brief.md
├── product_context.md
├── core/
├── episodic/
│   └── active/
│       ├── sessions/
│       ├── timeline/
│       ├── decisions/
│       └── milestones/
├── procedural/
│   └── active/
│       ├── workflows/
│       ├── checklists/
│       ├── guidelines/
│       └── operations/
├── semantic/
│   └── active/
│       ├── templates/
│       ├── architecture/
│       ├── knowledge_base/
│       ├── references/
│       └── concepts/
├── stable/
└── bedtime_protocol/
    ├── readme.md
    └── memory_tools/
```

## Implementation Timeline

These naming conventions will be fully implemented during Phase 2 of the Memory
Bank cleanup:

1. Step 7: Create Directory Restructuring Plan
2. Step 8: Implement Directory Restructuring
3. Step 9-10: Metadata Standardization

## Adherence Requirements

All future additions to the Memory Bank must strictly follow these naming
conventions. This includes:

- New directories and files
- Modified file names
- Refactored structures
- Generated documentation

## Convention Verification

Before considering the restructuring complete, verify:

1. All directory names are lowercase with underscores when needed
2. All file names follow the conventions for their type
3. No special characters, dots, or hyphens in names (except for extensions)
4. Internal/private directories are prefixed with underscore
5. Consistent naming patterns are maintained

## Adoption Strategy

To ensure smooth transition to the new naming conventions:

1. **Documentation First**: Update all documentation to reference the new naming
   conventions
2. **New Files Follow Standards**: All new files immediately follow the new
   standards
3. **Batch Renaming**: Plan careful batch renaming procedures for Phase 2
4. **Update Cross-References**: Update all references after renaming
5. **Verification Tools**: Create verification scripts to ensure compliance

## References

- Python PEP 8 Style Guide
- Python Module Naming Conventions
- Memory Bank Cleanup Plan
- CursorRules-ComprehensiveGuide.md

## 📝 Version History

| Version | Date       | Author    | Changes                                         |
| ------- | ---------- | --------- | ----------------------------------------------- |
| 1.0.0   | 2024-03-24 | BIG BRAIN | Initial naming conventions                      |
| 1.0.1   | 2024-03-24 | BIG BRAIN | Added detailed file naming patterns by category |
