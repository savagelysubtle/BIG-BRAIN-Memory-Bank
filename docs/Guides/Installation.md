# Installation Guide

## Overview

This guide provides detailed instructions for installing the BIG BRAIN Memory
Bank 2.0 system. The Memory Bank is a sophisticated system designed to maintain
operational consistency and knowledge persistence across memory resets. This
guide covers system requirements, installation steps, and verification
procedures.

## Prerequisites

Before installing the BIG BRAIN Memory Bank system, ensure you have:

- A compatible IDE environment (recommended: Cursor)
- Git version control system
- Python 3.8 or higher
- 500MB of available disk space
- Markdown-compatible text editor
- Administrator or appropriate access rights

## Installation Methods

You can install the BIG BRAIN Memory Bank system using one of these methods:

### Method 1: Clone from GitHub Repository

1. Open a terminal or command prompt
2. Navigate to your desired installation directory:
   ```bash
   cd /path/to/your/projects
   ```
3. Clone the repository:
   ```bash
   git clone https://github.com/big-brain/memory-bank.git
   ```
4. Navigate to the project directory:
   ```bash
   cd memory-bank
   ```

### Method 2: Download Release Package

1. Visit the
   [official releases page](https://github.com/big-brain/memory-bank/releases)
2. Download the latest release package (`big-brain-memory-bank-2.0.zip`)
3. Extract the package to your desired location:
   ```bash
   unzip big-brain-memory-bank-2.0.zip -d /path/to/installation
   ```
4. Navigate to the extracted directory:
   ```bash
   cd /path/to/installation/big-brain-memory-bank-2.0
   ```

## Configuration Setup

After installing the core system, you need to configure it:

1. Create the essential directory structure:

   ```bash
   mkdir -p memory-bank/core/active
   mkdir -p memory-bank/core/foundation
   mkdir -p memory-bank/short-term
   mkdir -p memory-bank/long-term
   mkdir -p .cursor/rules/BIG_BRAIN
   ```

2. Copy the default configuration files:

   ```bash
   cp config/templates/* .cursor/rules/BIG_BRAIN/
   ```

3. Initialize the memory bank:
   ```bash
   python scripts/initialize_memory_bank.py
   ```

## Rule System Setup

The BIG BRAIN Memory Bank relies on a comprehensive rule system:

1. Ensure the rules directory structure is correctly set up:

   ```bash
   ls -la .cursor/rules/BIG_BRAIN
   ```

   You should see these directories:

   - Core/
   - Identity/
   - Protocols/
   - Templates/
   - Utilities/

2. Verify rule files are present:

   ```bash
   find .cursor/rules/BIG_BRAIN -name "*.mdc" | wc -l
   ```

   The command should return a number of rule files (approximately 30+).

## Memory File Initialization

Initialize the core memory files:

1. Run the memory initialization script:

   ```bash
   python scripts/create_core_memory.py
   ```

2. Verify the creation of essential memory files:

   ```bash
   ls -la memory-bank/core/active
   ```

   You should see these files:

   - projectbrief.md
   - productContext.md
   - activeContext.md
   - systemPatterns.md
   - techContext.md
   - progress.md

## Verification

Verify your installation with these checks:

1. Run the system verification script:

   ```bash
   python scripts/verify_installation.py
   ```

   Expected output:

   ```
   BIG BRAIN Memory Bank 2.0
   ✓ Core structure verified
   ✓ Rule system available
   ✓ Memory files initialized
   ✓ Integration verified

   Installation successful!
   ```

2. Manually verify rule system:

   ```bash
   grep -r "description:" .cursor/rules/BIG_BRAIN
   ```

   This should display multiple rule descriptions.

## Troubleshooting

If you encounter issues during installation:

1. **Missing Dependencies**

   - Run `pip install -r requirements.txt` to install required packages

2. **Permission Issues**

   - Ensure you have write permissions to the installation directory
   - Use administrator mode if necessary

3. **Rule System Not Loading**

   - Check if your IDE is configured to use custom rules
   - Verify the rules path is correctly set in your IDE settings

4. **Memory File Initialization Failure**
   - Check disk space availability
   - Verify Python version compatibility
   - Ensure no conflicting files exist

## Related Information

- [Startup Guide](./Startup.md) - Learn how to start and use the system
- [Architecture Overview](../Architecture/Overview.md) - Understand the system
  architecture
- [Command Guide](./Commands.md) - Reference for system commands

## Version Information

- Last Updated: March 24, 2025
- Compatible with BIG BRAIN Memory Bank 2.0
- Changelog: Initial documentation for version 2.0
