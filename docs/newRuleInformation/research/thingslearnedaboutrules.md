# Key Tips for Cursor .mdc Rules

## Rule Structure Best Practices

### Frontmatter Format

- **Required Fields**: Every .mdc file must start with frontmatter
  ```
  ---
  description: Use ACTION TRIGGER OUTCOME format (e.g., WHEN X occurs THEN do Y)
  globs: Pattern for files where rule applies (e.g., src/**/*.py)
  ---
  ```
- **Description Format**: Use deterministic ACTION TRIGGER OUTCOME format for
  clarity
- **Globs**: Use standard glob patterns without quotes (e.g.,
  `*.js, src/**/*.ts`)

### XML Content Structure

- **Version Tag**: Always include version in format X.Y.Z
  (`<version>1.0.0</version>`)
- **Context Section**: Explain when and where the rule applies
- **Requirements Section**: List actionable items clearly
- **Examples Section**: Include both good and bad examples

### XML Formatting Rules

- Use descriptive, full-word XML tag names (never abbreviate)
- All XML tags must have proper opening and closing tags
- Empty tags should use self-closing syntax (`<tag/>`)
- Indent content within tags by 2 spaces
- Use consistent casing for tag names (prefer lowercase)
- Related tags should follow consistent naming patterns
- For collections, use plural container with singular item tags

## Naming Conventions

### File Naming System

- Use PREFIX-name.mdc pattern for all rule files
- Common prefixes:
  - `0XX`: Core standards
  - `1XX`: Tool configs
  - `3XX`: Testing standards
  - `4XX`: Documentation standards
  - `1XXX`: Language rules
  - `2XXX`: Framework rules
  - `8XX`: Workflows
  - `9XX`: Templates

## Content Optimization

### AI-Friendly Design

- Keep rules as short as possible without sacrificing clarity
- Use hierarchical structure for quick parsing
- Maintain high information density with minimal tokens
- Focus on machine-actionable instructions over human explanations
- Keep frontmatter description under 120 characters while maintaining clear
  intent
- Limit examples to essential patterns only

### Sectioning for Clarity

- Divide longer rules into titled sections to help the model distinguish between
  different instructions
- XML tags work well for organizing sections
- Wrap instructions in semantic tags like `<role>`, `<requirements>`,
  `<examples>`
- Key sections to consider:
  - `<context>`: When the rule applies
  - `<requirements>`: What must be done
  - `<examples>`: How to implement correctly
  - `<anti-patterns>`: What to avoid

## Effectiveness Tips

### Trigger Optimization

- Make trigger conditions specific and unambiguous
- Use multiple trigger keywords when appropriate
- Consider combining text triggers with file pattern matches

### Clear Expectations

- Specify exactly what actions should result from the rule
- Include step-by-step instructions when processes are complex
- Use ordered lists for sequential steps and unordered lists for options

### Reinforcement Elements

- Include both positive reinforcement (benefits of following the rule)
- Add negative reinforcement (consequences of not following the rule)
- Use specific examples to illustrate both good and bad practices

### Testing and Refinement

- Test rules in isolation to ensure they trigger as expected
- Test rules in combination to check for conflicts
- Refine rules based on actual usage patterns

## Rule System Integration

### Rule Priority

- Rules are combined but can sometimes conflict
- Lower prefix numbers generally indicate higher priority
- More specific glob patterns typically take precedence over general ones

### Modularity

- Break complex rule sets into multiple focused rules
- Design rules to be complementary rather than overlapping
- Consider rule dependencies and interactions

## Examples of Effective Rule Components

### Clear Trigger Condition

```xml
<activation>
  <keyword>memory bank update</keyword>
  <action>Review and update all memory bank files</action>
</activation>
```

### Step-by-Step Instructions

```xml
<procedure>
  <step>Review current context</step>
  <step>Identify changes needed</step>
  <step>Make updates preserving critical information</step>
  <step>Verify completeness</step>
</procedure>
```

### Good/Bad Examples

```xml
<examples>
  <good-practice>
    <description>Properly structured rule</description>
    <example>
      <rule>Use descriptive names for all functions</rule>
      <implementation>function calculateTotalPrice() { ... }</implementation>
    </example>
  </good-practice>
  <bad-practice>
    <description>Poor rule structure</description>
    <example>
      <rule>Use good names</rule>
      <implementation>function calc() { ... }</implementation>
    </example>
  </bad-practice>
</examples>
```
