<img src="https://r2cdn.perplexity.ai/pplx-full-logo-primary-dark%402x.png" class="logo" width="120"/>

# 

---

# Please explain how to setup proper glob rules and descriptions for cursor rules

To set up proper glob rules and descriptions for Cursor rules, follow these steps to ensure that your rules are applied effectively and consistently:

## **Step 1: Understand the Structure of Cursor Rules**

Cursor rules are stored in `.mdc` files within the `.cursor/rules/` directory. Each rule file has the following structure:

```plaintext
description: A brief explanation of when this rule should apply.
globs: 
  - File patterns (e.g., "*.js", "src/**/*.ts")
alwaysApply: true/false
---
Rule content or instructions go here.
```


### Key Parameters:

- **`description`**: A semantic explanation of the rule's purpose. This helps the AI understand when to apply the rule.
- **`globs`**: File patterns that determine which files the rule applies to. Use wildcards (`*`) and directory patterns (`**`) for flexibility.
- **`alwaysApply`**: If set to `true`, the rule is injected into every session regardless of context.

---

## **Step 2: Setting Up Glob Patterns**

Glob patterns allow you to target specific files or directories. Here are some examples:

- `*.js`: Applies to all JavaScript files in the current directory.
- `src/**/*.ts`: Applies to all TypeScript files in the `src/` directory and its subdirectories.
- `!test/*.js`: Excludes JavaScript files in a `test/` directory.


### Example:

```plaintext
description: Apply ESLint formatting rules to all JavaScript files in the project.
globs:
  - "*.js"
  - "src/**/*.js"
alwaysApply: false
---
Ensure ESLint rules are followed for all JavaScript files.
```

---

## **Step 3: Writing Effective Descriptions**

The `description` field is crucial because it guides the AI on when to activate a rule. Use clear, concise language that specifies the context or scenario.

### Tips for Descriptions:

1. Be specific about the use case (e.g., "Use strict typing for TypeScript files").
2. Avoid vague terms; instead, describe exact conditions or goals.
3. Include keywords that align with your coding standards or project requirements.

### Example:

```plaintext
description: Enforce strict typing conventions for TypeScript files in the `src/` directory.
globs:
  - "src/**/*.ts"
alwaysApply: false
---
Always use strict types instead of 'any' in TypeScript code.
```

---

## **Step 4: Organizing Rules**

To keep your rules manageable and effective:

1. **Use Naming Conventions**: Prefix filenames with numbers (e.g., `000-global.mdc`, `100-typescript.mdc`) for logical ordering.
2. **Group by Scope**:
    - Global rules (e.g., `000-global.mdc`) apply universally across projects.
    - Project-specific rules (e.g., `100-nextjs.mdc`) address unique requirements.

### Example Directory Structure:

```plaintext
.cursor/
└── rules/
    ├── 000-global.mdc
    ├── 100-typescript.mdc
    ├── 200-eslint.mdc
```

---

## **Step 5: Testing and Adjusting Rules**

1. Open a project in Cursor and observe whether your rules are being applied as expected.
2. If a rule isn’t working, check:
    - The accuracy of your glob patterns.
    - The clarity of your description field.
3. Update or refine rules based on feedback from Cursor’s behavior.

### Example Adjustment:

If a rule isn’t applying to `.jsx` files as intended, update the glob pattern:

```plaintext
globs:
  - "*.jsx"
```

---

## **Best Practices**

1. Start small—create a few essential rules and expand as needed.
2. Regularly review and refine your rules based on AI performance and project needs.
3. Avoid overly complex or redundant rules; simplicity improves effectiveness.

By following these steps, you can create robust and efficient Cursor rules tailored to your coding workflow.

<div style="text-align: center">⁂</div>

[^1]: https://www.reddit.com/r/ChatGPTCoding/comments/1hu276s/how_to_use_cursor_more_efficiently/

[^2]: https://www.reddit.com/r/cursor/comments/1j3buqr/new_to_cursor_whats_the_best_configuration_to_get/

[^3]: https://www.reddit.com/r/cursor/comments/1j8s1w7/youre_using_cursor_rules_the_wrong_way/

[^4]: https://www.reddit.com/r/cursor/comments/1j7rdoa/i_use_cursor_daily_heres_how_i_avoid_the_garbage/

[^5]: https://www.reddit.com/r/ClaudeAI/comments/1fdrbwa/so_how_many_of_you_have_permanently_switched_to/

[^6]: https://www.reddit.com/r/cursor/comments/1hkgyj6/im_new_to_cursor_and_was_wondering_is_there_a/

[^7]: https://www.reddit.com/r/ChatGPTCoding/comments/1cft751/my_experience_with_github_copilot_vs_cursor/

[^8]: https://www.reddit.com/r/cursor/comments/1h7a7ue/best_setting_you_have_come_up_with/

[^9]: https://www.youtube.com/watch?v=QXOZfIUOnQM

[^10]: https://workos.com/blog/what-are-cursor-rules

[^11]: https://forum.cursor.com/t/using-the-project-rules-in-0-45-2/44447

[^12]: https://forum.cursor.com/t/my-best-practices-for-mdc-rules-and-troubleshooting/50526

[^13]: https://docs.cursor.com/context/rules-for-ai

[^14]: https://www.reddit.com/r/ChatGPTCoding/comments/1j7ziag/sharing_my_cursor_rule_for_maintaining_best/

[^15]: https://rolloutit.net/how-to-create-ai-rules-for-cursor-ai/

[^16]: https://dev.to/heymarkkop/my-top-cursor-tips-v043-1kcg

[^17]: https://forum.cursor.com/t/optimal-structure-for-mdc-rules-files/52260

