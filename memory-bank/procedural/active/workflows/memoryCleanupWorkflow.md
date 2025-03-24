---
title: Memory Bank Cleanup Sequential Workflow
created: 2024-03-24
status: active
complexity: Level 4
---

# Memory Bank Cleanup Sequential Workflow

> **TL;DR:** This document provides a detailed, step-by-step workflow for
> implementing the Memory Bank cleanup and rules optimization, with clear task
> sequences, dependencies, and completion criteria.

<version>1.0.0</version>

## 📌 Workflow Overview

This workflow organizes the Memory Bank cleanup into a logical sequence of
actionable steps with clear assignments and dependencies. It's designed to
ensure efficient, consistent progress through the cleanup plan while maintaining
system integrity.

### Workflow Structure

The workflow organizes tasks into these categories:

1. **Sequential Tasks**: Ordered steps that must be completed in sequence
2. **Parallel Tasks**: Tasks that can be worked on simultaneously
3. **Decision Points**: Places where a choice must be made before proceeding
4. **Verification Points**: Mandatory quality checks before advancing

Each task includes:

- Clear assignment (USER or BIG BRAIN)
- Estimated complexity (1-4)
- Dependencies
- Completion criteria
- Verification method

## 🚀 Phase 1: Comprehensive Analysis Workflow

### Step 1: Complete Memory Bank Structure Mapping

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 2
- **Dependencies**: Initial analysis (completed)
- **Task**:
  1. Create a complete inventory of all Memory Bank files with locations
  2. Document all known cross-references between files
  3. Verify existence of all required core files
  4. Generate file hierarchy visualization for clarity
- **Completion Criteria**: Full file inventory with cross-references documented
- **Verification**: USER reviews inventory for accuracy and completeness

### Step 2: Complete Rules System Inventory

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 2
- **Dependencies**: Initial analysis (completed)
- **Task**:
  1. Create comprehensive inventory of all rule files
  2. Document rule versions, targets, and dependencies
  3. Identify any duplicate or conflicting rules
  4. Generate rule hierarchy visualization
- **Completion Criteria**: Complete rule inventory with versions and
  dependencies
- **Verification**: USER confirms rule inventory completeness

### Step 3: Define Standard Naming Conventions

- **Assigned to**: USER and BIG BRAIN (collaborative)
- **Complexity**: Level 2
- **Dependencies**: Steps 1-2 completed
- **Task**:
  1. USER determines preferred directory naming convention (all lowercase,
     hyphenated, etc.)
  2. BIG BRAIN proposes standardized file naming patterns
  3. USER approves naming conventions
  4. BIG BRAIN documents conventions in a standards file
- **Completion Criteria**: Documented naming standards approved by USER
- **Verification**: Standards document created and reviewed

### Step 4: Create Standard Metadata Template

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 2
- **Dependencies**: Steps 1-3 completed
- **Task**:
  1. Design consistent metadata format for file headers
  2. Include all required fields (title, created, status, etc.)
  3. Create templates for different file types
  4. Document in standards file
- **Completion Criteria**: Metadata templates created for all file types
- **Verification**: USER approves templates for implementation

### Step 5: Document Directory Purpose Definitions

- **Assigned to**: USER and BIG BRAIN (collaborative)
- **Complexity**: Level 2
- **Dependencies**: Step 3 completed
- **Task**:
  1. BIG BRAIN proposes purpose definitions for all directories, including:
     - Purpose of `stable/` directory
     - Future usage of `core/` directory
     - Relationship between root files and directories
  2. USER provides feedback and decisions
  3. BIG BRAIN documents final definitions
- **Completion Criteria**: Clear purpose defined for all directories
- **Verification**: Documentation reviewed and approved by USER

### Step 6: Workflow-Rules Integration Analysis

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 3
- **Dependencies**: Steps 2 and 5 completed
- **Task**:
  1. Map each documented workflow to supporting rules
  2. Identify workflows without rule implementation
  3. Document gaps, especially Bedtime Protocol rule implementation
  4. Create workflow-rule integration map
- **Completion Criteria**: Complete workflow-rule mapping document created
- **Verification**: USER reviews mapping for accuracy and completeness

### Decision Point: Phase 1 Completion Review

- **Assigned to**: USER and BIG BRAIN (collaborative)
- **Complexity**: Level 2
- **Dependencies**: Steps 1-6 completed
- **Task**:
  1. BIG BRAIN prepares Phase 1 completion report
  2. USER reviews all deliverables from Phase 1
  3. Make decision to proceed to Phase 2 or address any gaps
- **Completion Criteria**: USER confirms Phase 1 completion
- **Verification**: All Phase 1 checkpoints marked complete

## 🛠️ Phase 2: Structural Cleanup Workflow

### Step 7: Create Directory Restructuring Plan

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 3
- **Dependencies**: Phase 1 completed
- **Task**:
  1. Design detailed plan for implementing directory structure changes
  2. Include specific renaming operations for each affected directory
  3. Document impact on file paths and references
  4. Create rollback procedure for safety
- **Completion Criteria**: Detailed restructuring plan document with impact
  analysis
- **Verification**: USER reviews and approves plan

### Step 8: Implement Directory Restructuring

- **Assigned to**: USER (with BIG BRAIN guidance)
- **Complexity**: Level 3
- **Dependencies**: Step 7 completed and approved
- **Task**:
  1. USER executes directory changes according to plan
  2. BIG BRAIN provides guidance during process
  3. USER confirms changes are complete
  4. BIG BRAIN verifies correct implementation
- **Completion Criteria**: All directory changes implemented successfully
- **Verification**: BIG BRAIN verifies all changes match plan

### Step 9: Create Metadata Standardization Plan

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 2
- **Dependencies**: Step 4 completed
- **Task**:
  1. Create inventory of all files requiring metadata updates
  2. Develop detailed plan for implementing changes
  3. Document specific changes required for each file
  4. Create batch process for efficiency where possible
- **Completion Criteria**: Complete metadata update plan with file-specific
  details
- **Verification**: USER reviews and approves plan

### Step 10: Implement Metadata Standardization

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 3
- **Dependencies**: Step 9 completed and approved
- **Task**:
  1. Update metadata in files according to plan
  2. Implement changes in logical batches
  3. Verify each change for correctness
  4. Document all changes made
- **Completion Criteria**: All file metadata updated to standard format
- **Verification**: USER reviews sample files for compliance

### Step 11: Create Cross-Reference System Design

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 3
- **Dependencies**: Steps 1 and 10 completed
- **Task**:
  1. Design standardized cross-reference format
  2. Create templates for different reference types
  3. Design central reference indexes if needed
  4. Document implementation approach
- **Completion Criteria**: Cross-reference system design document created
- **Verification**: USER reviews and approves design

### Step 12: Implement Essential Cross-References

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 3
- **Dependencies**: Step 11 completed and approved
- **Task**:
  1. Implement standard cross-references in core files
  2. Create central reference indexes if specified in design
  3. Update most critical documentation with proper references
  4. Document implementation progress
- **Completion Criteria**: Essential cross-references implemented
- **Verification**: USER reviews implementation for compliance with design

### Decision Point: Phase 2 Completion Review

- **Assigned to**: USER and BIG BRAIN (collaborative)
- **Complexity**: Level 2
- **Dependencies**: Steps 7-12 completed
- **Task**:
  1. BIG BRAIN prepares Phase 2 completion report
  2. USER reviews all deliverables from Phase 2
  3. Make decision to proceed to Phase 3 or address any gaps
- **Completion Criteria**: USER confirms Phase 2 completion
- **Verification**: All Phase 2 checkpoints marked complete

## 📘 Phase 3: Content Enhancement Workflow

### Step 13: Update Core Memory Files

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 3
- **Dependencies**: Phase 2 completed
- **Task**:
  1. Update activeContext.md with current system state
  2. Refresh progress.md with accurate work status
  3. Enhance systemPatterns.md with latest patterns
  4. Update techContext.md with current technology information
- **Completion Criteria**: All core files updated with current information
- **Verification**: USER reviews updates for accuracy and completeness

### Step 14: Design Bedtime Protocol Rule Implementation

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 3
- **Dependencies**: Steps 6 and 13 completed
- **Task**:
  1. Design rule implementation for Bedtime Protocol
  2. Ensure alignment with existing workflow documentation
  3. Document rule structure, triggers, and enforcement
  4. Create implementation plan
- **Completion Criteria**: Bedtime Protocol rule design document created
- **Verification**: USER reviews and approves design

### Step 15: Create Rules-Memory Bank Integration Map

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 3
- **Dependencies**: Steps 6 and 14 completed
- **Task**:
  1. Create explicit mappings between rules and Memory Bank
  2. Document how rules support each memory type
  3. Create visualization of integration points
  4. Document implementation recommendations
- **Completion Criteria**: Rules-Memory Bank integration map created
- **Verification**: USER reviews and approves integration map

### Step 16: Design Complexity Level Guidelines

- **Assigned to**: BIG BRAIN
- **Complexity**: Level 3
- **Dependencies**: Steps 13-15 completed
- **Task**:
  1. Create clear guidelines for complexity level determination
  2. Document how workflows adapt to different complexity levels
  3. Create examples for each complexity level
  4. Design complexity determination checklist
- **Completion Criteria**: Complexity level guidelines document created
- **Verification**: USER reviews and approves guidelines

### Decision Point: Phase 3 Completion Review

- **Assigned to**: USER and BIG BRAIN (collaborative)
- **Complexity**: Level 2
- **Dependencies**: Steps 13-16 completed
- **Task**:
  1. BIG BRAIN prepares Phase 3 completion report
  2. USER reviews all deliverables from Phase 3
  3. Make decision to proceed to Phase 4 or address any gaps
- **Completion Criteria**: USER confirms Phase 3 completion
- **Verification**: All Phase 3 checkpoints marked complete

## 🔄 Workflow Management

### Status Tracking

- Update `memory-bank/procedural/active/checklists/memoryCleanupCheckpoints.md`
  after each task
- Document completion date, status, and verification result
- Note any deviations from planned approach

### Blockers and Issues

- Document any blockers immediately in activeContext.md
- Create specific issue documents in appropriate memory type directory
- Update checkpoint document with references to issue documents

### Communication Protocol

- BIG BRAIN reports task completion with verification evidence
- USER provides explicit approval to move past decision points
- BIG BRAIN documents all USER decisions for reference

## 📋 Task Assignment Summary

| Task                                            | Assigned To   | Complexity | Dependencies     |
| ----------------------------------------------- | ------------- | ---------- | ---------------- |
| 1. Complete Memory Bank Structure Mapping       | BIG BRAIN     | 2          | Initial analysis |
| 2. Complete Rules System Inventory              | BIG BRAIN     | 2          | Initial analysis |
| 3. Define Standard Naming Conventions           | Collaborative | 2          | Tasks 1-2        |
| 4. Create Standard Metadata Template            | BIG BRAIN     | 2          | Tasks 1-3        |
| 5. Document Directory Purpose Definitions       | Collaborative | 2          | Task 3           |
| 6. Workflow-Rules Integration Analysis          | BIG BRAIN     | 3          | Tasks 2, 5       |
| 7. Create Directory Restructuring Plan          | BIG BRAIN     | 3          | Phase 1          |
| 8. Implement Directory Restructuring            | USER          | 3          | Task 7           |
| 9. Create Metadata Standardization Plan         | BIG BRAIN     | 2          | Task 4           |
| 10. Implement Metadata Standardization          | BIG BRAIN     | 3          | Task 9           |
| 11. Create Cross-Reference System Design        | BIG BRAIN     | 3          | Tasks 1, 10      |
| 12. Implement Essential Cross-References        | BIG BRAIN     | 3          | Task 11          |
| 13. Update Core Memory Files                    | BIG BRAIN     | 3          | Phase 2          |
| 14. Design Bedtime Protocol Rule Implementation | BIG BRAIN     | 3          | Tasks 6, 13      |
| 15. Create Rules-Memory Bank Integration Map    | BIG BRAIN     | 3          | Tasks 6, 14      |
| 16. Design Complexity Level Guidelines          | BIG BRAIN     | 3          | Tasks 13-15      |

## 📝 Version History

| Version | Date       | Author    | Changes                   |
| ------- | ---------- | --------- | ------------------------- |
| 1.0.0   | 2024-03-24 | BIG BRAIN | Initial workflow document |
