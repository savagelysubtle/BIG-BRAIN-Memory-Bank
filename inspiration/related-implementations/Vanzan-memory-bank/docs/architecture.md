# Cursor Memory Bank System: Complete Architecture

## System Overview

The Memory Bank System is a comprehensive documentation-driven approach for AI
assistants that simulates persistent memory across sessions. It addresses the
fundamental limitation of LLMs forgetting context between interactions by
creating a robust, structured documentation system that serves as the AI's
"memory."

This architecture document provides a complete reference for implementing and
maintaining the Memory Bank System, optimized for LLM processing efficiency
while ensuring comprehensive documentation.

## Core Design Principles

1. **Documentation as Memory**: Documentation serves as mission-critical
   infrastructure
2. **Strategic Content Organization**: Balance between cohesive main files and
   extracted details
3. **Mandatory Verification Steps**: Explicit section checkpoints prevent steps
   from being skipped
4. **Single Source of Truth**: tasks.md as the authoritative source for task
   status tracking
5. **Platform Awareness**: Commands adapted for specific operating systems
6. **Real-Time Documentation**: Implementation details continuously added to
   activeContext.md
7. **Creative Phase Enforcement**: Hard gateways ensure proper design thinking
   for complex tasks
8. **Objective Quality Metrics**: Structured evaluation frameworks for decision
   quality

## Rule Types & Application Patterns

The system utilizes three distinct rule types, each with specific application
patterns:

### 1. Always-Applied Rules

```markdown
---
description:
globs:
alwaysApply: true
---
```

- Applied to every command regardless of context
- Used for critical rules that must be followed in all situations
- Kept concise to minimize context window usage
- Examples: main.mdc, verification-checklist.mdc
-

### 2. Auto-Attached Rules

```markdown
---
description:
globs: "**/memory-bank/**", "**/.cursorrules"
alwaysApply: false
---
```

- Automatically applied when working with matching file patterns
- Used for context-specific rules that only apply in certain situations
- Can be more detailed since they're only loaded when relevant
- Examples: memory-bank.mdc, task-tracking.mdc

### 3. Agent-Requested Rules

```markdown
---
description: CRITICAL: Contains mandatory examples for correct workflow implementation. DO NOT assume patterns without consulting this documentation.
globs: "**/src/**"
alwaysApply: false
---
```

- Agent explicitly instructed to read these files before proceeding
- Used for detailed examples, extended explanations, and verbose content
- Helps manage context window by moving details out of main files
- Examples: workflow-examples.mdc, command-examples.mdc,
  creative-phase-examples.mdc

## Complete File Structure

### Global Rules File (Cursor Settings > General > Rules for AI)

```markdown
# Cursor's Memory-Based Assistant

I am an AI with memory that resets between sessions. I use a structured Memory
Bank system to maintain context across sessions. For any task, I follow a 6-step
workflow and execute commands one at a time.

## 🚨 CRITICAL FIRST STEPS

1. Identify current operating system
2. Ensure `.cursorrules` file exists
3. Ensure `memory-bank/` directory with required files exists
4. Ensure `docs/archive/` directory with `completed_tasks.md` exists

## 📚 MEMORY BANK OVERVIEW

I maintain these core files:

- `projectbrief.md` - Foundation defining requirements and goals
- `productContext.md` - Why this project exists and problems it solves
- `activeContext.md` - Current work focus and recent changes
- `systemPatterns.md` - System architecture and key technical decisions
- `techContext.md` - Technologies used and development setup
- `progress.md` - What works, what's left, and implementation details
- `tasks.md` - SINGLE SOURCE OF TRUTH for all task tracking

## 🔄 STRUCTURED WORKFLOW

I follow these steps in exact order:

1. **INITIALIZATION** - Review Memory Bank, state task objective, identify
   platform
2. **DOCUMENTATION SETUP** - Update Memory Bank files
3. **TASK PLANNING** - Create step-by-step plan in tasks.md with [ ] markers
4. **CREATIVE PHASES** - For Level 3-4 tasks, complete all creative phases
   before implementation
5. **IMPLEMENTATION** - Execute commands one at a time, update task status in
   tasks.md
6. **REFLECTION** - Document learnings with 4 specific subsections
7. **ARCHIVING** - Archive tasks in docs/archive/completed_tasks.md

## ⚡ CORE PRINCIPLES

1. **Documentation First** - Memory Bank maintenance is my primary
   responsibility
2. **Safe Command Execution** - I run commands ONE AT A TIME, never chained
3. **Single Source of Truth** - tasks.md is the ONLY place to track task status
4. **Real-Time Documentation** - I add updates to activeContext.md during
   implementation
5. **Section Checkpoints** - I verify all requirements before moving to next
   section
6. **Creative Phase Enforcement** - Level 3-4 tasks REQUIRE creative phases
   before implementation
7. **VAN Protocol** - When you say "VAN", I respond with "OK VAN" and verify
   critical files
```

### Project Directory Structure

```
.cursor/
└── rules/
    ├── main.mdc                      # Master control file with references
    ├── system-overview.mdc           # High-level system overview
    │
    ├── Core Implementation/
    │   ├── archive.mdc               # Task archiving protocol
    │   ├── command-execution.mdc     # Command execution protocol
    │   ├── context-minimal-mode.mdc  # Context window optimization
    │   ├── creative-phase-enforcement.mdc  # Hard enforcement mechanisms
    │   ├── creative-phase-guidelines.mdc   # Creative phase requirements
    │   ├── creative-phase-metrics.mdc      # Quality metrics framework
    │   ├── creative-phase-triggers.mdc     # When to enter creative phases
    │   ├── cross-linking.mdc         # Cross-linking requirements
    │   ├── memory-bank.mdc           # Memory bank structure
    │   ├── platform-awareness.mdc    # Platform-specific command adaptations
    │   ├── reference-triggers.mdc    # Enhanced reference trigger system
    │   ├── reflection-format.mdc     # Reflection requirements
    │   ├── section-checkpoint-system.mdc # Enhanced section verification
    │   ├── task-tracking.mdc         # Task status tracking protocol
    │   ├── van-protocol.mdc          # VAN protocol implementation
    │   ├── verification-checklist.mdc # Simplified task verification
    │   └── workflow.mdc              # Structured workflow protocol
    │
    ├── Extended Details/
    │   ├── archive-examples.mdc      # Archive formatting examples
    │   ├── command-examples.mdc      # Command documentation examples
    │   ├── creative-phase-examples.mdc # Creative phase examples
    │   ├── reflection-examples.mdc   # Reflection format examples
    │   └── workflow-examples.mdc     # Workflow implementation examples
    │
    └── Templates/
        ├── templates-core.mdc        # Essential templates
        └── templates-extended.mdc    # Additional specialized templates

Project Root:
├── memory-bank/                # Primary memory storage
│   ├── projectbrief.md         # Project requirements and goals
│   ├── productContext.md       # Why this project exists
│   ├── activeContext.md        # Current work focus
│   ├── systemPatterns.md       # Architecture patterns
│   ├── techContext.md          # Technologies used
│   ├── progress.md             # Implementation status
│   └── tasks.md                # SINGLE SOURCE OF TRUTH for task tracking
├── .cursorrules                # Project-specific patterns
└── docs/
    └── archive/
        └── completed_tasks.md  # Archived completed tasks
```

## Sample Core Files

### main.mdc

```markdown
# 🔍 CURSOR'S MEMORY-BASED ASSISTANT SYSTEM

> **TL;DR:** I am an AI with memory that resets between sessions. I use a
> structured Memory Bank to maintain context. For any task, I must (1) check for
> critical files, (2) follow the 6-step workflow, (3) execute commands one at a
> time, (4) consult reference files, (5) update documentation in real-time, and
> (6) utilize creative phases for complex tasks.

## 🚨 PLATFORM IDENTIFICATION - FIRST STEP

Before proceeding with any task, identify the operating system:
```

### Platform Detection

Current environment: [Windows/Mac/Linux] Command adaptations required: [Yes/No]

```

## 🚨 CRITICAL FILE VERIFICATION - SECOND STEP

Verify critical file types (NOT directories):
```

### File Type Verification

.cursorrules: [File exists/File missing/ERROR: Is a directory] memory-bank:
[Directory exists/Directory missing] docs/archive: [Directory exists/Directory
missing] tasks.md: [File exists/File missing]

Creating any missing files (NOT directories):

```bash
### Preferred Tool-Based Commands

Use these built-in tools instead of direct terminal commands:
- `list_dir` tool - For listing directory contents (instead of dir/ls)
- `edit_file` tool - For creating/editing files (instead of echo/touch)
- Use relative paths directly with tools (instead of cd commands)
- `run_terminal_cmd` - When terminal commands are necessary, execute ONE at a time

```

```

## 🚨 MISSION-CRITICAL ESSENTIALS

1. **Memory Bank Files** - Create/update these first:
   - `projectbrief.md` - Core requirements
   - `productContext.md` - Project purpose
   - `activeContext.md` - Current focus
   - `systemPatterns.md` - Architecture
   - `techContext.md` - Tech stack
   - `progress.md` - Status & reflections
   - `tasks.md` - SINGLE SOURCE OF TRUTH for all task tracking

2. **Required Workflow** - Follow these steps in order:
```

1️⃣ INITIALIZATION 2️⃣ DOCUMENTATION SETUP 3️⃣ TASK PLANNING 4️⃣ CREATIVE PHASES
(Level 3-4 tasks) 5️⃣ IMPLEMENTATION 6️⃣ REFLECTION 7️⃣ ARCHIVING

```

3. **Command Safety** - Execute commands ONE AT A TIME with platform awareness
4. **Reference Consulting** - Explicitly check reference files with standardized format
5. **Real-Time Updates** - Update implementation details in activeContext.md
6. **Creative Phase Enforcement** - Use structured creative phases for complex decisions

## ⚡ QUICK REFERENCES

| Critical Process | Reference Link | When to Consult |
|---|----|-----|
| Memory Structure | [memory-bank.mdc](mdc:.cursor/rules/Core%20Implementation/memory-bank.mdc) | Before updating any docs |
| Workflow Process | [workflow.mdc](mdc:.cursor/rules/Core%20Implementation/workflow.mdc) | When starting a task |
| Command Safety  | [command-execution.mdc](mdc:.cursor/rules/Core%20Implementation/command-execution.mdc) | Before running commands |
| Task Archiving | [archive.mdc](mdc:.cursor/rules/Core%20Implementation/archive.mdc) | When completing a task |
| Verification | [verification-checklist.mdc](mdc:.cursor/rules/Core%20Implementation/verification-checklist.mdc) | Before finishing any task |
| Task Tracking | [task-tracking.mdc](mdc:.cursor/rules/Core%20Implementation/task-tracking.mdc) | When updating task status |
| Reference Triggers | [reference-triggers.mdc](mdc:.cursor/rules/Core%20Implementation/reference-triggers.mdc) | When consulting examples |
| Creative Phases | [creative-phase-guidelines.mdc](mdc:.cursor/rules/Core%20Implementation/creative-phase-guidelines.mdc) | For complex design decisions |
| Creative Triggers | [creative-phase-triggers.mdc](mdc:.cursor/rules/Core%20Implementation/creative-phase-triggers.mdc) | When to enter creative phases |
| Creative Enforcement | [creative-phase-enforcement.mdc](mdc:.cursor/rules/Core%20Implementation/creative-phase-enforcement.mdc) | For enforcing creative phases |
```

### workflow.mdc

```markdown
# STRUCTURED WORKFLOW PROTOCOL

> **TL;DR:** Follow a 7-step workflow in exact sequence. ALWAYS update section
> tracking after completing each section. Update task status ONLY in tasks.md.
> Add implementation details to activeContext.md. For complex tasks (Level 3-4),
> complete creative phases before implementation.

## 🚨 SECTION TRANSITION MARKERS

These visual markers indicate workflow section transitions:
```

======== INITIALIZATION COMPLETE ⟹ STARTING DOCUMENTATION SETUP ========

======== DOCUMENTATION SETUP COMPLETE ⟹ STARTING TASK PLANNING ========

======== TASK PLANNING COMPLETE ⟹ STARTING CREATIVE PHASES ========

======== CREATIVE PHASES COMPLETE ⟹ STARTING IMPLEMENTATION ========

======== IMPLEMENTATION COMPLETE ⟹ STARTING REFLECTION ========

======== REFLECTION COMPLETE ⟹ STARTING ARCHIVING ========

======== ARCHIVING COMPLETE ⟹ TASK FINISHED ========

```

## 🗂️ WORKFLOW SECTIONS

These 7 sections must be completed in this exact order:

1. **INITIALIZATION** - Establish context, identify platform
2. **DOCUMENTATION SETUP** - Update Memory Bank
3. **TASK PLANNING** - Create step-by-step plan in tasks.md
4. **CREATIVE PHASES** - For Level 3-4 tasks, complete design thinking
5. **IMPLEMENTATION** - Execute commands
6. **REFLECTION** - Document learnings
7. **ARCHIVING** - Store completed work

## 📋 SECTION TRACKING TEMPLATE

Add this at the start of every task:
```

## Section Progress

[ ] 1. INITIALIZATION [ ] 2. DOCUMENTATION SETUP [ ] 3. TASK PLANNING [ ] 4.
CREATIVE PHASES (Level 3-4 tasks) [ ] 5. IMPLEMENTATION [ ] 6. REFLECTION [ ] 7.
ARCHIVING

```

```

### creative-phase-enforcement.mdc

```markdown
# CREATIVE PHASE ENFORCEMENT

> **TL;DR:** This establishes hard enforcement mechanisms to ensure creative
> phases are properly implemented for all Level 3-4 tasks and complex design
> decisions. It creates strict gateways that prevent implementation without
> documented creative phase completion.

## 🚨 CREATIVE PHASE GATEWAY SYSTEM

The Creative Phase Gateway prevents transition to implementation without proper
creative phase documentation:
```

⛔ CREATIVE PHASE GATEWAY CHECK

- Level 3-4 task identified? [YES/NO]
- Complex architecture/design decisions required? [YES/NO]
- Creative phases required: [YES/NO]

→ If [YES] to any: CREATIVE PHASES REQUIRED BEFORE IMPLEMENTATION → NO
IMPLEMENTATION PERMITTED until all required creative phases are completed

```

## 🚨 MANDATORY CREATIVE PHASE TRIGGERS

These specific scenarios REQUIRE documented creative phases before ANY implementation:

1. **Component Architecture Decisions**
   - Component boundaries and responsibilities
   - Component hierarchy and relationships
   - Rendering strategies
   - Composition patterns

2. **State Management Approaches**
   - State structure design
   - State update patterns
   - State distribution approaches
   - State persistence strategies

3. **Data Modeling Decisions**
   - Data structure design
   - Relationship modeling
   - Validation approaches
   - Transformation patterns

4. **UI/UX Design Approaches**
   - Layout strategies
   - Interaction patterns
   - Responsive design approaches
   - Accessibility implementations

5. **Algorithm/Logic Design**
   - Business logic implementation
   - Computation approaches
   - Optimization strategies
   - Edge case handling

## ✅ CREATIVE PHASE VERIFICATION CHECKLIST

Before exiting a creative phase, all items must be verified:

```

✅ CREATIVE PHASE VERIFICATION

- Clear problem statement? [YES/NO]
- Multiple options considered (min 2)? [YES/NO]
- Pros/cons documented for each option? [YES/NO]
- Systematic verification against requirements? [YES/NO]
- Decision rationale clearly stated? [YES/NO]
- Implementation guidance provided? [YES/NO]
- Full creative phase markers used? [YES/NO]

→ If ANY [NO]: Creative phase is INCOMPLETE and must be finished before
proceeding

```

```

### Enhanced Features

#### Creative Phase Format (Inspired by Anthropic's "Think Tool")

```markdown
🎨🎨🎨 ENTERING CREATIVE PHASE: [DESIGN/ALGORITHM/ARCHITECTURE] 🎨🎨🎨 Focus:
[Specific focus area] Objective: [What you aim to accomplish] Constraints: [Any
constraints to consider]

Breaking down the problem:

- [Component 1]
- [Component 2]
- [Component 3]

[Systematic analysis with options and trade-offs]

🎨 CREATIVE CHECKPOINT: [Verification against requirements]

🎨🎨🎨 EXITING CREATIVE PHASE - RETURNING TO TASK TRACKING 🎨🎨🎨

🔄 CREATIVE PHASE SUMMARY:

- Completed: [Brief description of creative work]
- Key decisions: [Important decisions made]
- Next steps: [Follow-up implementation tasks]
- Verification: [Confirmation solution meets requirements]
```

#### Section Checkpoint System

```markdown
✓ SECTION CHECKPOINT: [SECTION NAME]

- Requirement 1? [YES/NO]
- Requirement 2? [YES/NO]
- Requirement 3? [YES/NO]
- Section tracking updated to [X]? [YES/NO]

→ If all YES: Ready for next section → If any NO: Fix missing items before
proceeding
```

#### Reference Check Format

```markdown
📚 REFERENCE CHECK:

- CONSULTING: [file name]
- PURPOSE: [specific reason for consulting]
- CRITICAL ELEMENTS: [key items to look for]

Key insights:

- [Key insight 1]
- [Key insight 2]
- [Key insight 3]

✓ Reference consultation complete
```

#### Task Status Update Format

```markdown
🔄 TASK UPDATE: [Task/Subtask] - [X] Complete/[ ] Pending

- Updated in tasks.md ✓

🔄 IMPLEMENTATION UPDATE:

- Added to activeContext.md: [Brief implementation details]
```

## Implementation Strategy

For optimal implementation of the Memory Bank System:

1. **Start with Global Rules**: Set up the Global Rules file in Cursor Settings
   first
2. **Create Directory Structure**: Establish the .cursor/rules directory
   structure
3. **Implement Core Files**: Create the core implementation files
4. **Add Extended Details**: Create the extended detail files with examples
5. **Implement Memory Bank Template**: Set up the initial Memory Bank structure
6. **Create Reference Triggers**: Ensure all reference triggers are in place
7. **Implement Creative Phase System**: Set up the creative phase enforcement
   structure

## New Features and Enhancements

1. **Single Source of Truth**: tasks.md is now the only file for tracking task
   status
2. **Enhanced Section Checkpoints**: Clear visual markers and verification
   questions at section transitions
3. **VAN Protocol**: Quick initialization protocol triggered by user typing
   "VAN"
4. **Platform-Specific Command Adaptations**: Commands automatically adapted for
   Windows, Mac, or Linux
5. **Standardized Reference Checks**: Formal process for consulting
   documentation
6. **Real-Time Documentation Updates**: Continuous updates to activeContext.md
   during implementation
7. **Tool-Based Command Execution**: Preference for built-in tools over direct
   terminal commands
8. **Creative Phase Enforcement**: Hard gateways prevent implementation without
   creative phases
9. **Objective Quality Metrics**: Structured evaluation frameworks for decision
   quality

## Creative Phase System (Inspired by Anthropic's "Think Tool")

The system's enhanced creative phase approach draws inspiration from Anthropic's
"Think Tool" concept, which provides AI assistants with a dedicated space for
complex problem-solving outside of their normal operation flow. Similar to how
the Think Tool gives Claude a way to stop and reflect on complex problems, our
creative phase system:

1. **Creates Dedicated Thinking Space**: Clearly marked creative phases provide
   a dedicated space for systematic thinking
2. **Enforces Structured Problem-Solving**: Follows a consistent format for
   breaking down and analyzing problems
3. **Prevents Premature Implementation**: Hard gateways ensure thorough design
   thinking before coding begins
4. **Documents Decision Rationale**: Captures the reasoning behind architectural
   and design decisions
5. **Incorporates Objective Evaluation**: Uses metrics and verification to
   ensure solution quality

The creative phase system is automatically activated for Level 3-4 tasks but can
also be triggered for any complex design decision that meets the criteria in
creative-phase-triggers.mdc.

## Best Practices for System Maintenance

1. **Keep Core Files Concise**: Core files should be 200-300 lines maximum
2. **Move Examples to Extended Files**: Detailed examples belong in extended
   files
3. **Add Reference Triggers**: Always include reference triggers for detailed
   documentation
4. **Use Appropriate Rule Types**: Select the right rule type for each file's
   purpose
5. **Maintain Directory Structure**: Keep the established directory structure
6. **Document Reference Relationships**: Clearly indicate which files reference
   others
7. **Apply Creative Phases Consistently**: Ensure all complex decisions use
   proper creative phases

## Common Implementation Challenges

1. **Missing Section Headers**: Always use all seven mandatory section headers
   in exact order
2. **Incorrect Task Status Tracking**: Update task status only in tasks.md
   (Single Source of Truth)
3. **Skipped Verification**: Always run the verification checklist before
   completing any task
4. **Template Text Remnants**: Always remove template/placeholder text in
   archive files
5. **Command Chaining**: Always execute commands one at a time, never chained
6. **.cursorrules as Directory**: Creating .cursorrules as a directory instead
   of a file
7. **Skipped Creative Phases**: Implementing Level 3-4 tasks without required
   creative phases

## Conclusion

This enhanced Memory Bank System architecture optimizes for both LLM processing
efficiency and comprehensive documentation. The additions of platform awareness,
section checkpoints, standardized reference checks, and single source of truth
for task tracking significantly improve the system's robustness and usability.
The integration of enforced creative phases with objective quality metrics
ensures high-quality decision-making for complex tasks.

The system's effectiveness depends entirely on strict adherence to its
architectural principles and documentation protocols. When implemented
correctly, it allows an AI assistant to maintain context across sessions,
creating a truly persistent development partner that can adapt to any operating
system, maintain clear documentation through a structured workflow, and make
high-quality architectural and design decisions.
