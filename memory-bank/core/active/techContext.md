# Technical Context

## 🛠️ Technology Stack

### Core Implementation

- **Language**: Markdown for memory files, MDC for cursor rules
- **File System**: Platform-agnostic file-based storage
- **Integration**: Cursor IDE rule system
- **Configuration**: JSON for memory tool configuration
- **Command System**: XML-structured command processing with hierarchical
  organization
- **Memory Model**: Cognitive memory architecture with scientifically-grounded
  memory types
- **Platform Support**: Multi-platform abstractions for cross-OS compatibility

### Tools

- **Memory Manager**: Python-based tool for memory file management
- **Setup Scripts**: PowerShell (Windows) and Bash (Unix) for initialization
- **Version Control**: Git for repository management
- **Documentation**: Markdown for all documentation
- **Memory Diagnostics**: Integrated tools for memory bank verification
- **Rule Debugging**: Utilities for rule visibility and glob pattern analysis

### Integration Points

- **Cursor IDE**: Primary integration through .cursor/rules system
- **GitHub**: Repository hosting and distribution
- **Local File System**: Storage of memory files
- **Operating System**: Platform detection and environment-specific adaptations
- **Command Interface**: Standardized command system for memory operations

## 🧰 Development Environment

- **Required Tools**:

  - Cursor IDE (required for full functionality)
  - Git (for version control and repository management)
  - PowerShell or Bash (for running setup scripts)
  - Python 3.8+ (for memory management tools)

- **Setup Instructions**:

  ```
  # Windows
  .\scripts\Initialize-MemoryBank.ps1

  # Unix/Linux/macOS
  ./scripts/Initialize-MemoryBank.sh
  ```

- **Editor Configuration**:
  - Cursor IDE with custom rules enabled
  - Markdown file support
  - UTF-8 encoding for all files
  - XML structure support for rule files

## 📋 Coding Standards

- **Style Guide**: Consistent formatting for Markdown files
- **Rule Format**: MDC format for all Cursor rules
- **Documentation Standards**:
  - Clear headers and sections
  - Emoji prefixes for visual scanning
  - Consistent formatting across memory files
  - Version history in all files
- **XML Structure**:
  - Consistent XML-like tags for rule sections
  - Required metadata elements (version, context, requirements)
  - Detailed examples and usage scenarios
  - TL;DR summaries for quick reference

## 🔄 Version Control

- **Repository**: GitHub - BIG BRAIN Memory Bank
- **Branching Strategy**:
  - `main` branch for stable releases
  - Feature branches for enhancements
  - Documentation branches for major doc changes
- **PR/Review Process**:
  - Pull requests required for all changes
  - Documentation updates required for all feature changes
  - Attribution maintained for all contributions
- **Version Management**:
  - Semantic versioning for rule files (major.minor.patch)
  - File versioning in memory bank for historical reference

## 🚀 Deployment

- **Environments**:
  - Local implementation (personal use)
  - GitHub repository (distribution)
- **Installation Process**:
  1. Clone the repository
  2. Run the initialization script
  3. Configure memory bank files for specific project
- **Update Procedures**:
  - Pull latest changes from the repository
  - Run initialization script with the update flag
- **Platform-Specific Instructions**:
  - Automatic detection of operating system
  - Platform-appropriate commands and paths
  - Environment-specific variable handling

## 🔌 External Dependencies

- **Third-Party Services**:
  - None required for core functionality
  - GitHub for distribution only
- **Libraries**:
  - Standard Python libraries for memory manager tool
  - No external JavaScript or other libraries required
- **Licensing**:
  - MIT License for the BIG BRAIN Memory Bank
  - Attribution requirements for original works

## 🧠 Cognitive Memory Implementation

- **Working Memory**:

  - Implementation of capacity-limited buffer (7±2 items)
  - Active context maintenance in memory-bank/active directory
  - Decay mechanisms for temporary information
  - Attention-based reinforcement procedures

- **Long-Term Memory**:

  - Episodic memory implementation in memory-bank/long-term/episodic
  - Semantic memory implementation in memory-bank/long-term/semantic
  - Procedural memory implementation in memory-bank/long-term/procedural
  - Memory strength tracking with reinforcement mechanisms

- **Memory Processes**:

  - Encoding procedures for converting information to memory representations
  - Retrieval methods (recall, recognition, reconstruction)
  - Reinforcement mechanisms (spaced repetition, elaboration, application)
  - Optimization strategies (chunking, structured forgetting, metadata
    enhancement)

- **Memory Operations**:
  - Command-triggered memory operations
  - Scheduled memory maintenance
  - Session-based memory consolidation
  - Context-aware memory retrieval

## 🔄 Command System Technology

- **Command Recognition**:

  - Natural language pattern matching
  - Command variation recognition
  - Case-insensitive processing
  - Partial command matching with intent detection

- **Command Structure**:

  - Hierarchical organization with primary/secondary/tertiary commands
  - Parameter handling with multiple format support
  - Command aliasing system
  - Command disambiguation logic

- **Command Categories**:

  - Core Commands: Basic memory bank operations
  - Mode Commands: Workflow control
  - Protocol Commands: Special procedures
  - Quick Start Command: Comprehensive initialization

- **Command Processing**:
  - Standardized processing pipeline
  - Prerequisite validation
  - Execution with appropriate permissions
  - Feedback generation with consistent formatting
  - Memory file updates

## 🌐 Platform Awareness Technology

- **OS Detection**:

  - Workspace metadata analysis
  - Shell environment detection
  - Path separator identification
  - Environment variable recognition

- **Command Adaptation**:

  - Windows-specific command variants
  - Unix/Linux/macOS command variants
  - PowerShell vs. Bash syntax handling
  - Command suppression for incompatible environments

- **Path Handling**:

  - Adaptive path separators
  - Absolute vs. relative path processing
  - Space handling in different environments
  - Directory traversal compatibility

- **Environment Variables**:
  - Platform-specific environment variable usage
  - Variable substitution in commands
  - Environment-aware configuration

## 🚧 Technical Constraints

- **Cross-Platform Compatibility**:
  - Must work on Windows, macOS, and Linux
  - Path handling must account for different OS conventions
  - Command syntax must adapt to different shell environments
- **Cursor Version Compatibility**:
  - Compatible with current and future Cursor IDE versions
  - Fallback mechanisms for environments without Cursor
- **Simplicity**:
  - Low-tech implementation to maximize compatibility
  - File-based approach to avoid complex dependencies
- **Privacy**:
  - Personal memory files must remain private
  - Repository structure must support public/private separation

## 🔄 Migration Considerations

- **From Traditional Documentation**:
  - Migration path from traditional documentation systems
  - Conversion guides for existing project documentation
- **From Other Memory Bank Systems**:
  - Integration notes for users of Vanzan Memory Bank
  - Migration path from ipenywis Memory Bank
  - Compatibility with both original systems
- **Version Upgrade Path**:
  - Migration from v1.0 to v1.1 memory structure
  - Backward compatibility with existing memory files
  - Upgrade scripts for automated conversion

## 📝 Version History

| Version | Date       | Author    | Changes                                       |
| ------- | ---------- | --------- | --------------------------------------------- |
| 0.1     | 2023-05-10 | BIG BRAIN | Initial draft                                 |
| 0.2     | 2023-05-15 | BIG BRAIN | Updated with repository structure             |
| 0.3     | 2023-05-17 | BIG BRAIN | Refined technical requirements                |
| 0.4     | 2025-03-24 | BIG BRAIN | Added command system technical details        |
| 0.5     | 2025-03-24 | BIG BRAIN | Added cognitive memory implementation details |
| 0.6     | 2025-03-24 | BIG BRAIN | Added platform awareness technology details   |
