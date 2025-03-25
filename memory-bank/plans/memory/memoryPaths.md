# Memory Path Resolution System

## Overview

The Memory Path Resolution System provides a standardized way to access all
memory files in the BIG BRAIN Memory Bank. This system ensures consistent path
references, enables validation before access, and eliminates path resolution
errors that have previously caused memory access failures.

## Canonical Path Registry

```javascript
/**
 * MEMORY_PATHS - Canonical path constants for all memory files
 * Use these constants for all memory file access to ensure consistency
 */
const MEMORY_PATHS = {
  // Core memory files
  core: {
    active: {
      // Primary memory files
      projectbrief: 'memory-bank/core/active/projectbrief.md',
      productContext: 'memory-bank/core/active/productContext.md',
      activeContext: 'memory-bank/core/active/activeContext.md',
      systemPatterns: 'memory-bank/core/active/systemPatterns.md',
      techContext: 'memory-bank/core/active/techContext.md',
      progress: 'memory-bank/core/active/progress.md',
      projectRules: 'memory-bank/core/active/projectRules.md',

      // System files
      memoryPaths: 'memory-bank/core/active/memoryPaths.md',

      // Planning and implementation files
      plans: 'memory-bank/core/active/plans/',
      implementations: 'memory-bank/core/active/implementations/',
    },
    archive: 'memory-bank/core/archive/',
  },

  // Long-term memory types
  episodic: {
    active: 'memory-bank/episodic/active/',
    archive: 'memory-bank/episodic/archive/',
  },
  procedural: {
    active: 'memory-bank/procedural/active/',
    archive: 'memory-bank/procedural/archive/',
  },
  semantic: {
    active: 'memory-bank/semantic/active/',
    archive: 'memory-bank/semantic/archive/',
  },

  // Session management
  bedtimeProtocol: {
    readme: 'memory-bank/Bedtime Protocol/README.md',
    tools: 'memory-bank/Bedtime Protocol/memory-tools/',
  },

  // Rule system
  rules: {
    main: '.cursor/rules/main.mdc',
    bigBrain: {
      root: '.cursor/rules/BIG_BRAIN/',
      identity: '.cursor/rules/BIG_BRAIN/Identity/',
      core: {
        root: '.cursor/rules/BIG_BRAIN/Core/',
        foundation: '.cursor/rules/BIG_BRAIN/Core/Foundation/',
        command: '.cursor/rules/BIG_BRAIN/Core/Command/',
        creative: '.cursor/rules/BIG_BRAIN/Core/Creative/',
        verification: '.cursor/rules/BIG_BRAIN/Core/Verification/',
        checkpoint: '.cursor/rules/BIG_BRAIN/Core/Checkpoint/',
        escalation: '.cursor/rules/BIG_BRAIN/Core/Escalation/',
        testing: '.cursor/rules/BIG_BRAIN/Core/Testing/',
        documentation: '.cursor/rules/BIG_BRAIN/Core/Documentation/',
      },
      workflows: '.cursor/rules/BIG_BRAIN/Workflows/',
      protocols: '.cursor/rules/BIG_BRAIN/Protocols/',
      templates: '.cursor/rules/BIG_BRAIN/Templates/',
      utilities: '.cursor/rules/BIG_BRAIN/Utilities/',
    },
    codebase: '.cursor/rules/Codebase/',
  },
};
```

## Path Resolution Protocol

When accessing any memory file, follow this protocol:

1. **Always use canonical paths**

   ```javascript
   // Incorrect ❌
   readFile('memory-bank/projectbrief.md');

   // Correct ✓
   readFile(MEMORY_PATHS.core.active.projectbrief);
   ```

2. **Validate path before access**

   ```javascript
   function validatePath(path) {
     if (!fileExists(path)) {
       throw new Error(`Memory file not found: ${path}`);
     }
     return true;
   }

   // Usage
   if (validatePath(MEMORY_PATHS.core.active.activeContext)) {
     const content = readFile(MEMORY_PATHS.core.active.activeContext);
     // Process content...
   }
   ```

3. **Use path helpers for derived paths**

   ```javascript
   function getSessionSummaryPath(date) {
     return `${MEMORY_PATHS.episodic.active}sessions/summary-${date}.md`;
   }

   // Usage
   const todaySummary = getSessionSummaryPath('2025-03-24');
   ```

4. **Handle directory vs. file paths appropriately**

   ```javascript
   // For directories, append the specific file name
   const milestonePath = `${MEMORY_PATHS.episodic.active}milestones/milestone-1.md`;

   // Use path.join for cross-platform compatibility when available
   const workflowPath = pathJoin(
     MEMORY_PATHS.procedural.active,
     'workflows',
     'development-workflow.md',
   );
   ```

## Fallback Mechanism

When a path cannot be resolved, implement this fallback strategy:

1. **Try canonical path first**
2. **Try alternative locations for backward compatibility**
3. **Generate helpful error message with suggestions**

```javascript
function resolveMemoryPath(pathKey, fallbacks = []) {
  // First try the canonical path
  const primaryPath = getPathFromKey(pathKey);
  if (fileExists(primaryPath)) {
    return primaryPath;
  }

  // Try fallbacks
  for (const fallbackPath of fallbacks) {
    if (fileExists(fallbackPath)) {
      console.warn(
        `Using fallback path: ${fallbackPath} instead of ${primaryPath}`,
      );
      return fallbackPath;
    }
  }

  // Generate helpful error with suggestions
  throw new Error(`
    Memory file not found: ${primaryPath}

    Attempted fallbacks: ${fallbacks.join(', ')}

    Suggestions:
    - Check if the file exists
    - Verify the memory bank structure
    - Ensure all core files are initialized
  `);
}
```

## Implementation Guidelines

1. Import this memory path system in all modules that access memory files
2. Update existing code to use these canonical paths
3. Add path validation before file access operations
4. Implement the fallback mechanism for backward compatibility
5. Log and report path resolution errors with helpful context

## Version History

| Version | Date       | Author    | Changes                                          |
| ------- | ---------- | --------- | ------------------------------------------------ |
| 1.0.0   | 2025-03-24 | BIG BRAIN | Initial implementation of path resolution system |
