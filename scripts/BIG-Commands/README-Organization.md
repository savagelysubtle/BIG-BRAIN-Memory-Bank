# BIG Organization Command

The BIG Organization Command provides a standardized interface for organizing, categorizing, and cleaning up content in the BIG BRAIN Memory Bank. It helps maintain a well-structured memory system by ensuring content is properly organized into the appropriate memory types and categories.

## Overview

The BIG Organization Command implements the following pattern:

```
BIG organization [command] [parameters] [--options]
```

## Available Commands

| Command      | Description                                                       |
| ------------ | ----------------------------------------------------------------- |
| `reorganize` | Reorganizes files based on content analysis and memory bank rules |
| `categorize` | Moves content to a specific long-term memory category             |
| `cleanup`    | Removes duplicate or unnecessary files from the memory bank       |

## Common Parameters

| Parameter          | Description                                                   | Default             |
| ------------------ | ------------------------------------------------------------- | ------------------- |
| `-TargetPath`      | Path to the content to process                                | `.\memory-bank`     |
| `-DestinationPath` | Where to move/copy organized content                          | Same as target path |
| `-Category`        | Category for categorization (required for categorize command) |                     |
| `-Force`           | Perform operations without confirmation prompts               | `false`             |
| `-WhatIf`          | Show what would happen without making changes                 | `false`             |

## Usage Examples

### Reorganizing Memory Content

```powershell
# Basic reorganization of all memory bank content
.\BIG-Organization.ps1 -Command reorganize

# Reorganize specific directory
.\BIG-Organization.ps1 -Command reorganize -TargetPath ".\memory-bank\active"

# Preview reorganization without making changes
.\BIG-Organization.ps1 -Command reorganize -WhatIf
```

### Categorizing Content

```powershell
# Categorize content as semantic
.\BIG-Organization.ps1 -Command categorize -Category semantic -TargetPath ".\memory-bank\active\knowledge"

# Categorize content as procedural and specify destination
.\BIG-Organization.ps1 -Command categorize -Category procedural -TargetPath ".\memory-bank\active\workflows" -DestinationPath ".\memory-bank\long-term\procedural\daily-workflows"

# Preview categorization without making changes
.\BIG-Organization.ps1 -Command categorize -Category episodic -TargetPath ".\memory-bank\active\sessions" -WhatIf
```

### Cleaning Up Memory

```powershell
# Clean up the entire memory bank
.\BIG-Organization.ps1 -Command cleanup

# Clean up a specific section
.\BIG-Organization.ps1 -Command cleanup -TargetPath ".\memory-bank\short-term"

# Preview cleanup without making changes
.\BIG-Organization.ps1 -Command cleanup -WhatIf
```

## Memory Categories

The BIG BRAIN memory system uses four primary categories for long-term memory:

1. **Episodic**: Time-based memories tied to specific events, sessions, and milestones
   - Sessions, decisions, milestones, timelines

2. **Semantic**: Knowledge-based memories containing concepts, facts, and understanding
   - Domain knowledge, API documentation, feature descriptions

3. **Procedural**: Process-based memories focused on how to perform tasks
   - Workflows, guides, checklists, operations

4. **Creative**: Design-based memories related to architecture and implementation
   - Architecture designs, algorithms, components, data models

## Integration with Bedtime Protocol

The organization commands are designed to integrate with the Bedtime Protocol workflow:

1. Run `BIG-Organization.ps1 -Command reorganize` to organize active and short-term memory
2. Run `BIG-Organization.ps1 -Command categorize` to manually categorize specific content
3. Run `BIG-Organization.ps1 -Command cleanup` to remove unnecessary files
4. Run `BIG-Analytics.ps1 -Command health` to verify improved memory health

## Rules for Content Organization

The BIG Organization system follows these rules when categorizing content:

1. **Stability**: Content must be stable and unlikely to change
2. **Completeness**: Content should be complete and self-contained
3. **Relevance**: Content should be relevant to future work
4. **Value**: Content should provide lasting value

## Troubleshooting

### Common Issues

1. **Files Not Moving**: Check file permissions and ensure destination directories exist
2. **Wrong Categorization**: Use the categorize command to manually move content to the correct category
3. **Missing Files**: Use the cleanup command with -WhatIf to see what would be removed before actual deletion

### Potential Errors

```
Error: Reorganize script not found
```
Solution: Verify that Reorganize-Project.ps1 exists in the scripts/Organization directory.

```
Error: Category parameter is required
```
Solution: Provide a valid category parameter (episodic, semantic, procedural, creative) when using the categorize command.

## Version History

- 1.0.0: Initial implementation of BIG Organization commands (2025-03-27)