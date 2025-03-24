# Memory Type Organization System

## Overview

The Memory Type Organization System implements a comprehensive cognitive memory
model across all memory types in the BIG BRAIN Memory Bank. This system
establishes structured organization for episodic, semantic, and procedural
memory, creates cross-referencing between related memories, implements memory
strength indicators, and enhances retrieval capabilities.

## Memory Type Specifications

### Episodic Memory

Episodic memory stores experiences, events, and milestones organized
chronologically.

```
memory-bank/episodic/active/
├── sessions/
│   ├── summary-YYYY-MM-DD.md     # Daily session summaries
│   └── insights-YYYY-MM-DD.md    # Key insights from sessions
├── milestones/
│   ├── milestone-NAME.md         # Major project milestones
│   └── retrospectives/           # Milestone retrospectives
├── decisions/
│   ├── decision-NAME.md          # Critical decision records
│   └── alternatives/             # Alternative options considered
└── timeline/
    └── project-timeline.md       # Chronological project events
```

#### Session Summary Template

```markdown
# Session Summary: YYYY-MM-DD

## Overview

Brief description of session focus and goals.

## Accomplishments

- Key accomplishment 1
- Key accomplishment 2
- ...

## Challenges

- Challenge encountered 1
- Challenge encountered 2
- ...

## Decisions Made

- Decision 1 [→ Link to decision record]
- Decision 2 [→ Link to decision record]
- ...

## Next Steps

- Next step 1
- Next step 2
- ...

## Memory Strength: [HIGH|MEDIUM|LOW]

Last Accessed: YYYY-MM-DD Access Frequency: [Frequent|Occasional|Rare]
Importance: [Critical|Important|Standard]
```

### Semantic Memory

Semantic memory stores knowledge, concepts, and reference information organized
by domain.

```
memory-bank/semantic/active/
├── concepts/
│   ├── domain-NAME/              # Domain-specific concepts
│   └── glossary.md               # Terminology definitions
├── architecture/
│   ├── system-overview.md        # System architecture overview
│   ├── component-NAME.md         # Component specifications
│   └── design-patterns.md        # Design patterns used
├── references/
│   ├── libraries/                # External library references
│   ├── apis/                     # API documentation
│   └── standards/                # Coding standards & conventions
└── knowledge-base/
    ├── tutorials/                # How-to guides
    ├── troubleshooting/          # Common issues and solutions
    └── best-practices/           # Best practices by category
```

#### Concept Definition Template

````markdown
# Concept: NAME

## Definition

Concise definition of the concept.

## Context

Where and how this concept is used in the project.

## Related Concepts

- Related concept 1 [→ Link to concept]
- Related concept 2 [→ Link to concept]
- ...

## Implementation Details

Specific details about how this concept is implemented.

## Examples

```code
// Example code or usage
```
````

## Memory Strength: [HIGH|MEDIUM|LOW]

Last Accessed: YYYY-MM-DD Access Frequency: [Frequent|Occasional|Rare]
Importance: [Critical|Important|Standard]

```

### Procedural Memory

Procedural memory stores workflows, processes, and procedures organized by purpose.

```

memory-bank/procedural/active/ ├── workflows/ │ ├── development-workflow.md #
Development workflow │ ├── testing-workflow.md # Testing procedures │ └──
deployment-workflow.md # Deployment processes ├── operations/ │ ├──
environment-setup.md # Environment setup procedures │ ├── maintenance.md #
Maintenance procedures │ └── troubleshooting.md # Troubleshooting procedures ├──
guidelines/ │ ├── coding-guidelines.md # Coding standards │ ├──
documentation.md # Documentation standards │ └── qa-guidelines.md # QA processes
└── checklists/ ├── release-checklist.md # Release preparation checklist ├──
review-checklist.md # Code review checklist └── security-checklist.md # Security
verification checklist

````

#### Workflow Template

```markdown
# Workflow: NAME

## Purpose

What this workflow accomplishes.

## Prerequisites

- Prerequisite 1
- Prerequisite 2
- ...

## Steps

1. Step 1
   - Details for step 1
   - Considerations for step 1
2. Step 2
   - Details for step 2
   - Considerations for step 2
...

## Verification

How to verify successful completion.

## Troubleshooting

Common issues and solutions.

## Memory Strength: [HIGH|MEDIUM|LOW]

Last Accessed: YYYY-MM-DD
Access Frequency: [Frequent|Occasional|Rare]
Importance: [Critical|Important|Standard]
````

## Cross-Referencing System

The cross-referencing system creates connections between related memories across
different memory types.

### Cross-Reference Syntax

```markdown
[→ TYPE:PATH:ANCHOR]
```

Examples:

- `[→ Episodic:sessions/summary-2025-03-24.md]`
- `[→ Semantic:concepts/architecture/system-overview.md#components]`
- `[→ Procedural:workflows/deployment-workflow.md]`

### Cross-Reference Registry

The system maintains a registry of all cross-references to enable validation and
navigation:

```javascript
const CROSS_REFERENCES = {
  // Source -> Target mapping
  'memory-bank/core/active/activeContext.md': [
    {
      target: 'memory-bank/episodic/active/sessions/summary-2025-03-24.md',
      type: 'Episodic',
      anchor: null,
      context: 'Recent session',
    },
    {
      target: 'memory-bank/semantic/active/architecture/system-overview.md',
      type: 'Semantic',
      anchor: 'components',
      context: 'System structure',
    },
  ],

  // Additional entries...
};
```

## Memory Strength Indicators

Memory strength is tracked to prioritize maintenance and ensure important
memories remain accessible.

### Strength Factors

1. **Recency**: When was the memory last accessed?

   - Recent (< 7 days): High contribution
   - Moderate (7-30 days): Medium contribution
   - Old (> 30 days): Low contribution

2. **Frequency**: How often is the memory accessed?

   - Frequent (daily/weekly): High contribution
   - Occasional (monthly): Medium contribution
   - Rare (less than monthly): Low contribution

3. **Importance**: How critical is this memory?
   - Critical (essential for operation): High contribution
   - Important (valuable for context): Medium contribution
   - Standard (general information): Low contribution

### Strength Calculation

```javascript
function calculateMemoryStrength(memory) {
  const recencyScore = getRecencyScore(memory.lastAccessed);
  const frequencyScore = getFrequencyScore(memory.accessHistory);
  const importanceScore = getImportanceScore(memory.importance);

  const totalScore =
    recencyScore * 0.3 + frequencyScore * 0.3 + importanceScore * 0.4;

  if (totalScore >= 0.7) return 'HIGH';
  if (totalScore >= 0.4) return 'MEDIUM';
  return 'LOW';
}
```

### Memory Maintenance Schedule

Based on strength indicators:

| Strength | Reinforcement Schedule | Maintenance Action                          |
| -------- | ---------------------- | ------------------------------------------- |
| HIGH     | As needed              | Regular access keeps strong                 |
| MEDIUM   | Monthly                | Schedule periodic review                    |
| LOW      | Bi-weekly              | Prioritize for review or consider archiving |

## Retrieval Enhancement

The retrieval enhancement system improves the ability to find and access
relevant memories.

### Unified Search Protocol

```javascript
function searchMemory(query, options = {}) {
  // Determine search scope
  const scope = options.scope || 'all'; // "all", "episodic", "semantic", "procedural"

  // Determine search type
  const searchType = options.type || 'semantic'; // "semantic", "keyword", "temporal"

  // Execute appropriate search
  let results;
  if (searchType === 'semantic') {
    results = semanticSearch(query, scope);
  } else if (searchType === 'keyword') {
    results = keywordSearch(query, scope);
  } else {
    results = temporalSearch(query, scope);
  }

  // Apply relevance scoring
  const scoredResults = scoreResults(results, query);

  // Filter by context if provided
  const filteredResults = options.context
    ? filterByContext(scoredResults, options.context)
    : scoredResults;

  return filteredResults;
}
```

### Relevance Scoring

```javascript
function scoreResults(results, query) {
  return results
    .map((result) => {
      // Base score
      let score = calculateBaseRelevance(result.content, query);

      // Adjust by memory strength
      score *= getStrengthMultiplier(result.strength);

      // Adjust by cross-reference count
      score *= getCrossReferenceMultiplier(result.path);

      // Adjust by recency
      score *= getRecencyMultiplier(result.lastAccessed);

      return {
        ...result,
        relevanceScore: score,
      };
    })
    .sort((a, b) => b.relevanceScore - a.relevanceScore);
}
```

## Implementation Guidelines

1. Create directory structures for each memory type
2. Implement templates for different memory record types
3. Add cross-referencing support to new and existing files
4. Start tracking memory access and calculate strength indicators
5. Implement the search and retrieval functionality
6. Integrate with the Memory Path Resolution and Reading Protocol systems

## Version History

| Version | Date       | Author    | Changes                                       |
| ------- | ---------- | --------- | --------------------------------------------- |
| 1.0.0   | 2025-03-24 | BIG BRAIN | Initial implementation of memory organization |
