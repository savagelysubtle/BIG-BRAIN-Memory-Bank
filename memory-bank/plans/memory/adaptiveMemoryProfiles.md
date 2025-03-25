# Adaptive Memory Profiles

## Overview

This file defines memory profiles for the Adaptive Memory Management system,
which dynamically allocates memory resources based on context, priority, and
usage patterns. These profiles guide how memory access, caching, and
optimization are performed across different memory types and scenarios.

## Base Memory Profile

The base memory profile establishes default allocation percentages, priority
rules, and caching strategies for different memory types.

```javascript
const BASE_MEMORY_PROFILE = {
  episodic: {
    allocation: 0.3, // 30% of memory resources
    priorityRules: [
      { pattern: 'sessions/recent', priority: 'high' },
      { pattern: 'decisions/critical', priority: 'high' },
      { pattern: 'milestones', priority: 'medium' },
      { pattern: 'timeline', priority: 'medium' },
      { pattern: 'sessions/archive', priority: 'low' },
    ],
    caching: {
      strategy: 'recency',
      limit: 10,
    },
  },

  semantic: {
    allocation: 0.4, // 40% of memory resources
    priorityRules: [
      { pattern: 'architecture/*', priority: 'high' },
      { pattern: 'concepts/core/*', priority: 'high' },
      { pattern: 'references/active', priority: 'medium' },
      { pattern: 'knowledge-base/current', priority: 'medium' },
      { pattern: 'references/archive', priority: 'low' },
    ],
    caching: {
      strategy: 'importance',
      limit: 15,
    },
  },

  procedural: {
    allocation: 0.3, // 30% of memory resources
    priorityRules: [
      { pattern: 'workflows/current', priority: 'high' },
      { pattern: 'operations/active', priority: 'high' },
      { pattern: 'guidelines', priority: 'medium' },
      { pattern: 'checklists', priority: 'medium' },
      { pattern: 'archive/*', priority: 'low' },
    ],
    caching: {
      strategy: 'frequency',
      limit: 10,
    },
  },
};
```

## Context-Specific Profiles

### Plan Mode Profile

```javascript
const PLAN_MODE_PROFILE = {
  episodic: {
    allocation: 0.25, // Reduced from base
    priorityRules: [
      { pattern: 'decisions/critical', priority: 'high' }, // More emphasis on decisions
      { pattern: 'milestones', priority: 'high' }, // More emphasis on milestones
      { pattern: 'sessions/recent', priority: 'medium' }, // Reduced priority
      { pattern: 'timeline', priority: 'medium' },
      { pattern: 'sessions/archive', priority: 'low' },
    ],
    caching: {
      strategy: 'importance', // Changed from recency to importance
      limit: 8,
    },
  },

  semantic: {
    allocation: 0.5, // Increased from base
    priorityRules: [
      { pattern: 'architecture/*', priority: 'high' },
      { pattern: 'concepts/core/*', priority: 'high' },
      { pattern: 'references/active', priority: 'high' }, // Increased priority
      { pattern: 'knowledge-base/current', priority: 'high' }, // Increased priority
      { pattern: 'references/archive', priority: 'medium' }, // Increased priority
    ],
    caching: {
      strategy: 'importance',
      limit: 20, // Increased limit
    },
  },

  procedural: {
    allocation: 0.25, // Reduced from base
    priorityRules: [
      { pattern: 'workflows/current', priority: 'high' },
      { pattern: 'guidelines', priority: 'high' }, // Increased priority
      { pattern: 'operations/active', priority: 'medium' }, // Reduced priority
      { pattern: 'checklists', priority: 'medium' },
      { pattern: 'archive/*', priority: 'low' },
    ],
    caching: {
      strategy: 'importance', // Changed from frequency to importance
      limit: 8,
    },
  },
};
```

### Act Mode Profile

```javascript
const ACT_MODE_PROFILE = {
  episodic: {
    allocation: 0.2, // Reduced from base
    priorityRules: [
      { pattern: 'sessions/recent', priority: 'high' },
      { pattern: 'decisions/critical', priority: 'high' },
      { pattern: 'milestones', priority: 'medium' },
      { pattern: 'timeline', priority: 'low' }, // Reduced priority
      { pattern: 'sessions/archive', priority: 'low' },
    ],
    caching: {
      strategy: 'recency',
      limit: 5, // Reduced limit
    },
  },

  semantic: {
    allocation: 0.3, // Reduced from base
    priorityRules: [
      { pattern: 'architecture/*', priority: 'high' },
      { pattern: 'concepts/core/*', priority: 'high' },
      { pattern: 'references/active', priority: 'medium' },
      { pattern: 'knowledge-base/current', priority: 'medium' },
      { pattern: 'references/archive', priority: 'low' },
    ],
    caching: {
      strategy: 'frequency', // Changed from importance to frequency
      limit: 10, // Reduced limit
    },
  },

  procedural: {
    allocation: 0.5, // Increased from base
    priorityRules: [
      { pattern: 'workflows/current', priority: 'high' },
      { pattern: 'operations/active', priority: 'high' },
      { pattern: 'checklists', priority: 'high' }, // Increased priority
      { pattern: 'guidelines', priority: 'high' }, // Increased priority
      { pattern: 'archive/*', priority: 'low' },
    ],
    caching: {
      strategy: 'frequency',
      limit: 15, // Increased limit
    },
  },
};
```

### Complexity-Based Profiles

```javascript
const COMPLEXITY_PROFILES = {
  // Level 1 (Simple) - Minimal memory requirements
  1: {
    episodic: { allocation: 0.2, cacheLimit: 3 },
    semantic: { allocation: 0.3, cacheLimit: 5 },
    procedural: { allocation: 0.5, cacheLimit: 7 },
  },

  // Level 2 (Moderate) - Balanced memory requirements
  2: {
    episodic: { allocation: 0.25, cacheLimit: 5 },
    semantic: { allocation: 0.35, cacheLimit: 10 },
    procedural: { allocation: 0.4, cacheLimit: 10 },
  },

  // Level 3 (Complex) - Enhanced memory requirements
  3: {
    episodic: { allocation: 0.3, cacheLimit: 8 },
    semantic: { allocation: 0.4, cacheLimit: 15 },
    procedural: { allocation: 0.3, cacheLimit: 12 },
  },

  // Level 4 (Critical) - Maximum memory requirements
  4: {
    episodic: { allocation: 0.35, cacheLimit: 12 },
    semantic: { allocation: 0.45, cacheLimit: 20 },
    procedural: { allocation: 0.2, cacheLimit: 15 },
  },
};
```

## Memory Optimization Strategies

```javascript
const MEMORY_OPTIMIZATION_STRATEGIES = {
  // Recency-based optimization (time-based)
  recency: {
    prioritize: (memories) =>
      memories.sort((a, b) => b.lastAccessed - a.lastAccessed),
    cache: (memories, limit) =>
      memories.sort((a, b) => b.lastAccessed - a.lastAccessed).slice(0, limit),
    evict: (cache, newItem) => {
      const oldest = cache.reduce((prev, curr) =>
        prev.lastAccessed < curr.lastAccessed ? prev : curr,
      );
      return cache.filter((item) => item !== oldest).concat([newItem]);
    },
  },

  // Frequency-based optimization (access count)
  frequency: {
    prioritize: (memories) =>
      memories.sort((a, b) => b.accessCount - a.accessCount),
    cache: (memories, limit) =>
      memories.sort((a, b) => b.accessCount - a.accessCount).slice(0, limit),
    evict: (cache, newItem) => {
      const leastUsed = cache.reduce((prev, curr) =>
        prev.accessCount < curr.accessCount ? prev : curr,
      );
      return cache.filter((item) => item !== leastUsed).concat([newItem]);
    },
  },

  // Importance-based optimization (explicit weight)
  importance: {
    prioritize: (memories) =>
      memories.sort((a, b) => b.importance - a.importance),
    cache: (memories, limit) =>
      memories.sort((a, b) => b.importance - a.importance).slice(0, limit),
    evict: (cache, newItem) => {
      const leastImportant = cache.reduce((prev, curr) =>
        prev.importance < curr.importance ? prev : curr,
      );
      return cache.filter((item) => item !== leastImportant).concat([newItem]);
    },
  },

  // Combined strategy (weighted formula)
  combined: {
    prioritize: (memories) =>
      memories.sort((a, b) => {
        const scoreA =
          0.4 * a.importance +
          0.3 * (a.accessCount / 10) +
          0.3 * (Date.now() - a.lastAccessed < 86400000 ? 1 : 0);
        const scoreB =
          0.4 * b.importance +
          0.3 * (b.accessCount / 10) +
          0.3 * (Date.now() - b.lastAccessed < 86400000 ? 1 : 0);
        return scoreB - scoreA;
      }),
    cache: (memories, limit) => {
      // Same sorting as prioritize
      return memories
        .sort((a, b) => {
          const scoreA =
            0.4 * a.importance +
            0.3 * (a.accessCount / 10) +
            0.3 * (Date.now() - a.lastAccessed < 86400000 ? 1 : 0);
          const scoreB =
            0.4 * b.importance +
            0.3 * (b.accessCount / 10) +
            0.3 * (Date.now() - b.lastAccessed < 86400000 ? 1 : 0);
          return scoreB - scoreA;
        })
        .slice(0, limit);
    },
    evict: (cache, newItem) => {
      // Find lowest combined score
      const lowestScore = cache.reduce((prev, curr) => {
        const scoreP =
          0.4 * prev.importance +
          0.3 * (prev.accessCount / 10) +
          0.3 * (Date.now() - prev.lastAccessed < 86400000 ? 1 : 0);
        const scoreC =
          0.4 * curr.importance +
          0.3 * (curr.accessCount / 10) +
          0.3 * (Date.now() - curr.lastAccessed < 86400000 ? 1 : 0);
        return scoreP < scoreC ? prev : curr;
      });
      return cache.filter((item) => item !== lowestScore).concat([newItem]);
    },
  },
};
```

## Profile Selection Logic

```javascript
function selectMemoryProfile(context) {
  // Base profile selection
  let profile = JSON.parse(JSON.stringify(BASE_MEMORY_PROFILE)); // Deep copy

  // Apply workflow mode adjustments
  if (context.mode === 'plan') {
    profile = applyModeProfile(profile, PLAN_MODE_PROFILE);
  } else if (context.mode === 'act') {
    profile = applyModeProfile(profile, ACT_MODE_PROFILE);
  }

  // Apply complexity adjustments
  profile = applyComplexityProfile(
    profile,
    COMPLEXITY_PROFILES[context.complexity] || COMPLEXITY_PROFILES[2],
  );

  // Apply task-specific adjustments if available
  if (context.taskType && TASK_SPECIFIC_PROFILES[context.taskType]) {
    profile = applyTaskAdjustments(
      profile,
      TASK_SPECIFIC_PROFILES[context.taskType],
    );
  }

  // Return the final profile
  return profile;
}

function applyModeProfile(baseProfile, modeProfile) {
  const result = JSON.parse(JSON.stringify(baseProfile)); // Deep copy

  // Apply mode-specific allocations and priorities
  Object.keys(modeProfile).forEach((memoryType) => {
    if (result[memoryType]) {
      result[memoryType].allocation = modeProfile[memoryType].allocation;

      if (modeProfile[memoryType].priorityRules) {
        result[memoryType].priorityRules =
          modeProfile[memoryType].priorityRules;
      }

      if (modeProfile[memoryType].caching) {
        result[memoryType].caching = modeProfile[memoryType].caching;
      }
    }
  });

  return result;
}

function applyComplexityProfile(profile, complexityProfile) {
  const result = JSON.parse(JSON.stringify(profile)); // Deep copy

  // Apply complexity-specific adjustments
  Object.keys(complexityProfile).forEach((memoryType) => {
    if (result[memoryType]) {
      if (complexityProfile[memoryType].allocation) {
        result[memoryType].allocation =
          complexityProfile[memoryType].allocation;
      }

      if (complexityProfile[memoryType].cacheLimit) {
        result[memoryType].caching.limit =
          complexityProfile[memoryType].cacheLimit;
      }
    }
  });

  return result;
}
```

## Usage Example

```javascript
// Example context
const context = {
  mode: 'plan',
  complexity: 3,
  taskType: 'architecture_design',
};

// Select appropriate memory profile
const memoryProfile = selectMemoryProfile(context);

// Use profile to guide memory operations
console.log(
  `Semantic memory allocation: ${memoryProfile.semantic.allocation * 100}%`,
);
console.log(
  `Episodic cache limit: ${memoryProfile.episodic.caching.limit} items`,
);
console.log(
  `Procedural caching strategy: ${memoryProfile.procedural.caching.strategy}`,
);
```

## Version History

| Version | Date       | Author    | Changes                                   |
| ------- | ---------- | --------- | ----------------------------------------- |
| 1.0.0   | 2025-03-26 | BIG BRAIN | Initial implementation of memory profiles |
