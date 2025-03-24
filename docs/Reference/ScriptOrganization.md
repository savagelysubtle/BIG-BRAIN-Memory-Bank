# Script Organization

## Overview

The BIG BRAIN Memory Bank system implements a categorical script organization
pattern to enhance maintainability, discoverability, and scalability. This
pattern ensures scripts are logically grouped by function while maintaining
backward compatibility with existing processes.

## Organization Structure

### Categorical Organization

Scripts are organized into functional categories:

| Category          | Purpose                                                          |
| ----------------- | ---------------------------------------------------------------- |
| **Init**          | Scripts for system initialization and setup                      |
| **Update**        | Scripts for updating system components and keeping files in sync |
| **Organization**  | Scripts for managing file and rule organization                  |
| **Visualization** | Scripts for generating diagrams and visual representations       |
| **Utilities**     | General utility scripts for common operations                    |
| **Core**          | Essential scripts duplicated for ease of access                  |
| **Backup**        | Scripts and storage for backup operations                        |
| **Bedtime**       | Scripts for session transition management                        |
| **Verification**  | Scripts for verifying system integrity                           |
| **Analytics**     | Scripts for analyzing memory bank usage and statistics           |
| **Migration**     | Scripts for migrating between versions                           |
| **Examples**      | Example scripts demonstrating common operations                  |
| **CI**            | Continuous integration scripts for testing and deployment        |

Each category contains:

- Scripts relevant to that functional area
- A README.md file describing the category's purpose
- Appropriate subdirectories as needed

### File Paths and Locations

Scripts are stored in the following structure:

```
scripts/
├── {Category}/           # Category folder (e.g., Init, Update)
│   ├── README.md         # Category description
│   ├── {script}.ps1      # PowerShell scripts
│   └── {script}.sh       # Bash scripts
└── ScriptCatalog.md      # Comprehensive documentation
```

### Primary Initialization and Update Scripts

For backward compatibility and ease of access, critical scripts are maintained
in both locations:

- The root `scripts/` directory
- Their appropriate category directory

This dual-location approach ensures that:

1. Previously documented paths continue to work
2. The organized structure is maintained for clarity and future development

## Script Discovery and Documentation

### Script Catalog

The `ScriptCatalog.md` file provides comprehensive documentation of all scripts,
organized by category. For each script, it includes:

- The script name and location
- A brief description of the script's purpose
- The primary operations performed by the script

### Category README Files

Each category directory includes a README.md file that describes:

- The category's purpose
- The types of scripts included
- Any special considerations for scripts in that category

### Placeholder Scripts

For planned but not yet implemented functionality, placeholder scripts are
provided that:

- Have the correct filename for the intended function
- Include a descriptive header explaining the planned purpose
- Display a message indicating the placeholder status when executed

## Path Resolution

For scripts that need to reference other scripts, a path resolution system is
implemented:

```powershell
function Find-ScriptPath {
    param (
        [string]$PrimaryPath,
        [string]$AlternativePath
    )

    if (Test-Path -Path $PrimaryPath) {
        return $PrimaryPath
    }
    elseif (Test-Path -Path $AlternativePath) {
        Write-Host "Using script from organized structure: $AlternativePath" -ForegroundColor Yellow
        return $AlternativePath
    }
    else {
        Write-Host "Warning: Script not found in either location." -ForegroundColor Yellow
        return $PrimaryPath # Return primary path as the target location
    }
}
```

This function:

1. Checks for a script in its traditional location
2. If not found, checks in the appropriate category directory
3. Returns the appropriate path for script execution

## Extensibility

The script organization pattern is designed for extensibility:

1. **New Categories**: Additional categories can be added as needed to
   accommodate new system capabilities
2. **Category Evolution**: Each category can evolve independently while
   maintaining system coherence
3. **Version Tracking**: Script versions can be tracked within each category
4. **Cross-Platform Support**: Both PowerShell (.ps1) and Bash (.sh) scripts are
   supported in each category

## Implementation

The script organization is implemented by:

1. The `Organize-ScriptsFolder.ps1` script, which:

   - Creates the category directory structure
   - Moves scripts to their appropriate categories
   - Creates README files for each category
   - Generates the ScriptCatalog.md file
   - Creates placeholder scripts for planned functionality

2. The `Update-InitializationScript.ps1` script, which:
   - Includes path resolution logic to find scripts in either location
   - Ensures initialization scripts work with the organized structure

## Maintaining the Organization

To maintain the script organization:

1. Add new scripts to the appropriate category directory
2. Update the ScriptCatalog.md when adding new scripts
3. Follow the naming conventions established for each category
4. Ensure critical scripts are duplicated in the root directory if needed for
   backward compatibility
5. Include path resolution logic in scripts that reference other scripts

## Version History

| Version | Date       | Author    | Changes                                           |
| ------- | ---------- | --------- | ------------------------------------------------- |
| 1.0.0   | 2025-03-24 | BIG BRAIN | Initial script organization pattern documentation |
