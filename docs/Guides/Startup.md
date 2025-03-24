# Startup Guide

## Overview

This guide explains how to initialize and start using the BIG BRAIN Memory Bank
2.0 system. It covers the initialization process, memory loading procedures,
task contextualization, and how to begin working with the system effectively.
This guide assumes you have already completed the
[Installation Guide](./Installation.md) procedures.

## First-Time Initialization

When starting the BIG BRAIN Memory Bank for the first time:

1. Navigate to your project directory:

   ```bash
   cd /path/to/memory-bank
   ```

2. Run the initial setup procedure:

   ```bash
   python scripts/first_time_setup.py
   ```

3. When prompted, provide the following information:

   - Project name
   - Brief project description
   - Primary user roles
   - Initial complexity level (1-4)

4. The system will generate the initial memory bank files and configure the rule
   system.

## Standard Startup Procedure

For regular usage after initial setup:

1. **Memory Bank Loading**

   Begin each session by loading the memory bank:

   ```
   MEMORY BANK INITIALIZE
   ```

   This command triggers the initialization workflow, which:

   - Loads all core memory files
   - Verifies file integrity
   - Restores context from previous session
   - Confirms rule system availability

2. **Context Assessment**

   Review the current system status:

   ```
   SHOW ACTIVE CONTEXT
   ```

   This command displays:

   - Current focus and priorities
   - Recent changes
   - Open issues and questions
   - Overall progress status
   - Next planned steps

3. **Task Contextualization**

   Before starting any work, contextualize your task:

   ```
   CONTEXTUALIZE [task description]
   ```

   Example:

   ```
   CONTEXTUALIZE Implement new verification process for memory integrity
   ```

   The system will:

   - Position the task within the overall project
   - Identify relevant components
   - Determine appropriate complexity level
   - Prepare necessary resources

4. **Readiness Confirmation**

   Confirm system readiness before proceeding:

   ```
   CONFIRM READINESS
   ```

   The system will verify that:

   - All required information is available
   - Current state is understood
   - Task objectives are clear
   - Implementation approach is defined

## Workflow Selection

Choose the appropriate workflow based on your task:

1. **Plan Mode**

   For design or planning tasks:

   ```
   ENTER PLAN MODE
   ```

   Plan mode optimizes for:

   - Requirement analysis
   - Design exploration
   - Option evaluation
   - Documentation creation

2. **Act Mode**

   For implementation or execution tasks:

   ```
   ENTER ACT MODE
   ```

   Act mode optimizes for:

   - Code implementation
   - Feature building
   - Testing and verification
   - Bug fixing

3. **Review Mode**

   For evaluation or assessment tasks:

   ```
   ENTER REVIEW MODE
   ```

   Review mode optimizes for:

   - Quality assessment
   - Verification against requirements
   - Documentation review
   - Improvement identification

4. **Hybrid Mode**

   For mixed tasks requiring multiple approaches:

   ```
   ENTER HYBRID MODE
   ```

## Memory Bank Operations

During your session, you may need these common operations:

1. **Update Memory Bank**

   When significant changes occur:

   ```
   UPDATE MEMORY BANK
   ```

   This triggers comprehensive memory updates, including:

   - activeContext.md modifications
   - progress.md updates
   - systemPatterns.md additions
   - techContext.md refinements

2. **Check Memory Health**

   To verify system integrity:

   ```
   MEMORY HEALTH CHECK
   ```

   This performs diagnostics on:

   - File existence and accessibility
   - Content integrity
   - Cross-reference validity
   - Consistency across files

3. **Show Active Rules**

   To understand active rule configuration:

   ```
   SHOW ACTIVE RULES
   ```

   This displays:

   - Currently active rules by category
   - Rule application status
   - Recent rule activations
   - Rule hierarchy

## Session Termination

To properly end a working session:

1. **Initiate Bedtime Protocol**

   ```
   BEDTIME PROTOCOL
   ```

   This protocol:

   - Performs session assessment
   - Updates memory bank files
   - Preserves current state
   - Prepares continuity information
   - Verifies information completeness

2. **Verify Protocol Completion**

   Wait for confirmation:

   ```
   ✓ SUCCESS: Bedtime Protocol complete, session ended properly
   ```

3. **Close Environment**

   You can now safely close your development environment.

## Memory Reset Handling

After a memory reset occurs:

1. **Restore Context**

   The system automatically restores context by reading all memory bank files
   when initialized.

2. **Review Active Context**

   ```
   SHOW ACTIVE CONTEXT
   ```

   This provides essential information about:

   - Where you were in the project
   - What was recently completed
   - What should be done next

3. **Resume Operations**

   Resume your previous workflow:

   ```
   RESUME [workflow type]
   ```

   Example:

   ```
   RESUME ACT MODE
   ```

## Troubleshooting

If you encounter issues during startup:

1. **Initialization Failures**

   - Run `python scripts/repair_memory.py` to attempt automatic repair
   - Check for missing or corrupted memory files
   - Verify rule system integrity

2. **Context Loading Issues**

   - Use `MEMORY HEALTH CHECK` to identify problems
   - Check file permissions and access
   - Examine logs for specific errors

3. **Rule System Problems**

   - Run `DEBUG RULES` to identify rule conflicts or issues
   - Verify rule file integrity
   - Check for rule application errors

4. **Performance Concerns**
   - Optimize memory bank size with `OPTIMIZE MEMORY BANK`
   - Remove unnecessary detail from rarely accessed areas
   - Consider archiving older information

## Related Information

- [Installation Guide](./Installation.md) - System installation procedures
- [Commands Guide](./Commands.md) - Complete command reference
- [Architecture Overview](../Architecture/Overview.md) - System design and
  components

## Version Information

- Last Updated: March 24, 2025
- Compatible with BIG BRAIN Memory Bank 2.0
- Changelog: Initial documentation for version 2.0
