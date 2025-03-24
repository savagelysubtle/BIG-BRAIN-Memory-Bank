# BIG BRAIN Memory Bank - Development Documentation

This document explains the development structure and processes for the BIG BRAIN
Memory Bank system.

## Branch Structure

The BIG BRAIN Memory Bank project uses a dual-branch approach:

1. **main branch** - Stable "clean install" version

   - The primary branch for new users
   - Contains a clean installation without development context
   - Should always be in a functional state

2. **memory-bank-dev branch** - Development version
   - Contains all current improvements and active context
   - Used for ongoing development work
   - Includes the latest Memory Bank updates
   - May contain experimental features or work-in-progress documentation

## Development Workflow

### Starting Work

1. Always work on the `memory-bank-dev` branch for active development
2. Run the `setup-dev-branch.bat` script if you need to create or switch to this
   branch
3. Pull the latest changes before beginning work:
   ```
   git checkout memory-bank-dev
   git pull origin memory-bank-dev
   ```

### Making Changes

1. Make your changes to the Memory Bank and/or documentation
2. Use the `update_docs.bat` script to commit and push changes
3. Update the Memory Bank files to reflect your changes

### Releasing to Main Branch

When you're ready to update the stable version with your improvements:

1. First, ensure all changes are committed and pushed to `memory-bank-dev`
2. Create a merge commit:
   ```
   git checkout main
   git pull origin main
   git merge --no-ff memory-bank-dev -m "Merge development into main: [DESCRIPTION]"
   git push origin main
   ```
3. Return to the development branch:
   ```
   git checkout memory-bank-dev
   ```

## Memory Bank Structure in Development Mode

When working in development mode, the Memory Bank should include:

1. All standard Memory Bank core files:

   - projectbrief.md
   - productContext.md
   - activeContext.md
   - systemPatterns.md
   - techContext.md
   - progress.md

2. Additional development-specific files:
   - Development roadmap
   - Testing procedures
   - Internal documentation
   - Experimental features documentation

## Using Scripts

This repository includes several helpful scripts:

- **setup-dev-branch.bat** - Creates and configures the development branch
- **update_docs.bat** - Simplifies committing and pushing documentation changes
- **[Other scripts as they are developed]**

## Pull Request Process

For significant changes, consider using pull requests:

1. Create a feature branch from `memory-bank-dev`
2. Make your changes and commit them
3. Push the feature branch to GitHub
4. Create a pull request to merge into `memory-bank-dev`
5. After review and approval, merge the pull request

## Questions or Issues

If you encounter issues with the development setup or have questions about the
process, please:

1. Check the documentation in the Memory Bank
2. Look for related issues in the GitHub repository
3. Create a new issue if needed, with clear details about your question or
   problem
