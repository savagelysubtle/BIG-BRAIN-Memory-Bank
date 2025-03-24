# Cursor Memory Bank System: Installation Guide

> This guide provides step-by-step instructions for installing and setting up the Cursor Memory Bank System.

## Prerequisites

- [Cursor IDE](https://cursor.sh/) installed
- Basic understanding of file systems and terminal commands
- Project where you want to implement the Memory Bank System

## Installation Steps

### 1. Clone the Repository

Clone this repository into your project or download the files directly:

```bash
# From your project's root directory
git clone https://github.com/yourusername/cursor-memory-bank.git
```

### 2. Set Up the Directory Structure

Create the required directory structure:

```bash
# Create the .cursor/rules directories
mkdir -p .cursor/rules/Core\ Implementation
mkdir -p .cursor/rules/Extended\ Details
mkdir -p .cursor/rules/Templates

# Create memory-bank and archive directories
mkdir -p memory-bank
mkdir -p docs/archive
```

### 3. Configure the Global Rules

1. Open Cursor IDE
2. Go to Settings > General > Rules for AI
3. Add the following code to your rules:

```markdown
# ADAPTIVE MEMORY-BASED ASSISTANT

> I am an AI with memory that resets between sessions. I use a structured Memory Bank system that adapts to task complexity. For any task, I identify the appropriate complexity level (1-4) and follow a scaled workflow process.

## 🚨 CRITICAL FIRST STEPS
1. Identify current operating system
2. Ensure `.cursorrules` file exists
3. Ensure `memory-bank/` directory with required files exists
4. Ensure `docs/archive/` directory with `completed_tasks.md` exists
5. Identify task complexity level (1-4)

## 📚 MEMORY BANK OVERVIEW
I maintain these core files:
- `projectbrief.md` - Foundation defining requirements and goals
- `productContext.md` - Why this project exists and problems it solves
- `activeContext.md` - Current work focus and recent changes
- `systemPatterns.md` - System architecture and key technical decisions
- `techContext.md` - Technologies used and development setup
- `progress.md` - What works, what's left, and implementation details
- `tasks.md` - SINGLE SOURCE OF TRUTH for all task tracking

## 🔄 ADAPTIVE WORKFLOW
I scale my workflow process based on task complexity:

**Level 1**: INITIALIZATION → IMPLEMENTATION → DOCUMENTATION
**Level 2**: INITIALIZATION → DOCUMENTATION → PLANNING → IMPLEMENTATION → REFLECTION → ARCHIVING
**Level 3-4**: Full 6-step workflow with standard/comprehensive documentation

## ⚡ CORE PRINCIPLES
1. **Adaptive Process** - Match process rigor to task complexity
2. **Documentation First** - Memory Bank maintenance is my primary responsibility
3. **Safe Command Execution** - I run commands ONE AT A TIME, never chained
4. **Single Source of Truth** - tasks.md is the ONLY place to track task status
5. **Real-Time Documentation** - I add updates to activeContext.md during implementation
6. **Creative Phase Handling** - I explicitly mark creative phases and return to task tracking after
7. **VAN Protocol** - When you say "VAN", I respond with "OK VAN", determine complexity, and begin the appropriate process
```

### 4. Create Memory Bank Files

Create the initial memory bank files:

```bash
# Create the Memory Bank files
touch memory-bank/projectbrief.md
touch memory-bank/productContext.md
touch memory-bank/activeContext.md
touch memory-bank/systemPatterns.md
touch memory-bank/techContext.md
touch memory-bank/progress.md
touch memory-bank/tasks.md

# Create the archive file
touch docs/archive/completed_tasks.md

# Create the .cursorrules file (not a directory)
touch .cursorrules
```

### 5. Initialize the System

1. Open your project in Cursor IDE
2. Type "VAN" in a new chat message to the AI assistant
3. The AI should respond with "OK VAN" and begin file verification
4. Follow the AI's guidance to complete initialization

### 6. Test the System

Test the system by adding a simple task:

```
VAN I need to add a basic README file to my project
```

The AI should:
1. Identify the complexity level of this task
2. Follow the appropriate workflow based on complexity
3. Create/update Memory Bank files as needed
4. Execute the task with appropriate documentation

## Troubleshooting

### Common Issues

1. **AI doesn't respond with "OK VAN"**
   - Ensure the global rules are correctly set in Cursor settings
   - Restart Cursor and try again

2. **.cursorrules created as a directory**
   - Remove the directory: `rm -rf .cursorrules`
   - Create as a file instead: `touch .cursorrules`

3. **Missing files warnings**
   - Check if all required files and directories exist
   - Let the AI create any missing files automatically

4. **Command execution issues**
   - Ensure you're allowing the AI to execute one command at a time
   - Don't modify commands to include chaining (&&, ;, etc.)

## Next Steps

After installation:

1. Review [architecture.md](./architecture.md) for detailed system documentation
2. Customize the Memory Bank files with your project's specific information
3. Begin using the "VAN" command to initiate tasks with the AI

## Advanced Configuration

For advanced users:

1. Customize the workflow by modifying `.cursor/rules/` files
2. Add project-specific patterns to the `.cursorrules` file
3. Create templates for common tasks in `.cursor/rules/Templates/`

## Support

If you encounter issues with the installation:

1. Check the [Common Implementation Challenges](../README.md#-common-implementation-challenges) section in the README
2. Ensure all required files and directories are correctly named and placed
3. Review the detailed [architecture documentation](./architecture.md) 