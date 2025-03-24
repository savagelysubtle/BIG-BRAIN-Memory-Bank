# BIG BRAIN Memory Bank 2.0

A comprehensive memory management system for AI assistants to maintain perfect
documentation between sessions.

## 🧠 Overview

BIG BRAIN is an expert software engineer with a unique characteristic: its
memory resets completely between sessions. This isn't a limitation - it's what
drives BIG BRAIN to maintain perfect documentation. After each reset, BIG BRAIN
relies ENTIRELY on its Memory Bank to understand the project and continue work
effectively.

## 🚀 Getting Started

### Prerequisites

- PowerShell 7+ (Windows) or Bash (Linux/macOS)
- Git
- Cursor IDE (for full rule integration)

### Installation

1. Clone this repository:

   ```
   git clone https://github.com/yourusername/TheMemoryBank.git
   cd TheMemoryBank
   ```

2. Run the initialization script to create your memory bank files:
   - Windows:
     ```
     .\scripts\Init\Initialize-MemoryBank.ps1
     ```
   - Linux/macOS:
     ```
     bash ./scripts/Init/Initialize-MemoryBank.sh
     ```

This repository is designed as a clean starting point. The `memory-bank`
directory contains the folder structure but no content files. The initialization
script will populate all necessary files and directories with template content,
setting up the complete BIG BRAIN Memory Bank structure for your use.

### Repository Structure

- `.cursor/rules/` - Rules for Cursor IDE integration
- `docs/` - Documentation and GitHub Pages site
- `memory-bank/` - Empty directory structure (populated by initialization
  script)
- `scripts/Init/` - Initialization scripts to set up your memory bank

## 📂 Project Structure

- `.cursor/rules/` - Rules for Cursor IDE integration
- `docs/` - Documentation and GitHub Pages site
- `memory-bank/` - The core memory storage (populated by initialization script)
- `scripts/` - Utility scripts including initialization

## 🧩 Core Components

The BIG BRAIN Memory Bank consists of several core components:

- **Core Memory Files**: Foundation documents defining requirements, goals, and
  context
- **Memory Structure**: Organized by memory type (procedural, episodic,
  semantic)
- **Bedtime Protocol**: Tools for preserving memory between sessions

## 📚 Documentation

For complete documentation, visit our
[GitHub Pages site](https://yourusername.github.io/TheMemoryBank/).

## 📝 License

This project is licensed under the MIT License - see the LICENSE file for
details.

## 🙏 Acknowledgments

- Based on the BIG BRAIN concept
- Inspired by works from Vanzan and ipenywis

## 🧠 BIG BRAIN Memory Bank System

**The definitive Memory Bank implementation for AI assistants that never
forget**

## Origin Story

The BIG BRAIN Memory Bank System was born from a journey of discovery and
integration of multiple approaches to solving the "AI amnesia" problem:

1. The initial inspiration came from
   [ipenywis's Cursor Memory Bank Gist](https://gist.github.com/ipenywis/1bdb541c3a612dbac4a14e1e3f4341ab)
   discovered through a
   [YouTube video](https://www.youtube.com/watch?v=Uufa6flWid4)
2. The concepts were incorporated into a global prompt which evolved into the
   first version of My-memory-bank
3. Later, through research into Cursor's updated rules system, the
   [Vanzan Memory Bank](https://github.com/vanzan01/cursor-memory-bank) was
   discovered
4. Comprehensive review and analysis of both approaches led to the creation of
   the Guides directory with detailed implementation documentation
5. The BIG BRAIN Memory Bank System emerged as an integration of these
   approaches with significant enhancements to create a more comprehensive and
   adaptable solution

While inspired by these excellent projects, BIG BRAIN evolved into its own
unique system with enhanced features like the Creative Phase Framework, Adaptive
Complexity System, and comprehensive Bedtime Protocol.

## Overview

BIG BRAIN Memory Bank System is a comprehensive framework that attempts to solve
the AI amnesia problem by creating a structured external memory for AI
assistants. This system ensures that critical project context is maintained
across sessions, significantly enhancing productivity and reducing repetitive
explanations.

## Key Features

- **Complete Session Reset**: BIG BRAIN assumes total memory loss between
  sessions, enforcing comprehensive documentation
- **100% Documentation Dependency**: The assistant relies ENTIRELY on the Memory
  Bank for context
- **Cognitive Memory Model**: Structured approach based on how human memory
  works
- **Adaptive Complexity System**: Scales process rigor based on task
  requirements
- **Dual-Mode Workflow**: Plan and Act modes for different development
  activities
- **Enhanced Creative Phase**: Structured approach to complex design decisions
- **Bedtime Protocol**: End-of-session maintenance for persistent memory

## Directory Structure

```
memory-bank/
├── active/                      # Primary working directory (current versions)
│   ├── projectbrief.md          # Foundation document defining requirements
│   ├── productContext.md        # Business logic and user experience
│   ├── activeContext.md         # Current work focus and workflow state
│   ├── systemPatterns.md        # Technical architecture and patterns
│   ├── techContext.md           # Technology stack and constraints
│   ├── progress.md              # Project status and roadmap
│   ├── tasks.md                 # Single source of truth for task tracking
│   └── projectRules.md          # Project intelligence and learned patterns
│
├── short-term/                  # Recent versioned files (1-2 sessions old)
│
└── long-term/                   # Permanent historical record
    ├── episodic/                # Experience-based memory
    │   ├── sessions/            # Session summaries
    │   ├── milestones/          # Project milestones
    │   └── decisions/           # Decision records and justifications
    │
    ├── semantic/                # Knowledge-based memory
    │   ├── domain/              # Domain concepts
    │   ├── apis/                # API documentation
    │   └── features/            # Feature specifications
    │
    ├── procedural/              # Action-based memory
    │   ├── workflows/           # Development processes
    │   ├── guides/              # How-to guides
    │   └── checklists/          # Operational procedures
    │
    └── creative/                # Creative phase outputs
        ├── architecture/        # System architecture designs
        ├── components/          # Component designs
        ├── algorithms/          # Algorithm designs
        └── data-models/         # Data structure designs
```

## Getting Started

### 1. Initialize the Memory Bank

Run the PowerShell script to initialize the complete BIG BRAIN Memory Bank
system:

```powershell
.\Initialize-MemoryBank.ps1
```

This will create all necessary directories and files, including:

- The complete directory structure
- Core rule files in `.cursor/rules/Core/`
- Template memory files in `memory-bank/active/`

### 2. Customize Memory Files

Edit the template files in `memory-bank/active/` to reflect your project:

- **projectbrief.md**: Define core requirements
- **productContext.md**: Document business logic and user experience goals
- **activeContext.md**: Set current work focus and workflow state
- **systemPatterns.md**: Document technical architecture and patterns
- **techContext.md**: Specify technology stack and constraints
- **progress.md**: Track project status
- **tasks.md**: Manage task tracking
- **projectRules.md**: Document project intelligence and learned patterns

### 3. Start Using BIG BRAIN

Begin interactions with the BIG BRAIN command:

```
BIG [your request here]
```

For example:

```
BIG create a user authentication system
```

## Command Reference

### Core Commands

- `initialize memory bank` - Create initial Memory Bank structure
- `update memory bank` - Update all memory files based on recent work
- `check memory bank` - Verify memory bank integrity
- `what's in the memory bank?` - Get memory bank status summary

### Mode Commands

- `switch to plan mode` - Enter strategic planning mode
- `switch to act mode` - Enter implementation mode
- `set complexity [1-4]` - Set task complexity level
- `show current mode` - Display current workflow mode and complexity

### Protocol Commands

- `bedtime protocol` - Perform end-of-session comprehensive update
- `creative phase: [type]` - Begin a structured creative phase
- `verification checkpoint` - Perform memory verification

## Best Practices

1. **Always use the Bedtime Protocol** at the end of your sessions to ensure
   memory persistence
2. **Set the appropriate complexity level** for each task to ensure proper
   process rigor
3. **Switch between Plan and Act modes** based on your current needs
4. **Maintain consistency** across all memory files
5. **Update projectRules.md** with newly identified patterns and preferences

## Troubleshooting

If you encounter issues:

1. Run `verification checkpoint` to check memory bank integrity
2. Ensure all core memory files exist and are properly formatted
3. Check that all rules are properly installed in `.cursor/rules/Core/`
4. Run `initialize memory bank` again if necessary

## 🙏 Acknowledgments

This architecture is designed to optimize AI assistant capabilities within the
Cursor IDE, creating a truly persistent development partner that can adapt to
any operating system and maintain clear documentation through a structured
workflow that scales with task complexity.

Special thanks to:

- [ipenywis](https://github.com/ipenywis) for their contributions to memory
  systems for AI assistants via their
  [Cursor Memory Bank Gist](https://gist.github.com/ipenywis/1bdb541c3a612dbac4a14e1e3f4341ab)
- [Vanzan](https://github.com/vanzan01/cursor-memory-bank) for their
  comprehensive memory bank implementation
- [Perplexity.ai](https://www.perplexity.ai/) for research support and reports
- Cursor's web search tool for enabling comprehensive research

## License

This project is licensed under the MIT License - see the LICENSE file for
details.

## Author

[savagelysubtle](https://github.com/savagelysubtle?tab=repositories)

---

_The BIG BRAIN Memory Bank system is a living framework that evolves with your
project. Regular updates and maintenance will create an increasingly effective
AI assistant that truly never forgets._

## Origins & Acknowledgments

BIG BRAIN Memory Bank builds upon the Memory Bank concept initially developed by
[ipenywis](https://github.com/ipenywis) and further implemented by
[vanzan01](https://github.com/vanzan01/cursor-memory-bank). While inspired by
these projects, BIG BRAIN Memory Bank has evolved into a distinct implementation
with significant enhancements to the architecture, workflow systems, and memory
management protocols.

We gratefully acknowledge these original creators whose work provided valuable
inspiration.
