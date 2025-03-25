# Memory Bank Core Concepts

## Overview

This document captures the fundamental concepts of the BIG BRAIN Memory Bank system. These are stable conceptual frameworks that guide the overall implementation.

## Cognitive Memory Model

The BIG BRAIN Memory Bank is structured according to a cognitive memory model that mirrors human memory:

- **Active Memory:** Current working context and state
- **Short-Term Memory:** Recent information that may be needed in the near term
- **Long-Term Memory:** Permanent knowledge organized into categories:
  - **Episodic Memory:** Experience-based (sessions, milestones, decisions)
  - **Semantic Memory:** Knowledge-based (domain concepts, APIs, features)
  - **Procedural Memory:** Action-based (workflows, guides, checklists)
  - **Creative Memory:** Design-based (architecture, components, algorithms, data models)

## Workflow Modes

The system operates in two distinct workflow modes:

- **Plan Mode:** Strategic thinking, architecture design, and high-level planning
- **Act Mode:** Implementation, coding, and concrete actions

## Complexity Levels

Tasks are categorized into four complexity levels that determine process rigor:

1. **Simple Tasks:** Quick changes with minimal planning
2. **Standard Tasks:** Normal development activities with moderate planning
3. **Complex Tasks:** Significant changes requiring thorough planning
4. **Advanced Tasks:** Major architectural changes requiring formal processes

## Bedtime Protocol

A critical workflow for preserving memory between sessions:

1. Memory update
2. Session summary creation
3. Memory archival
4. Verification
5. Completion confirmation

## Memory Analytics

A system for monitoring memory health through metrics:

- Memory Diversity
- Long-Term Ratio
- Category Balance
- Activity Score
- Overall Score

## Command System

The BIG command system provides a standardized interface for interacting with the memory bank:

```
BIG [category] [command] [parameters] [--options]
```

## Version History

- 1.0.0: Initial documentation of core concepts (2025-03-25)