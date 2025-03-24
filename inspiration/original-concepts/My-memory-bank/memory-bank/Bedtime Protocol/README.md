# Bedtime Protocol for Memory Management

## Purpose

The Bedtime Protocol is a structured process for memory management in AI agents
like BIG BRAIN, ensuring continuity across sessions. It preserves core project
information while organizing long-term knowledge in a structured way. This
protocol enables smooth transitions between memory states without loss of
critical context.

## Key Features

- **Fully Self-contained**: The entire system operates exclusively within the
  memory-bank folder and never looks outside it
- **100% Portable**: Can be placed anywhere in the filesystem - at the root of a
  drive or nested many folders deep
- **Zero External Dependencies**: Requires only Python to run (with optional
  psutil for memory monitoring)
- **Smart Organization**: Automatically categorizes files based on content and
  naming patterns
- **Safety-focused**: Uses a multi-stage approach with verification to prevent
  data loss

## Directory Structure

```
memory-bank/                           # Root folder (self-contained boundary)
├── activeContext_v1.2.md              # Current active files
├── progress_v1.1.md                   # Current active files
├── systemPatterns_v1.1.md             # Current active files
├── Bedtime Protocol/                  # Protocol folder
│   ├── README.md                      # This file
│   ├── memory-tools/                  # Tools for memory management
│   │   ├── memory_manager.py          # Memory management script
│   │   ├── memory_config.json         # Configuration file
│   │   └── logs/                      # Operation logs
│   └── Long term memory/              # Long-term memory storage
│       ├── projectbrief/              # Project brief documents and versions
│       ├── productContext/            # Product context documents and versions
│       ├── activeContext/             # Active context documents and versions
│       ├── systemPatterns/            # System patterns documents and versions
│       ├── techContext/               # Technical context documents and versions
│       ├── progress/                  # Progress documents and versions
│       ├── research/                  # Research documents
│       └── metadata/                  # Metadata about the memory system
```

## Portability

The memory-bank folder is completely self-contained and can be:

- Placed at the root of any drive
- Nested inside any number of parent folders
- Moved between projects easily
- Archived and restored as a complete unit

All path references are relative to the memory-bank folder itself, which serves
as the absolute boundary for all operations. The script will automatically
detect where memory-bank is located in your filesystem.

## How to Execute the Bedtime Protocol

### Phase 1: Memory Evaluation & Summarization

1. **Review Current Session Context**

   - Assess which memory files have been meaningfully updated during the session
   - Identify new insights, patterns, or decisions that should be preserved
   - Determine if new memory files need to be created

2. **Assess Memory Files**

   - For each memory file that requires updating:
     - Create a new version file (e.g., `activeContext_v1.2.md` →
       `activeContext_v1.3.md`)
     - Include a summary section at the top detailing what changed and why
     - Use clear section headers to organize information
     - Maintain backward compatibility with previous knowledge

3. **Create New Version Files**
   - Place new version files in the root `memory-bank/` directory
   - Include version number in the filename
   - Add timestamp and version history section

### Phase 2: Memory Preservation & Organization

4. **Update Memory Config File**

   - Edit `memory-bank/Bedtime Protocol/memory-tools/memory_config.json`
   - Add operations for each file to be moved to long-term memory
   - Specify organization options (categories, metadata, etc.)
   - Make sure all paths are relative to the memory-bank root folder

5. **Execute Memory Manager**

   Navigate to the memory-tools directory and run the following commands:

   **Stage 1: Validation Dry Run**

   ```
   cd path/to/memory-bank/Bedtime Protocol/memory-tools
   python memory_manager.py memory_config.json
   ```

   - Verify source and destination paths
   - Review planned operations
   - Document any errors or warnings

   **Stage 2: File Copying Operations**

   ```
   python memory_manager.py memory_config.json --force-overwrite --organize-by-category
   ```

   - Monitor logs for any issues during operation
   - Ensure all files are copied successfully

   **Stage 3: Recycling Bin Operations**

   ```
   python memory_manager.py memory_config.json --recycle-confirmed
   ```

   - Only proceed after confirming successful copies
   - This moves the original files to Windows recycle bin
   - Keep recycle bin intact until next session starts successfully

6. **Verify Operations**
   - Check `memory-bank/Bedtime Protocol/Long term memory` to ensure all files
     are present
   - Verify that files are organized into their respective category folders
   - Review the storage log for a complete record of the organization

## How It Works

The memory manager performs three key operations:

1. **Dry Run**: Validates all operations without making changes
2. **Copy Operations**: Creates copies of files in long-term memory, organized
   by category
3. **Recycling**: Moves original files to recycle bin (safety feature)

### Self-Contained Design

The memory manager is designed to be completely self-contained:

- It automatically detects where the memory-bank folder is located
- All file operations are performed relative to this root
- It never accesses or modifies files outside the memory-bank folder
- Works regardless of where memory-bank is located in the filesystem
- Requires only Python to run (psutil is optional)

### Category Organization

Files are organized into folders based on their content and filename:

- **Core Categories**: projectbrief, productContext, activeContext,
  systemPatterns, techContext, progress
- **Special Categories**: research, architecture, codebase, refactoring, import,
  metadata

Each category folder contains:

- The categorized files
- A `_category_metadata.json` file with description and last updated timestamp
- A `_category_contents.md` file listing all documents in the category

### Category Detection Methods

- **Basic**: Uses filename patterns only
- **Smart** (default): Uses filename patterns and basic content analysis
- **Content-based**: Deep analysis of file contents (more resource-intensive)

## Command-Line Arguments

The memory manager script supports various command-line arguments to control its
behavior:

```
python memory_manager.py [config_file] [options]
```

### Core Arguments

- `config_file`: Path to the JSON configuration file (default:
  memory_config.json)
- `--force-overwrite`: Allow overwriting of existing destination files
- `--recycle-confirmed`: Skip to recycling bin operations (only use after
  successful file copying)

### Organization Arguments

- `--organize-by-category`: Organize files into category folders in long-term
  memory
- `--reorganize-existing`: Organize existing files in long-term memory into
  category folders
- `--analyze-organization`: Analyze current organization without making changes
- `--category-detection`: Method for detecting file categories:
  - `basic`: Uses filename patterns only
  - `smart`: Uses filename patterns and basic content analysis (default)
  - `content-based`: Deep analysis of file contents (more resource-intensive)

### Example Commands

**Analyze Current Organization**:

```
python memory_manager.py memory_config.json --analyze-organization
```

**Dry Run with Category Organization**:

```
python memory_manager.py memory_config.json
```

**Perform File Operations with Category Organization**:

```
python memory_manager.py memory_config.json --force-overwrite --organize-by-category
```

**Move Originals to Recycle Bin** (after successful copying):

```
python memory_manager.py memory_config.json --recycle-confirmed
```

**Reorganize Existing Files**:

```
python memory_manager.py memory_config.json --reorganize-existing
```

## Safety Guidelines

1. **Always Create Versioned Files**: Create new versioned files in the root
   directory before running the protocol
2. **Run in Stages**: Follow the three-stage process (dry run → copy → recycle)
3. **Verify Before Recycling**: Never recycle files until copies are confirmed
4. **Maintain Recycle Bin**: Keep files in recycle bin until next session starts
5. **Check Logs**: Review logs after each operation for any issues

## Best Practices

1. **Organize Related Information**: Group related documents into the same
   category
2. **Use Clear Filenames**: Include topic and version in filenames
3. **Include Summaries**: Add summary sections at the top of documents
4. **Document Changes**: Note why changes were made and their impact
5. **Maintain Version History**: Keep track of document evolution

Remember: Proper memory management ensures continuity of knowledge and effective
AI assistance across sessions!
