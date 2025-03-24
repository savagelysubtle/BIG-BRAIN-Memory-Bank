---
layout: default
title: Documentation Updates
parent: Workflows
nav_order: 3
permalink: /workflows/documentation-updates/
---

# Documentation Updates

Documentation Updates workflow ensures that the Memory Bank remains accurate,
comprehensive, and up-to-date, preserving all knowledge for future sessions.

{: .fs-6 .fw-300 }

## Purpose of Documentation Updates

The Documentation Updates workflow serves as the critical knowledge preservation
system within the Memory Bank framework. It focuses on:

- Capturing all relevant information discovered during work sessions
- Maintaining the accuracy of existing documentation
- Ensuring that the Memory Bank reflects the current state of the project
- Organizing knowledge in a structured, accessible manner
- Preserving context for future reference

## When to Update Documentation

Documentation updates should occur:

- After completing a significant task or milestone
- Upon discovering new project patterns or insights
- When modifying system architecture or design
- After implementing significant changes
- Before ending a work session (mandatory)
- When requested with "update memory bank" (comprehensive review required)
- When system context needs clarification

## Documentation Update Process

### Phase 1: Information Gathering

1. **Review Recent Changes**

   - Assess work completed since last documentation update
   - Identify new knowledge or insights gained
   - Note any changes to system architecture or patterns
   - Collect information on progress and status

2. **Identify Documentation Needs**

   - Determine which Memory Bank files need updates
   - Identify new documentation that may be needed
   - Assess if new specialized documentation should be created
   - Evaluate the impact of changes on existing documentation

3. **Organize Information**
   - Structure information logically by topic and relevance
   - Prioritize critical information that affects system understanding
   - Separate implementation details from conceptual understanding
   - Group related changes for cohesive updates

### Phase 2: Core File Updates

1. **Update activeContext.md**

   - Document current work focus
   - Record recent changes and their impact
   - Update next steps based on current progress
   - Note any open questions or considerations

2. **Update progress.md**

   - Record completed tasks and milestones
   - Update the status of in-progress work
   - Document known issues and their status
   - Adjust timelines and priorities as needed

3. **Update systemPatterns.md**

   - Add new patterns discovered
   - Update existing patterns that have evolved
   - Document new relationships between components
   - Clarify architectural decisions

4. **Review projectbrief.md and productContext.md**

   - Ensure alignment with current project direction
   - Update if project scope or goals have changed
   - Refine user experience goals based on insights
   - Verify that problem definitions remain accurate

5. **Update techContext.md**
   - Document new technologies or tools introduced
   - Update technical constraints or considerations
   - Record changes to development setup
   - Note any technical decisions made

### Phase 3: Specialized Documentation

1. **Feature Documentation**

   - Create or update detailed feature specifications
   - Document feature behavior and edge cases
   - Record implementation details and decisions
   - Document testing approaches and results

2. **Integration Documentation**

   - Update information on system integrations
   - Document API changes or new endpoints
   - Record data flow between components
   - Update authentication and security details

3. **Specialized Knowledge Areas**
   - Create documentation for complex algorithms
   - Document business logic and rules
   - Record domain-specific knowledge
   - Create references for specialized terminology

### Phase 4: Verification and Organization

1. **Review Documentation Quality**

   - Ensure clarity and completeness
   - Verify accuracy of all information
   - Check for inconsistencies or contradictions
   - Ensure documentation is appropriately detailed

2. **Organize Documentation Structure**

   - Maintain logical organization of files
   - Ensure proper cross-referencing between documents
   - Update navigation and indexes as needed
   - Maintain consistent formatting and style

3. **Check for Gaps**
   - Identify any missing information
   - Ensure all significant changes are documented
   - Verify that context is preserved for all changes
   - Confirm that rationales for decisions are recorded

### Phase 5: Final Review

1. **Comprehensive Review**

   - Verify that all Memory Bank files are up-to-date
   - Ensure documentation reflects current system state
   - Check that recent changes are well-documented
   - Verify that next steps are clearly defined

2. **Future-Proofing**

   - Ensure documentation will remain clear after context is lost
   - Add explanatory notes for complex concepts
   - Include references for further information
   - Document any assumptions made

3. **Prepare for Bedtime Protocol**
   - Ensure Memory Bank is comprehensive and accurate
   - Verify that all core files are updated
   - Check that specialized documentation is complete
   - Confirm that context is preserved for the next session

## Documentation Update Output

A complete Documentation Update should produce:

1. **Updated Core Files**

   - activeContext.md reflecting current status
   - progress.md showing accurate completion state
   - systemPatterns.md with current patterns
   - Updated techContext.md if relevant
   - Refined projectbrief.md and productContext.md if needed

2. **Specialized Documentation**

   - New or updated feature documentation
   - Updated integration documentation
   - Additional specialized knowledge documents as needed
   - Updated references and guides

3. **Organized Knowledge Structure**
   - Well-structured documentation hierarchy
   - Logical organization of information
   - Clear navigation between related documents
   - Consistent formatting and style

## Best Practices for Documentation Updates

- **Be Comprehensive**: Document all relevant information, not just what seems
  important now
- **Prioritize Clarity**: Write for your future self who will have no context
- **Focus on Context**: Explain why decisions were made, not just what was
  decided
- **Be Consistent**: Use consistent terminology and formatting
- **Cross-Reference**: Link related information across documents
- **Include Examples**: Provide concrete examples for complex concepts
- **Document Assumptions**: Record any assumptions made during implementation
- **Review Thoroughly**: Always review documentation before finalizing
- **Write Immediately**: Document insights and decisions as they occur, not
  after
- **Think Long-Term**: Consider how the documentation will be used in the future

## Example Documentation Update

Here's a simplified example of a documentation update session:

```markdown
# Documentation Update Session: After Implementing Authentication System

## activeContext.md Updates

- Current Focus: Just completed user authentication system implementation
- Recent Changes:
  - Added JWT-based authentication
  - Implemented password hashing with bcrypt
  - Created user registration and login endpoints
- Next Steps:
  - Implement user profile management
  - Add password reset functionality
  - Integrate with frontend components

## progress.md Updates

- Completed:
  - User authentication system
  - Password security implementation
  - API endpoints for auth
- In Progress:
  - Frontend integration (30% complete)
- Known Issues:
  - Token refresh mechanism needs optimization
  - Password reset email delivery slow in testing

## systemPatterns.md Updates

- Added new pattern: Token-based Authentication Flow
  - Describes JWT generation, validation, and refresh processes
  - Documents middleware chain for protected routes
  - Outlines security considerations and token storage

## New Specialized Documentation

- Created auth/README.md:
  - Complete documentation of authentication subsystem
  - API endpoint specifications
  - Security implementation details
  - Testing strategy and results

## Updated Files

- Updated api/README.md to include new authentication endpoints
- Updated techContext.md to add JWT and bcrypt as dependencies
- Created new auth/security-considerations.md file documenting security
  decisions
```

## Post-Documentation Transition

After completing Documentation Updates, you should be ready to:

1. **Continue with new tasks** if within the same work session
2. **Execute the [Bedtime
   Protocol]({{ site.baseurl }}/memory-bank/bedtime-protocol/)** if ending a
   work session
3. **Begin a new Planning Mode** cycle for the next feature or task

The comprehensive documentation you've created ensures that knowledge is
preserved and can be effectively retrieved in future sessions, maintaining the
efficiency and effectiveness of the Memory Bank system.
