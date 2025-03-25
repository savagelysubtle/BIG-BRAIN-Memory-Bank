# Memory Reading Protocol

## Overview

The Memory Reading Protocol establishes a standardized process for reading and
processing memory files in the BIG BRAIN Memory Bank. This protocol ensures
thorough context acquisition by enforcing complete memory reading, sequential
processing, and verification.

## Reading Requirements

### Core Requirements

1. **Complete Reading**: ALL core memory files MUST be read at the start of
   EVERY task
2. **Sequential Processing**: Files must be read in the specified order to
   ensure proper context building
3. **Verification**: After reading, completion must be verified to ensure no
   files were missed
4. **Comprehension Check**: Basic understanding of memory content must be
   confirmed
5. **Cross-Reference Resolution**: Related information across files must be
   connected

### Task-Specific Requirements

Additional reading requirements based on task complexity:

| Level | Description | Reading Requirements                                                 |
| ----- | ----------- | -------------------------------------------------------------------- |
| 1     | Simple      | Core files only, focused on relevant sections                        |
| 2     | Moderate    | Core files + directly relevant specialized files                     |
| 3     | Complex     | Core files + comprehensive specialized files + related references    |
| 4     | Critical    | Complete memory bank scan, including archives for historical context |

## Sequential Reading Process

```javascript
/**
 * Reading sequence for BIG BRAIN memory bank
 * Files MUST be read in this order for proper context building
 */
function readMemoryBank(taskComplexity = 4) {
  // Set up memory access tracking
  const memoryTracker = initializeMemoryTracker();

  try {
    // 1. Core memory files - always required
    readAndTrack(MEMORY_PATHS.core.active.projectbrief, memoryTracker);
    readAndTrack(MEMORY_PATHS.core.active.productContext, memoryTracker);
    readAndTrack(MEMORY_PATHS.core.active.activeContext, memoryTracker);
    readAndTrack(MEMORY_PATHS.core.active.systemPatterns, memoryTracker);
    readAndTrack(MEMORY_PATHS.core.active.techContext, memoryTracker);
    readAndTrack(MEMORY_PATHS.core.active.progress, memoryTracker);
    readAndTrack(MEMORY_PATHS.core.active.projectRules, memoryTracker);

    // 2. System files - required for memory operation
    readAndTrack(MEMORY_PATHS.core.active.memoryPaths, memoryTracker);
    if (fileExists(MEMORY_PATHS.core.active.memoryReadingProtocol)) {
      readAndTrack(
        MEMORY_PATHS.core.active.memoryReadingProtocol,
        memoryTracker,
      );
    }

    // 3. Memory type directories - complexity dependent
    if (taskComplexity >= 2) {
      readMemoryDirectory(MEMORY_PATHS.episodic.active, memoryTracker);
      readMemoryDirectory(MEMORY_PATHS.procedural.active, memoryTracker);
      readMemoryDirectory(MEMORY_PATHS.semantic.active, memoryTracker);
    }

    // 4. Archives - only for highest complexity
    if (taskComplexity >= 4) {
      readMemoryDirectory(MEMORY_PATHS.core.archive, memoryTracker);
      readMemoryDirectory(MEMORY_PATHS.episodic.archive, memoryTracker);
      readMemoryDirectory(MEMORY_PATHS.procedural.archive, memoryTracker);
      readMemoryDirectory(MEMORY_PATHS.semantic.archive, memoryTracker);
    }

    // 5. Verify complete read
    const verification = verifyMemoryReadComplete(memoryTracker);
    if (!verification.success) {
      handleIncompleteMemoryRead(verification.missingFiles);
    }

    // 6. Generate memory digest
    return generateMemoryDigest(memoryTracker);
  } catch (error) {
    handleMemoryReadError(error, memoryTracker);
    throw new Error(`Memory reading failed: ${error.message}`);
  }
}

/**
 * Read a specific file and track its completion
 */
function readAndTrack(path, tracker) {
  try {
    // Validate path
    if (!validatePath(path)) {
      throw new Error(`Invalid memory path: ${path}`);
    }

    // Read file
    const content = readFile(path);

    // Process content
    processFileContent(path, content);

    // Mark as read in tracker
    tracker.markAsRead(path, {
      timestamp: Date.now(),
      status: 'complete',
    });

    return content;
  } catch (error) {
    tracker.markAsRead(path, {
      timestamp: Date.now(),
      status: 'failed',
      error: error.message,
    });
    throw error;
  }
}

/**
 * Read all files in a directory
 */
function readMemoryDirectory(dirPath, tracker) {
  // Get all files in directory
  const files = getFilesInDirectory(dirPath);

  // Read each file
  for (const file of files) {
    try {
      readAndTrack(`${dirPath}${file}`, tracker);
    } catch (error) {
      // Log but continue with other files
      console.error(`Error reading ${file}: ${error.message}`);
    }
  }
}
```

## Memory Access Tracking

The Memory Access Tracking system records which files have been read and their
processing status.

```javascript
/**
 * Initialize the memory tracker
 */
function initializeMemoryTracker() {
  return {
    // Required files that must be read
    requiredFiles: [
      MEMORY_PATHS.core.active.projectbrief,
      MEMORY_PATHS.core.active.productContext,
      MEMORY_PATHS.core.active.activeContext,
      MEMORY_PATHS.core.active.systemPatterns,
      MEMORY_PATHS.core.active.techContext,
      MEMORY_PATHS.core.active.progress,
      MEMORY_PATHS.core.active.projectRules,
    ],

    // Track files that have been read
    readFiles: {},

    // Mark a file as read
    markAsRead(path, status) {
      this.readFiles[path] = status;
    },

    // Check if a file has been read
    hasBeenRead(path) {
      return this.readFiles[path] && this.readFiles[path].status === 'complete';
    },

    // Get all read files
    getReadFiles() {
      return Object.keys(this.readFiles).filter(
        (path) => this.readFiles[path].status === 'complete',
      );
    },

    // Get missing required files
    getMissingRequiredFiles() {
      return this.requiredFiles.filter((file) => !this.hasBeenRead(file));
    },
  };
}
```

## Verification Process

```javascript
/**
 * Verify that all required memory files have been read
 */
function verifyMemoryReadComplete(tracker) {
  // Check for missing required files
  const missingFiles = tracker.getMissingRequiredFiles();

  if (missingFiles.length > 0) {
    return {
      success: false,
      missingFiles,
      message: `Missing required memory files: ${missingFiles.join(', ')}`,
    };
  }

  return {
    success: true,
    readFiles: tracker.getReadFiles(),
    message: 'All required memory files successfully read',
  };
}

/**
 * Handle incomplete memory read situation
 */
function handleIncompleteMemoryRead(missingFiles) {
  console.error(`
    ⚠️ INCOMPLETE MEMORY READ DETECTED

    The following required files were not successfully read:
    ${missingFiles.map((file) => `- ${file}`).join('\n')}

    This may result in incomplete context and potential errors.

    Action required: Ensure all memory files exist and are accessible.
  `);

  // Attempt recovery for each missing file
  for (const file of missingFiles) {
    attemptFileRecovery(file);
  }
}
```

## Memory Digest Generation

```javascript
/**
 * Generate a consolidated memory digest from all read files
 */
function generateMemoryDigest(tracker) {
  const digest = {
    projectSummary: extractProjectSummary(),
    currentFocus: extractCurrentFocus(),
    keyPatterns: extractKeyPatterns(),
    technicalContext: extractTechnicalContext(),
    progressSummary: extractProgressSummary(),
    rules: extractKeyRules(),

    // Additional sections for higher complexity tasks
    recentChanges: extractRecentChanges(),
    openQuestions: extractOpenQuestions(),
    nextSteps: extractNextSteps(),

    // Metadata
    readTimestamp: Date.now(),
    filesRead: tracker.getReadFiles().length,
    readCompleteness: calculateReadCompleteness(tracker),
  };

  return digest;
}
```

## Reading Protocol Adherence

To ensure proper adherence to this protocol:

1. Begin EVERY session and task with a complete memory reading
2. Follow the sequential order specified in the protocol
3. Verify reading completion before proceeding with any task
4. Consult the memory digest for key information
5. Flag and address any memory access issues immediately

## Implementation Guidelines

1. Integrate with the Memory Path Resolution System
2. Use the tracker to maintain reading state
3. Verify completion before any task execution
4. Generate and use the memory digest for context
5. Handle errors gracefully with recovery attempts

## Version History

| Version | Date       | Author    | Changes                                    |
| ------- | ---------- | --------- | ------------------------------------------ |
| 1.0.0   | 2025-03-24 | BIG BRAIN | Initial implementation of reading protocol |
