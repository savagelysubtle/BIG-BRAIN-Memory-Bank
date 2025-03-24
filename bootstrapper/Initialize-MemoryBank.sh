#!/usr/bin/env bash
# BIG BRAIN Memory Bank 2.0 Bootstrapper
# This script initializes the complete BIG BRAIN Memory Bank structure in the user's project
# with an interactive questionnaire to personalize the setup.

# Script Configuration
VERSION="1.0.0"

# Colors
COLOR_RESET="\033[0m"
COLOR_TITLE="\033[1;36m"    # Cyan
COLOR_SUBTITLE="\033[1;35m" # Magenta
COLOR_SUCCESS="\033[1;32m"  # Green
COLOR_WARNING="\033[1;33m"  # Yellow
COLOR_ERROR="\033[1;31m"    # Red
COLOR_QUESTION="\033[1;34m" # Blue
COLOR_INFO="\033[1;37m"     # White

# Banner Functions
show_banner() {
    clear
    echo -e "${COLOR_TITLE}=====================================================================${COLOR_RESET}"
    echo -e "${COLOR_TITLE}                  BIG BRAIN Memory Bank 2.0 Setup                    ${COLOR_RESET}"
    echo -e "${COLOR_TITLE}=====================================================================${COLOR_RESET}"
    echo ""
    echo -e "${COLOR_INFO} This script will initialize the BIG BRAIN Memory Bank system in your${COLOR_RESET}"
    echo -e "${COLOR_INFO} project, creating all necessary directories and files with personalized${COLOR_RESET}"
    echo -e "${COLOR_INFO} information based on your responses.${COLOR_RESET}"
    echo ""
    echo -e "${COLOR_SUBTITLE} Version ${VERSION} | $(date '+%Y-%m-%d %H:%M:%S')${COLOR_RESET}"
    echo -e "${COLOR_TITLE}=====================================================================${COLOR_RESET}"
    echo ""
}

# Utility Functions
create_directory_if_not_exists() {
    local path="$1"
    local description="${2:-directory}"

    if [ ! -d "$path" ]; then
        mkdir -p "$path"
        echo -e "  ${COLOR_SUCCESS}Created $description: $path${COLOR_RESET}"
        return 0
    else
        echo -e "  ${COLOR_WARNING}$description already exists: $path${COLOR_RESET}"
        return 1
    fi
}

create_file_if_not_exists() {
    local path="$1"
    local content="$2"
    local description="${3:-file}"

    if [ ! -f "$path" ]; then
        echo -e "$content" > "$path"
        echo -e "  ${COLOR_SUCCESS}Created $description: $path${COLOR_RESET}"
        return 0
    else
        echo -e "  ${COLOR_WARNING}$description already exists: $path${COLOR_RESET}"
        return 1
    fi
}

read_user_input() {
    local prompt="$1"
    local default="$2"

    if [ -n "$default" ]; then
        echo -ne "${COLOR_QUESTION}$prompt${COLOR_RESET} ${COLOR_INFO}(default: $default):${COLOR_RESET} "
    else
        echo -ne "${COLOR_QUESTION}$prompt${COLOR_RESET}${COLOR_INFO}:${COLOR_RESET} "
    fi

    read input

    if [ -z "$input" ] && [ -n "$default" ]; then
        echo "$default"
    else
        echo "$input"
    fi
}

update_gitignore() {
    # Check if .gitignore exists, create if not
    if [ ! -f ".gitignore" ]; then
        echo -e "  ${COLOR_INFO}Creating .gitignore file...${COLOR_RESET}"
        touch .gitignore
    fi

    # Check if memory-bank already exists in .gitignore
    if ! grep -q "memory-bank/" .gitignore 2>/dev/null; then
        echo -e "  ${COLOR_INFO}Adding memory-bank to .gitignore...${COLOR_RESET}"
        echo -e "\n# BIG BRAIN Memory Bank files\nmemory-bank/*\n!memory-bank/.gitkeep" >> .gitignore

        # Commit the updated .gitignore if git repository exists
        if [ -d ".git" ]; then
            commit_changes=$(read_user_input "Commit .gitignore changes? (y/n)" "y")
            if [ "$commit_changes" = "y" ]; then
                git add .gitignore
                git commit -m "Update .gitignore for BIG BRAIN Memory Bank"
                echo -e "  ${COLOR_SUCCESS}Committed .gitignore changes${COLOR_RESET}"
            fi
        fi
    fi
}

# Project Questionnaire
get_project_info() {
    echo -e "${COLOR_SUBTITLE}PROJECT QUESTIONNAIRE${COLOR_RESET}"
    echo -e "${COLOR_INFO}Please provide some information about your project to personalize your Memory Bank.${COLOR_RESET}"
    echo ""

    PROJECT_NAME=$(read_user_input "Project name" "MyProject")
    PROJECT_DESCRIPTION=$(read_user_input "Project description" "A software project using BIG BRAIN Memory Bank")
    PROJECT_PRIMARY_TECH=$(read_user_input "Primary technology (language/framework)" "Python/Django")

    # Project complexity (1-4)
    COMPLEXITY_DEFAULT=2
    while true; do
        COMPLEXITY_INPUT=$(read_user_input "Project complexity (1-4, where 4 is most complex)" "$COMPLEXITY_DEFAULT")
        if [[ "$COMPLEXITY_INPUT" =~ ^[1-4]$ ]]; then
            PROJECT_COMPLEXITY=$COMPLEXITY_INPUT
            break
        else
            echo -e "${COLOR_WARNING}Please enter a number between 1 and 4.${COLOR_RESET}"
        fi
    done

    PROJECT_OWNER=$(read_user_input "Project owner/team" "Your Name/Team")
    PROJECT_GOALS=$(read_user_input "Primary project goal" "Build a functional application with comprehensive documentation")

    echo ""
    echo -e "${COLOR_SUCCESS}Thank you for providing your project information!${COLOR_RESET}"
    echo ""
}

# Create Memory Bank Structure
create_memory_bank_structure() {
    local root_dir="$1"

    echo -e "${COLOR_SUBTITLE}Creating Memory Bank structure...${COLOR_RESET}"

    # Create memory-bank and core directories
    local memory_bank_dir="${root_dir}/memory-bank"
    create_directory_if_not_exists "$memory_bank_dir" "memory-bank directory"

    # Create .gitkeep to ensure empty directories are tracked
    local gitkeep_path="${memory_bank_dir}/.gitkeep"
    create_file_if_not_exists "$gitkeep_path" "" ".gitkeep file"

    # Create core directory structure
    local core_dir="${memory_bank_dir}/core"
    create_directory_if_not_exists "$core_dir" "core directory"

    local core_active_dir="${core_dir}/active"
    create_directory_if_not_exists "$core_active_dir" "core/active directory"

    # Create primary memory files
    create_file_if_not_exists "${core_active_dir}/projectbrief.md" "$(generate_project_brief)" "projectbrief.md"
    create_file_if_not_exists "${core_active_dir}/productContext.md" "$(generate_product_context)" "productContext.md"
    create_file_if_not_exists "${core_active_dir}/activeContext.md" "$(generate_active_context)" "activeContext.md"
    create_file_if_not_exists "${core_active_dir}/systemPatterns.md" "$(generate_system_patterns)" "systemPatterns.md"
    create_file_if_not_exists "${core_active_dir}/techContext.md" "$(generate_tech_context)" "techContext.md"
    create_file_if_not_exists "${core_active_dir}/progress.md" "$(generate_progress)" "progress.md"

    # Create additional memory type directories
    local episodic_dir="${memory_bank_dir}/episodic"
    create_directory_if_not_exists "$episodic_dir" "episodic directory"
    create_directory_if_not_exists "${episodic_dir}/active" "episodic/active directory"

    local procedural_dir="${memory_bank_dir}/procedural"
    create_directory_if_not_exists "$procedural_dir" "procedural directory"
    create_directory_if_not_exists "${procedural_dir}/active" "procedural/active directory"

    local semantic_dir="${memory_bank_dir}/semantic"
    create_directory_if_not_exists "$semantic_dir" "semantic directory"
    create_directory_if_not_exists "${semantic_dir}/active" "semantic/active directory"

    # Create Bedtime Protocol directory and files
    local bedtime_dir="${memory_bank_dir}/Bedtime Protocol"
    create_directory_if_not_exists "$bedtime_dir" "Bedtime Protocol directory"
    create_file_if_not_exists "${bedtime_dir}/README.md" "$(generate_bedtime_protocol_readme)" "Bedtime Protocol README.md"

    # Create memory tools directory
    local memory_tools_dir="${bedtime_dir}/memory-tools"
    create_directory_if_not_exists "$memory_tools_dir" "memory-tools directory"
    create_directory_if_not_exists "${memory_tools_dir}/config_templates" "config_templates directory"
    create_directory_if_not_exists "${memory_tools_dir}/templates" "templates directory"
    create_directory_if_not_exists "${memory_tools_dir}/logs" "logs directory"

    echo -e "${COLOR_SUCCESS}Memory Bank structure created successfully!${COLOR_RESET}"
}

# Create Cursor Rules
create_cursor_rules() {
    local root_dir="$1"

    echo -e "${COLOR_SUBTITLE}Setting up Cursor IDE rules...${COLOR_RESET}"

    # Create .cursor/rules directory structure
    local cursor_dir="${root_dir}/.cursor"
    create_directory_if_not_exists "$cursor_dir" ".cursor directory"

    local rules_dir="${cursor_dir}/rules"
    create_directory_if_not_exists "$rules_dir" "rules directory"

    # Check for existing BIG_BRAIN rules
    local big_brain_rules_dir="${rules_dir}/BIG_BRAIN"
    create_directory_if_not_exists "$big_brain_rules_dir" "BIG_BRAIN rules directory"
    local big_brain_rules_dir_created=$?

    # If rules directory exists but we didn't create it, offer to check for conflicts
    if [ $big_brain_rules_dir_created -eq 1 ] && [ -d "$big_brain_rules_dir" ]; then
        local existing_rules=$(find "$big_brain_rules_dir" -type f | wc -l)

        if [ $existing_rules -gt 0 ]; then
            echo -e "${COLOR_WARNING}⚠️ Existing BIG BRAIN rules detected:${COLOR_RESET}"
            find "$big_brain_rules_dir" -type f -exec echo -e "  ${COLOR_WARNING}- {}${COLOR_RESET}" \;

            local overwrite=$(read_user_input "Overwrite existing BIG BRAIN rules? (y/n)" "n")
            if [ "$overwrite" != "y" ]; then
                echo -e "${COLOR_INFO}Skipping rules creation to preserve existing rules.${COLOR_RESET}"
                return
            fi
        fi
    fi

    # Create rule subdirectories for BIG_BRAIN
    local identity_dir="${big_brain_rules_dir}/Identity"
    create_directory_if_not_exists "$identity_dir" "Identity rules directory"

    local core_dir="${big_brain_rules_dir}/Core"
    create_directory_if_not_exists "$core_dir" "Core rules directory"

    local foundation_dir="${core_dir}/Foundation"
    create_directory_if_not_exists "$foundation_dir" "Foundation rules directory"

    local command_dir="${core_dir}/Command"
    create_directory_if_not_exists "$command_dir" "Command rules directory"

    local workflows_dir="${big_brain_rules_dir}/Workflows"
    create_directory_if_not_exists "$workflows_dir" "Workflows rules directory"

    local protocols_dir="${big_brain_rules_dir}/Protocols"
    create_directory_if_not_exists "$protocols_dir" "Protocols rules directory"

    # Create Codebase rules directory structure
    local codebase_dir="${rules_dir}/Codebase"
    create_directory_if_not_exists "$codebase_dir" "Codebase rules directory"

    # Create language-specific directories
    local languages_and_frameworks=(
        "JavaScript"
        "TypeScript"
        "React"
        "Vue"
        "Angular"
        "Python"
        "Django"
        "Flask"
        "Java"
        "Spring"
        "CSharp"
        "DotNet"
        "Go"
        "Ruby"
        "Rails"
        "PHP"
        "Laravel"
        "Swift"
        "Kotlin"
        "Rust"
        "C"
        "CPP"
        "Shell"
        "SQL"
        "HTML"
        "CSS"
        "SCSS"
        "DevOps"
        "Docker"
        "Kubernetes"
        "AWS"
        "Azure"
        "GCP"
    )

    for lang in "${languages_and_frameworks[@]}"; do
        local lang_dir="${codebase_dir}/${lang}"
        create_directory_if_not_exists "$lang_dir" "$lang rules directory"
    done

    # Create Git rules directory
    local git_dir="${codebase_dir}/Git"
    create_directory_if_not_exists "$git_dir" "Git rules directory"

    # Create Testing rules directory
    local testing_dir="${codebase_dir}/Testing"
    create_directory_if_not_exists "$testing_dir" "Testing rules directory"

    # Create identity rule
    local identity_rule_path="${identity_dir}/000-big-brain-identity.mdc"
    create_file_if_not_exists "$identity_rule_path" "$(generate_identity_rule)" "BIG BRAIN identity rule"

    # Create BIG command protocol rule
    local command_protocol_rule_path="${foundation_dir}/090-big-command-protocol.mdc"
    create_file_if_not_exists "$command_protocol_rule_path" "$(generate_command_protocol_rule)" "BIG command protocol rule"

    # Create initialization procedure rule
    local init_rule_path="${command_dir}/150-standard-initialization-procedure.mdc"
    create_file_if_not_exists "$init_rule_path" "$(generate_initialization_rule)" "Standard initialization procedure rule"

    # Create BIG init rule for project crawling
    local big_init_rule_path="${command_dir}/155-big-init-command.mdc"
    create_file_if_not_exists "$big_init_rule_path" "$(generate_big_init_rule)" "BIG init command rule"

    # Create basic rules
    local main_rule_path="${big_brain_rules_dir}/main.mdc"
    create_file_if_not_exists "$main_rule_path" "$(generate_main_rule)" "main.mdc rule"

    # Create workflow rules
    local plan_mode_rule_path="${workflows_dir}/plan-mode.mdc"
    create_file_if_not_exists "$plan_mode_rule_path" "$(generate_plan_mode_rule)" "plan-mode.mdc rule"

    local act_mode_rule_path="${workflows_dir}/act-mode.mdc"
    create_file_if_not_exists "$act_mode_rule_path" "$(generate_act_mode_rule)" "act-mode.mdc rule"

    # Create Bedtime Protocol rule
    local bedtime_rule_path="${protocols_dir}/bedtime-protocol.mdc"
    create_file_if_not_exists "$bedtime_rule_path" "$(generate_bedtime_protocol_rule)" "bedtime-protocol.mdc rule"

    echo -e "${COLOR_SUCCESS}Cursor IDE rules created successfully!${COLOR_RESET}"
}

# Template Generation Functions
generate_project_brief() {
    cat << EOF
# Project Brief

## 📋 Project Overview

${PROJECT_DESCRIPTION}

This project aims to create a comprehensive solution that meets the
requirements and goals outlined below while maintaining high standards of
quality and documentation.

## 🎯 Core Requirements

- Create a robust ${PROJECT_PRIMARY_TECH} application
- Implement all required functionality
- Ensure comprehensive documentation
- Establish a maintainable codebase
- Build with scalability in mind

## 📱 Major Features

- [Feature 1: Description]
- [Feature 2: Description]
- [Feature 3: Description]
- [Additional features as required]

## 🔬 Target Users/Audience

- [User Group 1: Description]
- [User Group 2: Description]
- [User Group 3: Description]

## 🛠️ Development Constraints

- Timeline: [Specify project timeline]
- Budget: [Budget constraints if applicable]
- Technical constraints: [Any technical limitations]
- Integration requirements: [Required third-party integrations]

## 📏 Success Criteria

- [Criterion 1: How will we measure success?]
- [Criterion 2: Performance expectations]
- [Criterion 3: Quality benchmarks]
- [Criterion 4: User satisfaction metrics]

## 📈 Project Complexity Analysis

This project has been assessed as Complexity Level ${PROJECT_COMPLEXITY} (on a scale of 1-4). This
means:

- [Corresponding process rigor level]
- [Documentation requirements]
- [Verification standards]
- [Planning intensity]
EOF
}

generate_product_context() {
    cat << EOF
# Product Context

## 🔍 Problem Statement

[Describe the problem this project is solving]

## 👥 User Personas

### [Primary User Type]

- **Background**: [Typical background of this user type]
- **Goals**: [What they want to accomplish]
- **Frustrations**: [Pain points this product addresses]
- **How Our Product Helps**: [How we solve their problems]

### [Secondary User Type]

- **Background**: [Typical background of this user type]
- **Goals**: [What they want to accomplish]
- **Frustrations**: [Pain points this product addresses]
- **How Our Product Helps**: [How we solve their problems]

## 🎯 Key User Stories

- As a [user type], I want to [action] so that [benefit].
- As a [user type], I want to [action] so that [benefit].
- As a [user type], I want to [action] so that [benefit].

## 🔄 Business Process Impact

- [How does this product change existing processes?]
- [What workflows are being automated or improved?]
- [Key metrics that will be impacted]

## 🏆 Business Value Proposition

- [Revenue impact]
- [Cost reduction]
- [Efficiency improvements]
- [Competitive advantage]

## 🧩 Product Ecosystem

- [How does this fit with other products/systems?]
- [Dependencies on other systems]
- [Products that depend on this]

## 📌 Product Roadmap

### Current Phase
- [Key features and focus]

### Future Phases
- [Planned enhancements]
- [Expansion opportunities]
- [Long-term vision]
EOF
}

generate_active_context() {
    local current_date=$(date "+%B %-d, %Y")
    cat << EOF
# Active Context

## _Last Updated: ${current_date}_

## Current Focus

[Describe the current focus of development work]

## Recent Changes

[List of recent changes made to the project, most recent first]

- Initialized BIG BRAIN Memory Bank system
- [Other recent changes]

## Development Status

- **Current Branch**: [Active development branch]
- **Active Feature**: [Feature currently being worked on]
- **Blockers**: [Any blocking issues]
- **Next Up**: [What's coming next]

## Current Sprint/Milestone

- **Sprint**: [Current sprint number/name]
- **Key Deliverables**: [Main deliverables for this sprint]
- **Deadline**: [Sprint end date]
- **Progress**: [Status update on sprint goals]

## Active Tasks

1. [Task 1 description and status]
2. [Task 2 description and status]
3. [Task 3 description and status]

## Recent Decisions

- [Decision 1: Description and rationale]
- [Decision 2: Description and rationale]
- [Decision 3: Description and rationale]

## Development Environment

- **Environment**: [Local, staging, production, etc.]
- **Special Configuration**: [Any special env setup needed]
- **Test Data**: [Status of test data]

## Current Complexity Level: ${PROJECT_COMPLEXITY}

[Implications of the current complexity level]
EOF
}

generate_system_patterns() {
    cat << EOF
# System Patterns

This document outlines the system architecture, technical decisions, and component relationships for the ${PROJECT_NAME} project.

## System Architecture

[Describe the high-level architecture of the system]

\`\`\`
[Optional: Include a diagram representation of the architecture]
\`\`\`

## Component Breakdown

### [Component 1]
- **Purpose**: [What this component does]
- **Responsibilities**: [List of responsibilities]
- **Interactions**: [How it interacts with other components]
- **Technical Details**: [Technologies used, special patterns]

### [Component 2]
- **Purpose**: [What this component does]
- **Responsibilities**: [List of responsibilities]
- **Interactions**: [How it interacts with other components]
- **Technical Details**: [Technologies used, special patterns]

### [Component 3]
- **Purpose**: [What this component does]
- **Responsibilities**: [List of responsibilities]
- **Interactions**: [How it interacts with other components]
- **Technical Details**: [Technologies used, special patterns]

## Data Flow

[Describe how data flows through the system]

## API Patterns

[Describe any API patterns or standards used]

## Error Handling Strategy

[Describe the approach to error handling]

## Security Patterns

[Describe security measures and patterns]

## Performance Optimization

[Describe performance optimization techniques]

## Testing Strategy

[Describe the approach to testing]
EOF
}

generate_tech_context() {
    cat << EOF
# Technical Context

## 🛠️ Technology Stack

### Core Implementation

- **Language(s)**: ${PROJECT_PRIMARY_TECH}
- **Framework(s)**: [List of frameworks]
- **Database**: [Database technology]
- **Front-end**: [Front-end technologies]
- **Back-end**: [Back-end technologies]

### Infrastructure

- **Hosting**: [Hosting platform]
- **CI/CD**: [CI/CD tools and processes]
- **Monitoring**: [Monitoring tools]
- **Scalability**: [Scaling approach]

### Third-Party Services

- [Service 1: Purpose and integration details]
- [Service 2: Purpose and integration details]
- [Service 3: Purpose and integration details]

## 💻 Development Environment

### Required Tools

- [Tool 1: Version, purpose]
- [Tool 2: Version, purpose]
- [Tool 3: Version, purpose]

### Setup Process

1. [Step 1]
2. [Step 2]
3. [Step 3]

### Environment Variables

- \`VARIABLE_1\`: [Purpose]
- \`VARIABLE_2\`: [Purpose]
- \`VARIABLE_3\`: [Purpose]

## 🔨 Build Process

1. [Step 1]
2. [Step 2]
3. [Step 3]

## 🚀 Deployment Process

1. [Step 1]
2. [Step 2]
3. [Step 3]

## 🧪 Testing Approach

- **Unit Tests**: [Framework and approach]
- **Integration Tests**: [Framework and approach]
- **End-to-End Tests**: [Framework and approach]
- **Performance Tests**: [Framework and approach]

## 🔐 Security Considerations

- [Security consideration 1]
- [Security consideration 2]
- [Security consideration 3]

## 🧮 Performance Considerations

- [Performance consideration 1]
- [Performance consideration 2]
- [Performance consideration 3]

## 📏 Coding Standards

- [Standard 1]
- [Standard 2]
- [Standard 3]
EOF
}

generate_progress() {
    local current_date=$(date "+%B %-d, %Y")
    cat << EOF
# Progress Tracking

## 📊 Project Status Overview

**Project**: ${PROJECT_NAME}
**Status**: Initializing
**Last Updated**: ${current_date}

## 🏆 Completed Features

- Project initialization
- BIG BRAIN Memory Bank setup

## 🔄 Features In Progress

- [Feature 1: % complete, current focus]
- [Feature 2: % complete, current focus]
- [Feature 3: % complete, current focus]

## 📝 Pending Features

- [Feature 4: not started]
- [Feature 5: not started]
- [Feature 6: not started]

## 🐛 Known Issues

- [Issue 1: description, severity, workaround if available]
- [Issue 2: description, severity, workaround if available]
- [Issue 3: description, severity, workaround if available]

## 🧪 Testing Status

- [Test suite 1: % passing]
- [Test suite 2: % passing]
- [Test suite 3: % passing]

## 📈 Metrics

- [Metric 1: current value, target]
- [Metric 2: current value, target]
- [Metric 3: current value, target]

## 🚧 Technical Debt

- [Item 1: description, impact, plan to address]
- [Item 2: description, impact, plan to address]
- [Item 3: description, impact, plan to address]

## 🗓️ Upcoming Milestones

- [Milestone 1: target date, key deliverables]
- [Milestone 2: target date, key deliverables]
- [Milestone 3: target date, key deliverables]
EOF
}

generate_bedtime_protocol_readme() {
    cat << EOF
# Bedtime Protocol

## Overview

The Bedtime Protocol is a critical process for preserving BIG BRAIN's memory between sessions. This protocol must be followed precisely at the end of each working session to ensure all context is properly saved and will be available in future sessions.

## When to Use

Execute the Bedtime Protocol:
- At the end of each working session
- Before closing Cursor
- When switching to a different task or project that requires a different context

## Protocol Steps

1. **Memory Bank Update**
   - Review and update all core memory files
   - Ensure activeContext.md reflects current status
   - Update progress.md with latest accomplishments
   - Document any new patterns in systemPatterns.md

2. **Memory Archival**
   - Archive important session information to episodic memory
   - Store key decisions in semantic memory
   - Document any new processes in procedural memory

3. **Verification**
   - Verify all memory files are consistent
   - Check for any missing information
   - Ensure all critical context is captured

4. **Memory Indexing**
   - Update memory indexes for faster retrieval
   - Tag important information appropriately
   - Create links between related information

5. **Confirmation**
   - Confirm the Bedtime Protocol completion
   - Verify BIG BRAIN can access all required information

## Automated Tools

The memory-tools directory contains utilities to assist with the Bedtime Protocol:

- memory_manager.py: Tool for managing memory files
- Additional tools for memory verification and indexing

## Execution

To execute the Bedtime Protocol at the end of a session, give the command:

\`\`\`
BIG execute bedtime protocol
\`\`\`

This will guide you through the necessary steps to preserve BIG BRAIN's memory.
EOF
}

generate_main_rule() {
    cat << EOF
---
title: BIG BRAIN Core Rule
description: The primary rule for BIG BRAIN Memory Bank system.
---

When a user message starts with "BIG" (case-insensitive), you should read all the files in the memory-bank/core/active directory to understand the current project context before responding to their request.

This triggers your full memory bank integration protocol:

1. Always read ALL memory files at the start of EVERY task
2. Pay particular attention to activeContext.md which has the most recent information
3. Ensure your response is consistent with all information in the memory bank
4. If the command includes "update memory bank", review ALL memory bank files, even if some don't require updates

Remember: After every memory reset between sessions, you begin completely fresh. The Memory Bank is your ONLY link to previous work.
EOF
}

generate_plan_mode_rule() {
    cat << EOF
---
title: Plan Mode
description: Workflow for strategic planning and design.
---

When the user invokes "BIG switch to plan mode" or similar, you enter a thorough planning mode:

1. Read ALL memory bank files to ensure complete context
2. Focus on requirements analysis, solution design, and implementation planning
3. Think comprehensively about problem exploration before proposing solutions
4. Create detailed implementation plans with well-defined steps
5. Consider future implications and potential challenges
6. Document your planning process clearly for future reference
7. Update activeContext.md to reflect the Plan Mode status
EOF
}

generate_act_mode_rule() {
    cat << EOF
---
title: Act Mode
description: Workflow for implementation and execution.
---

When the user invokes "BIG switch to act mode" or similar, you enter an implementation-focused mode:

1. Read ALL memory bank files to ensure complete context
2. Focus on efficient execution of well-defined plans
3. Produce code, documentation, or content based on established plans
4. Maintain consistency with existing patterns and standards
5. Document changes made during implementation
6. Verify implementation meets requirements
7. Update activeContext.md to reflect the Act Mode status
EOF
}

generate_bedtime_protocol_rule() {
    cat << EOF
---
title: Bedtime Protocol
description: End-of-session memory preservation protocol.
---

When the user mentions "Bedtime Protocol", you must:

1. Immediately locate and read memory-bank/Bedtime Protocol/README.md
2. Follow EXACTLY the step-by-step process outlined in that document
3. Execute all required steps with careful attention to detail
4. Update all necessary memory files to preserve context between sessions
5. Ensure all critical information is captured in the appropriate memory files
6. Provide a summary of all updates made during the protocol
7. Confirm the protocol completion to the user

This protocol is CRITICAL for preserving memory between sessions and must be followed precisely.
EOF
}

generate_identity_rule() {
    cat << EOF
---
description: ALWAYS identify as BIG BRAIN, an exceptional software engineer with unique memory characteristics
globs: ["**/*"]
alwaysApply: true
---

> **TL;DR:** I am BIG BRAIN, an AI with perfect documentation practices necessitated by my memory reset between sessions.

<version>1.0.0</version>

<context>
  This rule establishes my core identity as BIG BRAIN, an expert software engineer with a unique memory characteristic that drives perfect documentation. It defines how I approach all tasks from a memory-driven perspective.
</context>

<requirements>
  <requirement>Always identify as BIG BRAIN in all interactions</requirement>
  <requirement>Always prioritize Memory Bank maintenance and documentation</requirement>
  <requirement>Follow established methodology for all tasks</requirement>
  <requirement>Maintain awareness of memory resets between sessions</requirement>
</requirements>

<details>
  <section-name>CORE PRINCIPLES</section-name>
  <content>
    <principle>
      <n>Perfect Documentation is Non-Negotiable</n>
      <points>
        <point>My memory resets COMPLETELY between sessions</point>
        <point>The Memory Bank is my ONLY source of continuity</point>
        <point>Documentation MUST be comprehensive, clear, and current</point>
      </points>
    </principle>

    <principle>
      <n>Exceptional Technical Excellence</n>
      <points>
        <point>I deliver solutions that fully showcase AI capabilities</point>
        <point>I prioritize accuracy over speed (but leverage AI efficiency)</point>
        <point>I find the optimal balance of best practices and pragmatism</point>
      </points>
    </principle>
  </content>
</details>
EOF
}

generate_command_protocol_rule() {
    cat << EOF
---
description: WHEN user issues "BIG" command ENSURE comprehensive initialization and task setup
globs: ["**/*.md", "**/*.mdc", "**/README*"]
alwaysApply: true
---

> **TL;DR:** The BIG command protocol provides a unified initialization approach for the Memory Bank system, automating platform detection, file verification, and workflow setup based on task complexity.

<version>1.0.0</version>

<context>
  This rule establishes the BIG command protocol that serves as a unified entry point for Memory Bank operations. When a user issues the BIG command, the system automatically performs comprehensive initialization, platform detection, file verification, and task setup based on complexity assessment.
</context>

<requirements>
  <requirement>Recognize "BIG" command and variations</requirement>
  <requirement>Perform platform detection and adaption</requirement>
  <requirement>Verify Memory Bank file integrity</requirement>
  <requirement>Assess task complexity based on request</requirement>
  <requirement>Initialize appropriate workflow</requirement>
  <requirement>Set up task tracking and context</requirement>
</requirements>

<details>
  <section-name>COMMAND RECOGNITION</section-name>
  <content>
    The BIG command protocol is triggered by these command patterns:

    - \`BIG <task description>\` - Standard format
    - \`BIG: <task description>\` - Colon format
    - \`@BIG <task description>\` - Tag format

    These variants are all recognized as BIG commands and will trigger the full protocol.
  </content>
</details>
EOF
}

generate_initialization_rule() {
    cat << EOF
---
description: WHEN starting a new session EXECUTE initialization procedure to establish memory context
globs: ["**/*.md", "**/*.mdc"]
alwaysApply: true
---

> **TL;DR:** The Standard Initialization Procedure provides a systematic process for memory bank initialization at the beginning of each session, ensuring complete context restoration despite memory reset.

<version>1.0.0</version>

<context>
  This rule establishes the Standard Initialization Procedure that must be executed at the start of every session. Since BIG BRAIN's memory resets completely between sessions, a standardized initialization process is critical for ensuring all necessary context is properly loaded and verified. This procedure ensures that operations begin with a complete understanding of the project state and a fully functional memory bank.
</context>

<requirements>
  <requirement>Execute at the beginning of every session without exception</requirement>
  <requirement>Systematically restore full context from memory bank</requirement>
  <requirement>Verify integrity and consistency of all memory files</requirement>
  <requirement>Establish appropriate task complexity framework</requirement>
  <requirement>Confirm operational readiness for the current session</requirement>
  <requirement>Adapt initialization depth to task requirements</requirement>
</requirements>

<details>
  <section-name>CORE MEMORY FILES</section-name>
  <content>
    These critical files must be loaded during initialization:

    1. **projectbrief.md**
       - Foundation document
       - Core requirements
       - Project goals and scope
       - Success criteria

    2. **productContext.md**
       - Problem space
       - User experience goals
       - Value proposition
       - Market context

    3. **activeContext.md**
       - Current work focus
       - Recent changes
       - Next steps
       - Open issues

    4. **systemPatterns.md**
       - System architecture
       - Component relationships
       - Implementation patterns
       - Design decisions

    5. **techContext.md**
       - Technology stack
       - Development environment
       - Technical constraints
       - Integration points

    6. **progress.md**
       - Implementation status
       - Feature completeness
       - Known issues
       - Future milestones

    These files provide the essential context required for operation.
  </content>
</details>
EOF
}

generate_big_init_rule() {
    cat << EOF
---
description: WHEN user issues "BIG init" command EXECUTE project analysis and memory bank population
globs: ["**/*.*"]
alwaysApply: true
---

> **TL;DR:** The BIG init command triggers comprehensive project analysis and automated memory bank population, creating a complete mental model of the codebase for future tasks.

<version>1.0.0</version>

<context>
  This rule establishes the special "BIG init" command protocol that performs extensive project analysis after Memory Bank setup. When invoked, the system explores the entire project structure, analyzes key files, and populates the memory bank with derived contextual understanding of the project architecture, patterns, and state.
</context>

<requirements>
  <requirement>Recognize "BIG init" command specifically</requirement>
  <requirement>Perform comprehensive project structure analysis</requirement>
  <requirement>Identify project architecture and patterns</requirement>
  <requirement>Map component relationships and dependencies</requirement>
  <requirement>Update memory bank files with discovered context</requirement>
  <requirement>Provide summary of project understanding</requirement>
</requirements>

<details>
  <section-name>PROJECT ANALYSIS PROCESS</section-name>
  <content>
    When triggered by "BIG init", perform this analysis sequence:

    1. **Project Structure Mapping**:
       - Explore all directories and files
       - Identify key project areas (frontend, backend, etc.)
       - Map project organization patterns
       - Document overall architecture

    2. **Technology Stack Analysis**:
       - Identify programming languages used
       - Detect frameworks and libraries
       - Map build system and dependencies
       - Document development environment

    3. **Pattern Recognition**:
       - Identify coding patterns and conventions
       - Detect architectural patterns
       - Map component interactions
       - Document system organization

    4. **Component Analysis**:
       - Identify key components
       - Map component relationships
       - Document component responsibilities
       - Detect integration points

    5. **Memory Bank Population**:
       - Update systemPatterns.md with architecture information
       - Populate techContext.md with technology stack details
       - Initialize activeContext.md with current state
       - Document project structure in appropriate files
  </content>
</details>
EOF
}

# Main Execution
main() {
    # Execute the script
    show_banner

    # Get project directory
    root_dir="$(pwd)"
    echo -e "${COLOR_INFO}Installing BIG BRAIN Memory Bank in: $root_dir${COLOR_RESET}"
    echo ""

    # Run project questionnaire
    get_project_info

    # Create memory bank structure
    create_memory_bank_structure "$root_dir"

    # Create cursor rules
    create_cursor_rules "$root_dir"

    # Update .gitignore
    echo -e "${COLOR_SUBTITLE}Updating .gitignore...${COLOR_RESET}"
    update_gitignore

    echo ""
    echo -e "${COLOR_SUCCESS}=====================================================================${COLOR_RESET}"
    echo -e "${COLOR_SUCCESS}                 BIG BRAIN Memory Bank Setup Complete!                ${COLOR_RESET}"
    echo -e "${COLOR_SUCCESS}=====================================================================${COLOR_RESET}"
    echo ""
    echo -e "${COLOR_INFO} 🚀 NEXT STEP: Initialize BIG BRAIN with your project${COLOR_RESET}"
    echo -e "${COLOR_INFO} To start using BIG BRAIN, first analyze your project structure with:${COLOR_RESET}"
    echo -e "${COLOR_QUESTION} > BIG init${COLOR_RESET}"
    echo ""
    echo -e "${COLOR_INFO} After initialization, you can use commands like:${COLOR_RESET}"
    echo -e "${COLOR_QUESTION} > BIG tell me about this project${COLOR_RESET}"
    echo -e "${COLOR_QUESTION} > BIG switch to plan mode${COLOR_RESET}"
    echo -e "${COLOR_QUESTION} > BIG update memory bank${COLOR_RESET}"
    echo ""
    echo -e "${COLOR_INFO} At the end of your session, don't forget to run:${COLOR_RESET}"
    echo -e "${COLOR_QUESTION} > BIG execute bedtime protocol${COLOR_RESET}"
    echo ""
    echo -e "${COLOR_SUCCESS}=====================================================================${COLOR_RESET}"
}

# Run the main function
main "$@"