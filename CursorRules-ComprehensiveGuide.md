# Cursor Rules: The Comprehensive Guide

> **TL;DR:** This guide provides a complete framework for understanding,
> creating, and optimizing Cursor rules to customize AI behavior. Learn about
> rule types, file structures, naming conventions, and advanced techniques to
> enhance your AI-assisted development experience.

## Introduction

Cursor rules provide a powerful way to customize AI behavior in the Cursor IDE,
enabling more consistent, accurate, and tailored coding assistance. This guide
offers a structured approach to understanding, creating, and organizing Cursor
rules for maximum effectiveness.

## Table of Contents

- [Cursor Rules: The Comprehensive Guide](#cursor-rules-the-comprehensive-guide)
  - [Introduction](#introduction)
  - [Table of Contents](#table-of-contents)
  - [Acknowledgments](#acknowledgments)
  - [Understanding Cursor Rules](#understanding-cursor-rules)
    - [What Are Cursor Rules?](#what-are-cursor-rules)
    - [Types of Rules](#types-of-rules)
    - [The Rule Application Process](#the-rule-application-process)
  - [Setting Up Cursor Rules](#setting-up-cursor-rules)
    - [Global Rules](#global-rules)
    - [Project-Specific Rules](#project-specific-rules)
    - [File Structure and Organization](#file-structure-and-organization)
  - [Writing Effective Rules](#writing-effective-rules)
    - [Rule File Structure](#rule-file-structure)
    - [Crafting Descriptions](#crafting-descriptions)
    - [Content Optimization Strategies](#content-optimization-strategies)
    - [Optimizing Glob Patterns](#optimizing-glob-patterns)
    - [XML Content Structure](#xml-content-structure)
  - [Naming Conventions](#naming-conventions)
    - [Core Standards (0XX)](#core-standards-0xx)
    - [Tool Configs (1XX)](#tool-configs-1xx)
    - [Testing Standards (3XX)](#testing-standards-3xx)
    - [Documentation Standards (4XX)](#documentation-standards-4xx)
    - [Language Rules (1XXX)](#language-rules-1xxx)
    - [Framework Rules (2XXX)](#framework-rules-2xxx)
    - [Workflows (8XX)](#workflows-8xx)
    - [Templates (9XX)](#templates-9xx)
    - [Categorization Strategies](#categorization-strategies)
    - [Hierarchical Rule Systems](#hierarchical-rule-systems)
  - [Advanced Rule Application Patterns](#advanced-rule-application-patterns)
    - [Always-Applied Rules](#always-applied-rules)
    - [Auto-Attached Rules](#auto-attached-rules)
    - [Agent-Requested Rules](#agent-requested-rules)
    - [Rule Visibility and Self-Documentation](#rule-visibility-and-self-documentation)
  - [Optimizing Rules for Context Windows](#optimizing-rules-for-context-windows)
    - [Priority-Based Content Organization](#priority-based-content-organization)
    - [Visual Hierarchy for Quick Parsing](#visual-hierarchy-for-quick-parsing)
    - [Reference Systems for Detailed Content](#reference-systems-for-detailed-content)
  - [Optimizing Glob Patterns](#optimizing-glob-patterns-1)
    - [Targeting Specific Files](#targeting-specific-files)
    - [Exclusion Patterns](#exclusion-patterns)
    - [Performance Considerations](#performance-considerations)
  - [Best Practices](#best-practices)
    - [Rule Content Optimization](#rule-content-optimization)
    - [Testing and Refining Rules](#testing-and-refining-rules)
    - [Maintenance Strategies](#maintenance-strategies)
  - [Advanced Techniques](#advanced-techniques)
    - [Enterprise-Scale Pattern Strategies](#enterprise-scale-pattern-strategies)
    - [Rule Visibility and Debugging](#rule-visibility-and-debugging)
    - [Integration with Build Systems](#integration-with-build-systems)
    - [Creative Process Integration](#creative-process-integration)
  - [Example Rules and Templates](#example-rules-and-templates)
    - [Global Rule Examples](#global-rule-examples)
    - [Project-Specific Rule Examples](#project-specific-rule-examples)
    - [Language-Specific Rules](#language-specific-rules)

## Acknowledgments

This guide incorporates creative elements and best practices from several
sources, with special recognition to:

- [vanzan01/cursor-memory-bank](https://github.com/vanzan01/cursor-memory-bank):
  A documentation-driven framework that gives Cursor a better persistent memory
  across sessions. We've incorporated several innovative concepts from this
  project, including:
  - The three-tier rule application pattern (Always-Applied, Auto-Attached,
    Agent-Requested)
  - Content optimization strategies for context windows
  - Creative process framework for complex design decisions
  - Reference systems for managing detailed documentation
  - Visual hierarchy techniques for improved rule parsing

The Cursor Memory Bank System provides an excellent framework for creating AI
assistants with persistent memory across sessions, which complements the
rule-based approach described in this guide. We highly recommend exploring their
repository for additional insights on using Cursor rules to create more
sophisticated AI assistance workflows.

---

## Understanding Cursor Rules

### What Are Cursor Rules?

Cursor rules are custom instructions that guide the AI's behavior when
interpreting code, generating suggestions, and responding to queries. They serve
as a mechanism to ensure the AI assistant understands your coding preferences,
project requirements, and development standards.

Rules allow you to:

- Enforce consistent coding standards
- Improve AI-generated code quality
- Encourage best practices for security, error handling, and performance
- Reduce code review issues by having the AI follow established team conventions

### Types of Rules

Cursor supports two primary types of rules based on their scope:

**1. Global Rules**

- Apply across all projects
- Set in Cursor Settings under "General > Rules for AI"
- Best for enforcing personal coding style and preferences

**2. Project-Specific Rules**

- Apply only to specific projects
- Stored in `.cursor/rules/` directory as `.mdc` files
- Best for project-specific requirements and team standards

### The Rule Application Process

Rules in Cursor undergo a sophisticated two-stage process before affecting AI
behavior:

**1. Injection Stage**

- Rules are incorporated into the system prompt context
- Depends on the `alwaysApply` parameter and the `globs` parameter
- Injection makes rules available but doesn't guarantee activation

**2. Activation Stage**

- Determines whether a rule actually influences AI behavior
- Primarily based on the `description` field
- The AI evaluates the rule's relevance to the current context

This two-stage approach allows for precise control over when and how rules
apply.

---

## Setting Up Cursor Rules

### Global Rules

Global rules are ideal for establishing fundamental guidelines that apply across
all projects:

1. Open Cursor Settings
2. Navigate to "General > Rules for AI"
3. Enter your custom instructions in the provided text area
4. Click "Save" to apply your global rules

Effective global rules typically address:

- Code commenting standards
- Naming conventions
- Refactoring preferences
- Stylistic choices

### Project-Specific Rules

Project-specific rules address unique requirements for individual projects:

1. Create the directory structure `.cursor/rules/` in your project root
2. Add individual `.mdc` files for different rule categories
3. Ensure rules follow proper formatting (described in the next section)

Project rules should focus on:

- Framework-specific guidelines
- Project architecture patterns
- Team coding standards
- Specific file type requirements

### File Structure and Organization

Organize your `.cursor/rules/` directory with a logical structure:

```
.cursor/
└── rules/
    ├── 000-global.mdc
    ├── 100-typescript.mdc
    ├── 200-react.mdc
    └── 300-eslint.mdc
```

For larger projects, consider using subdirectories for better organization:

```
.cursor/
└── rules/
    ├── Core/
    │   ├── 000-global.mdc
    │   └── 010-security.mdc
    ├── Languages/
    │   ├── 100-typescript.mdc
    │   └── 110-python.mdc
    ├── Frameworks/
    │   ├── 200-react.mdc
    │   └── 210-django.mdc
    └── Tools/
        ├── 300-eslint.mdc
        └── 310-prettier.mdc
```

- Use prefixes (e.g., `000`, `100`) to order files logically
- Group related rules together
- Consider following a standard numbering system (described in Naming
  Conventions section)

---

## Writing Effective Rules

### Rule File Structure

Each `.mdc` file has a specific structure with key parameters in the
frontmatter, followed by content:

```
description: Concise explanation of when this rule should apply
globs:
  - File patterns (e.g., "*.js", "src/**/*.ts")
alwaysApply: true/false
---
Rule content or instructions go here.
```

**Key Parameters:**

- **`description`**: Semantic explanation of when the rule should apply
- **`globs`**: File patterns determining which files the rule applies to
- **`alwaysApply`**: If true, injects the rule regardless of context

### Crafting Descriptions

The `description` field guides the AI on when to activate a rule. Well-crafted
descriptions:

- Use a deterministic ACTION TRIGGER OUTCOME format
  - "WHEN writing Python code ENSURE proper docstrings are included"
  - "WHILE refactoring TypeScript ALWAYS maintain type safety"
- Are concise but specific (aim for under 120 characters)
- Focus on the context of application
- Avoid vague language

Examples:

- Good: "Apply ESLint formatting rules when editing JavaScript files"
- Bad: "Follow good coding practices"

### Content Optimization Strategies

For effective rule content structure, use these strategies from enterprise AI
systems:

1. **Priority-Based Content Organization**

   - Begin with a TL;DR summary of essential points
   - Place critical instructions at the top
   - Use progressive disclosure (essentials first, details later)

2. **Visual Hierarchy**
   - Use emoji markers for different content types (🚨, ✅, ❌, 📋)
   - Create tables for reference information
   - Add visual separation between different sections

Example structure:

```markdown
> **TL;DR:** This rule enforces TypeScript type safety patterns, ensuring proper
> type declarations, avoiding any/unknown types, and requiring explicit return
> types.

## 🚨 CRITICAL REQUIREMENTS

- Always use explicit types (never implicit any)
- Provide return types for all functions
- Use interfaces for object shapes

## ✅ BEST PRACTICES

- Prefer interfaces over types for objects
- Use union types for variables with multiple types
- Leverage generics for reusable components

## ❌ ANTIPATTERNS

- Avoid type assertions without validation
- Never use `any` or `unknown` without constraint
- Don't use Enums (use union types)
```

### Optimizing Glob Patterns

Glob patterns determine which files the rule applies to:

- `*.js`: All JavaScript files in the current directory
- `src/**/*.ts`: All TypeScript files in the src/ directory and subdirectories
- `!test/*.js`: Excludes JavaScript files in the test/ directory

Best practices:

- Be as specific as possible to avoid unnecessary processing
- Use exclusion patterns (`!`) to skip directories like tests, node_modules
- Consider performance implications for large codebases

### XML Content Structure

For rule content, using a structured XML format improves clarity and helps the
AI parse instructions:

```xml
> **TL;DR:**: ONE OR TWO HIGH Quality Sentences explaining the rule.

<version>1.0.0</version>

<context>
  This rule applies when working with React components.
</context>

<requirements>
  <requirement>Use functional components instead of class components</requirement>
  <requirement>Implement proper prop type validation</requirement>
  <requirement>Follow React hooks best practices</requirement>
</requirements>

<examples>
  <good-practice>
    <description>Functional component with proper typing</description>
    <code>
      const Button = ({ text, onClick }: ButtonProps) => (
        <button onClick={onClick}>{text}</button>
      );
    </code>
  </good-practice>
  <bad-practice>
    <description>Class component with missing prop validation</description>
    <code>
      class Button extends React.Component {
        render() {
          return <button onClick={this.props.onClick}>{this.props.text}</button>;
        }
      }
    </code>
  </bad-practice>
</examples>
```

Key sections to include:

> **TL;DR:**: ONE OR TWO HIGH Quality Sentences explaining the rule.

- `<version>`: For tracking rule updates
- `<context>`: When the rule applies
- `<requirements>`: What must be done
- `<examples>`: How to implement correctly
- `<anti-patterns>`: What to avoid

---

## Naming Conventions

Use a consistent
PREFIX-rule-name-that-clearly-defines-relation-to-system.mdc(**preferably
shorter**) format for all rule files.

> **BIG BRAIN prefixes:** Only add the 5 OR 50 suffix when the rule is nearly
> identical to a primary rule but marked as not "always applied" (i.e., a
> booster rule). For example, use `X15.mdc` for a conditional variation of
> `X10.mdc` OR `X150` FOR `X100` Prefrence is to have `XXX0` as the ending
> number and go up in 10 in `XXX` and 100 in `XXXX`

- `0XX`: Rule style guide/best practices for @file linking
- `0XXX`: BIG BRAIN Core standards - No Conditional Logic these are the the main
  logic for system
- `1XXX`: memory-system
- `2XX`: Testing standards
- `4XX`: Documentation standards
- `1XXX`: Language rules
- `2XXX`: Framework rules
- `8XX`: Workflows
- `9XX`: Templates

For example:

### Core Standards (0XX)

- 000-coding-standards.mdc - Global coding standards across all languages
- 010-security-principles.mdc - Security best practices for all code
- 020-error-handling.mdc - Standard error handling patterns
- 050-code-organization.mdc - Project structure and file organization rules

### Tool Configs (1XX)

- 100-eslint-rules.mdc - ESLint configuration standards
- 110-prettier-formatting.mdc - Prettier code formatting rules
- 120-webpack-config.mdc - Webpack configuration standards
- 150-docker-practices.mdc - Docker configuration best practices

### Testing Standards (3XX)

- 300-unit-testing.mdc - Unit testing requirements and patterns
- 310-integration-tests.mdc - Integration testing standards
- 320-e2e-testing.mdc - End-to-end testing guidelines
- 350-test-coverage.mdc - Code coverage requirements

### Documentation Standards (4XX)

- 400-code-comments.mdc - Code commenting standards
- 410-api-documentation.mdc - API documentation requirements
- 420-readme-standards.mdc - README file structure and content
- 450-jsdoc-guidelines.mdc - JSDoc formatting standards

### Language Rules (1XXX)

- 1000-javascript-standards.mdc - JavaScript coding standards
- 1100-typescript-conventions.mdc - TypeScript-specific conventions
- 1200-python-patterns.mdc - Python coding patterns and practices
- 1300-java-guidelines.mdc - Java development guidelines

### Framework Rules (2XXX)

- 2000-react-components.mdc - React component architecture
- 2100-angular-patterns.mdc - Angular development patterns
- 2200-vue-standards.mdc - Vue.js coding standards
- 2300-django-practices.mdc - Django framework best practices

### Workflows (8XX)

- 800-git-workflow.mdc - Git branching and commit standards
- 810-code-review.mdc - Code review process and requirements
- 820-ci-cd-pipeline.mdc - CI/CD workflow standards
- 850-deployment-procedures.mdc - Deployment checklist and procedures

### Templates (9XX)

- 900-component-template.mdc - Standard component template structure
- 910-test-template.mdc - Test file template format
- 920-module-template.mdc - Module structure template
- 950-documentation-template.mdc - Documentation file templates

### Categorization Strategies

Separate rules into logical categories for better organization:

1. **By Technology**

   - Language-specific rules (Python, TypeScript, etc.)
   - Framework rules (React, Vue, Django, etc.)
   - Tool-specific rules (ESLint, Jest, etc.)

2. **By Function**

   - Styling and formatting
   - Documentation requirements
   - Testing standards
   - Security practices
   - Performance optimization

3. **By Scope**
   - Project-wide standards
   - Module-specific guidelines
   - Component-specific requirements

### Hierarchical Rule Systems

Implement a hierarchical system where rules build upon each other:

1. **Core Rules (000-099)**

   - Fundamental coding standards
   - Project architecture principles
   - Security baseline requirements

2. **Language Rules (100-199)**

   - Language-specific best practices
   - Style and formatting requirements

3. **Framework Rules (200-299)**

   - Framework-specific patterns and practices
   - Component architecture

4. **Specialized Rules (300+)**
   - Testing requirements
   - Documentation standards
   - Performance optimization

This hierarchical approach ensures that rules are applied in a logical order and
avoids conflicts.

---

## Advanced Rule Application Patterns

Building on the basic rule types, we can implement three distinct application
patterns for more sophisticated rule systems:

### Always-Applied Rules

```markdown
---
description: Critical security guidelines that must be followed in all code
globs:
alwaysApply: true
---
```

- Applied to every command regardless of context
- Used for critical rules that must be followed in all situations
- Kept concise to minimize context window usage
- Examples: security protocols, core principles, mission-critical standards

Always-Applied rules should be:

- As short and concise as possible
- Highly structured for easy parsing
- Focused on truly universal requirements
- Limited in number to avoid context window overuse

### Auto-Attached Rules

```markdown
---
description: TypeScript coding standards for React components
globs: "src/components/**/*.tsx", "src/components/**/*.ts"
alwaysApply: false
---
```

- Automatically applied when working with matching file patterns
- Used for context-specific rules that only apply in certain situations
- Can be more detailed since they're only loaded when relevant
- Examples: language-specific standards, framework guidelines, domain-specific
  rules

Auto-Attached rules should:

- Use precise glob patterns for accurate targeting
- Include clear context explanation in description
- Scale detail based on targeting specificity
- Provide concrete examples relevant to the file patterns

### Agent-Requested Rules

```markdown
---
description: CRITICAL: Contains mandatory examples for React component patterns. CONSULT before implementing new components.
globs: "src/components/**/*.tsx"
alwaysApply: false
---
```

- Agent explicitly instructed to read these files before proceeding with
  specific tasks
- Used for detailed examples, extended explanations, and verbose content
- Helps manage context window by moving details out of main rules
- Examples: detailed pattern examples, complex implementation guidelines,
  extensive code samples

Agent-Requested rules should:

- Use explicit instruction language in description
- Include visual indicators of importance
- Contain comprehensive examples
- Provide cross-references to related rules

### Rule Visibility and Self-Documentation

To ensure the AI understands which rules are active and when, implement a rule
visibility system:

```markdown
---
description: Display which rules are currently active in the context
globs:
alwaysApply: true
---

# Rule Visibility System

When command includes "SHOW ACTIVE RULES", I will:

1. List all active rules based on the current context
2. Show rule activation reason for each active rule
3. Indicate which rules are always applied vs. context-specific
4. Show any rules explicitly loaded through reference

Example response:
```

ACTIVE RULES:

- 000-global-standards.mdc (Always Applied)
- 010-security-principles.mdc (Always Applied)
- 100-typescript-conventions.mdc (Auto-Attached for \*.ts files)
- 2000-react-components.mdc (Explicitly Referenced)

```

```

This visibility system helps debug rule application issues and ensures
transparency in which rules are influencing the AI's behavior.

---

## Optimizing Rules for Context Windows

LLMs have a fundamental limitation: they can only "see" a limited amount of text
at once (the context window). When this window is full, older information gets
pushed out and forgotten. Optimizing rules for context window efficiency is
critical for complex rule systems.

### Priority-Based Content Organization

To maximize the impact of limited context window space:

1. **Begin with a TL;DR Summary**

   - Place a concise summary of the most critical points at the top
   - Format as a blockquote for visual emphasis
   - Keep under 3-5 lines for maximum impact

2. **Place Mission-Critical Content First**

   - Organize content in descending order of importance
   - Ensure the most vital information appears before any scrolling would be
     required
   - Use clear headings to delineate sections

3. **Implement Progressive Disclosure**
   - Start with essential instructions
   - Move details, examples, and edge cases later in the document
   - Use specific reference markers for detailed content

Example structure:

```markdown
> **TL;DR:** Always use TypeScript interfaces for React props. Follow component
> file structure: exports first, component logic next, helpers last. Use
> styled-components with theme tokens only.

## ESSENTIAL REQUIREMENTS

[Most critical instructions here]

## IMPLEMENTATION DETAILS

[More detailed guidance here]

## EXAMPLES AND EDGE CASES

[Specific examples and special cases here]
```

### Visual Hierarchy for Quick Parsing

Create a clear visual hierarchy that helps the AI parse instructions
efficiently:

1. **Consistent Emoji Markers**

   - 🚨 for critical warnings/requirements
   - ✅ for best practices
   - ❌ for anti-patterns
   - 📋 for checklists
   - 📚 for references

2. **Structured Tables for Reference Information**

   - Use tables for complex relationships or comparison information
   - Keep tables narrow enough to avoid horizontal scrolling
   - Include clear headers for each column

3. **Visual Separation Between Sections**
   - Use horizontal rules (`---`) between major sections
   - Employ consistent heading levels
   - Add whitespace between different categories of information

Example:

```markdown
## 🚨 CRITICAL REQUIREMENTS

- [Critical requirement 1]
- [Critical requirement 2]

## ✅ BEST PRACTICES

- [Best practice 1]
- [Best practice 2]

## ❌ ANTI-PATTERNS

- [Anti-pattern 1]
- [Anti-pattern 2]

## 📋 IMPLEMENTATION CHECKLIST

- [ ] [Checklist item 1]
- [ ] [Checklist item 2]
```

### Reference Systems for Detailed Content

For extensive rule systems, implement a reference system to manage context
window limitations:

1. **Standardized Reference Format**

   ```markdown
   📚 REFERENCE CHECK:

   - CONSULTING: [file name]
   - PURPOSE: [specific reason for consulting]
   - CRITICAL ELEMENTS: [key items to look for]
   ```

2. **Cross-Referencing Between Rules**

   - Use a consistent link format:
     `[Rule Name](mdc:.cursor/rules/path/to/rule.mdc)`
   - Include brief context about what's in the referenced rule
   - Specify when a reference should be consulted

3. **File-Specific Reference Triggers**
   - Create specific triggers for detailed documentation
   - Example: "When implementing a new React component, CONSULT
     component-patterns.mdc"
   - Use capitalization for important reference instructions

This reference system allows you to maintain comprehensive documentation while
keeping individual rules concise and context-efficient.

---

## Optimizing Glob Patterns

### Targeting Specific Files

Precise glob patterns improve rule application and performance:

- **Target by Path**: `src/components/**/*.tsx`
- **Target by Extension**: `*.{ts,tsx}`
- **Target Specific Files**: `src/config/settings.js`
- **Multiple Patterns**:
  ```
  globs:
    - "src/**/*.ts"
    - "src/**/*.tsx"
    - "lib/**/*.js"
  ```

### Exclusion Patterns

Use exclusion patterns to avoid processing unnecessary files:

```
globs:
  - "src/**/*.js"
  - "!src/test/**/*.js"
  - "!src/vendor/**/*.js"
  - "!**/node_modules/**"
```

This approach:

- Improves performance by reducing file scanning
- Prevents rules from applying to third-party code
- Avoids conflicts with test files that may have different standards

### Performance Considerations

For large-scale applications, optimize glob patterns for performance:

- **Minimize Scope**: Avoid overbroad patterns like `**/*`
- **Use Explicit Paths**: Target specific directories rather than searching
  everywhere
- **Minimize Nesting Depth**: Patterns with multiple `**/` are slower to
  evaluate
- **Cache Results**: For build systems, combine with caching mechanisms

Performance benchmarks from enterprise applications:

| Approach           | 100k Files | 1M Files |
| :----------------- | :--------- | :------- |
| Broad `**/*`       | 2.1s       | 24.8s    |
| Targeted Globs     | 0.3s       | 1.9s     |
| Globs + Exclusions | 0.2s       | 1.2s     |

---

## Best Practices

### Rule Content Optimization

Create rules that are both clear for humans and optimized for AI processing:

- **Keep rules concise** without sacrificing clarity
- **Use hierarchical structure** for quick parsing
- **Maintain high information density** with minimal tokens
- **Focus on machine-actionable instructions** over verbose explanations
- **Use consistent terminology** across all rules
- **Prefer specific, concrete examples** over abstract concepts

### Testing and Refining Rules

Iteratively improve your rules based on actual usage:

1. **Test rules in isolation** to ensure they trigger as expected
2. **Test rules in combination** to check for conflicts
3. **Monitor AI behavior** to identify issues with rule application
4. **Create new rules** when encountering repeated issues
5. **Refine existing rules** based on effectiveness

**Validation Strategy:**

- Apply a rule to a specific file
- Verify the AI follows the guidelines
- Adjust the description or content as needed
- Re-test with different contexts

### Maintenance Strategies

Keep your rule system effective over time:

- **Regularly review rules** for relevance and accuracy
- **Document the purpose of each rule** for team understanding
- **Establish a version control process** for rule updates
- **Remove or update outdated rules** as project requirements evolve
- **Consider implementing automatic rule validation** in CI/CD pipelines
- **Keep core files concise** (under 300 lines maximum)
- **Move detailed examples to separate files** to manage context window usage

---

## Advanced Techniques

### Enterprise-Scale Pattern Strategies

For large codebases and enterprise applications:

**A. Microservices Isolation**

```
services/{{service_name}}/src/**/*
!services/{{service_name}}/vendor/
```

**B. Monorepo Optimization**

```
# Target only changed packages
packages/{{package_name}}/**/*.{js,ts}
```

**C. Security Scanning**

```
**/Dockerfile
**/*.yaml
!**/node_modules/**/*.yaml
```

### Rule Visibility and Debugging

Implement mechanisms to understand which rules are being applied:

- Create visibility rules that output active rules during AI actions
- Include debugging commands in descriptions to activate rule tracing
- Use specific patterns in your queries to verify rule activation

**Debug Rule Example:**

```markdown
---
description: Debug Cursor rules activation and application
globs:
alwaysApply: true
---

## Rule Debugging Commands

When you see any of these commands in a query, perform the associated action:

- SHOW_RULES: List all currently active rules
- TRACE_RULE [rule-name]: Show why that rule was activated
- DEBUG_GLOB [pattern]: Show which files match the pattern
- RULE_CONFLICTS: Identify any conflicting rules
```

### Integration with Build Systems

Combine rules with modern build system features:

```
# Example Turborepo Configuration
{
  "pipeline": {
    "build": {
      "dependsOn": ["^build"],
      "outputs": ["dist/**"],
      "inputs": ["src/**/*.ts", "!src/**/*.test.ts"]
    }
  }
}
```

This integration:

- Ensures consistent application of standards
- Improves incremental build performance
- Reduces CI/CD pipeline time

### Creative Process Integration

For complex design decisions, incorporate structured creative process guidance
in your rules:

````markdown
---
description: When designing new components or architecture, follow this structured creative process
globs: "src/components/**/*.tsx", "src/architecture/**/*.md"
alwaysApply: false
---

# Structured Design Thinking Process

## 🎨 Creative Phase Framework

When making significant design decisions, follow this structured approach:

1. **Problem Definition**

   - Clearly state the problem to be solved
   - Identify constraints and requirements
   - Define success criteria

2. **Options Exploration**

   - Generate at least 3 alternative approaches
   - Document pros/cons for each option
   - Consider edge cases for each approach

3. **Evaluation Matrix**

   - Create weighted criteria for evaluation
   - Score each option against the criteria
   - Document the decision rationale

4. **Implementation Planning**
   - Break down the selected approach into steps
   - Identify potential challenges
   - Create validation checkpoints

## Example Creative Process

```markdown
🎨🎨🎨 ENTERING CREATIVE PHASE: COMPONENT ARCHITECTURE 🎨🎨🎨 Focus: User
profile component architecture Objective: Create a modular, performant user
profile system

[Detailed creative process steps]

🎨🎨🎨 EXITING CREATIVE PHASE - DECISION DOCUMENTED 🎨🎨🎨
```
````

```

Use this structured approach for:

- Component architecture decisions
- State management approaches
- Data modeling decisions
- Algorithm design
- UI/UX patterns

```

This creative process integration helps ensure that complex design decisions
receive proper consideration and documentation.

---

## Example Rules and Templates

### Global Rule Examples

**Code Style Rule:**

```

description: WHEN writing code ENSURE consistent formatting and style globs:
alwaysApply: true

---

<version>1.0.0</version>

<requirements>
  <requirement>Use 2 spaces for indentation</requirement>
  <requirement>Keep line length under 100 characters</requirement>
  <requirement>Use meaningful variable and function names</requirement>
  <requirement>Add comments for complex logic</requirement>
</requirements>
```

**Documentation Rule:**

```
description: WHEN creating functions ALWAYS include proper documentation
globs:
alwaysApply: true
---
<version>1.0.0</version>

<requirements>
  <requirement>Document function purpose</requirement>
  <requirement>List parameters and return values</requirement>
  <requirement>Provide usage examples for complex functions</requirement>
</requirements>
```

### Project-Specific Rule Examples

**React Components Rule:**

```
description: WHEN creating React components FOLLOW established patterns
globs:
  - "src/**/*.tsx"
  - "src/**/*.jsx"
alwaysApply: false
---
<version>1.0.0</version>

<requirements>
  <requirement>Use functional components with hooks</requirement>
  <requirement>Implement proper prop type validation</requirement>
  <requirement>Follow component file structure conventions</requirement>
</requirements>

<examples>
  <good-practice>
    <description>Functional component with prop types</description>
    <code>
      import React from 'react';

      interface ButtonProps {
        label: string;
        onClick: () => void;
      }

      export const Button: React.FC<ButtonProps> = ({ label, onClick }) => {
        return (
          <button onClick={onClick}>
            {label}
          </button>
        );
      };
    </code>
  </good-practice>
</examples>
```

### Language-Specific Rules

**Python Rule:**

```
description: WHEN writing Python code ENSURE it follows clean architecture principles
globs:
  - "**/*.py"
alwaysApply: false
---
<version>1.0.0</version>

<context>
  Python code should follow clean architecture principles with clear separation
  of concerns between layers.
</context>

<requirements>
  <requirement>
    Place code in the appropriate layer:
    - Domain: Core business logic and entities
    - Application: Use cases and orchestration
    - Infrastructure: External systems and frameworks
    - Interface: User-facing components
  </requirement>
  <requirement>
    Always use type hints for functions, methods, and variables
  </requirement>
  <requirement>
    Add proper docstrings using Google-style format
  </requirement>
</requirements>

<examples>
  <good-practice>
    <description>Domain entity with proper typing and docstrings</description>
    <code>
      class User:
          """Represents a user in the system.

          Attributes:
              id (str): Unique identifier for the user.
              name (str): The user's full name.
              email (str): The user's email address.
          """

          def __init__(self, id: str, name: str, email: str) -> None:
              """Initialize a new User.

              Args:
                  id: Unique identifier for the user.
                  name: The user's full name.
                  email: The user's email address.
              """
              self.id = id
              self.name = name
              self.email = email

          def validate_email(self) -> bool:
              """Check if the user's email is valid.

              Returns:
                  True if the email is valid, False otherwise.
              """
              return "@" in self.email
    </code>
  </good-practice>
</examples>
```

---

This guide provides a comprehensive framework for understanding, creating, and
optimizing Cursor rules. By following these principles and best practices, you
can enhance your AI-assisted development experience and ensure consistent,
high-quality code across projects and teams.
