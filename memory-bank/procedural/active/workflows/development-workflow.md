# Workflow: BIG BRAIN Development Workflow

## Purpose

This workflow defines the standard process for developing and implementing
features in the BIG BRAIN Memory Bank system, ensuring consistency, quality, and
proper memory management throughout the development lifecycle.

## Prerequisites

- BIG BRAIN Memory Bank repository cloned locally
- Development environment set up according to techContext.md
- Appropriate branch created for the implementation
- Task complexity assessed (levels 1-4)
- Workflow mode determined (Plan or Act)

## Steps

1. **Initialization Phase**

   - Execute `BIG init` command to establish context
   - Verify all memory files are read and understood
   - Assess task complexity and set mode
   - Create appropriate planning/implementation structure

2. **Planning Phase (Plan Mode)**

   - Read all relevant memory files thoroughly
   - Analyze system architecture and patterns
   - Research similar implementations in episodic memory
   - Create detailed implementation plan with:
     - Architecture considerations
     - Component specifications
     - Interface definitions
     - Testing strategy
   - Document plan in memory-bank/core/active/plans/
   - Execute verification checkpoints
   - Switch to Act mode when plan is complete

3. **Implementation Phase (Act Mode)**

   - Reference implementation plan frequently
   - Follow established patterns from systemPatterns.md
   - Implement code in small, testable increments
   - Create appropriate tests for new functionality
   - Document implementation details in comments
   - Update memory files as implementation progresses

4. **Verification Phase**

   - Execute verification checkpoints
   - Run test suite to validate functionality
   - Verify implementation against requirements
   - Check for consistency with system patterns
   - Review documentation and memory updates

5. **Memory Update Phase**

   - Execute `BIG update memory bank` command
   - Update activeContext.md with implementation details
   - Document decisions in episodic memory
   - Update progress.md with status
   - Create/update relevant semantic and procedural memory files

6. **Completion Phase**
   - Commit changes to the appropriate branch
   - Open pull request with detailed description
   - Execute Bedtime Protocol if ending session
   - Prepare context for next session

## Verification

Verify successful workflow completion by:

- Checking that all implementation requirements are met
- Confirming all tests pass
- Verifying memory bank files are updated
- Ensuring code meets quality standards
- Confirming appropriate documentation exists

## Troubleshooting

### Common Issues

| Issue                                | Solution                                                  |
| ------------------------------------ | --------------------------------------------------------- |
| Incomplete memory reading            | Execute `BIG init` again with appropriate parameters      |
| Plan verification failures           | Review and update plan before switching to Act mode       |
| Rule conflicts during implementation | Review rule conflicts and resolve according to precedence |
| Memory update failures               | Check for consistency issues and resolve conflicts        |
| Missing cross-references             | Update memory files with proper cross-reference syntax    |

### Recovery Strategies

- For implementation issues, review related episodic memories for similar
  problems
- For memory system issues, check system patterns and architecture documentation
- For workflow failures, restart from the most recent successful checkpoint

## Memory Strength: HIGH

Last Accessed: 2025-03-24 Access Frequency: Frequent Importance: Critical
