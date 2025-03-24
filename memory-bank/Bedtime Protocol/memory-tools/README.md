# Memory Manager for BIG BRAIN Memory Bank

This directory contains tools that automate memory management for the BIG BRAIN
Memory Bank system, with a focus on the Bedtime Protocol operations. These tools
help ensure consistent memory organization, proper archiving, and maintenance of
context across sessions.

## Key Components

1. **memory_manager.py**: Main script for managing memory files, including
   moving active files to archive locations, organizing by categories, and
   maintaining version history.

2. **memory_config.json**: Configuration file that defines operations, paths,
   and categorization rules.

3. **logs/**: Directory containing operation logs.

4. **templates/**: Directory containing template files for various memory types.

## Memory Manager Features

- **BIG BRAIN Compatible**: Fully adapted to work with the BIG BRAIN Memory Bank
  structure
- **Memory Type Support**: Handles all memory types (core, episodic, semantic,
  procedural)
- **Safe Operations**: Performs dry runs and verifications before any
  destructive actions
- **Recycling Bin**: Uses the system recycling bin rather than permanent
  deletion
- **Smart Categorization**: Automatically detects appropriate categories based
  on content
- **Hierarchical Organization**: Maintains the hierarchical memory structure

## How to Use

### Basic Usage

```bash
python memory_manager.py memory_config.json
```

This will:

1. Perform a dry run to check all operations
2. Request confirmation before making changes
3. Copy active files to appropriate archive locations
4. Verify all operations completed successfully
5. Request confirmation before moving originals to recycling bin

### Command-Line Options

- `--force-overwrite`: Allow overwriting of existing files (use with caution)
- `--recycle-confirmed`: Skip confirmations and perform recycling bin operations
- `--organize-by-category`: Organize files into category folders within archive
  directories
- `--reorganize-existing`: Organize existing files in archive directories
- `--analyze-organization`: Analyze current organization without making changes
- `--category-detection`: Specify method for category detection (basic, smart,
  content-based)

### Integration with Bedtime Protocol

The memory manager is designed to support the BIG BRAIN Bedtime Protocol:

1. After completing the manual steps in the Bedtime Protocol README.md, run the
   memory manager to archive files.
2. Use the `--organize-by-category` flag to ensure proper organization by memory
   type and category.
3. The script will maintain versioned files in the active directories while
   archiving previous versions.

## Advanced Usage

### Custom Configuration

You can create custom configuration files for specific tasks:

```bash
python memory_manager.py custom_config.json --organize-by-category
```

### Organization Analysis

To analyze the current state of your memory bank organization:

```bash
python memory_manager.py memory_config.json --analyze-organization
```

### Memory Reorganization

To reorganize existing files in the archive directories:

```bash
python memory_manager.py memory_config.json --reorganize-existing
```

## Safety Features

- Dry run verification before operations
- File copying before deletion (never directly moves files)
- Confirmation prompts at critical stages
- Recycling bin usage instead of permanent deletion
- Detailed operation logs

## Example Workflow

1. Complete manual Bedtime Protocol steps
2. Run `python memory_manager.py memory_config.json --analyze-organization` to
   assess current state
3. Run `python memory_manager.py memory_config.json --organize-by-category` to
   archive and organize files
4. Verify the operations were successful by checking the archive directories
5. Begin the next session with a clean, well-organized memory bank

## Configuration Format

The memory_config.json file uses the following structure:

```json
{
  "description": "Memory Management Configuration",
  "operations": [
    {
      "operation_type": "move",
      "source": "core/active/file.md",
      "destination_folder": "core/archive",
      "description": "Archive file",
      "memory_type": "core"
    }
  ],
  "options": {
    "memory_types": {
      "core": ["projectbrief", "productContext", "..."],
      "episodic": ["sessions", "decisions", "..."],
      "semantic": ["domain", "features", "..."],
      "procedural": ["workflows", "guides", "..."]
    }
  }
}
```

## Technical Information

- Python script requiring Python 3.8+
- Uses standard library modules (os, shutil, json, etc.)
- Optional psutil dependency for memory monitoring
- Windows-specific code for recycling bin operations
