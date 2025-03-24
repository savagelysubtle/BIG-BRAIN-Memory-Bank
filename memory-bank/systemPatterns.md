---
title: System Patterns
---

# System Patterns

This document outlines the key architectural patterns, design decisions, and
component relationships that define the BIG BRAIN Memory Bank system.

## Documentation Structure Patterns

### Hierarchical Organization

The Memory Bank documentation follows a clear hierarchical structure:

- Core Memory Bank files provide the foundation (projectbrief.md,
  productContext.md, etc.)
- Specialized documentation builds upon this foundation
- Navigation is organized by topic area with logical parent-child relationships
- Cross-referencing connects related information across the hierarchy

### Progressive Detail Pattern

Documentation follows a pattern of progressive detail disclosure:

- High-level overviews first
- Conceptual understanding before implementation details
- Logical flow from general to specific
- Common elements before exceptions and edge cases

## Version Control Patterns

### Dual-Branch Development Pattern

The repository follows a dual-branch pattern for development:

- Main branch: Stable, production-ready version for new users
- Development branch: Current work with latest improvements
- Feature branches as needed for specific tasks
- Controlled merges maintain stability of main branch

### Branch-Specific Content Pattern

Some content is intentionally kept in only one branch:

- The inspiration folder exists only in the main branch
- Development branch excludes this folder via .gitignore
- Specialized scripts maintain this separation
- Merge operations preserve the separation through automation

#### Implementation Mechanism

The branch-specific content pattern is implemented using:

1. **Branch-Specific Configuration**: .gitignore entries specific to the
   development branch
2. **Preservative Merge Process**: Two-step merge that preserves protected
   content
3. **Automated Protection**: Scripts that ensure consistent application of the
   pattern
4. **Clear Documentation**: Explicit documentation of what content is
   branch-specific

#### Benefits of Branch-Specific Content

This pattern provides several advantages:

- Keeps reference content available in the stable branch
- Maintains a clean, focused environment for development
- Prevents accidental deletion of important materials
- Allows tailoring of content to different usage scenarios

## Workflow Patterns

### Cycle-Based Workflow Pattern

The core operational model follows a cyclical pattern:

1. **Memory Reset Handling** → Recover context
2. **Planning Mode** → Analyze and design
3. **Action Mode** → Implement and verify
4. **Documentation Updates** → Record and preserve
5. Back to **Memory Reset Handling** for the next session

This cycle ensures continuous progress while maintaining comprehensive knowledge
preservation.

### Phase-Based Process Structure

Each workflow is structured into clear phases:

- Initial phases focus on understanding and preparation
- Middle phases concentrate on execution and verification
- Final phases emphasize documentation and transition

This consistent phase structure creates predictability and completeness across
workflows.

### Input-Process-Output Pattern

Workflows follow a consistent Input-Process-Output pattern:

- **Inputs**: Requirements, existing documentation, code, contextual information
- **Process**: Structured sequence of steps with decision points
- **Outputs**: Tangible artifacts, documentation updates, and transition
  guidance

### Documentation-as-Code Pattern

The Memory Bank treats documentation with the same rigor as code:

- Version-controlled documentation
- Structured review processes
- Consistent formatting and organization
- Explicit linking between related elements

## Knowledge Preservation Patterns

### Single Source of Truth

The Memory Bank serves as the definitive reference for all project knowledge:

- Core files contain fundamental information
- Specialized documentation elaborates on specific areas
- All decisions and context are recorded
- External information is internalized

### Context Layering

Information is organized in layers of context:

- Project goals and vision (outer layer)
- System architecture and patterns (middle layer)
- Implementation details and decisions (inner layer)

### Active-Historical Balance

The Memory Bank balances current state with historical context:

- ActiveContext.md focuses on present status
- Progress.md tracks changes over time
- Historical decisions are preserved with rationales
- Current priorities are clearly distinguished from completed work

## Interaction Patterns

### Workflow Transition Points

Clear transition points are defined between workflows:

- Completion criteria for each workflow
- Explicit handoff information for the next workflow
- Decision frameworks for selecting the appropriate next workflow
- Verification steps before transitions

### Progressive Refinement

Complex tasks follow a pattern of progressive refinement:

- Begin with broad understanding (Planning Mode)
- Refine into specific implementation steps (Action Mode)
- Crystallize into documented knowledge (Documentation Updates)
- Reestablish context after resets (Memory Reset Handling)

## Automation Patterns

### Self-Documenting Scripts

Scripts are designed to be self-documenting:

- Clear descriptive output of operations
- Explicit naming that indicates purpose
- Error messages that explain problems and solutions
- Comments that clarify complex operations

### Script Automation Levels

Scripts follow a pattern of increasing automation:

- Level 1: Guided operation with user confirmation
- Level 2: Single-command operation with minimal input
- Level 3: Fully automated operation with intelligent defaults
- Level 4: Scheduled or triggered operation without manual intervention

### Recovery-Oriented Operations

Scripts are designed with recovery in mind:

- State checking before operations
- Automatic handling of common edge cases
- Clean rollback when operations fail
- Return to original state when appropriate

These patterns provide the structural framework that enables the Memory Bank
system to function effectively across memory resets, maintaining consistency,
completeness, and clarity throughout the development process.
