# Bedtime Protocol Workflow

## Overview

The Bedtime Protocol is a critical workflow that ensures proper memory preservation between sessions. It must be executed completely before ending any significant work session to prevent information loss.

## Workflow Steps

### 1. Analytics Phase

- Run memory bank analytics to assess system health:
  * Generate memory statistics: `BIG analytics stats --include-details`
  * Create memory usage report: `BIG analytics report --format HTML`
  * Perform health check: `BIG analytics health --threshold 60`
- Review any critical recommendations from health assessment
- Address urgent memory organization issues before proceeding

### 2. Memory Update Phase

- Update the following core files with latest information:
  * activeContext.md: Current focus and state
  * progress.md: Working features and known issues
  * tasks.md: Current task status and next actions
  * systemPatterns.md: If architectural changes were made
  * techContext.md: If technology changes were made
  * projectRules.md: If new patterns or preferences were established

### 3. Session Summary Creation

- Create a session summary in activeContext.md using this format:
  ```markdown
  ## 📊 SESSION SUMMARY (YYYY-MM-DD)

  ### Accomplishments
  - [Brief description of completed work]

  ### Current State
  - [Description of the current system state]
  - [Current task progress: N%]

  ### Next Actions
  1. [Specific next step with detailed context]
  2. [Another specific next step]

  ### Open Questions
  - [Question that needs resolution]
  - [Decision that needs to be made]

  ### Critical Notes
  - [Any information essential for continuation]

  ### Memory Health
  - Health Score: [score from analytics]
  - Status: [overall status from analytics]
  - Critical Recommendations: [highlight critical recommendations]
  ```

### 4. Memory Archival Phase

- Version active files that have changed:
  * Copy to short-term/ directory with date suffix
- Archive important information to long-term/:
  * Move session summary to episodic/sessions/
  * Add new discoveries to semantic/domain/
  * Document new workflows in procedural/workflows/
  * Archive design decisions in creative/
- Store analytics reports in memory-bank/active/analytics/

### 5. Verification Phase

- Verify consistency across all memory files
- Ensure all architectural decisions are documented
- Confirm current state is accurately reflected
- Validate working features and issues are up-to-date

### 6. Completion Confirmation

- Provide final confirmation:
  ```markdown
  ## ✅ BEDTIME PROTOCOL COMPLETE

  The memory preservation protocol has been successfully executed. All critical
  information has been documented and the system state has been preserved.

  Memory Health Score: [score]% ([status])

  Memory files updated:
  - [list of updated files]

  Analytics reports generated:
  - memory-statistics.json
  - memory-usage-report.html

  Continuation point established in activeContext.md

  You may safely end this session.
  ```

## Best Practices

1. **Never Skip Steps**: Each phase of the Bedtime Protocol is essential for memory preservation
2. **Be Thorough with Session Summaries**: Include sufficient detail for future continuation
3. **Verify Archive Integrity**: Ensure files are properly copied to their destinations
4. **Document Health Metrics**: Always include memory health status in session summaries
5. **Confirm Completion**: Always wait for the completion confirmation before ending the session

## Common Issues and Solutions

- **Incomplete Session Summary**: If you can't complete all sections, mark them with "[TBD]" for future completion
- **Missing Files**: Run a verification check to identify and restore any missing files
- **Health Issues**: Address critical health recommendations before completing the protocol
- **Insufficient Time**: At minimum, complete the Session Summary and Memory Update phases

## Version History

- 1.0.0: Initial documentation of Bedtime Protocol workflow (2025-03-25)