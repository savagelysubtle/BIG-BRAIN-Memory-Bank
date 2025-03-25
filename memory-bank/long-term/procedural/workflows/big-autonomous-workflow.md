---
title: BIG Autonomous Command System Workflow
created: 2025-03-25
status: active
complexity: Level 3
category: workflow
tags: [autonomous, command, workflow, rules, automation]
related:
  - memory-bank/long-term/procedural/guides/automated-operations.md
  - memory-bank/long-term/semantic/features/command-architecture.md
  - memory-bank/long-term/procedural/checklists/daily-maintenance.md
---

# BIG Autonomous Command System Workflow

> **TL;DR:** The BIG-Autonomous command system provides one-stop automation for memory bank operations, intelligently orchestrating commands across different categories based on rules and file tags.

<version>1.0.0</version>

## 📌 System Overview

The BIG-Autonomous command system serves as a central orchestration layer for the Memory Bank, providing pre-configured operation sequences that bring together multiple command categories into cohesive workflows. It enables increased automation, consistency, and reliability by managing dependencies between operations and handling error conditions gracefully.

### Key System Features

1. **Command Orchestration:** Executes sequences of commands across different categories
2. **Contextual Intelligence:** Uses rules and file tags to customize operations
3. **Progress Tracking:** Monitors and logs execution with detailed reporting
4. **Error Resilience:** Gracefully handles and recovers from operation failures
5. **User Interaction Options:** Configurable levels of user confirmation
6. **Skip Capability:** Flexible execution with ability to skip specific operation types

## 🚀 Command Operation Modes

### Daily Operations
Focused on essential maintenance tasks that should be performed regularly:

1. Health check to assess memory bank status
2. Application of active rules to maintain organization
3. Content reorganization based on current structure
4. Daily summary report generation

### Weekly Operations
More comprehensive maintenance with deeper system adjustments:

1. System script updates to incorporate improvements
2. Complete rule validation and application
3. Content reorganization and obsolete file cleanup
4. Comprehensive HTML and JSON reporting

### Monthly Operations
Full-scale maintenance cycle for comprehensive system health:

1. Initialization script updates and memory structure updates
2. Complete rules validation and application
3. Content categorization, reorganization and cleanup
4. Comprehensive HTML, JSON, and text reporting

### Refresh Operations
Quick maintenance when immediate improvements are needed:

1. Health check to identify issues
2. Rule application to address organization issues
3. Basic content reorganization

### Full Operations
Complete end-to-end system overhaul:

1. Complete system and initialization script updates
2. Full rule validation and application
3. Health checks and detailed statistics
4. Complete content categorization, reorganization and cleanup
5. Comprehensive reporting in multiple formats
6. Bedtime protocol execution for session completion

## 📂 Rule-Based Execution Patterns

The autonomous command system leverages rules to determine how to handle files based on their metadata, tags, and content patterns. This creates a powerful automation system that can adapt operations to the specific context of your memory bank.

### File Tag Integration

The system uses file tags (found in frontmatter) to intelligently process content by:

1. **Tag-Based Prioritization:** Files with `priority: high` or `status: needs-review` tags receive priority handling during reorganization
2. **Category-Specific Processing:** Files with category tags like `category: workflow` or `category: documentation` trigger specific rule sets
3. **Tag-Rule Actions:** Special tags like `@action:move-to-semantic` or `@action:archive` trigger specific rule actions
4. **Age-Based Processing:** Files with creation dates older than specified thresholds receive special handling based on `created` metadata

### Rule Pattern Examples

```
# Tag-based rule example
{
  "id": "auto-001",
  "category": "automation",
  "description": "Process workflow files with specific tags",
  "pattern": "*.md",
  "conditions": [
    { "tag": "category", "equals": "workflow" },
    { "tag": "status", "equals": "active" }
  ],
  "action": "apply-workflow-template",
  "priority": 100,
  "enabled": true
}

# Content-pattern rule example
{
  "id": "auto-002",
  "category": "automation",
  "description": "Process files needing automation updates",
  "pattern": "*.md",
  "conditions": [
    { "content": "@automation:needs-update" }
  ],
  "action": "flag-for-update",
  "priority": 90,
  "enabled": true
}
```

## ⚙️ Implementation Architecture

The BIG-Autonomous system implements a layered architecture:

1. **Command Layer:** `BIG.ps1` provides the entry point and parameter validation
2. **Orchestration Layer:** `BIG-Autonomous.ps1` manages the sequencing of operations
3. **Execution Layer:** Individual category scripts that perform specific operations
4. **Rule Engine Layer:** `BIG-Rules.ps1` applies rules based on file content and metadata
5. **Logging Layer:** Centralized logging through `Write-BIGLog.ps1`

### Execution Flow

```
[User Command] → [BIG.ps1] → [BIG-Autonomous.ps1] → [Operation Selection] → [Rule Processing]
                                                   → [Category Scripts] → [Results] → [Reports]
```

## 📝 File Tag Patterns for Automation

To leverage autonomous operations effectively, implement these file tag patterns in your content:

### Priority Tags
```yaml
priority: high|medium|low
```

### Status Tags
```yaml
status: active|archived|draft|needs-review
```

### Category Tags
```yaml
category: workflow|documentation|reference|guide|checklist
```

### Action Tags (within content)
```markdown
<!-- @action:move-to-semantic -->
<!-- @action:mark-complete -->
<!-- @action:archive -->
```

### Automation Tags (within content)
```markdown
<!-- @automation:daily -->
<!-- @automation:weekly -->
<!-- @automation:monthly -->
<!-- @automation:skip-reorganize -->
```

## 🔄 Rule-Action Integration Points

The autonomous system extends regular rules with special actions specifically designed for automated operations:

| Rule Action            | Description                                               |
| ---------------------- | --------------------------------------------------------- |
| `auto-reorganize`      | Automatically reorganizes files based on tags and content |
| `auto-categorize`      | Assigns categories based on content analysis              |
| `auto-tag`             | Adds appropriate tags based on content patterns           |
| `auto-update-metadata` | Updates metadata based on file content and system state   |
| `auto-generate-report` | Creates reports based on file analysis                    |
| `auto-link-related`    | Establishes relationships between related files           |

## 📊 Workflow Decision Matrix

| Condition                    | Daily | Weekly | Monthly | Refresh | Full |
| ---------------------------- | ----- | ------ | ------- | ------- | ---- |
| Low memory health (<40%)     | ✅     |        |         | ✅       |      |
| Files without categories >10 |       | ✅      |         |         |      |
| System updates available     |       | ✅      |         |         | ✅    |
| Rules need validation        |       | ✅      |         |         |      |
| New memory types added       |       |        | ✅       |         |      |
| End of week (Friday)         |       | ✅      |         |         |      |
| End of month                 |       |        | ✅       |         |      |
| After major changes          |       |        |         | ✅       |      |
| Before long absence          |       |        |         |         | ✅    |

## 🚦 Usage Guidelines

### When to Use Each Command Mode

* **Daily**: Regular maintenance during active work periods
* **Weekly**: End-of-week cleanup or when rule changes need application
* **Monthly**: Comprehensive maintenance or when structure needs updates
* **Refresh**: After adding significant content or when health score drops
* **Full**: For complete system overhauls or before extended absences

### Command Syntax Examples

```powershell
# Basic daily operations
.\BIG.ps1 -Category autonomous -Command daily

# Weekly maintenance skipping system updates
.\BIG.ps1 -Category autonomous -Command weekly -SkipUpdate

# Monthly maintenance with custom report location
.\BIG.ps1 -Category autonomous -Command monthly -OutputPath "C:\Reports"

# Quick refresh after adding new content
.\BIG.ps1 -Category autonomous -Command refresh

# Full system operations without interaction (for scheduled tasks)
.\BIG.ps1 -Category autonomous -Command full -NoInteraction
```

## 🧩 Integration with Manual Workflows

The autonomous system is designed to complement, not replace, manual operations:

1. **Pre-Session**: Run `refresh` to ensure memory bank is properly organized
2. **During-Session**: Use manual commands for specific targeted operations
3. **Post-Session**: Run `daily` to ensure all changes are properly processed
4. **End-of-Week**: Run `weekly` to perform deeper maintenance
5. **End-of-Month**: Run `monthly` to ensure complete system health

## 🔍 Implementation Notes

1. The autonomous system logs all operations to the central log file, providing a complete audit trail
2. All operations include proper error handling with detailed error messages
3. The `-NoInteraction` switch enables fully automated operation for scheduled tasks
4. Each operation sequence can be customized with skip parameters
5. The system respects file locking and will not modify files that are currently open in other applications

## 📌 Future Enhancements

1. Advanced content analysis for improved categorization
2. ML-based priority determination based on usage patterns
3. Enhanced reporting with visualization components
4. Automated scheduling of appropriate commands
5. Adaptive operation sequences based on system health metrics

By implementing the BIG-Autonomous command system with proper file tagging and rule integration, the Memory Bank gains significant automation capabilities that increase consistency, reduce maintenance overhead, and ensure the system remains optimally organized.