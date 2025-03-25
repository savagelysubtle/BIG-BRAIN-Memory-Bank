# BIG BRAIN Rules System

**Version: 1.0.0** (March 25, 2023)

This directory contains the rule files that govern BIG BRAIN's behavior,
focusing on memory management, cognitive processing, and operational workflows.

## Directory Structure

```
.cursor/rules/
├── main.mdc                      # Main rules entry point
├── README.md                     # This file
├── BIG_BRAIN/                    # Core BIG BRAIN system components
│   ├── core/                     # Foundational identity and protocols (0000-0099)
│   ├── memory-system/            # Memory management rules (1000-1999)
│   │   ├── active/               # Active memory management (1100-1199)
│   │   ├── short-term/           # Short-term memory management (1200-1299)
│   │   ├── long-term/            # Long-term memory management (1300-1399)
│   │   ├── plan/                 # Planning capabilities (1400-1499)
│   │   ├── act/                  # Action capabilities (1500-1599)
│   │   ├── testing/              # Testing protocols (1600-1699)
│   │   ├── tools/                # Memory tools (1700-1799)
│   │   └── workflows/            # Memory workflows (1800-1899)
├── documentation/                # Documentation standards (400-499)
├── rule_guidelines/              # Meta-rules for rule creation (010-099)
└── templates/                    # Reusable templates (900-999)
```

## Naming Conventions

Rules follow a standardized naming pattern:

```
PREFIX-descriptive-name.mdc
```

Where `PREFIX` is a numeric prefix indicating the rule's category and hierarchy:

- `0XXX`: BIG BRAIN Core standards - Foundation system rules
- `1XXX`: Memory system rules
  - `10XX`: Core memory system
  - `11XX`: Active memory management
  - `12XX`: Short-term memory management
  - `13XX`: Long-term memory management
  - `14XX`: Planning aspects
  - `15XX`: Action aspects
  - `16XX`: Testing standards
  - `17XX`: Tools and utilities
  - `18XX`: Workflows and protocols
- `4XX`: Documentation standards
- `9XX`: Templates and patterns

## Rule Hierarchy

Rules build upon each other in the following hierarchy:

1. **Core Identity Rules (0000-0099)**

   - `0000-big-brain-identity.mdc` - Defines BIG BRAIN's core identity
   - `0010-standard-initialization-procedure.mdc` - Initialization process
   - `0020-protocol-enforcement-mechanisms.mdc` - Protocol enforcement
   - `0050-big-command-protocol.mdc` - Command structure
   - `0060-unified-command-interface.mdc` - Interface standards

2. **Memory System Rules (1000-1999)**

   - `1000-memory-core-system.mdc` - Primary memory system definition
   - Memory type-specific rules (active, short-term, long-term)
   - Memory operation rules (plan, act, tools, workflows)

3. **Documentation Rules (400-499)**

   - Documentation formatting and standards

4. **Templates (900-999)**
   - Reusable patterns and templates

## Memory Bank Integration

The rule organization mirrors the memory-bank structure:

```
memory-bank/
├── active/                      # Primary working directory (current versions)
├── short-term/                  # Recent versioned files (1-2 sessions old)
└── long-term/                   # Permanent historical record
    ├── episodic/                # Experience-based memory
    ├── semantic/                # Knowledge-based memory
    ├── procedural/              # Action-based memory
    └── creative/                # Creative phase outputs
```

This alignment ensures that rules governing each memory type are organized
logically.

## Rule Application Patterns

Rules follow three distinct application patterns:

1. **Always-Applied Rules**

   - Applied to every command regardless of context
   - Core rules like `0000-big-brain-identity.mdc` and
     `1000-memory-core-system.mdc`
   - Set with `alwaysApply: true`

2. **Auto-Attached Rules**

   - Automatically applied when working with matching file patterns
   - Memory type-specific rules that activate when working with corresponding
     files
   - Use specific glob patterns like `memory-bank/active/**/*.md`

3. **Agent-Requested Rules**
   - Explicitly loaded for specific tasks
   - Detailed workflows like the Bedtime Protocol
   - Often marked with "CRITICAL" in the description

## Versioning

Rules follow semantic versioning (MAJOR.MINOR.PATCH):

- **MAJOR**: Incompatible changes requiring retraining
- **MINOR**: Added functionality in a backward-compatible manner
- **PATCH**: Backward-compatible bug fixes

Current version: **1.0.0**

- Initial structured implementation of the BIG BRAIN memory system
- Established cognitive memory model with active, short-term, and long-term
  storage
- Implemented hierarchical rule organization

## Contributing

When adding or modifying rules:

1. Follow the established naming conventions
2. Place files in the appropriate directory based on function
3. Include a proper `<version>` tag in the rule file
4. Update this README when making significant structural changes

## Version History

- **1.0.0** (March 25, 2023)

  - Initial structured implementation with cognitive memory model
  - Established hierarchical rule organization
  - Created core memory workflows

- **0.9.0** (March 24, 2023)
  - Pre-release with basic memory organization
  - Defined active, short-term, and long-term memory structures
  - Initial implementation of Bedtime Protocol
