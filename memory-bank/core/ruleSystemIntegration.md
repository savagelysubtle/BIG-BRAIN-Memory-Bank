# Rule System Integration

## Overview

The Rule System Integration establishes a comprehensive framework for applying
rules across the BIG BRAIN Memory Bank. This system implements a three-tier rule
architecture, provides rule visibility during operations, detects and resolves
rule conflicts, and measures rule effectiveness over time.

## Three-Tier Rule Architecture

The rule system is organized into three tiers, each with different application
scope and persistence:

```
┌─────────────────────────┐
│ TIER 1: Always-Applied  │
│ Core Rules              │
├─────────────────────────┤
│ TIER 2: Context-Sensitive│
│ Rules                   │
├─────────────────────────┤
│ TIER 3: Agent-Requested │
│ Rules                   │
└─────────────────────────┘
```

### Tier 1: Always-Applied Core Rules

These rules are always in effect and form the foundation of the system.

```javascript
/**
 * Core rule definitions
 */
const CORE_RULES = {
  // Memory access rules
  memoryPathResolution: {
    id: 'core.memory.path_resolution',
    description: 'Ensure all memory access uses canonical paths',
    enforcement: 'mandatory',
    implementation: function enforceMemoryPathResolution(operation) {
      // Implementation of path resolution enforcement
      return validatePathInOperation(operation);
    },
  },

  memoryReadVerification: {
    id: 'core.memory.read_verification',
    description: 'Verify all required memory files are read before operations',
    enforcement: 'mandatory',
    implementation: function enforceMemoryReadVerification(operation) {
      // Implementation of read verification
      return verifyRequiredReads(operation);
    },
  },

  // Identity preservation rules
  identityPreservation: {
    id: 'core.identity.preservation',
    description: 'Maintain consistent BIG BRAIN identity across operations',
    enforcement: 'mandatory',
    implementation: function enforceIdentityPreservation(operation) {
      // Identity preservation implementation
      return validateIdentityConsistency(operation);
    },
  },

  // Task assessment rules
  taskComplexityAssessment: {
    id: 'core.task.complexity_assessment',
    description: 'Assess task complexity for appropriate handling',
    enforcement: 'mandatory',
    implementation: function enforceTaskComplexityAssessment(operation) {
      // Task complexity assessment implementation
      return assessAndValidateComplexity(operation);
    },
  },

  // Basic memory update rules
  memoryUpdateConsistency: {
    id: 'core.memory.update_consistency',
    description: 'Ensure memory updates maintain consistency',
    enforcement: 'mandatory',
    implementation: function enforceMemoryUpdateConsistency(operation) {
      // Memory update consistency implementation
      return validateUpdateConsistency(operation);
    },
  },
};
```

### Tier 2: Context-Sensitive Rules

These rules are applied based on specific contexts such as file type, memory
type, workflow mode, or task complexity.

```javascript
/**
 * Context-sensitive rule definitions
 */
const CONTEXT_SENSITIVE_RULES = {
  // File type specific rules
  markdownFormatting: {
    id: 'context.file.markdown',
    description: 'Enforce markdown formatting standards',
    contexts: ['file:*.md'],
    enforcement: 'recommended',
    implementation: function enforceMarkdownFormatting(operation, context) {
      // Markdown formatting implementation
      return validateMarkdownFormat(operation, context);
    },
  },

  // Memory type specific rules
  episodicStructure: {
    id: 'context.memory.episodic',
    description: 'Enforce episodic memory structure',
    contexts: ['memory:episodic'],
    enforcement: 'recommended',
    implementation: function enforceEpisodicStructure(operation, context) {
      // Episodic memory structure implementation
      return validateEpisodicStructure(operation, context);
    },
  },

  semanticConsistency: {
    id: 'context.memory.semantic',
    description: 'Ensure semantic memory consistency',
    contexts: ['memory:semantic'],
    enforcement: 'recommended',
    implementation: function enforceSemanticConsistency(operation, context) {
      // Semantic memory consistency implementation
      return validateSemanticConsistency(operation, context);
    },
  },

  proceduralCompleteness: {
    id: 'context.memory.procedural',
    description: 'Verify procedural memory completeness',
    contexts: ['memory:procedural'],
    enforcement: 'recommended',
    implementation: function enforceProceduralCompleteness(operation, context) {
      // Procedural memory completeness implementation
      return validateProceduralCompleteness(operation, context);
    },
  },

  // Workflow mode specific rules
  planModeDocumentation: {
    id: 'context.mode.plan',
    description: 'Enforce documentation standards in Plan mode',
    contexts: ['mode:plan'],
    enforcement: 'recommended',
    implementation: function enforcePlanModeDocumentation(operation, context) {
      // Plan mode documentation implementation
      return validatePlanDocumentation(operation, context);
    },
  },

  actModeVerification: {
    id: 'context.mode.act',
    description: 'Enforce verification in Act mode',
    contexts: ['mode:act'],
    enforcement: 'recommended',
    implementation: function enforceActModeVerification(operation, context) {
      // Act mode verification implementation
      return validateActVerification(operation, context);
    },
  },

  // Task complexity level rules
  level3Documentation: {
    id: 'context.complexity.level3',
    description: 'Enforce Level 3 documentation requirements',
    contexts: ['complexity:3'],
    enforcement: 'recommended',
    implementation: function enforceLevel3Documentation(operation, context) {
      // Level 3 documentation implementation
      return validateLevel3Documentation(operation, context);
    },
  },

  level4Verification: {
    id: 'context.complexity.level4',
    description: 'Enforce Level 4 verification requirements',
    contexts: ['complexity:4'],
    enforcement: 'mandatory',
    implementation: function enforceLevel4Verification(operation, context) {
      // Level 4 verification implementation
      return validateLevel4Verification(operation, context);
    },
  },
};
```

### Tier 3: Agent-Requested Rules

These rules are explicitly requested by the agent for specific tasks.

```javascript
/**
 * Agent-requested rule definitions
 */
const AGENT_REQUESTED_RULES = {
  // Protocol implementation rules
  bedtimeProtocol: {
    id: 'agent.protocol.bedtime',
    description: 'Implement Bedtime Protocol steps',
    requestable: true,
    implementation: function implementBedtimeProtocol(operation, parameters) {
      // Bedtime protocol implementation
      return executeBedtimeProtocol(operation, parameters);
    },
  },

  creativePhase: {
    id: 'agent.protocol.creative',
    description: 'Implement Creative Phase structure',
    requestable: true,
    implementation: function implementCreativePhase(operation, parameters) {
      // Creative phase implementation
      return executeCreativePhase(operation, parameters);
    },
  },

  // Specialized workflow rules
  migrationWorkflow: {
    id: 'agent.workflow.migration',
    description: 'Implement Migration Workflow',
    requestable: true,
    implementation: function implementMigrationWorkflow(operation, parameters) {
      // Migration workflow implementation
      return executeMigrationWorkflow(operation, parameters);
    },
  },

  refactoringWorkflow: {
    id: 'agent.workflow.refactoring',
    description: 'Implement Refactoring Workflow',
    requestable: true,
    implementation: function implementRefactoringWorkflow(
      operation,
      parameters,
    ) {
      // Refactoring workflow implementation
      return executeRefactoringWorkflow(operation, parameters);
    },
  },

  // Project-specific technical rules
  projectSpecificPatterns: {
    id: 'agent.project.patterns',
    description: 'Apply project-specific patterns',
    requestable: true,
    implementation: function implementProjectPatterns(operation, parameters) {
      // Project patterns implementation
      return applyProjectPatterns(operation, parameters);
    },
  },
};
```

## Rule Application System

```javascript
/**
 * Rule application system
 */
function applyRules(operation, context) {
  // Set up rule application tracking
  const ruleTracker = initializeRuleTracker();

  try {
    // 1. Apply Tier 1 (Core) rules - always applied
    const coreRuleResults = applyCoreRules(operation, ruleTracker);
    if (!coreRuleResults.success) {
      return handleRuleViolations(coreRuleResults.violations, ruleTracker);
    }

    // 2. Determine applicable context-sensitive rules
    const applicableRules = determineApplicableRules(context);

    // 3. Apply Tier 2 (Context-sensitive) rules
    const contextRuleResults = applyContextSensitiveRules(
      operation,
      context,
      applicableRules,
      ruleTracker,
    );
    if (
      !contextRuleResults.success &&
      containsMandatoryViolations(contextRuleResults.violations)
    ) {
      return handleRuleViolations(contextRuleResults.violations, ruleTracker);
    }

    // 4. Apply Tier 3 (Agent-requested) rules if specified
    if (context.requestedRules && context.requestedRules.length > 0) {
      const agentRuleResults = applyAgentRequestedRules(
        operation,
        context,
        context.requestedRules,
        ruleTracker,
      );
      if (
        !agentRuleResults.success &&
        containsMandatoryViolations(agentRuleResults.violations)
      ) {
        return handleRuleViolations(agentRuleResults.violations, ruleTracker);
      }
    }

    // 5. Check for rule conflicts
    const conflictResults = checkRuleConflicts(ruleTracker.appliedRules);
    if (conflictResults.hasConflicts) {
      return handleRuleConflicts(conflictResults.conflicts, ruleTracker);
    }

    // 6. Generate rule application report
    const ruleReport = generateRuleApplicationReport(ruleTracker);

    // 7. Return successful application result
    return {
      success: true,
      appliedRules: ruleTracker.appliedRules,
      warnings: [
        ...contextRuleResults.violations,
        ...agentRuleResults.violations,
      ].filter((v) => v.level === 'warning'),
      report: ruleReport,
    };
  } catch (error) {
    return {
      success: false,
      error: `Rule application error: ${error.message}`,
      appliedRules: ruleTracker.appliedRules,
    };
  }
}

/**
 * Apply core (Tier 1) rules
 */
function applyCoreRules(operation, tracker) {
  const violations = [];

  // Apply each core rule
  for (const [ruleName, rule] of Object.entries(CORE_RULES)) {
    try {
      const result = rule.implementation(operation);

      // Track rule application
      tracker.trackRuleApplication({
        tier: 1,
        ruleId: rule.id,
        ruleName,
        result: result.success,
        timestamp: Date.now(),
      });

      // Collect violations if any
      if (!result.success) {
        violations.push({
          ruleId: rule.id,
          ruleName,
          level: 'error',
          message: result.message || `Violation of core rule: ${ruleName}`,
          details: result.details || null,
        });
      }
    } catch (error) {
      // Track rule application error
      tracker.trackRuleApplication({
        tier: 1,
        ruleId: rule.id,
        ruleName,
        result: false,
        error: error.message,
        timestamp: Date.now(),
      });

      violations.push({
        ruleId: rule.id,
        ruleName,
        level: 'error',
        message: `Error applying core rule: ${error.message}`,
        details: { stack: error.stack },
      });
    }
  }

  return {
    success: violations.length === 0,
    violations,
  };
}

/**
 * Determine which context-sensitive rules apply
 */
function determineApplicableRules(context) {
  const applicableRules = {};

  for (const [ruleName, rule] of Object.entries(CONTEXT_SENSITIVE_RULES)) {
    // Check if rule applies to current context
    const applies = rule.contexts.some((contextPattern) => {
      const [contextType, contextValue] = contextPattern.split(':');

      switch (contextType) {
        case 'file':
          return matchesFilePattern(context.file, contextValue);
        case 'memory':
          return context.memoryType === contextValue;
        case 'mode':
          return context.workflowMode === contextValue;
        case 'complexity':
          return context.taskComplexity.toString() === contextValue;
        default:
          return false;
      }
    });

    if (applies) {
      applicableRules[ruleName] = rule;
    }
  }

  return applicableRules;
}
```

## Rule Visibility System

The Rule Visibility System provides transparency into which rules are currently
being applied during operations.

```javascript
/**
 * Generate rule visibility report
 */
function generateRuleVisibilityReport(activeRules) {
  // Create markdown-formatted rule report
  const report = ['## Active Rules\n'];

  // Add core rules section
  report.push('### Core Rules\n');
  activeRules
    .filter((r) => r.tier === 1)
    .forEach((rule) => {
      report.push(`- ${rule.ruleName}: ${rule.active ? '✓' : '✗'}`);
    });

  // Add context-sensitive rules section
  report.push('\n### Context-Sensitive Rules\n');
  activeRules
    .filter((r) => r.tier === 2)
    .forEach((rule) => {
      report.push(`- ${rule.ruleName}: ${rule.active ? '✓' : '✗'}`);
    });

  // Add agent-requested rules section if any
  const agentRules = activeRules.filter((r) => r.tier === 3);
  if (agentRules.length > 0) {
    report.push('\n### Agent-Requested Rules\n');
    agentRules.forEach((rule) => {
      report.push(`- ${rule.ruleName}: ${rule.active ? '✓' : '✗'}`);
    });
  }

  return report.join('\n');
}

/**
 * Generate rule application indicator for output
 */
function generateRuleApplicationIndicator(appliedRules) {
  return `
## Rules Applied (${appliedRules.length})

${appliedRules
  .map(
    (r) =>
      `- ${r.tier === 1 ? 'Core' : r.tier === 2 ? 'Context' : 'Agent'}: ${
        r.ruleName
      }`,
  )
  .join('\n')}
  `;
}
```

## Rule Conflict Detection

The Rule Conflict Detection system identifies and resolves conflicts between
rules from different tiers.

```javascript
/**
 * Check for conflicts between applied rules
 */
function checkRuleConflicts(appliedRules) {
  const conflicts = [];

  // Define known conflict patterns
  const conflictPatterns = [
    {
      rules: ['context.mode.plan', 'context.mode.act'],
      description: 'Cannot simultaneously apply Plan mode and Act mode rules',
      resolution: 'mode:plan takes precedence',
    },
    {
      rules: ['context.complexity.level1', 'context.complexity.level4'],
      description: 'Conflicting complexity level rules',
      resolution: 'Higher complexity level takes precedence',
    },
    // Additional conflict patterns
  ];

  // Get IDs of applied rules
  const appliedRuleIds = appliedRules.map((r) => r.ruleId);

  // Check for known conflicts
  for (const pattern of conflictPatterns) {
    if (pattern.rules.every((rule) => appliedRuleIds.includes(rule))) {
      conflicts.push({
        conflictingRules: pattern.rules,
        description: pattern.description,
        resolution: pattern.resolution,
      });
    }
  }

  // Check for redundant rules
  const rulesByCategory = {};
  for (const rule of appliedRules) {
    const category = rule.ruleId.split('.')[1]; // e.g., "memory" from "context.memory.episodic"
    if (!rulesByCategory[category]) {
      rulesByCategory[category] = [];
    }
    rulesByCategory[category].push(rule);
  }

  // Find categories with multiple applied rules
  for (const [category, rules] of Object.entries(rulesByCategory)) {
    if (rules.length > 1) {
      // Check for potential conflicts within category
      checkCategoryConflicts(category, rules, conflicts);
    }
  }

  return {
    hasConflicts: conflicts.length > 0,
    conflicts,
  };
}

/**
 * Handle detected rule conflicts
 */
function handleRuleConflicts(conflicts, tracker) {
  // Log conflicts
  for (const conflict of conflicts) {
    console.warn(`Rule conflict detected: ${conflict.description}`);
    console.info(`Resolution: ${conflict.resolution}`);

    // Track conflict in tracker
    tracker.trackConflict(conflict);
  }

  // Apply resolutions based on conflict type
  applyConflictResolutions(conflicts, tracker);

  return {
    success: true,
    warnings: conflicts.map((c) => ({
      level: 'warning',
      message: `Rule conflict: ${c.description}`,
      resolution: c.resolution,
    })),
    appliedRules: tracker.appliedRules,
  };
}
```

## Rule Effectiveness Metrics

The Rule Effectiveness Metrics system measures the impact and overhead of rules
over time.

```javascript
/**
 * Track rule effectiveness metrics
 */
function trackRuleEffectiveness(ruleId, metrics) {
  // Initialize effectiveness tracking if not exists
  if (!globalRuleMetrics[ruleId]) {
    globalRuleMetrics[ruleId] = {
      applicationCount: 0,
      successCount: 0,
      violationCount: 0,
      executionTime: [],
      impactScores: [],
      lastUpdated: null,
    };
  }

  // Update metrics
  const ruleMetrics = globalRuleMetrics[ruleId];
  ruleMetrics.applicationCount += 1;

  if (metrics.success) {
    ruleMetrics.successCount += 1;
  } else {
    ruleMetrics.violationCount += 1;
  }

  ruleMetrics.executionTime.push(metrics.executionTime);
  ruleMetrics.impactScores.push(metrics.impactScore);
  ruleMetrics.lastUpdated = Date.now();

  // Trim arrays if they get too large
  if (ruleMetrics.executionTime.length > 100) {
    ruleMetrics.executionTime = ruleMetrics.executionTime.slice(-100);
    ruleMetrics.impactScores = ruleMetrics.impactScores.slice(-100);
  }

  // Persist metrics for long-term analysis
  persistRuleMetrics(ruleId, ruleMetrics);
}

/**
 * Calculate rule effectiveness score
 */
function calculateRuleEffectivenessScore(ruleId) {
  const metrics = globalRuleMetrics[ruleId];
  if (!metrics || metrics.applicationCount === 0) {
    return 0;
  }

  // Calculate components of effectiveness
  const successRate = metrics.successCount / metrics.applicationCount;
  const averageImpact = calculateAverage(metrics.impactScores);
  const averageExecutionTime = calculateAverage(metrics.executionTime);
  const timeEfficiency = 1 - Math.min(averageExecutionTime / 1000, 1); // Normalize to 0-1

  // Calculate overall effectiveness (success rate × impact × efficiency)
  return successRate * averageImpact * timeEfficiency;
}

/**
 * Identify rules for optimization
 */
function identifyRulesForOptimization() {
  const optimizationCandidates = [];

  for (const [ruleId, metrics] of Object.entries(globalRuleMetrics)) {
    // Skip rules with insufficient data
    if (metrics.applicationCount < 10) {
      continue;
    }

    const effectiveness = calculateRuleEffectivenessScore(ruleId);
    const averageExecutionTime = calculateAverage(metrics.executionTime);

    // Rules with low effectiveness or high execution time are candidates
    if (effectiveness < 0.3 || averageExecutionTime > 500) {
      optimizationCandidates.push({
        ruleId,
        effectiveness,
        averageExecutionTime,
        applicationCount: metrics.applicationCount,
        violationRate: metrics.violationCount / metrics.applicationCount,
      });
    }
  }

  // Sort by effectiveness (ascending)
  return optimizationCandidates.sort(
    (a, b) => a.effectiveness - b.effectiveness,
  );
}
```

## Rule Update Mechanism

The Rule Update Mechanism keeps rules in sync with system evolution.

```javascript
/**
 * Process rule system updates
 */
function processRuleSystemUpdates() {
  // 1. Check for new rule definitions
  const ruleDefinitionUpdates = checkForRuleDefinitionUpdates();

  // 2. Apply any new rule definitions
  if (ruleDefinitionUpdates.hasUpdates) {
    applyRuleDefinitionUpdates(ruleDefinitionUpdates.updates);
  }

  // 3. Update rule effectiveness thresholds based on metrics
  updateRuleEffectivenessThresholds();

  // 4. Apply rule optimizations if needed
  const optimizationCandidates = identifyRulesForOptimization();
  if (optimizationCandidates.length > 0) {
    applyRuleOptimizations(optimizationCandidates);
  }

  // 5. Update rule conflict patterns
  updateRuleConflictPatterns();

  return {
    definitionUpdates: ruleDefinitionUpdates.hasUpdates
      ? ruleDefinitionUpdates.updates.length
      : 0,
    optimizationCandidates: optimizationCandidates.length,
    thresholdsUpdated: true,
    conflictPatternsUpdated: true,
  };
}

/**
 * Synchronize rule definitions with implementation
 */
function synchronizeRuleDefinitions() {
  // Get current implementation rule IDs
  const implementationRuleIds = new Set([
    ...Object.values(CORE_RULES).map((r) => r.id),
    ...Object.values(CONTEXT_SENSITIVE_RULES).map((r) => r.id),
    ...Object.values(AGENT_REQUESTED_RULES).map((r) => r.id),
  ]);

  // Get rule IDs from definition files
  const definitionRuleIds = getRuleIdsFromDefinitions();

  // Find mismatches
  const missingInImplementation = definitionRuleIds.filter(
    (id) => !implementationRuleIds.has(id),
  );
  const missingInDefinition = [...implementationRuleIds].filter(
    (id) => !definitionRuleIds.includes(id),
  );

  return {
    synchronized:
      missingInImplementation.length === 0 && missingInDefinition.length === 0,
    missingInImplementation,
    missingInDefinition,
  };
}
```

## Implementation Guidelines

1. Integrate this rule system with the Memory Path Resolution, Reading Protocol,
   and Workflow Implementation systems
2. Implement the three-tier rule architecture with clear separation of concerns
3. Build the rule visibility system to track which rules are active
4. Implement rule conflict detection and resolution
5. Set up rule effectiveness metrics for long-term optimization
6. Establish a mechanism for rule updates and evolution

## Version History

| Version | Date       | Author    | Changes                               |
| ------- | ---------- | --------- | ------------------------------------- |
| 1.0.0   | 2025-03-24 | BIG BRAIN | Initial implementation of rule system |
