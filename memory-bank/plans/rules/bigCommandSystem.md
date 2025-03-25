# BIG Command System

## Overview

The BIG Command System provides a standardized interface for interacting with
the BIG BRAIN Memory Bank. It implements a hierarchical command structure with
context sensitivity, standardized responses, and integrated verification.

## Command Structure

All BIG BRAIN commands follow a consistent pattern:

```
BIG [command] [subcommand] [parameters] [--options]
```

Examples:

- `BIG init`
- `BIG switch to plan mode`
- `BIG update memory bank`
- `BIG execute verification --level=thorough`

## Core Commands

### Initialization

```
BIG init [--project-type=TYPE] [--complexity=LEVEL] [--mode=MODE]
```

Initializes the BIG BRAIN system by reading memory files, analyzing the current
project, and determining the workflow mode.

### Mode Switching

```
BIG switch to plan mode [--with-verification]
BIG switch to act mode [--force]
```

Switches between PLAN and ACT workflow modes with appropriate transition
processing.

### Memory Update

```
BIG update memory bank [--core-only] [--all]
```

Updates memory bank files to reflect current project state and progress.

### Status

```
BIG status [--detailed] [--visual]
```

Displays the current status of the BIG BRAIN system, including mode, task
complexity, and active memory files.

### Bedtime Protocol

```
BIG execute bedtime protocol
```

Initiates the Bedtime Protocol for end-of-session memory preservation.

## Command Processing Functions

### Command Parser

```javascript
function parseCommand(inputCommand) {
  // Extract components
  const parts = inputCommand.split(' ');

  if (parts[0].toLowerCase() !== 'big') {
    return {
      valid: false,
      error: 'All commands must start with "BIG"',
    };
  }

  // Extract command and subcommands
  const command = parts[1]?.toLowerCase();
  const subcommands = [];
  const parameters = [];
  const options = {};

  // Process remaining parts
  for (let i = 2; i < parts.length; i++) {
    const part = parts[i];

    // Option (--flag or --key=value)
    if (part.startsWith('--')) {
      const optionPart = part.substring(2);
      const [key, value] = optionPart.split('=');
      options[key] = value !== undefined ? value : true;
      continue;
    }

    // Parameter (non-option, non-subcommand)
    parameters.push(part);
  }

  // Reconstruct subcommands from parameters based on command context
  if (
    command === 'switch' &&
    parameters.length >= 2 &&
    parameters[0] === 'to'
  ) {
    subcommands.push('to');
    subcommands.push(parameters[1]);
    parameters.splice(0, 2);
  } else if (command === 'update' && parameters.length >= 1) {
    subcommands.push(parameters[0]);
    parameters.splice(0, 1);
  } else if (command === 'execute' && parameters.length >= 1) {
    subcommands.push(parameters[0]);
    parameters.splice(0, 1);
  }

  return {
    valid: !!command,
    command,
    subcommands,
    parameters,
    options,
    original: inputCommand,
  };
}
```

### Command Dispatcher

```javascript
function dispatchCommand(parsedCommand) {
  if (!parsedCommand.valid) {
    return {
      success: false,
      error: parsedCommand.error || 'Invalid command',
    };
  }

  // Dispatch to appropriate handler
  switch (parsedCommand.command) {
    case 'init':
      return executeInit(parsedCommand);

    case 'switch':
      if (parsedCommand.subcommands[0] === 'to') {
        const mode = parsedCommand.subcommands[1];
        if (mode === 'plan' || mode === 'plan mode') {
          return executeSwitchToPlanMode(parsedCommand);
        } else if (mode === 'act' || mode === 'act mode') {
          return executeSwitchToActMode(parsedCommand);
        }
      }
      return {
        success: false,
        error: 'Invalid switch command. Usage: BIG switch to [plan|act] mode',
      };

    case 'update':
      if (
        parsedCommand.subcommands[0] === 'memory' &&
        (parsedCommand.subcommands[1] === 'bank' ||
          !parsedCommand.subcommands[1])
      ) {
        return executeUpdateMemoryBank(parsedCommand);
      }
      return {
        success: false,
        error:
          'Invalid update command. Usage: BIG update memory bank [--options]',
      };

    case 'status':
      return executeStatus(parsedCommand);

    case 'execute':
      if (
        parsedCommand.subcommands[0] === 'bedtime' &&
        (parsedCommand.subcommands[1] === 'protocol' ||
          !parsedCommand.subcommands[1])
      ) {
        return executeBedtimeProtocol(parsedCommand);
      } else if (parsedCommand.subcommands[0] === 'verification') {
        return executeVerification(parsedCommand);
      }
      return {
        success: false,
        error:
          'Invalid execute command. Usage: BIG execute [bedtime protocol|verification]',
      };

    default:
      return {
        success: false,
        error: `Unknown command: ${parsedCommand.command}`,
      };
  }
}
```

## Command Implementations

### Initialize

```javascript
function executeInit(parsedCommand) {
  // 1. Verify memory bank structure
  const structureValid = verifyMemoryBankStructure();
  if (!structureValid.success) {
    return {
      success: false,
      error: `Memory bank structure invalid: ${structureValid.error}`,
    };
  }

  // 2. Read memory files
  const memoryReadResult = readMemoryFiles(
    parsedCommand.options.complexity || 2,
  );
  if (!memoryReadResult.success) {
    return {
      success: false,
      error: `Memory reading failed: ${memoryReadResult.error}`,
    };
  }

  // 3. Analyze current project
  const projectType = parsedCommand.options.projectType || detectProjectType();

  // 4. Determine workflow mode
  const mode = parsedCommand.options.mode || determineWorkflowMode();

  // 5. Assess task complexity
  const complexity = parsedCommand.options.complexity || assessTaskComplexity();

  // 6. Establish project context
  establishProjectContext(projectType, mode, complexity);

  return {
    success: true,
    message: `## BIG BRAIN Initialized\n\n**Mode**: ${mode.toUpperCase()}\n**Complexity**: Level ${complexity}\n**Project Type**: ${projectType}\n\n✅ Memory files read successfully\n✅ Project context established`,
    data: {
      mode,
      complexity,
      projectType,
      memoryFiles: memoryReadResult.files,
    },
  };
}
```

### Switch to Plan Mode

```javascript
function executeSwitchToPlanMode(parsedCommand) {
  // 1. Verify current mode is not already PLAN
  const currentMode = getCurrentWorkflowMode();
  if (currentMode === 'plan') {
    return {
      success: true,
      message: '## Already in PLAN Mode\n\nNo mode switch required.',
    };
  }

  // 2. Capture current implementation state
  const implementationState = captureImplementationState();

  // 3. Verify implementation state if requested
  if (parsedCommand.options.withVerification) {
    const verificationResult = verifyImplementationState(implementationState);
    if (!verificationResult.success) {
      return {
        success: false,
        error: `Cannot switch to PLAN mode: ${verificationResult.error}`,
        suggestions: verificationResult.suggestions,
      };
    }
  }

  // 4. Execute mode transition
  const transitionResult = transitionActToPlan(implementationState);
  if (!transitionResult.success) {
    return {
      success: false,
      error: `Mode transition failed: ${transitionResult.error}`,
    };
  }

  // 5. Update mode in memory bank
  updateWorkflowMode('plan');

  // 6. Provide planning guidance
  const planningGuidance = generatePlanningGuidance();

  return {
    success: true,
    message: `## Switched to PLAN Mode\n\n✅ Successfully transitioned from ACT to PLAN mode\n\n### Planning Guidance\n\n${planningGuidance}`,
    data: {
      previousMode: 'act',
      newMode: 'plan',
      planContext: transitionResult.planContext,
    },
  };
}
```

### Switch to Act Mode

```javascript
function executeSwitchToActMode(parsedCommand) {
  // 1. Verify current mode is not already ACT
  const currentMode = getCurrentWorkflowMode();
  if (currentMode === 'act') {
    return {
      success: true,
      message: '## Already in ACT Mode\n\nNo mode switch required.',
    };
  }

  // 2. Get current plan context
  const planContext = getCurrentPlanContext();

  // 3. Verify plan readiness
  const planReadiness = verifyPlanReadiness(planContext);
  if (!planReadiness.ready && !parsedCommand.options.force) {
    return {
      success: false,
      error: 'Cannot switch to ACT mode: Plan is incomplete',
      details: planReadiness.issues,
      suggestions: [
        'Complete the plan',
        'Use --force to override (not recommended)',
      ],
    };
  }

  // 4. Execute mode transition
  const transitionResult = transitionPlanToAct(planContext);
  if (!transitionResult.success) {
    return {
      success: false,
      error: `Mode transition failed: ${transitionResult.error}`,
    };
  }

  // 5. Update mode in memory bank
  updateWorkflowMode('act');

  // 6. Provide implementation guidance
  const implementationGuidance = generateImplementationGuidance(
    transitionResult.actContext,
  );

  return {
    success: true,
    message: `## Switched to ACT Mode\n\n✅ Successfully transitioned from PLAN to ACT mode\n\n### Implementation Guidance\n\n${implementationGuidance}`,
    data: {
      previousMode: 'plan',
      newMode: 'act',
      actContext: transitionResult.actContext,
    },
  };
}
```

### Update Memory Bank

```javascript
function executeUpdateMemoryBank(parsedCommand) {
  // 1. Determine update scope
  const updateCoreOnly = parsedCommand.options.coreOnly === true;
  const updateAll = parsedCommand.options.all === true;

  // 2. Collect current state
  const currentState = collectCurrentState();

  // 3. Determine files to update
  let filesToUpdate = [];

  if (updateCoreOnly) {
    filesToUpdate = CORE_MEMORY_FILES;
  } else if (updateAll) {
    filesToUpdate = [...CORE_MEMORY_FILES, ...getAllMemoryFiles()];
  } else {
    filesToUpdate = [...CORE_MEMORY_FILES, ...getRelevantMemoryFiles()];
  }

  // 4. Update each file
  const updateResults = [];
  for (const file of filesToUpdate) {
    const updateResult = updateMemoryFile(file, currentState);
    updateResults.push({
      file,
      success: updateResult.success,
      changes: updateResult.changes,
      error: updateResult.error,
    });
  }

  // 5. Verify consistency after updates
  const consistencyResult = verifyMemoryConsistency();

  // 6. Generate summary report
  const successCount = updateResults.filter((r) => r.success).length;
  const errorCount = updateResults.filter((r) => !r.success).length;
  const totalChanges = updateResults.reduce(
    (sum, r) => sum + (r.changes || 0),
    0,
  );

  return {
    success: errorCount === 0,
    message: `## Memory Bank Update\n\n✅ Updated ${successCount} files with ${totalChanges} changes${
      errorCount > 0 ? `\n❌ Failed to update ${errorCount} files` : ''
    }\n\n${
      consistencyResult.success
        ? '✅ Memory bank consistency verified'
        : '⚠️ Consistency issues detected'
    }`,
    data: {
      updateResults,
      consistencyResult,
    },
  };
}
```

### Bedtime Protocol

```javascript
function executeBedtimeProtocol(parsedCommand) {
  // 1. Generate session summary
  const sessionSummary = generateSessionSummary();

  // 2. Update activeContext.md
  const activeContextUpdate = updateActiveContext(sessionSummary);
  if (!activeContextUpdate.success) {
    return {
      success: false,
      error: `Failed to update activeContext.md: ${activeContextUpdate.error}`,
    };
  }

  // 3. Create/update episodic memory record
  const episodicUpdate = createEpisodicRecord(sessionSummary);
  if (!episodicUpdate.success) {
    return {
      success: false,
      error: `Failed to create episodic record: ${episodicUpdate.error}`,
    };
  }

  // 4. Update progress.md
  const progressUpdate = updateProgress(sessionSummary);
  if (!progressUpdate.success) {
    return {
      success: false,
      error: `Failed to update progress.md: ${progressUpdate.error}`,
    };
  }

  // 5. Verify memory bank consistency
  const consistencyVerification = verifyMemoryConsistency();
  if (
    !consistencyVerification.success &&
    consistencyVerification.criticalIssues
  ) {
    return {
      success: false,
      error: `Memory bank consistency issues: ${consistencyVerification.criticalIssues}`,
      suggestions: consistencyVerification.suggestions,
    };
  }

  // 6. Generate next session preparation
  const nextSessionPrep = prepareForNextSession();

  return {
    success: true,
    message: `## Bedtime Protocol Executed\n\n✅ Session summary generated\n✅ activeContext.md updated\n✅ Episodic memory record created\n✅ progress.md updated\n${
      consistencyVerification.success
        ? '✅ Memory bank consistency verified'
        : '⚠️ Minor consistency issues detected'
    }\n\n### Next Session Preparation\n\n${nextSessionPrep}`,
    data: {
      sessionSummary,
      episodicRecord: episodicUpdate.path,
      consistencyIssues: consistencyVerification.issues,
    },
  };
}
```

## Response Format

All command responses follow a standardized format:

```javascript
{
  // Required fields
  success: true/false,
  message: "Formatted markdown message with rich details",

  // Optional fields
  error: "Error message if success is false",
  data: { /* Command-specific data */ },
  suggestions: ["Helpful suggestion 1", "Helpful suggestion 2"],
  warnings: [{ level: "info/warning/error", message: "Warning description" }]
}
```

## Version History

| Version | Date       | Author    | Changes                                      |
| ------- | ---------- | --------- | -------------------------------------------- |
| 1.0.0   | 2025-03-25 | BIG BRAIN | Initial implementation of BIG Command System |
