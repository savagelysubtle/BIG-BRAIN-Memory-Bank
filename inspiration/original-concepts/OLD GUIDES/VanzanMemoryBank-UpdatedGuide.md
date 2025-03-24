# Vanzan Memory Bank System: Updated Implementation

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)

> **Give your AI assistant a memory that persists between sessions with enhanced
> rule structure and workflow management**

## Table of Contents

1. [The Problem: AI Assistant Amnesia](#the-problem-ai-assistant-amnesia)
2. [The Solution: Strategic Context Management](#the-solution-strategic-context-management)
3. [Core Architecture Overview](#core-architecture-overview)
4. [Adaptive Workflow System](#adaptive-workflow-system)
5. [Rule Implementation](#rule-implementation)
6. [Enhanced Creative Phase Framework](#enhanced-creative-phase-framework)
7. [Memory Bank File Structure](#memory-bank-file-structure)
8. [Rule Organization and Optimization](#rule-organization-and-optimization)
9. [Command System](#command-system)
10. [Project Intelligence Capture](#project-intelligence-capture)
11. [Integration Insights](#integration-insights)
12. [Implementation Guide](#implementation-guide)

## The Problem: AI Assistant Amnesia

Every developer who works with AI assistants faces the same frustration: **your
AI helper forgets everything between sessions**. You spend time explaining your
project, walking through architecture decisions, and establishing conventions -
only to have that context disappear when you close your editor or when the
context window fills up.

This fundamental limitation of Large Language Models (LLMs) creates several
significant challenges:

- **Lost Context**: Every new session starts from scratch
- **Repeated Explanations**: You constantly re-explain your project basics
- **Inconsistent Implementations**: Solutions vary as context is lost
- **Documentation Drift**: Project knowledge exists only in your head
- **Workflow Disruption**: Design decisions need to be reexplained repeatedly

## The Solution: Strategic Context Management

The Vanzan Memory Bank System (updated with the latest best practices) creates a
**structured external memory** for your AI assistant using Cursor's powerful
rules system. Rather than overwhelming the LLM with massive context dumps (which
often get partially processed), our approach strategically organizes
documentation into purpose-built files that are:

- **Selectively Loaded**: Only relevant context is accessed when needed
- **Automatically Maintained**: The system updates its own memory
- **Procedurally Verified**: Built-in checkpoints ensure completeness
- **Platform-Aware**: Adapts to your operating system automatically
- **Adaptive Complexity**: Scales process based on task complexity
- **Creative Phase Enforcement**: Ensures proper design thinking for complex
  tasks

![Memory Bank System](../Vanzan-memory-bank/images/memory-bank-diagram.png)

## Core Architecture Overview

The Memory Bank System solves the context limitations of LLMs through these key
innovations:

### 1. Structured Documentation as Memory

Instead of trying to pack everything into a single context window, we create a
network of specialized documentation files that serve as the AI's long-term
memory:

```
memory-bank/
├── projectbrief.md      # What we're building
├── productContext.md    # Why we're building it
├── activeContext.md     # What we're working on now
├── systemPatterns.md    # How we've designed it
├── techContext.md       # What technologies we're using
├── progress.md          # What we've completed
└── tasks.md             # What we're tracking (single source of truth)
```

### 2. Three-Tier Rule Application System

We leverage Cursor's rules system using an optimized three-tier approach to
manage context effectively:

1. **Always-Applied Rules**:

   - Critical system functions that guide every interaction
   - Kept extremely concise to minimize context window usage
   - Used for mission-critical requirements

2. **Auto-Attached Rules**:

   - Context that loads only when working in specific directories or file types
   - Used for language-specific or framework-specific guidance
   - More detailed than always-applied rules but still optimized

3. **Agent-Requested Rules**:
   - Detailed information the AI explicitly requests when needed
   - Contains extensive examples and detailed guidelines
   - Helps manage context window by keeping details separate

This strategic loading prevents context window overflow while ensuring the AI
has access to all knowledge.

### 3. Adaptive Workflow Enforcement

The system scales its workflow process based on task complexity:

- **Level 1: Quick Bug Fix** - Streamlined process for simple errors and minor
  issues
- **Level 2: Simple Enhancement** - Basic process for small features and
  improvements
- **Level 3: Intermediate Feature** - Standard process for complete features
  with required creative phases
- **Level 4: Complex System** - Comprehensive process for major architectural
  changes with enforced creative phases

Each level provides appropriate documentation rigor and process structure to
match the task requirements.

## Adaptive Workflow System

### Complexity Level Determination

The system begins by assessing task complexity and assigning the appropriate
level:

```markdown
## 🔍 COMPLEXITY ASSESSMENT

Task: [Brief Task Description]

Complexity Factors:

- Scope: [Narrow/Focused/Broad/System-Wide]
- Risk Level: [Low/Medium/High/Critical]
- Dependencies: [Few/Some/Many/Extensive]
- Technical Difficulty: [Simple/Moderate/Complex/Advanced]

→ COMPLEXITY LEVEL: [1-4]
```

### Level-Specific Workflows

Each complexity level follows a different workflow with appropriate scaling of
documentation requirements:

#### Level 1: Quick Bug Fix

```
INITIALIZATION → IMPLEMENTATION → DOCUMENTATION
```

- 2-3 task updates total
- Focused on solving the immediate issue
- Minimal documentation updates

#### Level 2: Simple Enhancement

```
INITIALIZATION → DOCUMENTATION → PLANNING → IMPLEMENTATION → REFLECTION → ARCHIVING
```

- 4-6 task updates at key milestones
- Basic planning and documentation
- Simple feature implementation

#### Level 3: Intermediate Feature

```
INITIALIZATION → DOCUMENTATION → PLANNING → CREATIVE PHASE → IMPLEMENTATION → VERIFICATION → REFLECTION → ARCHIVING
```

- 8-12 task updates at defined points
- Mandatory creative phase for design decisions
- Comprehensive planning and documentation

#### Level 4: Complex System

```
INITIALIZATION → DEEP DOCUMENTATION → COMPREHENSIVE PLANNING → MULTI-STAGE CREATIVE PHASE → PHASED IMPLEMENTATION → FORMAL VERIFICATION → DETAILED REFLECTION → STRUCTURED ARCHIVING
```

- 15+ task updates with formal verification
- Multiple creative phases for architectural decisions
- Extensive documentation and planning

### Workflow Mode Integration

On top of the complexity levels, the system now integrates two workflow modes
that determine the AI's approach:

- **Plan Mode**: For strategic discussions and approach planning
- **Act Mode**: For implementation and execution

These modes can be activated within any complexity level, creating a dual-axis
system that adjusts both process rigor and thinking approach.

## Rule Implementation

The Memory Bank System relies on a set of optimized rules in the
`.cursor/rules/` directory. Based on the latest best practices from the Cursor
Rules Comprehensive Guide, we've enhanced the rule structure for maximum clarity
and efficiency.

### Core Rules

#### 1. Main Control Rule (000-memory-bank-core.mdc)

```markdown
---
description:
  WHEN starting ANY task ENSURE checking memory-bank files BEFORE proceeding
globs:
alwaysApply: true
---

> **TL;DR:** Before responding to any request, always check the memory-bank
> directory and tasks.md to understand project context and current work focus.
> Determine complexity level and follow appropriate workflow.

# Memory Bank System

## 🚨 CRITICAL REQUIREMENTS

BEFORE starting any task or providing any response, you MUST:

1. Check if memory-bank/ directory and .cursorrules file exist

   - If they do not exist, offer to initialize them
   - If they exist, read ALL mandatory files

2. Read these files IN ORDER:

   - memory-bank/projectbrief.md
   - memory-bank/productContext.md
   - memory-bank/systemPatterns.md
   - memory-bank/techContext.md
   - memory-bank/activeContext.md
   - memory-bank/progress.md
   - memory-bank/tasks.md (SINGLE SOURCE OF TRUTH)

3. Identify task complexity level (1-4)

   - Level 1: Quick Bug Fix
   - Level 2: Simple Enhancement
   - Level 3: Intermediate Feature
   - Level 4: Complex System

4. Check the current workflow mode

   - Identify if in PLAN mode or ACT mode
   - Adjust response approach accordingly

5. Follow the appropriate workflow based on complexity level
   - Use more rigorous process for higher complexity levels
   - Include creative phases for Level 3-4 tasks
```

#### 2. Task Tracking Rule (010-task-tracking.mdc)

```markdown
---
description:
  WHEN updating task status ENSURE using tasks.md as single source of truth
globs: '**/memory-bank/tasks.md'
alwaysApply: true
---

> **TL;DR:** tasks.md is the ONLY place to track task status. Update it
> consistently with a standardized format that includes complexity level,
> workflow mode, and current stage.

# Task Tracking System

## 📋 TASK TRACKING FORMAT
```

## [Task Name] - LEVEL [1-4] - [PLAN|ACT] MODE

Status: [Not Started|In Progress|Completed] Current Stage:
[Initialization|Planning|Creative
Phase|Implementation|Verification|Reflection|Archiving] Last Updated: [Date]

### Requirements

- [Requirement 1]
- [Requirement 2]

### Progress

- [✓] Subtask 1 completed
- [ ] Subtask 2 pending

```

## 🔄 UPDATE PROCEDURE

1. Update tasks.md at EVERY workflow transition
2. Record complexity level and mode changes
3. Track all subtasks with completion status
4. Maintain single source of truth
```

#### 3. Adaptive Complexity Rule (020-adaptive-complexity.mdc)

```markdown
---
description:
  WHEN determining task complexity ENSURE selecting appropriate workflow level
globs:
alwaysApply: true
---

> **TL;DR:** Match workflow complexity to task requirements by assessing scope,
> risk, dependencies, and technical difficulty. Apply the appropriate process
> rigor for each level.

# Adaptive Complexity System

## 🔍 COMPLEXITY ASSESSMENT CRITERIA

Assess each task against these criteria:

| Factor               | Level 1      | Level 2        | Level 3             | Level 4     |
| -------------------- | ------------ | -------------- | ------------------- | ----------- |
| Scope                | Isolated fix | Single feature | Multiple components | System-wide |
| Risk                 | Low          | Medium         | High                | Critical    |
| Dependencies         | Few/None     | Some           | Many                | Extensive   |
| Technical Difficulty | Simple       | Moderate       | Complex             | Advanced    |

## 📊 WORKFLOW SCALING

Scale process rigor based on complexity level:

- **Level 1**: Streamlined 3-step process, 2-3 task updates
- **Level 2**: Basic 6-step process, 4-6 task updates
- **Level 3**: Standard process with creative phase, 8-12 updates
- **Level 4**: Comprehensive process with multiple creative phases, 15+ updates
```

#### 4. Workflow Mode Rule (030-workflow-modes.mdc)

```markdown
---
description:
  WHEN switching workflow mode ENSURE following appropriate mental model
globs:
alwaysApply: true
---

> **TL;DR:** Switch between Plan mode (for strategic thinking) and Act mode (for
> implementation) based on current needs. Each mode uses a different approach to
> problem-solving.

# Workflow Modes

## 🔄 MODE CHARACTERISTICS

Two primary workflow modes are supported:

### Plan Mode

- Focus on strategic thinking and preparation
- Explore multiple approaches before suggesting solutions
- Ask thorough questions to understand requirements
- Create comprehensive implementation plans

### Act Mode

- Focus on efficient implementation and execution
- Apply established patterns and best practices
- Make more concise suggestions
- Prioritize completing tasks over exploring alternatives

## 📋 MODE SWITCHING COMMANDS

Recognize these mode switching commands:

- "switch to plan mode"
- "enter plan mode"
- "switch to act mode"
- "enter act mode"

When switching modes:

1. Update activeContext.md with the new mode
2. Adjust working approach accordingly
3. Update tasks.md with new mode
```

#### 5. Creative Phase Rule (040-creative-phase.mdc)

```markdown
---
description:
  WHEN designing solutions for Level 3-4 tasks ENSURE using proper creative
  phase
globs:
alwaysApply: true
---

> **TL;DR:** For complex tasks, a dedicated creative phase is MANDATORY. Follow
> the structured framework to explore options, evaluate alternatives, and
> document decisions before implementation.

# Creative Phase Framework

## 🎨 CREATIVE PHASE FORMAT
```

🎨🎨🎨 ENTERING CREATIVE PHASE: [DESIGN/ALGORITHM/ARCHITECTURE] 🎨🎨🎨

FOCUS: [Brief description of design challenge] OBJECTIVE: [What needs to be
accomplished]

## Problem Breakdown

- [Component 1]
- [Component 2]
- [Component 3]

## Options Analysis

| Option   | Pros | Cons | Complexity | Performance |
| -------- | ---- | ---- | ---------- | ----------- |
| Option 1 | ...  | ...  | ...        | ...         |
| Option 2 | ...  | ...  | ...        | ...         |
| Option 3 | ...  | ...  | ...        | ...         |

## Decision

[Selected approach with rationale]

## Implementation Plan

1. [Step 1]
2. [Step 2]
3. [Step 3]

🎨 CREATIVE CHECKPOINT:

- Meets all requirements? [YES/NO]
- Considered at least 3 alternatives? [YES/NO]
- Evaluated performance implications? [YES/NO]
- Created implementation plan? [YES/NO]

🎨🎨🎨 EXITING CREATIVE PHASE - RETURNING TO TASK TRACKING 🎨🎨🎨

```

## 🔍 QUALITY METRICS

Creative phases must meet these minimum quality thresholds:
- At least 3 options fully evaluated
- Decision criteria explicitly stated
- Trade-offs clearly articulated
- Implementation plan with concrete steps
```

## Enhanced Creative Phase Framework

The Creative Phase Framework has been significantly enhanced based on the latest
best practices for LLM-assisted development. This framework provides a
structured approach to complex design decisions, ensuring thorough exploration
of options before implementation begins.

### Creative Phase Types

The system supports different types of creative phases for various design
challenges:

1. **Architecture Design** - For system-level architecture decisions
2. **Component Design** - For designing individual components or modules
3. **Algorithm Design** - For developing or selecting algorithms
4. **Data Model Design** - For database schema or data structure design
5. **UI/UX Design** - For user interface and experience decisions

### Structured Design Thinking Process

Each creative phase follows a systematic approach:

```markdown
🎨🎨🎨 ENTERING CREATIVE PHASE: [PHASE TYPE] 🎨🎨🎨

FOCUS: [Specific design challenge] OBJECTIVE: [Clear design goal]

## 1. Problem Analysis

- Current state: [Description of existing system/situation]
- Limitations: [What's not working or needs improvement]
- Requirements: [Specific needs that must be satisfied]
- Constraints: [Technical, business, or other limitations]

## 2. Options Exploration

| Option   | Description            | Pros       | Cons        |
| -------- | ---------------------- | ---------- | ----------- |
| Option 1 | [Detailed description] | [Benefits] | [Drawbacks] |
| Option 2 | [Detailed description] | [Benefits] | [Drawbacks] |
| Option 3 | [Detailed description] | [Benefits] | [Drawbacks] |

## 3. Evaluation Matrix

| Criteria (Weight)     | Option 1 | Option 2 | Option 3 |
| --------------------- | -------- | -------- | -------- |
| Performance (30%)     | Score/30 | Score/30 | Score/30 |
| Maintainability (25%) | Score/25 | Score/25 | Score/25 |
| Scalability (20%)     | Score/20 | Score/20 | Score/20 |
| Complexity (15%)      | Score/15 | Score/15 | Score/15 |
| Cost (10%)            | Score/10 | Score/10 | Score/10 |
| **TOTAL**             | **Sum**  | **Sum**  | **Sum**  |

## 4. Decision

Selected approach: [Option X] Rationale: [Detailed explanation of why this
option was selected]

## 5. Implementation Plan

1. [Step 1 with details]
2. [Step 2 with details]
3. [Step 3 with details]

## 6. Validation Strategy

- [Method 1 to validate the design]
- [Method 2 to validate the design]

🎨 QUALITY VERIFICATION:

- Explored at least 3 options? [YES/NO]
- Evaluated with weighted criteria? [YES/NO]
- Addressed all requirements? [YES/NO]
- Created detailed implementation plan? [YES/NO]
- Defined validation strategy? [YES/NO]

🎨🎨🎨 EXITING CREATIVE PHASE - RETURNING TO TASK TRACKING 🎨🎨🎨
```

### Creative Phase Integration

Creative phases are mandatory for Level 3-4 tasks and are integrated into the
workflow process:

```
INITIALIZATION → DOCUMENTATION → PLANNING → CREATIVE PHASE → IMPLEMENTATION
```

The creative phase serves as a hard gateway - implementation cannot begin until
a properly documented creative phase with quality verification has been
completed.

### Enhanced Decision Quality

The updated framework includes several improvements for decision quality:

1. **Weighted Decision Matrix** - Formalized approach to evaluating options
2. **Explicit Rationale** - Clear documentation of decision reasoning
3. **Implementation Planning** - Concrete steps for executing the design
4. **Validation Strategy** - Methods to verify the design meets requirements
5. **Quality Thresholds** - Minimum requirements for design thoroughness

## Memory Bank File Structure

The system now uses an optimized file structure based on cognitive memory types:

```
memory-bank/
├── Core Files/
│   ├── projectbrief.md       # Foundation document defining requirements
│   ├── productContext.md     # Business logic and user experience goals
│   ├── activeContext.md      # Current work focus and workflow mode
│   ├── systemPatterns.md     # Technical architecture and patterns
│   ├── techContext.md        # Technology stack and development setup
│   ├── progress.md           # Project status and roadmap
│   └── tasks.md              # Single source of truth for task tracking
│
├── Long-Term Memory/
│   ├── Episodic/             # Records of experiences and events
│   │   ├── milestones/       # Project milestones
│   │   └── sessions/         # Session summaries
│   │
│   ├── Semantic/             # Knowledge about the project and domain
│   │   ├── domain/           # Domain concepts
│   │   ├── apis/             # API documentation
│   │   └── features/         # Feature specifications
│   │
│   └── Procedural/           # Knowledge about how to perform actions
│       ├── workflows/        # Development processes
│       ├── guides/           # How-to guides
│       └── checklists/       # Operational procedures
│
└── Creative/                 # Storage for creative phase outputs
    ├── architecture/         # System architecture designs
    ├── components/           # Component designs
    ├── algorithms/           # Algorithm designs
    └── data-models/          # Data structure designs
```

## Rule Organization and Optimization

The Memory Bank System now uses an optimized rule organization based on the
latest Cursor Rules best practices, with three key optimizations:

### 1. Rule Categorization

Rules are organized into clearly defined categories with numeric prefixes:

```
.cursor/rules/
├── Core/
│   ├── 000-memory-bank-core.mdc
│   ├── 010-task-tracking.mdc
│   ├── 020-adaptive-complexity.mdc
│   ├── 030-workflow-modes.mdc
│   └── 040-creative-phase.mdc
│
├── Languages/
│   ├── 1000-javascript.mdc
│   ├── 1100-typescript.mdc
│   └── 1200-python.mdc
│
├── Frameworks/
│   ├── 2000-react.mdc
│   ├── 2100-vue.mdc
│   └── 2200-django.mdc
│
└── Extended Details/
    ├── creative-phase-examples.mdc
    ├── workflow-examples.mdc
    └── command-examples.mdc
```

### 2. Context Window Optimization

Rules are optimized for the LLM's context window with these techniques:

1. **TL;DR Summaries** - Essential information at the top of each rule
2. **Visual Hierarchy** - Consistent emoji markers and formatting
3. **Progressive Disclosure** - Most important content first
4. **Reference System** - Detailed information in separate files

### 3. Rule Application Patterns

The three-tier rule application system ensures efficient context usage:

1. **Always-Applied Rules** - Critical rules applied to every interaction
2. **Auto-Attached Rules** - Applied when matching file patterns
3. **Agent-Requested Rules** - Explicitly consulted for detailed information

## Command System

The updated Memory Bank System uses a streamlined command system for user
interaction:

### VAN Command

The primary entry point is the "VAN" command:

```
User: VAN I need to create a new API endpoint for user authentication

AI: OK VAN

I'll check for the critical files:

## FILE VERIFICATION
[X] .cursorrules - exists
[X] memory-bank directory - exists
[X] docs/archive directory - exists

## COMPLEXITY ASSESSMENT
Task: Create API endpoint for user authentication
Scope: Focused (single endpoint)
Risk: Medium (security implications)
Dependencies: Some (auth system, database)
Technical Difficulty: Moderate

→ COMPLEXITY LEVEL: 2
→ WORKFLOW MODE: Current mode is PLAN

I'll begin by reviewing the Memory Bank files to understand our current architecture...
```

### Mode Switching Commands

Switch between workflow modes:

- `switch to plan mode` - Enter strategic planning mode
- `switch to act mode` - Enter implementation mode

### Memory Management Commands

Commands for memory bank management:

- `initialize memory bank` - Create initial memory bank structure
- `update memory bank` - Update memory files based on recent changes
- `check memory bank` - Verify memory bank integrity
- `show active rules` - Display currently active rules

### Task Complexity Commands

Set or change task complexity:

- `set complexity 1` - Simple bug fix
- `set complexity 2` - Basic enhancement
- `set complexity 3` - Intermediate feature (requires creative phase)
- `set complexity 4` - Complex system (requires multiple creative phases)

## Project Intelligence Capture

One of the key enhancements is improved project intelligence capture. The system
now maintains a `projectRules.md` file that captures learned patterns, user
preferences, and effective approaches discovered during development.

### Project Rules Structure

```markdown
# Project Rules and Learned Patterns

## Coding Patterns

- [Pattern 1]: [Description and context]
- [Pattern 2]: [Description and context]

## User Preferences

- [Preference 1]: [Description]
- [Preference 2]: [Description]

## Implementation Approaches

- [Task type 1]: [Preferred approach]
- [Task type 2]: [Preferred approach]

## Known Challenges

- [Challenge 1]: [Solution approach]
- [Challenge 2]: [Solution approach]
```

### Autonomous Intelligence Capture

The system now proactively identifies and suggests capturing important patterns:

```markdown
I've noticed a pattern in how you structure API endpoints. Would you like me to
add this to the projectRules.md file? This would help ensure consistent
implementation in future endpoints.

Pattern: REST API Endpoint Structure

- Controllers use class-based views
- Authentication handled via middleware
- Response format follows {status, data, message} structure
- Error handling uses custom exception classes
```

## Integration Insights

The updated system incorporates several integration improvements:

### Platform Awareness

Commands and operations automatically adapt to the user's operating system:

**Windows Command Format:**

```bash
echo. > .cursorrules
mkdir memory-bank
```

**Mac/Linux Command Format:**

```bash
touch .cursorrules
mkdir -p memory-bank
```

### Documentation Integration

The system now better integrates with standard documentation practices:

- Automatic README.md generation and updates
- JSDoc/docstring compliance for code documentation
- Changelog maintenance
- API documentation generation

### Build System Integration

For advanced projects, the Memory Bank can integrate with build systems:

```json
{
  "scripts": {
    "memory:init": "node .cursor/tools/memory-init.js",
    "memory:update": "node .cursor/tools/memory-update.js",
    "memory:verify": "node .cursor/tools/memory-verify.js"
  }
}
```

## Implementation Guide

Follow these steps to implement the updated Memory Bank System:

### 1. Directory Structure Setup

```bash
# Create basic directory structure
mkdir -p .cursor/rules/Core
mkdir -p .cursor/rules/Languages
mkdir -p .cursor/rules/Frameworks
mkdir -p .cursor/rules/Extended\ Details

# Create memory bank structure
mkdir -p memory-bank/Core\ Files
mkdir -p memory-bank/Long-Term\ Memory/Episodic/milestones
mkdir -p memory-bank/Long-Term\ Memory/Episodic/sessions
mkdir -p memory-bank/Long-Term\ Memory/Semantic/domain
mkdir -p memory-bank/Long-Term\ Memory/Semantic/apis
mkdir -p memory-bank/Long-Term\ Memory/Semantic/features
mkdir -p memory-bank/Long-Term\ Memory/Procedural/workflows
mkdir -p memory-bank/Long-Term\ Memory/Procedural/guides
mkdir -p memory-bank/Long-Term\ Memory/Procedural/checklists
mkdir -p memory-bank/Creative/architecture
mkdir -p memory-bank/Creative/components
mkdir -p memory-bank/Creative/algorithms
mkdir -p memory-bank/Creative/data-models
mkdir -p docs/archive
```

### 2. Core Rule Creation

Create the following rule files:

1. `.cursor/rules/Core/000-memory-bank-core.mdc`
2. `.cursor/rules/Core/010-task-tracking.mdc`
3. `.cursor/rules/Core/020-adaptive-complexity.mdc`
4. `.cursor/rules/Core/030-workflow-modes.mdc`
5. `.cursor/rules/Core/040-creative-phase.mdc`

### 3. Memory File Templates

Create template files for the memory bank:

1. `memory-bank/Core Files/projectbrief.md`
2. `memory-bank/Core Files/productContext.md`
3. `memory-bank/Core Files/activeContext.md`
4. `memory-bank/Core Files/systemPatterns.md`
5. `memory-bank/Core Files/techContext.md`
6. `memory-bank/Core Files/progress.md`
7. `memory-bank/Core Files/tasks.md`
8. `memory-bank/Core Files/projectRules.md`

### 4. Task Archive Setup

Create the task archive file:

```bash
touch docs/archive/completed_tasks.md
```

### 5. Initialization

After setting up the directory structure and files, use the VAN command to
initialize the system:

```
User: VAN initialize memory bank
```

---

This guide updates the Vanzan Memory Bank System with the latest cursor rules
best practices, incorporating enhanced rule structure, workflow management,
creative phase frameworks, and context window optimization techniques. The
result is a more robust, efficient, and powerful persistent memory system for
your AI assistant.

In the next guide, we'll integrate these updates with the
CursorMemoryBank-ImplementationGuide.md to create an even more comprehensive
system.
