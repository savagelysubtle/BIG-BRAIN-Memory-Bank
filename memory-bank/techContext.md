---
title: Technical Context
---

# Technical Context

## Development Environment

### Version Control

- **Git:** Used for version control
- **GitHub:** Hosts the repository at
  [https://github.com/savagelysubtle/BIG-BRAIN-Memory-Bank](https://github.com/savagelysubtle/BIG-BRAIN-Memory-Bank)
- **Branch Structure:**
  - `main` - Stable "clean install" version for new users
  - `memory-bank-dev` - Development branch with current improvements and context
  - Branch-specific content maintained through specialized scripts

### Documentation Platform

- **GitHub Pages:** Hosts the documentation site
- **Jekyll:** Static site generator for documentation
- **Just the Docs:** Jekyll theme for documentation with navigation

### Development Tools

- **Windows PowerShell:** Primary shell environment
- **Batch Scripts:** Automation for common tasks
- **Markdown:** Used for all documentation files

## Repository Structure

### Core Directories

- **`docs/`**: Contains the GitHub Pages documentation site

  - `docs/assets/`: Static assets for the documentation site
  - `docs/Workflows/`: Documentation for operational workflows
  - `docs/Memory-Bank/`: Documentation for Memory Bank structure

- **`memory-bank/`**: Contains the Memory Bank core files

  - Core files: projectbrief.md, productContext.md, activeContext.md, etc.
  - Specialized documentation in subdirectories

- **`inspiration/`**: Branch-specific folder kept only in main branch

  - Contains reference materials and inspiration sources
  - Intentionally excluded from development branch

- **`scripts/`**: Utility scripts for development and maintenance

- **`bootstrapper/`**: Contains lightweight entry scripts for Memory Bank setup
  - `Initialize-MemoryBank.ps1`: PowerShell implementation for Windows
  - `Initialize-MemoryBank.sh`: Bash implementation for Unix systems
  - `README.md`: Documentation for bootstrapper usage
  - `.gitignore`: Template for Memory Bank file exclusions

### Key Files

- **`update_docs.bat`**: Script for automatically committing and pushing
  documentation changes
- **`setup-dev-branch.bat`**: Script for setting up the development branch
- **`merge-to-main.bat`**: Script for merging development to main with content
  protection
- **`protect-branch-content.bat`**: Script for setting up branch-specific
  content protection
- **`DEVELOPMENT.md`**: Documentation for the development workflow
- **`SETUP-DEV-BRANCH.md`**: Manual instructions for branch setup
- **`bootstrapper/Initialize-MemoryBank.ps1`**: PowerShell script for
  initializing Memory Bank in new projects
- **`bootstrapper/Initialize-MemoryBank.sh`**: Bash script for initializing
  Memory Bank in new projects

## Technical Constraints

### GitHub Pages Limitations

- Jekyll processing has specific syntax requirements
- Certain plugins may not be available in GitHub Pages
- Build times can affect how quickly changes appear on the site

### Memory Bank Considerations

- Files should be in Markdown format for consistency
- File naming should follow established conventions
- Cross-references must be maintained carefully
- Documentation should be navigable both on GitHub and GitHub Pages

### Branch-Specific Content Management

- `.gitignore` entries must be branch-specific
- Merge operations must preserve branch-specific content
- Automated protection mechanisms are needed for consistent results
- System must handle frequent merges between branches

## Development Workflow

### Branch Usage Guidelines

- Development work occurs on the `memory-bank-dev` branch
- The `main` branch is reserved for stable, clean installations
- Feature branches can be created from `memory-bank-dev` for specific tasks
- Changes to `main` should only occur through controlled merges from
  `memory-bank-dev`
- Branch-specific content requires special handling during merges

### Update Procedure

1. Make changes on the `memory-bank-dev` branch
2. Use `update_docs.bat` to commit and push changes
3. When ready for a stable release, merge to `main` using:
   ```
   .\merge-to-main.bat "Your merge message here"
   ```
4. The script handles branch-specific content automatically
5. Return to the development branch for continued work

### Branch-Specific Content Protection

1. **Initial Setup:**

   - Run `protect-branch-content.bat` on development branch
   - This adds appropriate entries to .gitignore
   - Content will remain in main but be excluded from development

2. **During Development:**

   - Work normally on development branch
   - Specified content (inspiration folder) remains hidden
   - Other files operate normally

3. **During Merges:**
   - Use `merge-to-main.bat` for automated protection
   - The script preserves branch-specific content
   - Ensures inspiration folder remains in main

## Technical Decisions

### Why a Dual-Branch Approach?

The dual-branch structure allows:

- A clean, stable version for new users (main)
- A development version with the latest context (memory-bank-dev)
- Separation of concerns between stable and development code
- Controlled updates to the stable version

### Why Branch-Specific Content?

Branch-specific content was implemented to:

- Keep reference materials in the stable branch
- Maintain a clean, focused development environment
- Allow different content needs for different branch purposes
- Avoid accidental deletion of important content

### Documentation Framework Choices

- **Markdown**: Chosen for its simplicity, widespread support, and clear
  readability
- **Jekyll**: Selected for its integration with GitHub Pages and robust theme
  support
- **Just the Docs**: Picked for its navigation features and clean documentation
  styling

### Why a Bootstrapper Approach?

The bootstrapper approach was implemented to:

- Provide a minimal entry point for new users without requiring a full
  repository clone
- Create personalized Memory Bank structures tailored to specific projects
- Support cross-platform usage with dedicated scripts for Windows and Unix
- Enable integration with existing projects through interactive configuration
- Establish a foundation for the command system, particularly the `BIG init`
  command
