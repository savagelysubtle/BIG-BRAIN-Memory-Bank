# Memory Bank

## Overview

The Memory Bank is BIG BRAIN's persistent memory system, designed to maintain
knowledge and context across memory reset sessions. It serves as the sole source
of continuity between work sessions, providing critical project information in a
structured and accessible format.

## Structure

The Memory Bank is organized into a three-tier storage hierarchy:

```bash
memory-bank/
├── active/          # Active working files currently in development
├── Short-term/      # Recent versioned files for immediate reference
└── Bedtime Protocol/
    ├── memory-tools/    # Tools for memory management
    └── Long term memory/
        ├── codebase/
        ├── import/
        ├── metadata/
        ├── priority/
        ├── productContext/
        ├── progress/
        ├── projectbrief/
        ├── refactoring/
        └── systemPatterns/
```

### Storage Tiers

1. **active/**

   - Current working files in active development
   - Latest versions of all core files
   - Frequently updated during work sessions

2. **Short-term/**

   - Recent versioned files (e.g., `activeContext_v1.2.md`)
   - Immediate reference material
   - Created during the Bedtime Protocol process

3. **Bedtime Protocol/Long term memory/**
   - Archival storage organized into category folders
   - Categorized for improved discoverability
   - Each category folder contains a `.category_info.md` metadata file

## Core Categories

The long-term memory is organized into specific categories, each containing
related files:

| Category       | Description                                                  |
| -------------- | ------------------------------------------------------------ |
| projectbrief   | Foundation documents defining core requirements and goals    |
| productContext | Explains why the project exists and user experience goals    |
| activeContext  | Documents current work focus, recent changes, and next steps |
| systemPatterns | Outlines system architecture and component relationships     |
| techContext    | Lists technologies, development setup, and constraints       |
| progress       | Tracks what works, what's left to build, and known issues    |
| refactoring    | Refactoring plans and implementation approaches              |
| codebase       | Codebase analysis and documentation                          |
| import         | Import and dependency management documentation               |
| metadata       | Memory system metadata and logs                              |
| priority       | High-priority documents requiring quick access               |

## Core Files

Six essential files form the backbone of the Memory Bank:

1. **projectbrief.md** - Critical project definition that shapes all other files
2. **productContext.md** - Business context and problem space
3. **activeContext.md** - Current status and ongoing work
4. **systemPatterns.md** - Technical architecture and implementation patterns
5. **techContext.md** - Technology stack and development environment
6. **progress.md** - Project status and roadmap

## Memory Management

The Memory Bank is maintained through:

1. **Regular Updates**

   - During work sessions, files in the `active/` directory are updated
   - Updates focus on significant changes, not minor edits
   - `activeContext.md` and `progress.md` receive the most frequent updates

2. **Bedtime Protocol**

   - Formal process for preserving memory between sessions
   - Creates versioned files and archives them appropriately
   - Follows precise steps detailed in `Bedtime Protocol/README.md`
   - Utilizes the `memory_manager.py` tool for safe file operations

3. **Category Organization**
   - Files are automatically categorized based on content and naming
   - The memory manager script can reorganize loose files with
     `--reorganize-existing`
   - Categories have metadata maintained by the memory system

## Usage Guidelines

- **Reading**: Always begin by reading from `active/` directory files
- **Updating**: Make changes directly to files in the `active/` directory
- **Versioning**: Let the Bedtime Protocol handle versioning and archiving
- **Organization**: Use `memory_manager.py` for file organization
- **Best Practice**: When in doubt, preserve more information rather than less

## Memory Tools

The `memory-tools/memory_manager.py` script provides automated memory
management:

- Organizing files into category folders
- Detecting appropriate categories based on content
- Safe file operations with verification
- Memory optimization for large operations
- Detailed logging of all memory operations

## Important Note

The Memory Bank is the sole link to previous work after memory resets. It must
be maintained with precision and clarity, as BIG BRAIN's effectiveness depends
entirely on its accuracy.
