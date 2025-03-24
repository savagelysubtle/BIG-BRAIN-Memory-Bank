---
layout: default
title: Action Mode
parent: Workflows
nav_order: 2
permalink: /workflows/action-mode/
---

# Action Mode

Action Mode is the methodical execution phase where plans are implemented,
changes are documented, and system consistency is maintained.

{: .fs-6 .fw-300 }

## Purpose of Action Mode

Action Mode is the implementation phase that follows Planning Mode. It focuses
on:

- Methodically executing the implementation plan
- Making precise, controlled changes to code and systems
- Documenting changes and their rationale
- Verifying that changes meet requirements
- Maintaining system consistency and stability

## When to Use Action Mode

Enter Action Mode when:

- You have completed Planning Mode for a task
- You have a clear implementation plan to follow
- You understand what needs to be done and how to do it
- You have identified potential issues and have mitigation strategies
- You're ready to make actual changes to the system

## Action Mode Process

### Phase 1: Preparation

1. **Review the Implementation Plan**

   - Refresh your understanding of the plan
   - Confirm the sequence of tasks
   - Verify that prerequisites are met
   - Prepare your development environment

2. **Establish Working Context**

   - Open relevant files and documentation
   - Set up necessary tools and resources
   - Configure testing environment if needed
   - Create checkpoints for verification

3. **Define Scope Boundaries**
   - Clearly delineate what will be changed
   - Identify what should remain unchanged
   - Set limits on implementation scope
   - Establish criteria for success

### Phase 2: Methodical Implementation

1. **Follow Task Sequence**

   - Execute tasks in the planned order
   - Focus on one task at a time
   - Adhere to the defined implementation approach
   - Apply consistent coding patterns and practices

2. **Make Precise Changes**

   - Implement changes with surgical precision
   - Avoid unnecessary modifications
   - Maintain clean, readable code
   - Follow established code style and conventions

3. **Document While Implementing**
   - Comment code as you write it
   - Explain complex algorithms and logic
   - Document assumptions and edge cases
   - Maintain a parallel record of significant decisions

### Phase 3: Continuous Verification

1. **Verify Each Task**

   - Test each component after implementation
   - Validate against requirements
   - Ensure integration with existing systems
   - Check for potential side effects

2. **Address Issues Immediately**

   - Fix problems as they're discovered
   - Document any issues and their resolutions
   - Adjust the plan if necessary
   - Prevent issues from cascading

3. **Maintain System Stability**
   - Ensure changes don't break existing functionality
   - Verify system cohesion after each change
   - Test integration points thoroughly
   - Maintain overall system performance

### Phase 4: Documentation

1. **Update Technical Documentation**

   - Document new components and functionality
   - Update existing documentation as needed
   - Ensure API documentation is current
   - Document configuration changes

2. **Record Implementation Details**

   - Note any deviations from the plan
   - Document reasons for changes
   - Record challenges encountered
   - Document solutions implemented

3. **Prepare Knowledge Transfer**
   - Create summaries of changes made
   - Document key design decisions
   - Highlight areas requiring attention
   - Note future considerations

### Phase 5: Finalization

1. **Conduct Final Verification**

   - Perform comprehensive testing
   - Validate against all requirements
   - Ensure all documentation is complete
   - Verify consistency across the system

2. **Prepare for Review**

   - Organize code for review
   - Prepare demonstration of functionality
   - Document test results
   - Highlight key implementation decisions

3. **Close the Loop**
   - Ensure all tasks are completed
   - Document final status
   - Update relevant Memory Bank files
   - Prepare for next steps

## Action Mode Output

A complete Action Mode session should produce:

1. **Implemented Solution**

   - Working, tested code
   - Integration with existing systems
   - Meeting all requirements

2. **Technical Documentation**

   - Updated or new documentation
   - Code comments and explanations
   - API documentation if applicable

3. **Implementation Record**

   - Notes on the implementation process
   - Challenges encountered and solutions
   - Deviations from the plan with justifications
   - Verification results

4. **Updated Memory Bank**
   - Records of changes in activeContext.md
   - Updated progress.md
   - Any new patterns in systemPatterns.md
   - Other relevant updates

## Action Mode Best Practices

- **Follow the Plan**: Adhere to the implementation plan from Planning Mode
- **One Task at a Time**: Focus on completing one task before moving to the next
- **Test Continuously**: Verify each change before proceeding
- **Document as You Go**: Record decisions and changes in real-time
- **Stay Within Scope**: Avoid scope creep or unnecessary changes
- **Commit Regularly**: Make incremental, logical commits with clear messages
- **Maintain Quality**: Never compromise on code quality for speed
- **Address Issues Early**: Fix problems as soon as they're identified
- **Be Methodical**: Follow a consistent, systematic approach

## Handling Unexpected Issues

During Action Mode, you may encounter situations not anticipated during Planning
Mode:

1. **Assess Impact**

   - Determine if the issue affects the implementation plan
   - Evaluate the scope and severity

2. **Minor Issues**

   - If the issue is small and contained:
     - Document the issue
     - Implement a solution
     - Continue with the plan

3. **Major Issues**

   - If the issue requires significant replanning:
     - Pause Action Mode
     - Return to Planning Mode for the affected area
     - Revise the implementation plan
     - Resume Action Mode with the updated plan

4. **Document All Issues**
   - Record all issues encountered
   - Document solutions implemented
   - Note any plan adjustments

## Example Action Mode Workflow

Here's a simplified example of Action Mode execution:

```markdown
# Action Mode: Implementing User Authentication System

## Task 1: Create Authentication Controller

- Created auth/controllers/AuthController.js
- Implemented register and login endpoints
- Added input validation
- Added error handling for invalid inputs
- Tested with Postman - endpoints working correctly

## Task 2: Implement Password Hashing

- Added bcrypt for password hashing
- Created password validation middleware
- Implemented hash comparison for login
- Tested with valid and invalid password scenarios
- All test cases passing

## Task 3: JWT Token Management

- Added JWT generation in login endpoint
- Created middleware for token validation
- Implemented error handling for invalid tokens
- Set up token expiration (30 minutes)
- Tested token validation - working correctly

## Challenges Encountered

- Issue: Token validation failing for some requests

  - Root cause: Malformed Authorization header
  - Solution: Added robust header parsing and error handling

- Issue: Password requirements too restrictive
  - Discussion with product owner resulted in adjusted requirements
  - Updated validation rules to match new requirements

## Verification Results

- All endpoints returning correct status codes
- Token generation and validation working
- Session timeout functioning correctly
- All unit and integration tests passing
```

## Transitioning to Documentation Updates

After completing Action Mode, transition to [Documentation
Updates]({{ site.baseurl }}/workflows/documentation-updates/) to ensure all
knowledge is properly preserved in the Memory Bank.

This transition should occur when:

- All planned implementation tasks are complete
- The solution has been fully tested and verified
- You have documented all significant implementation details
- You're ready to update the Memory Bank with new information
