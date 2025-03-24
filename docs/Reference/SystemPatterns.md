# System Patterns

## Overview

This document provides detailed information about the key architectural and
design patterns used in the BIG BRAIN Memory Bank 2.0 system. It serves as a
reference for understanding the standard patterns, their applications, and how
they ensure system integrity and consistency. This document complements the
Architecture Overview and Components documentation by focusing specifically on
repeatable patterns.

## Memory Patterns

### Memory File Structure Pattern

**Purpose:** Standardizes the organization and content of memory files for
consistency and discoverability.

**Pattern:**

```
# [File Title]

## [Section 1]
[Content following consistent format]

## [Section 2]
[Content following consistent format]

...

## Version Information
- Last Updated: [Date]
- Compatible with [Version]
- Changelog: [Changes]
```

**Applications:**

- All core memory files
- Documentation files
- Reference materials

**Benefits:**

- Consistent organization for easier navigation
- Standardized structure for automated processing
- Clear versioning for change tracking
- Supports verification and validation

### Progressive Disclosure Pattern

**Purpose:** Organizes information from most important to least important to
optimize information retrieval.

**Pattern:**

1. Start with concise summary (TL;DR)
2. Provide essential context and purpose
3. Present core information in priority order
4. Follow with supporting details
5. End with reference information and metadata

**Applications:**

- Memory file organization
- Command responses
- Documentation structure
- Error messages and reports

**Benefits:**

- Focuses attention on most critical information
- Enables quick comprehension of essentials
- Allows drilling down for additional detail
- Adapts information delivery to task needs

### Cross-Reference Pattern

**Purpose:** Maintains relationships between related information across
different files.

**Pattern:**

```
See [Document Name](../path/to/document.md) for [specific information]
```

**Applications:**

- Linking related documentation
- Connecting memory files
- Establishing dependencies
- Providing navigation paths

**Benefits:**

- Prevents information duplication
- Makes relationships explicit
- Supports navigation between related content
- Enables verification of reference integrity

## Command Patterns

### Command Syntax Pattern

**Purpose:** Provides consistent structure for all system commands.

**Pattern:**

```
COMMAND_NAME [PARAMETER1] [PARAMETER2] [--option1=value] [--option2]
```

**Applications:**

- All system commands
- Command documentation
- Command processing
- Command generation

**Benefits:**

- Consistent user interface
- Predictable behavior
- Easier command learning
- Simplified command processing

### Command Response Pattern

**Purpose:** Standardizes command execution responses.

**Pattern:**

```
[Status Indicator] [Command Echo]
[Primary Result]
[Additional Information]
[Next Steps or Recommendations]
```

**Applications:**

- All command outputs
- Verification responses
- Status reports
- Error messages

**Benefits:**

- Clear indication of command success/failure
- Consistent presentation of results
- Actionable next steps
- Standardized format for parsing

### Operation Verification Pattern

**Purpose:** Validates operations before and after execution.

**Pattern:**

1. Pre-operation validation
2. Execution with monitoring
3. Post-operation verification
4. Result reporting with confirmation
5. Error handling if needed

**Applications:**

- Critical system operations
- Memory bank updates
- State transitions
- Configuration changes

**Benefits:**

- Prevents invalid operations
- Confirms successful execution
- Provides verification evidence
- Supports recovery from failures

## Workflow Patterns

### Task Classification Pattern

**Purpose:** Categorizes tasks to determine appropriate handling.

**Pattern:**

1. Evaluate task type (design, implementation, verification)
2. Assess complexity (1-4 scale)
3. Identify special requirements or constraints
4. Determine appropriate workflow and resources
5. Set verification requirements

**Applications:**

- Task initialization
- Resource allocation
- Workflow selection
- Verification planning

**Benefits:**

- Appropriate resource allocation
- Consistent task handling
- Proper verification rigor
- Optimized process selection

### Phased Execution Pattern

**Purpose:** Breaks complex tasks into standardized phases.

**Pattern:**

1. Initialization Phase
2. Planning Phase
3. Execution Phase
4. Verification Phase
5. Documentation Phase
6. Transition Phase

**Applications:**

- All workflow types
- Complex operations
- Multi-step processes
- Session management

**Benefits:**

- Consistent process execution
- Clear checkpoints between phases
- Standardized documentation
- Simplified tracking and reporting

### Checkpoint Pattern

**Purpose:** Defines clear criteria for completion verification.

**Pattern:**

```
## Checkpoint: [Name]

**Verification Criteria:**
- [Criterion 1]
- [Criterion 2]
...

**Validation Steps:**
1. [Step 1]
2. [Step 2]
...

**Evidence Required:**
- [Evidence 1]
- [Evidence 2]
...
```

**Applications:**

- Section completion verification
- Quality validation
- Progress tracking
- Release criteria

**Benefits:**

- Clear completion criteria
- Standardized verification approach
- Objective assessment
- Documented evidence

## Verification Patterns

### Multi-Level Verification Pattern

**Purpose:** Provides graduated verification depth based on complexity and
importance.

**Pattern:**

1. Level 1: Basic existence and format check
2. Level 2: Structure and cross-reference validation
3. Level 3: Content integrity and consistency verification
4. Level 4: Comprehensive analysis and deep validation

**Applications:**

- Memory file verification
- Rule compliance checking
- Documentation validation
- System integrity verification

**Benefits:**

- Appropriate verification depth
- Resource optimization
- Risk-based verification approach
- Adaptable to different needs

### Error Recovery Pattern

**Purpose:** Provides structured approach to handling verification failures.

**Pattern:**

1. Detect and classify error
2. Determine recovery options
3. Select appropriate strategy:
   - Automatic correction for simple issues
   - Guided intervention for complex issues
   - Fallback options for critical failures
4. Implement recovery actions
5. Verify successful resolution
6. Document incident and solution

**Applications:**

- Memory file issues
- Rule conflicts
- Command failures
- Inconsistency detection

**Benefits:**

- Consistent error handling
- Clear resolution paths
- Documented recovery procedures
- Problem-appropriate strategies

### Validation Reporting Pattern

**Purpose:** Standardizes the reporting of verification results.

**Pattern:**

```
## Validation Report: [Subject]

**Status:** [PASSED/WARNING/FAILED]

**Issues Found:**
- [Issue 1]: [Description]
- [Issue 2]: [Description]
...

**Recommendations:**
- [Recommendation 1]
- [Recommendation 2]
...
```

**Applications:**

- System health checks
- Memory bank verification
- Rule system diagnostics
- Quality assessments

**Benefits:**

- Clear status indication
- Structured issue reporting
- Actionable recommendations
- Consistent format for processing

## Integration Patterns

### Component Interface Pattern

**Purpose:** Defines standardized interfaces between system components.

**Pattern:**

```
## Interface: [Name]

**Provided Operations:**
- [Operation 1]: [Description]
- [Operation 2]: [Description]
...

**Required Operations:**
- [Operation 1]: [Description]
- [Operation 2]: [Description]
...

**Data Exchange Format:**
[Format specification]
```

**Applications:**

- Component integration
- System extension
- Third-party integration
- Component replacement

**Benefits:**

- Clear component boundaries
- Standardized integration points
- Simplified component replacement
- Reduced coupling

### State Transition Pattern

**Purpose:** Manages system state changes in a controlled manner.

**Pattern:**

1. State capture (before transition)
2. Transition preparation
3. Execution of state change
4. State verification (after transition)
5. Transition completion confirmation
6. Rollback procedures (if needed)

**Applications:**

- Session transitions
- Mode changes
- Workflow phase transitions
- System initialization/termination

**Benefits:**

- Controlled state changes
- Verification at transition points
- Rollback capability
- Clear transition boundaries

### Protocol Adaptation Pattern

**Purpose:** Adjusts protocol rigor based on task complexity and importance.

**Pattern:**

1. Determine task complexity (1-4)
2. Identify critical requirements
3. Select appropriate protocol variant
4. Apply protocol with adapted:
   - Verification depth
   - Documentation detail
   - Process rigor
   - Resource allocation

**Applications:**

- Protocol enforcement
- Verification procedures
- Documentation requirements
- Workflow execution

**Benefits:**

- Appropriate protocol rigor
- Resource optimization
- Risk-based approach
- Consistent yet flexible protocols

## Related Information

- [Architecture Overview](../Architecture/Overview.md) - High-level system
  architecture
- [Architecture Components](../Architecture/Components.md) - Detailed component
  information
- [Commands Guide](../Guides/Commands.md) - Command reference and usage

## Version Information

- Last Updated: March 24, 2025
- Compatible with BIG BRAIN Memory Bank 2.0
- Changelog: Initial documentation for version 2.0
