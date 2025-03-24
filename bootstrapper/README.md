# BIG BRAIN Memory Bank Bootstrapper

A lightweight entry point for setting up the BIG BRAIN Memory Bank system in any
project.

## Overview

This bootstrapper provides a minimal set of scripts that dynamically generate
the complete BIG BRAIN Memory Bank structure in your project. Instead of cloning
a large repository with predefined content, these scripts create a personalized
Memory Bank tailored to your specific project.

## Features

- **Interactive Setup**: Questionnaire-based personalization
- **Cross-Platform**: Supports Windows (PowerShell) and Unix (Bash)
- **Smart Integration**: Respects existing files and handles conflicts
  gracefully
- **Git-Friendly**: Properly configures .gitignore for Memory Bank files
- **Self-Contained**: All templates and logic in a single script file
- **Cursor IDE Integration**: Automatically sets up rules for Cursor IDE

## Installation

### Option 1: Direct Download

1. Download the script for your platform:

   - Windows: `Initialize-MemoryBank.ps1`
   - Unix: `Initialize-MemoryBank.sh`

2. Make the script executable (Unix only):

   ```bash
   chmod +x Initialize-MemoryBank.sh
   ```

3. Run the script:
   - Windows: `./Initialize-MemoryBank.ps1`
   - Unix: `./Initialize-MemoryBank.sh`

### Option 2: Clone This Repository

1. Clone the bootstrapper repository:

   ```
   git clone https://github.com/username/bigbrain-bootstrapper.git
   cd bigbrain-bootstrapper
   ```

2. Run the appropriate script for your platform:

   - Windows: `./Initialize-MemoryBank.ps1`
   - Unix: `./Initialize-MemoryBank.sh`

3. After setup is complete, you can safely delete the bootstrapper directory.

## What Gets Created

The bootstrapper creates the following directory structure:

```
your-project/
├── .cursor/rules/
│   ├── BIG_BRAIN/             # Rules for BIG BRAIN core functionality
│   │   ├── Identity/          # Core identity rules
│   │   ├── Core/              # Core operation rules
│   │   │   ├── Foundation/    # Foundation layer rules
│   │   │   ├── Command/       # Command handling rules
│   │   │   └── ...           # Other core rule categories
│   │   ├── Workflows/         # Workflow operation rules
│   │   └── Protocols/         # Process protocol rules
│   └── Codebase/              # Language/framework specific rules
│       ├── JavaScript/        # JavaScript specific rules
│       ├── Python/            # Python specific rules
│       ├── Java/              # Java specific rules
│       ├── ...                # Other language directories
│       ├── Git/               # Git operation rules
│       └── Testing/           # Testing-related rules
├── memory-bank/              # The core memory storage
│   ├── core/                 # Foundation memory files
│   │   └── active/           # Current working files
│   ├── episodic/             # Experience-based memory
│   ├── procedural/           # Action-based memory
│   ├── semantic/             # Knowledge-based memory
│   └── Bedtime Protocol/     # End-of-session protocol
└── .gitignore               # Updated to ignore memory files
```

## Using BIG BRAIN

After initialization, you can start using BIG BRAIN by following these steps:

1. **Initialize Project Context**:

   ```
   BIG init
   ```

   This command analyzes your project structure and populates the memory bank
   with context about your codebase.

2. **Query BIG BRAIN** with commands that begin with "BIG":

   ```
   BIG tell me about this project
   BIG switch to plan mode
   BIG update memory bank
   ```

3. **End Your Session** with the Bedtime Protocol:
   ```
   BIG execute bedtime protocol
   ```
   This ensures all context is properly saved for future sessions.

## License

This project is licensed under the MIT License - see the LICENSE file for
details.

## Acknowledgments

- Based on the BIG BRAIN concept
- Inspired by works from Vanzan and ipenywis
