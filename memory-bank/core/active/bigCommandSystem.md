# BIG Command System

## Overview

The BIG Command System provides a unified interface for interacting with the BIG
BRAIN Memory Bank. This system standardizes command syntax, implements
intelligent command parsing, and establishes core commands for memory
operations, workflow transitions, and system management.

## Command Structure

All BIG commands follow this syntax pattern:

```
BIG [command] [subcommand] [parameters] [--options]
```

Examples:

- `BIG init` - Initialize context for the current project
- `BIG switch to plan mode` - Change to planning workflow
- `BIG update memory bank` - Perform memory updates
- `BIG execute bedtime protocol` - Run end-of-session procedures

## Core Commands

### Context Commands

| Command            | Description                            | Parameters   | Options              |
| ------------------ | -------------------------------------- | ------------ | -------------------- |
| `BIG init`         | Initialize context for current project | project-type | --verbose, --minimal |
| `BIG status`       | Show current system status             |              | --detailed           |
| `BIG check memory` | Verify memory bank integrity           |              | --fix, --report      |

### Mode Commands

| Command                   | Description                   | Parameters  | Options            |
| ------------------------- | ----------------------------- | ----------- | ------------------ |
| `BIG switch to plan mode` | Enter planning workflow       |             | --complexity=[1-4] |
| `BIG switch to act mode`  | Enter implementation workflow |             | --complexity=[1-4] |
| `BIG set complexity`      | Set task complexity level     | level=[1-4] |                    |

### Memory Commands

| Command                  | Description                 | Parameters  | Options                                 |
| ------------------------ | --------------------------- | ----------- | --------------------------------------- |
| `BIG update memory bank` | Update memory files         |             | --core-only, --all                      |
| `BIG query memory`       | Search for information      | query-terms | --type=[semantic\|episodic\|procedural] |
| `BIG memory stats`       | Show memory bank statistics |             | --visual                                |

### Protocol Commands

| Command                        | Description                       | Parameters | Options                                      |
| ------------------------------ | --------------------------------- | ---------- | -------------------------------------------- |
| `BIG execute bedtime protocol` | Run end-of-session procedures     |            | --quick, --full                              |
| `BIG start creative phase`     | Begin structured creative process |            | --template=[architecture\|algorithm\|design] |
| `BIG run verification`         | Execute verification procedures   |            | --depth=[basic\|thorough]                    |

## Command Processing

```javascript
/**
 * Process a BIG command
 */
function processBigCommand(commandString) {
  // Parse the command string
  const parsedCommand = parseCommandString(commandString);

  // Validate the command
  const validationResult = validateCommand(parsedCommand);
  if (!validationResult.valid) {
    return {
      success: false,
      error: validationResult.error,
      suggestions: validationResult.suggestions,
    };
  }

  // Execute the command
  try {
    const result = executeCommand(parsedCommand);
    return {
      success: true,
      result,
      message: generateSuccessMessage(parsedCommand, result),
    };
  } catch (error) {
    return {
      success: false,
      error: error.message,
      suggestedFix: generateFixSuggestion(parsedCommand, error),
    };
  }
}

/**
 * Parse command string into structured command object
 */
function parseCommandString(commandString) {
  // Remove "BIG" prefix
  const withoutPrefix = commandString.replace(/^BIG\s+/i, '');

  // Extract command parts
  const parts = withoutPrefix.split(' ');
  const command = parts[0];

  // Handle special cases like "switch to plan mode"
  if (
    command === 'switch' &&
    parts[1] === 'to' &&
    (parts[2] === 'plan' || parts[2] === 'act') &&
    parts[3] === 'mode'
  ) {
    return {
      command: 'switch',
      subcommand: `${parts[2]}_mode`,
      parameters: [],
      options: extractOptions(parts.slice(4)),
    };
  }

  // Handle update memory bank
  if (command === 'update' && parts[1] === 'memory' && parts[2] === 'bank') {
    return {
      command: 'update',
      subcommand: 'memory_bank',
      parameters: [],
      options: extractOptions(parts.slice(3)),
    };
  }

  // Handle execute bedtime protocol
  if (
    command === 'execute' &&
    parts[1] === 'bedtime' &&
    parts[2] === 'protocol'
  ) {
    return {
      command: 'execute',
      subcommand: 'bedtime_protocol',
      parameters: [],
      options: extractOptions(parts.slice(3)),
    };
  }

  // Default parsing for other commands
  return {
    command,
    subcommand: parts[1] || null,
    parameters: extractParameters(parts.slice(2)),
    options: extractOptions(parts.slice(2)),
  };
}

/**
 * Extract command parameters (non-option args)
 */
function extractParameters(parts) {
  return parts.filter((part) => !part.startsWith('--'));
}

/**
 * Extract command options (--option style args)
 */
function extractOptions(parts) {
  const options = {};
  parts
    .filter((part) => part.startsWith('--'))
    .forEach((option) => {
      const [key, value] = option.substring(2).split('=');
      options[key] = value || true;
    });
  return options;
}
```

## Command Implementation: BIG init

The `BIG init` command is a comprehensive initialization command that:

1. Verifies memory bank structure
2. Reads all memory files
3. Analyzes the current project
4. Determines appropriate workflow mode
5. Assesses task complexity
6. Establishes project context

```javascript
/**
 * Implementation of BIG init command
 */
function executeBigInit(parameters, options) {
  // 1. Verify memory bank structure
  const structureVerification = verifyMemoryBankStructure();
  if (!structureVerification.valid) {
    return handleInvalidStructure(structureVerification);
  }

  // 2. Read all memory files
  const memoryReadResult = readMemoryBank();
  if (!memoryReadResult.success) {
    return handleMemoryReadFailure(memoryReadResult);
  }

  // 3. Analyze current project
  const projectAnalysis = analyzeProject(parameters[0] || detectProjectType());

  // 4. Determine workflow mode
  const recommendedMode = determineWorkflowMode(projectAnalysis);

  // 5. Assess task complexity
  const taskComplexity = assessTaskComplexity(projectAnalysis);

  // 6. Generate project context
  const projectContext = generateProjectContext(
    projectAnalysis,
    recommendedMode,
    taskComplexity,
    memoryReadResult.digest,
  );

  // 7. Return initialization result
  return {
    success: true,
    projectType: projectAnalysis.type,
    workflowMode: recommendedMode,
    taskComplexity,
    context: projectContext,
    memoryStatus: memoryReadResult.status,
  };
}

/**
 * Generate project context from analysis
 */
function generateProjectContext(analysis, mode, complexity, memoryDigest) {
  return {
    // Project metadata
    name: analysis.name,
    type: analysis.type,

    // Memory context
    memoryDigest,

    // Workflow context
    workflowMode: mode,
    taskComplexity: complexity,

    // Project analysis
    fileCount: analysis.fileCount,
    technologies: analysis.technologies,
    mainComponents: analysis.mainComponents,

    // Current state
    currentFocus: memoryDigest.currentFocus || analysis.currentFocus,
    recentChanges: memoryDigest.recentChanges || analysis.recentChanges,
    openIssues: memoryDigest.openQuestions || analysis.openIssues,

    // Initialization metadata
    initTimestamp: Date.now(),
    initVersion: '1.0.0',
  };
}
```

## Command Implementation: Mode Switching

Mode switching commands allow transitioning between Plan and Act modes:

```javascript
/**
 * Switch to Plan Mode
 */
function executeSwitchToPlanMode(parameters, options) {
  // 1. Verify current state
  const currentState = getCurrentState();

  // 2. If already in plan mode, just refresh
  if (currentState.mode === 'plan') {
    return {
      success: true,
      message: 'Already in Plan Mode, refreshing context',
      previousMode: 'plan',
      newMode: 'plan',
      refreshed: true,
    };
  }

  // 3. Perform mode transition
  const transitionResult = transitionToMode('plan', currentState, options);

  // 4. Update memory bank with new mode
  updateActiveContext({ workflowMode: 'plan' });

  // 5. Return result
  return {
    success: true,
    message: 'Successfully switched to Plan Mode',
    previousMode: currentState.mode,
    newMode: 'plan',
    taskComplexity: transitionResult.taskComplexity,
    planFocus: transitionResult.planFocus,
  };
}

/**
 * Switch to Act Mode
 */
function executeSwitchToActMode(parameters, options) {
  // 1. Verify current state
  const currentState = getCurrentState();

  // 2. If already in act mode, just refresh
  if (currentState.mode === 'act') {
    return {
      success: true,
      message: 'Already in Act Mode, refreshing context',
      previousMode: 'act',
      newMode: 'act',
      refreshed: true,
    };
  }

  // 3. Check plan readiness
  const planReadiness = checkPlanReadiness(currentState);
  if (!planReadiness.ready && !options.force) {
    return {
      success: false,
      message: 'Cannot switch to Act Mode: Plan is not complete',
      readinessIssues: planReadiness.issues,
      suggestion: 'Complete the plan or use --force to override',
    };
  }

  // 4. Perform mode transition
  const transitionResult = transitionToMode('act', currentState, options);

  // 5. Update memory bank with new mode
  updateActiveContext({ workflowMode: 'act' });

  // 6. Return result
  return {
    success: true,
    message: 'Successfully switched to Act Mode',
    previousMode: currentState.mode,
    newMode: 'act',
    taskComplexity: transitionResult.taskComplexity,
    implementationFocus: transitionResult.implementationFocus,
  };
}
```

## Command Implementation: Memory Update

The memory update command refreshes memory files with current information:

```javascript
/**
 * Update Memory Bank
 */
function executeUpdateMemoryBank(parameters, options) {
  // 1. Determine update scope
  const updateScope = options['core-only'] ? 'core' : 'all';

  // 2. Gather current state information
  const currentState = getCurrentState();

  // 3. Prepare updates for each relevant file
  const updates = prepareMemoryUpdates(currentState, updateScope);

  // 4. Apply updates
  const updateResults = applyMemoryUpdates(updates);

  // 5. Verify update integrity
  const verificationResults = verifyUpdates(updateResults);

  // 6. Return results
  return {
    success: verificationResults.success,
    updatedFiles: updateResults.updatedFiles,
    failedUpdates: updateResults.failedUpdates,
    verificationIssues: verificationResults.issues,
    message: generateUpdateSummary(updateResults, verificationResults),
  };
}
```

## Command Implementation: Bedtime Protocol

The bedtime protocol command executes end-of-session procedures:

```javascript
/**
 * Execute Bedtime Protocol
 */
function executeBedtimeProtocol(parameters, options) {
  // 1. Read bedtime protocol requirements
  const protocol = readBedtimeProtocol();

  // 2. Gather session information
  const sessionInfo = collectSessionInformation();

  // 3. Update memory files
  const memoryUpdates = updateMemoryForBedtime(sessionInfo);

  // 4. Create session summary
  const sessionSummary = createSessionSummary(sessionInfo);

  // 5. Verify memory consistency
  const consistencyCheck = verifyMemoryConsistency();

  // 6. Generate continuation points
  const continuationPoints = generateContinuationPoints(sessionInfo);

  // 7. Return completion confirmation
  return {
    success: true,
    protocolVersion: protocol.version,
    updatedFiles: memoryUpdates.updatedFiles,
    sessionSummary,
    consistencyStatus: consistencyCheck.status,
    continuationPoints,
    message: 'Bedtime Protocol successfully executed',
  };
}
```

## Command Response Format

All BIG commands return responses in a standardized format:

```javascript
{
  // Overall success status
  success: true,

  // Main result content
  result: {
    // Command-specific result data
  },

  // Formatted message
  message: "Operation completed successfully",

  // Additional information (optional)
  details: {
    // Detailed result information
  },

  // Verification information (optional)
  verification: {
    // Verification results
  },

  // Suggestions (optional)
  suggestions: [
    // Suggested next actions
  ]
}
```

## Implementation Guidelines

1. Integrate this command system with the Memory Path Resolution and Reading
   Protocol systems
2. Implement core commands in order of priority: init, mode switching, memory
   update, bedtime protocol
3. Create standardized command processing flow for all commands
4. Ensure error handling provides clear guidance and recovery options
5. Maintain command history for reference

## Version History

| Version | Date       | Author    | Changes                                  |
| ------- | ---------- | --------- | ---------------------------------------- |
| 1.0.0   | 2025-03-24 | BIG BRAIN | Initial implementation of command system |
