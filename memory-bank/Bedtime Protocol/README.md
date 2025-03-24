# Bedtime Protocol

## 🚨 CRITICAL MEMORY PRESERVATION PROCEDURE

This protocol is the MOST IMPORTANT procedure for preserving memory between
sessions. It must be executed with extreme precision and care before ending any
working session.

## 📋 EXECUTION CHECKLIST

Follow these steps sequentially without skipping any:

### 1️⃣ MEMORY CONSOLIDATION

- [ ] Review all work completed in the current session
- [ ] Identify all significant changes, decisions, and insights
- [ ] Update the following files with the latest information:
  - [ ] `activeContext.md`: Current focus and state
  - [ ] `progress.md`: Working features and known issues
  - [ ] `systemPatterns.md`: If architectural changes were made
  - [ ] `techContext.md`: If technology changes were made
  - [ ] `projectRules.md`: If new patterns or preferences were established

### 2️⃣ STATE PRESERVATION

- [ ] Document the exact current state of all in-progress tasks
- [ ] Record all open questions requiring future decisions
- [ ] Capture next steps with precise details
- [ ] List all known issues and their current status
- [ ] Archive key learnings from the current session

### 3️⃣ CONTINUITY PREPARATION

- [ ] Create clear entry points for the next session
- [ ] Establish a prioritized task list for continuation
- [ ] Highlight any dependencies or blockers
- [ ] Provide explicit return instructions

## 📊 SESSION SUMMARY CREATION

Create a session summary in `activeContext.md` using this format:

```markdown
## 📊 SESSION SUMMARY (YYYY-MM-DD)

### Accomplishments

- [Brief description of completed work]

### Current State

- [Description of the current system state]
- [Current task progress: N%]

### Next Actions

1. [Specific next step with detailed context]
2. [Another specific next step]

### Open Questions

- [Question that needs resolution]
- [Decision that needs to be made]

### Critical Notes

- [Any information essential for continuation]
```

## 🔍 MEMORY CONSISTENCY VERIFICATION

Verify consistency across all memory files:

- [ ] All architectural decisions are documented in `systemPatterns.md`
- [ ] All technology choices are documented in `techContext.md`
- [ ] Current state is accurately reflected in `activeContext.md`
- [ ] Working features and issues are up-to-date in `progress.md`
- [ ] Project patterns and rules are captured in `projectRules.md`

## 📝 FINAL CONFIRMATION

After completing all steps above, create a final confirmation:

```markdown
## ✅ BEDTIME PROTOCOL COMPLETE

The memory preservation protocol has been successfully executed. All critical
information has been documented and the system state has been preserved.

Memory files updated:

- [list of updated files]

Continuation point established in `activeContext.md`

You may safely end this session.
```

## ⚠️ CRITICAL WARNINGS

- **NEVER** skip this protocol before ending a session
- **NEVER** abbreviate or shortcut these procedures
- **ALWAYS** verify all files are updated before concluding
- **ALWAYS** create a clear continuation point for the next session

## 🔄 NEXT SESSION INITIALIZATION

When returning to this project:

1. Begin by reading ALL memory bank files
2. Start with the continuation point in `activeContext.md`
3. Follow the prioritized task list established during the Bedtime Protocol

## 🤖 AUTOMATED MEMORY MANAGEMENT

For additional automation of the Bedtime Protocol file management process, you
can use the memory management tools provided in the `memory-tools/` directory:

### Using the Memory Manager

After completing the manual steps above (memory consolidation, state
preservation, and continuity preparation), you can use the memory manager to
handle file archiving and organization:

```bash
cd memory-bank/Bedtime Protocol/memory-tools
python memory_manager.py memory_config.json
```

The memory manager will:

1. Perform a dry run to preview file operations
2. Request confirmation before making changes
3. Copy files to appropriate archive locations
4. Organize them by memory type and category
5. Maintain detailed operation logs

### Customizing for Your Workflow

You can customize the `memory_config.json` file to match your specific workflow
needs. The default configuration is tailored to the standard BIG BRAIN Memory
Bank structure.

### Advanced Options

Additional command-line options are available:

- `--organize-by-category`: Ensure files are organized by category in archive
  directories
- `--analyze-organization`: Check the current state of memory organization
  without making changes
- `--reorganize-existing`: Organize existing archived files

For more detailed instructions, see the `memory-tools/README.md` file.
