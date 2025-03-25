# Organization

Scripts for organizing files, rules, and other components of the memory bank
system.

## BIG BRAIN Memory System Rules Organization

The scripts in this directory implement a comprehensive hierarchical
organization for BIG BRAIN's memory system rules, following cognitive memory
model principles:

### Directory Structure

```
.cursor/rules/
└── BIG_BRAIN/
    ├── core/                                   # Core system components (0000-0999)
    │   ├── 0000-big-brain-identity.mdc         # Core identity and purpose
    │   ├── 0010-standard-initialization.mdc    # Startup procedures
    │   └── ...
    └── memory-system/                          # Memory-specific rules (1000-1999)
        ├── 1000-memory-core-system.mdc         # Primary memory system definition
        ├── active/                             # Active memory rules (1100-1199)
        ├── short-term/                         # Short-term memory rules (1200-1299)
        ├── long-term/                          # Long-term memory rules (1300-1399)
        ├── plan/                               # Planning aspects (1400-1499)
        ├── act/                                # Action aspects (1500-1599)
        ├── testing/                            # Testing rules (1600-1699)
        ├── tools/                              # Tool rules (1700-1799)
        └── workflows/                          # Workflow rules (1800-1899)
```

### Naming Conventions

The naming convention follows this pattern:

- `0XXX`: BIG BRAIN Core standards - Foundation system logic
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

### Scripts

1. **reorganize-rules.ps1**

   - Creates the hierarchical directory structure
   - Moves and renames files according to the new naming convention
   - Updates file content with appropriate metadata
   - Creates critical new files needed for the memory system

2. **delete-original-rules.ps1**
   - Deletes original files after reorganization
   - Removes empty directories
   - Only run after verifying the new structure works correctly

### Usage

1. First, run `reorganize-rules.ps1` to create the new structure
2. Test the new structure to ensure everything works correctly
3. When ready, run `delete-original-rules.ps1` to remove the original files

### Memory System Integration

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

This alignment ensures that the rules governing each memory type are organized
in a way that makes them easy to find and update.
