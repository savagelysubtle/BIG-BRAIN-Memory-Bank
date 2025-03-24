# Project Rules and Learned Patterns

## 🧠 Project Intelligence

This document captures learned patterns, conventions, and preferences specific
to this project. It evolves throughout the project lifecycle as new insights are
discovered.

## 🔍 Code Conventions

### Naming Conventions

- **Files**: [Pattern for file naming]
- **Classes**: [Pattern for class naming]
- **Functions/Methods**: [Pattern for function naming]
- **Variables**: [Pattern for variable naming]
- **Constants**: [Pattern for constant naming]

### Formatting Standards

- **Indentation**: [Tab/Spaces, count]
- **Line Length**: [Maximum characters]
- **Comments**: [Style and frequency expectations]
- **Whitespace**: [Rules for whitespace usage]

## 🏗️ Project-Specific Patterns

### Architecture Patterns

- **[Pattern 1]**: [Description and usage examples]
- **[Pattern 2]**: [Description and usage examples]

### Design Patterns

- **[Pattern 1]**: [Description and usage examples]
- **[Pattern 2]**: [Description and usage examples]

## 🧰 Component Patterns

- **[Component Type 1]**: [Structure, usage patterns]
- **[Component Type 2]**: [Structure, usage patterns]

## 📊 Data Handling

- **State Management**: [Conventions for managing state]
- **API Integration**: [Patterns for API calls]
- **Error Handling**: [Standard error handling approaches]
- **Data Validation**: [Approaches to validation]

## 🧪 Testing Approach

- **Unit Tests**: [Conventions and requirements]
- **Integration Tests**: [Conventions and requirements]
- **Test Data**: [How to create and manage test data]

## 🚫 Anti-Patterns

- **[Anti-Pattern 1]**: [Description and why to avoid]
- **[Anti-Pattern 2]**: [Description and why to avoid]

## 👤 User Preferences

- **UI/UX Preferences**: [User preferences for interface design]
- **Workflow Preferences**: [User preferences for development workflow]
- **Documentation Style**: [Preferred documentation approaches]
- **Communication Style**: [Preferred communication style]

## 📜 Documentation Patterns

### XML-Structured Documentation

- **Pattern**: Use XML-like tags for structured documentation in rule files
- **Implementation**:

  ```
  <version>1.1.0</version>

  <context>
    Description of the rule's context and purpose
  </context>

  <requirements>
    <requirement>First requirement description</requirement>
    <requirement>Second requirement description</requirement>
  </requirements>
  ```

- **Usage**: All Cursor rule files (.mdc) should follow this pattern
- **Benefits**: Improved parsing, clearer organization, better maintainability

### TL;DR Summaries

- **Pattern**: Include a brief TL;DR summary at the top of each rule file
- **Implementation**:
  ```
  > **TL;DR:** Brief one-line summary of the rule's purpose and function.
  ```
- **Usage**: Required for all Cursor rules to provide quick understanding
- **Benefits**: Quick grasp of rule purpose without reading entire file

### Section Headers with Emoji

- **Pattern**: Use emoji prefixes for section headers to improve scannability
- **Implementation**:
  ```
  ## 🧠 Cognitive Memory Architecture
  ## 🔄 Command Processing
  ## 🚀 Protocol Commands
  ```
- **Usage**: All documentation files and rule files
- **Benefits**: Visual scanning aid, improved readability, consistent style

## 🔄 Command System Patterns

### Command Category Organization

- **Pattern**: Organize commands into distinct categories with clear
  responsibilities
- **Implementation**:
  - Core Commands: Basic Memory Bank operations (initialize, update, check,
    query)
  - Mode Commands: Workflow control (switch mode, set complexity)
  - Protocol Commands: Special procedures (bedtime protocol, creative phase)
  - Quick Start Command: Comprehensive initialization (BIG command)
- **Usage**: All command processing should recognize and route based on
  categories
- **Benefits**: Clear organization, easier extensibility, improved user
  understanding

### Nested Command Hierarchy

- **Pattern**: Structure commands in hierarchical levels for complex operations
- **Implementation**:
  - Primary Commands: Base command (e.g., "update memory bank")
  - Secondary Commands: Subcommands with colons (e.g., "update memory bank:
    core-files")
  - Tertiary Commands: Options with flags (e.g., "update memory bank --force")
- **Usage**: When operations need more granular control or specification
- **Benefits**: Allows complex operations while maintaining command clarity

### Command Parameter Formats

- **Pattern**: Support multiple parameter formats for flexibility
- **Implementation**:
  - Colon Parameters: command: parameter
  - Flag Parameters: command --option
  - Space Parameters: command parameter
- **Usage**: All command implementations should recognize these formats
- **Benefits**: More natural command phrasing, flexibility for users

### Command Feedback Format

- **Pattern**: Provide standardized, clearly formatted command feedback
- **Implementation**:

  ```
  ✓ COMMAND COMPLETED

  Section Title:
  - [Detail point 1]
  - [Detail point 2]

  Section Title:
  - [Detail point 1]
  - [Detail point 2]

  → Summary or next steps
  ```

- **Usage**: All command responses should follow this structured format
- **Benefits**: Consistent user experience, clear operation feedback

## 🧠 Cognitive Memory Patterns

### Memory Type Organization

- **Pattern**: Organize memory based on cognitive memory types
- **Implementation**:
  - Working Memory: Active context in memory-bank/active
  - Episodic Memory: Experience-based information in
    memory-bank/long-term/episodic
  - Semantic Memory: Knowledge-based information in
    memory-bank/long-term/semantic
  - Procedural Memory: Process-based information in
    memory-bank/long-term/procedural
- **Usage**: All memory operations should respect this organization
- **Benefits**: More natural information storage, improved retrieval, better
  memory management

### Memory Strength Tracking

- **Pattern**: Track memory strength for optimized retention
- **Implementation**:
  - High Strength: Recently accessed, frequently used items
  - Medium Strength: Periodically accessed items
  - Low Strength: Rarely accessed items
  - Include strength indicators in file metadata
- **Usage**: Session summaries, bedtime protocol, memory updates
- **Benefits**: Prioritization of important information, directed reinforcement

### Memory Process Flow

- **Pattern**: Follow established cognitive processes for memory operations
- **Implementation**:
  - Encoding: Convert information into structured memory
  - Retrieval: Access stored information when needed
  - Reinforcement: Strengthen memory through review
  - Optimization: Improve memory system through strategies
- **Usage**: All memory operations should align with these processes
- **Benefits**: Scientifically-grounded approach, improved recall and stability

## 🌐 Platform Awareness Patterns

### OS Detection Pattern

- **Pattern**: Detect operating system from workspace metadata
- **Implementation**:
  - Extract OS information from user_info section
  - Parse shell information for additional context
  - Set platform flags for Windows/Unix/macOS
- **Usage**: All platform-specific operations
- **Benefits**: Automatic adaptation without user configuration

### Path Normalization Pattern

- **Pattern**: Normalize file paths based on detected OS
- **Implementation**:
  - Windows: Use backslashes and drive letters
  - Unix/macOS: Use forward slashes
  - Handle spaces appropriately for each platform
- **Usage**: All file operations
- **Benefits**: Cross-platform compatibility without manual adjustments

### Command Adaptation Pattern

- **Pattern**: Adapt commands based on detected OS
- **Implementation**:
  - Windows: PowerShell syntax and commands
  - Unix/macOS: Bash syntax and commands
  - Suppress commands incompatible with current OS
- **Usage**: All terminal commands and script execution
- **Benefits**: Platform-appropriate behavior without user intervention

## 🏗️ Integration Patterns

### Rule Bridge Pattern

- **Pattern**: Create bridge rules that connect different functional areas
- **Implementation**:
  - Cross-reference related rules in context sections
  - Define clear interaction points between rules
  - Establish hierarchical rule relationships
- **Usage**: Complex rule interactions, workflow integration
- **Benefits**: Cohesive rule system, clear relationships, improved
  functionality

### Command-Memory Integration

- **Pattern**: Connect command system directly to memory operations
- **Implementation**:
  - Commands trigger specific memory processes
  - Memory operations provide standardized feedback
  - Command categories align with memory types
- **Usage**: All command implementations
- **Benefits**: Unified experience, consistent operations, intuitive usage

## 📝 Decision Records

### XML Structure for Rules

- **Context**: Original rule format lacked clear structure and was difficult to
  parse
- **Decision**: Implement XML-like structure for all rule files
- **Rationale**: Improves clarity, parsing, and organization while maintaining
  markdown compatibility
- **Consequences**: More structured rules, easier maintenance, slight increase
  in verbosity
- **Date**: 2024-03-24

### Cognitive Memory Model Implementation

- **Context**: Need for more scientifically-grounded memory organization
- **Decision**: Implement cognitive memory model with working memory and
  long-term memory types
- **Rationale**: Aligns with human memory processes, improves organization and
  retrieval
- **Consequences**: More structured memory organization, better information
  management
- **Date**: 2024-03-24

### Hierarchical Command System

- **Context**: Need for more flexible and powerful command interface
- **Decision**: Implement hierarchical command system with nested commands
- **Rationale**: Supports both simple and complex operations with consistent
  syntax
- **Consequences**: More powerful command capabilities, slightly more complex
  implementation
- **Date**: 2024-03-24

### Platform Awareness Implementation

- **Context**: Cross-platform compatibility issues, especially with file paths
  and commands
- **Decision**: Implement comprehensive platform awareness with automatic OS
  detection
- **Rationale**: Provides seamless experience across different operating systems
- **Consequences**: Improved compatibility, more complex command processing
- **Date**: 2024-03-24

## 🔄 Evolution of Patterns

### Rule Documentation Pattern

- **Initial Implementation**: Basic markdown with headers and sections
- **Current Implementation**: XML-structured format with version, context,
  requirements
- **Reason for Change**: Improved clarity, better parsing, more consistent
  structure
- **Date of Change**: 2025-03-24

### Memory Organization Pattern

- **Initial Implementation**: Simple directory structure with basic file
  categories
- **Current Implementation**: Cognitive model with working memory and long-term
  memory types
- **Reason for Change**: More scientifically-grounded approach, better alignment
  with human memory
- **Date of Change**: 2025-03-24

### Command Interface Pattern

- **Initial Implementation**: Basic commands without formal structure
- **Current Implementation**: Hierarchical command system with nested commands
- **Reason for Change**: Need for more power and flexibility, improved user
  experience
- **Date of Change**: 2025-03-24

## 📝 Version History

| Version | Date       | Author    | Changes                                    |
| ------- | ---------- | --------- | ------------------------------------------ |
| 0.1     | 2023-05-01 | BIG BRAIN | Initial draft                              |
| 0.2     | 2023-05-15 | BIG BRAIN | Updated with repository structure patterns |
| 0.3     | 2025-03-24 | BIG BRAIN | Added XML structure and command patterns   |
| 0.4     | 2025-03-24 | BIG BRAIN | Added cognitive memory patterns            |
| 0.5     | 2025-03-24 | BIG BRAIN | Added platform awareness patterns          |
