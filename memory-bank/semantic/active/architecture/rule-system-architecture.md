# Architecture: Rule System

## Overview

The Rule System architecture establishes a comprehensive framework for rule
management, application, and evolution in the BIG BRAIN Memory Bank system. This
three-tier architecture ensures appropriate rule application based on context
while providing visibility and conflict detection.

## Core Components

### Three-Tier Rule Architecture

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

#### Tier 1: Always-Applied Core Rules

These rules are foundational and always active, ensuring consistent system
behavior:

- Memory path resolution rules
- Memory read verification rules
- Identity preservation rules
- Task complexity assessment rules
- Memory update consistency rules

#### Tier 2: Context-Sensitive Rules

These rules activate based on specific contexts:

- File type specific rules (e.g., markdown formatting)
- Memory type specific rules (episodic, semantic, procedural)
- Workflow mode rules (plan vs. act)
- Task complexity level rules (levels 1-4)

#### Tier 3: Agent-Requested Rules

These rules are explicitly activated by the agent for specific tasks:

- Protocol implementation rules (bedtime, creative phase)
- Specialized workflow rules (migration, refactoring)
- Project-specific technical rules

### Rule Application Process

1. Apply Tier 1 (Core) rules - always applied
2. Determine applicable context-sensitive rules
3. Apply Tier 2 (Context-sensitive) rules
4. Apply Tier 3 (Agent-requested) rules if specified
5. Check for rule conflicts
6. Generate rule application report
7. Return application result

### Rule Visibility System

The Rule Visibility System provides transparency into active rules:

- Core Rules section
- Context-Sensitive Rules section
- Agent-Requested Rules section (when applicable)

### Rule Conflict Detection

The conflict detection system:

- Identifies contradictory rule combinations
- Detects redundant rules within categories
- Applies resolution strategies based on rule precedence
- Tracks conflict patterns for future prevention

### Rule Effectiveness Metrics

Tracks metrics for rule optimization:

- Application count
- Success and violation rates
- Execution time
- Impact scores
- Effectiveness calculation

## Integration Points

### Memory System Integration

- Path resolution rules ensure proper memory access
- Read verification rules validate memory operations
- Update consistency rules maintain memory integrity

### Workflow System Integration

- Mode-specific rules adapt to Plan or Act mode
- Complexity-driven rules scale based on task complexity
- Verification rules ensure workflow checkpoint completion

### Command System Integration

- Rule application during command execution
- Command-specific rule context determination
- Rule visibility in command responses

## Decision Considerations

### Rule Precedence

When rules conflict, precedence is determined by:

1. Tier level (Tier 1 > Tier 2 > Tier 3)
2. Enforcement level (mandatory > recommended > optional)
3. Specificity (more specific context > less specific)
4. Recency (newer rule > older rule)

### Performance Optimization

Rules are optimized for:

- Minimal execution time impact
- Targeted application to relevant contexts
- Efficient conflict detection
- Cached rule resolution for common patterns

## Implementation Notes

- Rule definitions stored in structured format for consistency
- Rule application tracked for metrics collection
- Conflict patterns updated based on detected issues
- Effectiveness thresholds adjusted dynamically

## Related Concepts

- Memory Path Resolution [→ Core:active/memoryPaths.md]
- Workflow Implementation [→ Core:active/workflowImplementation.md]
- Task Complexity Framework [→ Semantic:concepts/task-complexity.md]
- Memory Reading Protocol [→ Core:active/memoryReadingProtocol.md]

## Memory Strength: HIGH

Last Accessed: 2025-03-24 Access Frequency: Frequent Importance: Critical
