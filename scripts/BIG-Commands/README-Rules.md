# BIG Rules Command

The BIG Rules Command provides a standardized interface for managing and applying rules in the BIG BRAIN Memory Bank. It allows users to define, manage, and enforce consistent rules for file organization, naming conventions, content categorization, and more.

## Overview

The BIG Rules Command implements the following pattern:

```
BIG rules [command] [parameters] [--options]
```

## Available Commands

| Command    | Description                            |
| ---------- | -------------------------------------- |
| `list`     | Lists all rules or filters by category |
| `add`      | Adds a new rule to the system          |
| `update`   | Updates an existing rule               |
| `remove`   | Removes a rule from the system         |
| `apply`    | Applies rules to a target path         |
| `validate` | Validates the consistency of rules     |

## Common Parameters

| Parameter      | Description                                           | Default         |
| -------------- | ----------------------------------------------------- | --------------- |
| `-RuleId`      | Unique identifier for the rule (format: `prefix-###`) |                 |
| `-Category`    | Category of the rule (e.g., organization, naming)     |                 |
| `-Description` | Description of what the rule does                     |                 |
| `-Pattern`     | File pattern to match (supports wildcards)            |                 |
| `-Action`      | Action to perform when rule matches                   |                 |
| `-Priority`    | Priority level (higher numbers = higher priority)     | `100`           |
| `-TargetPath`  | Path where rules should be applied                    | `.\memory-bank` |
| `-Force`       | Skip confirmation prompts                             | `false`         |
| `-Detailed`    | Show detailed rule information                        | `false`         |

## Rule Structure

Each rule in the system has the following components:

```json
{
  "id": "prefix-###",
  "category": "category-name",
  "description": "What the rule does",
  "pattern": "*.md",
  "action": "action-name",
  "priority": 100,
  "enabled": true
}
```

### Rule ID Format

Rule IDs follow the format `prefix-###`, where:
- `prefix` is a short alphabetic code indicating the rule type (e.g., `org` for organization)
- `###` is a three-digit number (e.g., `001`)

Examples: `org-001`, `cat-002`, `nam-003`

### Categories

Common rule categories include:

- `organization`: Rules for organizing files in the memory bank
- `categorization`: Rules for categorizing content into memory types
- `naming`: Rules for enforcing naming conventions
- `formatting`: Rules for content formatting
- `linking`: Rules for creating relationships between files
- `housekeeping`: Rules for maintenance and cleanup

### Actions

Common rule actions include:

- `move-to-long-term`: Move matching files to long-term memory
- `categorize-as-episodic`: Categorize matching files as episodic memory
- `categorize-as-semantic`: Categorize matching files as semantic memory
- `categorize-as-procedural`: Categorize matching files as procedural memory
- `categorize-as-creative`: Categorize matching files as creative memory
- `enforce-kebab-case`: Ensure files use kebab-case naming
- `enforce-frontmatter`: Ensure files include required frontmatter
- `create-index-link`: Create index entries for matching files

## Usage Examples

### Listing Rules

```powershell
# List all rules in summary format
.\BIG-Rules.ps1 -Command list

# List rules with detailed information
.\BIG-Rules.ps1 -Command list -Detailed

# List rules by category
.\BIG-Rules.ps1 -Command list -Category naming
```

### Adding Rules

```powershell
# Add a new organization rule
.\BIG-Rules.ps1 -Command add -RuleId org-004 -Category organization -Description "Move knowledge files to semantic memory" -Pattern "*knowledge*.md" -Action categorize-as-semantic

# Add a new naming rule with custom priority
.\BIG-Rules.ps1 -Command add -RuleId nam-002 -Category naming -Description "Ensure all procedure files are properly named" -Pattern "*.md" -Action enforce-procedure-naming -Priority 120
```

### Updating Rules

```powershell
# Update a rule's description
.\BIG-Rules.ps1 -Command update -RuleId org-001 -Description "New description"

# Update multiple properties
.\BIG-Rules.ps1 -Command update -RuleId cat-002 -Pattern "*session-*.md" -Priority 95 -Action categorize-as-episodic
```

### Removing Rules

```powershell
# Remove a rule (with confirmation)
.\BIG-Rules.ps1 -Command remove -RuleId org-001

# Remove a rule without confirmation
.\BIG-Rules.ps1 -Command remove -RuleId org-001 -Force
```

### Applying Rules

```powershell
# Apply all active rules to the memory bank
.\BIG-Rules.ps1 -Command apply

# Apply rules to a specific directory
.\BIG-Rules.ps1 -Command apply -TargetPath ".\memory-bank\active"
```

### Validating Rules

```powershell
# Validate the consistency of all rules
.\BIG-Rules.ps1 -Command validate
```

## Default Rules

The system comes with the following default rules:

1. **core-001**: Stable knowledge should be moved to long-term memory
   - Pattern: `*.md`
   - Action: `move-to-long-term`
   - Priority: 100

2. **core-002**: Session records should be categorized as episodic memory
   - Pattern: `*session*.md`
   - Action: `categorize-as-episodic`
   - Priority: 90

3. **core-003**: All files should use kebab-case naming convention
   - Pattern: `*`
   - Action: `enforce-kebab-case`
   - Priority: 80

## Integration with Other BIG Commands

The Rules system integrates with other BIG commands:

- **BIG-Organization**: Rules drive the organization process
- **BIG-Bedtime**: Rules are applied during the bedtime protocol
- **BIG-Analytics**: Rules contribute to memory health

## Rules Storage

Rules are stored in a JSON file at:
```
scripts/Rules/memory-rules.json
```

This makes them easy to version control and back up.

## Extending Rules

To create custom rules or actions:

1. Add a new rule with a unique ID using `BIG-Rules.ps1 -Command add`
2. Implement action handlers in the rules implementation script
3. Document the new rule and action in your system documentation

## Troubleshooting

### Common Issues

1. **Rule Not Applied**: Check the rule's pattern and ensure it matches the expected files
2. **Conflicting Rules**: Rules with higher priority are applied first, which may prevent lower-priority rules from executing
3. **Invalid Rule ID**: Rule IDs must follow the `prefix-###` format

### Potential Errors

```
Error: Invalid rule ID format
```
Solution: Ensure the rule ID follows the format `prefix-###` (e.g., `org-001`).

```
Error: Rule ID already exists
```
Solution: Choose a unique rule ID or use `-Force` to overwrite the existing rule.

## Version History

- 1.0.0: Initial implementation of BIG Rules commands (2025-03-27)