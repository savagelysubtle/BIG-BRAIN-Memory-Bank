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

- **`scripts/`**: Utility scripts for development and maintenance

### Key Files

- **`update_docs.bat`**: Script for committing and pushing documentation changes
- **`setup-dev-branch.bat`**: Script for setting up the development branch
- **`DEVELOPMENT.md`**: Documentation for the development workflow
- **`SETUP-DEV-BRANCH.md`**: Manual instructions for branch setup

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

## Development Workflow

### Branch Usage Guidelines

- Development work occurs on the `memory-bank-dev` branch
- The `main` branch is reserved for stable, clean installations
- Feature branches can be created from `memory-bank-dev` for specific tasks
- Changes to `main` should only occur through controlled merges from
  `memory-bank-dev`

### Update Procedure

1. Make changes on the `memory-bank-dev` branch
2. Use `update_docs.bat` to commit and push changes
3. When ready for a stable release, merge to `main` using:
   ```
   git checkout main
   git pull origin main
   git merge --no-ff memory-bank-dev -m "Merge development into main: [DESCRIPTION]"
   git push origin main
   ```
4. Return to the development branch for continued work

## Technical Decisions

### Why a Dual-Branch Approach?

The dual-branch structure allows:

- A clean, stable version for new users (main)
- A development version with the latest context (memory-bank-dev)
- Separation of concerns between stable and development code
- Controlled updates to the stable version

### Documentation Framework Choices

- **Markdown**: Chosen for its simplicity, widespread support, and clear
  readability
- **Jekyll**: Selected for its integration with GitHub Pages and robust theme
  support
- **Just the Docs**: Picked for its navigation features and clean documentation
  styling
