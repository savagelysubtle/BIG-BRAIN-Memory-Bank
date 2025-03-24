# Commands Guide

## Overview

This guide provides a comprehensive reference for all available commands in the
BIG BRAIN Memory Bank 2.0 system. Commands allow you to interact with the memory
bank, manage workflows, perform system operations, and execute various tasks
efficiently. This guide organizes commands by category and provides syntax,
parameters, examples, and usage notes.

## Command Syntax

BIG BRAIN commands follow this general syntax:

```
COMMAND_NAME [PARAMETER1] [PARAMETER2] [OPTIONS]
```

- **Command Names**: Always in UPPERCASE
- **Parameters**: Values or identifiers the command operates on
- **Options**: Optional flags or modifiers that change command behavior

## Initialization Commands

Commands used during system initialization and startup.

### MEMORY BANK INITIALIZE

Initializes the memory bank system and loads core memory files.

**Syntax:**

```
MEMORY BANK INITIALIZE [--force] [--skip-verification]
```

**Parameters:**

- `--force`: Override warnings and initialization blockers
- `--skip-verification`: Skip verification steps (not recommended)

**Example:**

```
MEMORY BANK INITIALIZE
```

**Notes:**

- This should be the first command run in any new session
- Automatically reads all memory bank files
- Performs system verification checks
- Restores context from previous session

### CONFIRM READINESS

Verifies system readiness for task execution.

**Syntax:**

```
CONFIRM READINESS [TASK_DESCRIPTION]
```

**Parameters:**

- `TASK_DESCRIPTION`: Optional task description to check readiness for

**Example:**

```
CONFIRM READINESS Implement validation system
```

**Notes:**

- Checks that all required information is available
- Confirms current state understanding
- Verifies task objectives are clear
- Ensures implementation approach is defined

## Workflow Commands

Commands for managing different operational workflows.

### ENTER PLAN MODE

Switches to planning workflow for design and strategy tasks.

**Syntax:**

```
ENTER PLAN MODE [--complexity=LEVEL]
```

**Parameters:**

- `--complexity=LEVEL`: Set complexity level (1-4)

**Example:**

```
ENTER PLAN MODE --complexity=3
```

**Notes:**

- Optimizes for requirement analysis and design exploration
- Emphasizes documentation and option evaluation
- Adjusts verification rigor based on complexity

### ENTER ACT MODE

Switches to action workflow for implementation tasks.

**Syntax:**

```
ENTER ACT MODE [--complexity=LEVEL]
```

**Parameters:**

- `--complexity=LEVEL`: Set complexity level (1-4)

**Example:**

```
ENTER ACT MODE --complexity=2
```

**Notes:**

- Optimizes for code implementation and feature building
- Focuses on execution efficiency and output quality
- Balances documentation with implementation speed

### ENTER REVIEW MODE

Switches to review workflow for evaluation tasks.

**Syntax:**

```
ENTER REVIEW MODE [--depth=LEVEL]
```

**Parameters:**

- `--depth=LEVEL`: Review depth level (1-4)

**Example:**

```
ENTER REVIEW MODE --depth=4
```

**Notes:**

- Optimizes for quality assessment and verification
- Enhanced focus on thoroughness and completeness
- Systematic evaluation against requirements

### ENTER HYBRID MODE

Switches to hybrid workflow for mixed task types.

**Syntax:**

```
ENTER HYBRID MODE [--primary=MODE] [--complexity=LEVEL]
```

**Parameters:**

- `--primary=MODE`: Primary mode component (PLAN, ACT, REVIEW)
- `--complexity=LEVEL`: Set complexity level (1-4)

**Example:**

```
ENTER HYBRID MODE --primary=ACT --complexity=3
```

**Notes:**

- Combines elements of multiple workflows
- Adapts based on specified primary mode
- Balances planning, execution, and verification

### RESUME

Resumes the previous workflow after interruption.

**Syntax:**

```
RESUME [WORKFLOW_TYPE]
```

**Parameters:**

- `WORKFLOW_TYPE`: Optional workflow to resume (defaults to previous)

**Example:**

```
RESUME ACT MODE
```

**Notes:**

- Restores workflow state from memory bank
- Continues from last known position
- Recreates operational context

## Memory Operations Commands

Commands for interacting with and managing memory bank content.

### UPDATE MEMORY BANK

Updates memory bank files with current state and progress information.

**Syntax:**

```
UPDATE MEMORY BANK [--files=FILE1,FILE2,...] [--comprehensive]
```

**Parameters:**

- `--files`: Comma-separated list of specific files to update
- `--comprehensive`: Perform complete review and update of all files

**Example:**

```
UPDATE MEMORY BANK --comprehensive
```

**Notes:**

- Updates activeContext.md with current status
- Records progress in progress.md
- Documents system changes in systemPatterns.md
- Updates technical details in techContext.md

### MEMORY HEALTH CHECK

Performs diagnostics on memory bank files and system integrity.

**Syntax:**

```
MEMORY HEALTH CHECK [--repair] [--verbose]
```

**Parameters:**

- `--repair`: Attempt to repair identified issues
- `--verbose`: Show detailed diagnostic information

**Example:**

```
MEMORY HEALTH CHECK --verbose
```

**Notes:**

- Checks file existence and accessibility
- Verifies content integrity and format
- Validates cross-references
- Confirms overall memory bank health

### CONTEXTUALIZE

Positions current task within project context and prepares resources.

**Syntax:**

```
CONTEXTUALIZE TASK_DESCRIPTION
```

**Parameters:**

- `TASK_DESCRIPTION`: Description of the task to contextualize

**Example:**

```
CONTEXTUALIZE Implement error recovery for verification system
```

**Notes:**

- Positions task within implementation plan
- Identifies related components
- Determines appropriate complexity level
- Prepares relevant resources

### SHOW ACTIVE CONTEXT

Displays current system status and operational context.

**Syntax:**

```
SHOW ACTIVE CONTEXT [--section=SECTION_NAME]
```

**Parameters:**

- `--section`: Optional specific section to display

**Example:**

```
SHOW ACTIVE CONTEXT --section="Current Focus"
```

**Notes:**

- Shows current focus and priorities
- Displays recent changes and status
- Lists open issues and questions
- Outlines overall progress and next steps

## Rule System Commands

Commands for managing and debugging the rule system.

### SHOW ACTIVE RULES

Displays currently active rules in the system.

**Syntax:**

```
SHOW ACTIVE RULES [CATEGORY]
```

**Parameters:**

- `CATEGORY`: Optional category to filter rules (e.g., FOUNDATION)

**Example:**

```
SHOW ACTIVE RULES VERIFICATION
```

**Notes:**

- Lists active rules, grouping by category
- Shows rule activation status
- Indicates which rules apply to current context
- Provides count summary by category

### DEBUG RULES

Performs comprehensive diagnostics on the rule system.

**Syntax:**

```
DEBUG RULES [--detail=LEVEL]
```

**Parameters:**

- `--detail=LEVEL`: Detail level for diagnostics (1-3)

**Example:**

```
DEBUG RULES --detail=2
```

**Notes:**

- Identifies potential rule conflicts
- Shows rule execution statistics
- Reports on rule system health
- Recommends optimizations

### DEBUG RULE

Provides detailed analysis of a specific rule.

**Syntax:**

```
DEBUG RULE RULE_NAME
```

**Parameters:**

- `RULE_NAME`: Name of the rule to debug

**Example:**

```
DEBUG RULE memory-file-verification
```

**Notes:**

- Shows rule execution history
- Identifies interaction with other rules
- Provides detailed analysis of rule behavior
- Reports usage statistics

## Session Management Commands

Commands for managing session state and transitions.

### BEDTIME PROTOCOL

Properly terminates a working session, preserving state.

**Syntax:**

```
BEDTIME PROTOCOL [--quick]
```

**Parameters:**

- `--quick`: Perform abbreviated session termination (emergency only)

**Example:**

```
BEDTIME PROTOCOL
```

**Notes:**

- Performs session assessment
- Updates all memory bank files
- Preserves current state
- Prepares continuity information
- Verifies information completeness

### PAUSE SESSION

Temporarily pauses the current session, preserving state for later resumption.

**Syntax:**

```
PAUSE SESSION [--memo="MEMO_TEXT"]
```

**Parameters:**

- `--memo`: Optional memo about the pause reason

**Example:**

```
PAUSE SESSION --memo="Pausing to gather additional requirements"
```

**Notes:**

- Captures current task state
- Records pause reason
- Creates resumption point
- Does not terminate session fully

## Utility Commands

Miscellaneous utility commands for various operations.

### OPTIMIZE MEMORY BANK

Optimizes memory bank size and organization.

**Syntax:**

```
OPTIMIZE MEMORY BANK [--aggressive]
```

**Parameters:**

- `--aggressive`: Remove more content for greater optimization

**Example:**

```
OPTIMIZE MEMORY BANK
```

**Notes:**

- Removes unnecessary detail
- Consolidates related information
- Improves retrieval efficiency
- Maintains critical knowledge

### EXPORT MEMORY

Exports memory bank content for backup or transfer.

**Syntax:**

```
EXPORT MEMORY [--format=FORMAT] [--destination=PATH]
```

**Parameters:**

- `--format`: Export format (MARKDOWN, JSON, PACKAGE)
- `--destination`: Path for export files

**Example:**

```
EXPORT MEMORY --format=PACKAGE --destination="./backups"
```

**Notes:**

- Creates portable backup of memory bank
- Preserves directory structure
- Includes rule system configuration
- Maintains relationships between files

## Command Combinations

Effective workflows often combine multiple commands in sequence:

**Example: Complete Session Workflow**

```
MEMORY BANK INITIALIZE
SHOW ACTIVE CONTEXT
CONTEXTUALIZE Implement new verification component
ENTER ACT MODE --complexity=3
... (work execution) ...
UPDATE MEMORY BANK --comprehensive
BEDTIME PROTOCOL
```

**Example: System Diagnostic Workflow**

```
MEMORY BANK INITIALIZE
MEMORY HEALTH CHECK --verbose
DEBUG RULES
OPTIMIZE MEMORY BANK
UPDATE MEMORY BANK --comprehensive
```

## Related Information

- [Installation Guide](./Installation.md) - System installation procedures
- [Startup Guide](./Startup.md) - System startup procedures
- [Architecture Overview](../Architecture/Overview.md) - System design and
  components

## Version Information

- Last Updated: March 24, 2025
- Compatible with BIG BRAIN Memory Bank 2.0
- Changelog: Initial documentation for version 2.0
