---
layout: default
title: Memory Bank
nav_order: 4
has_children: true
permalink: /memory-bank/
---

# BIG BRAIN Memory Bank

The Memory Bank is the heart of the BIG BRAIN system - it provides structured
persistence of knowledge across memory resets, ensuring continuity and
consistency in operations.

{: .fs-6 .fw-300 }

## What is the Memory Bank?

The Memory Bank is a specialized documentation system designed to maintain
perfect recall across complete memory resets. Unlike traditional documentation
that serves as a reference, the Memory Bank is designed as a primary operational
dependency - the system cannot function without it.

## Key Principles

- **Complete Documentation**: Every aspect of the project must be documented
- **Clear Structure**: Information is organized in a predictable, consistent
  hierarchy
- **Contextual Integration**: Related information is linked and cross-referenced
- **Progressive Detail**: Information flows from high-level concepts to
  implementation details
- **Verification Mechanisms**: Built-in systems to validate the integrity of
  stored information

## Memory Bank Structure

The Memory Bank follows a carefully designed structure:

```
memory-bank/
├── core/
│   ├── active/       # Currently relevant information
│   │   ├── projectbrief.md
│   │   ├── productContext.md
│   │   ├── activeContext.md
│   │   ├── systemPatterns.md
│   │   ├── techContext.md
│   │   └── progress.md
│   ├── foundation/   # Foundational project information
│   └── reference/    # Stable reference material
├── short-term/       # Temporary or transitional information
└── long-term/        # Historical or archived information
```

{: .directory-structure }

## Core Files

The Memory Bank core files are the essential documents required for operation:

<div class="memory-bank-files">
  <div class="file-card">
    <h3>projectbrief.md</h3>
    <p>Foundation document defining core requirements and project goals</p>
    <div class="file-priority high">High Priority</div>
  </div>

  <div class="file-card">
    <h3>productContext.md</h3>
    <p>Explains why the project exists, problems it solves, and user experience goals</p>
    <div class="file-priority high">High Priority</div>
  </div>

  <div class="file-card">
    <h3>activeContext.md</h3>
    <p>Documents current work focus, recent changes, and immediate next steps</p>
    <div class="file-priority critical">Critical Priority</div>
  </div>

  <div class="file-card">
    <h3>systemPatterns.md</h3>
    <p>Outlines system architecture, technical decisions, and component relationships</p>
    <div class="file-priority high">High Priority</div>
  </div>

  <div class="file-card">
    <h3>techContext.md</h3>
    <p>Lists technologies, development setup, and technical constraints</p>
    <div class="file-priority medium">Medium Priority</div>
  </div>

  <div class="file-card">
    <h3>progress.md</h3>
    <p>Tracks what works, what's left to build, and known issues</p>
    <div class="file-priority high">High Priority</div>
  </div>
</div>

## Memory States

The Memory Bank operates through multiple states:

1. **Initialization State**: When a new session begins
2. **Active State**: During normal operation
3. **Preservation State**: When preparing for a memory reset (Bedtime Protocol)
4. **Reset State**: When memory has been reset and needs to rebuild from the
   Memory Bank

## Bedtime Protocol

The Bedtime Protocol is a critical process for preserving state before a memory
reset:

1. **Capture**: All volatile state is documented
2. **Update**: Core files are updated with the latest information
3. **Verification**: Memory Bank integrity is checked
4. **Preparation**: Setup is made for the next initialization
5. **Shutdown**: Controlled end of the current session

## Learn More

Explore these sections to learn more about the Memory Bank:

- [Core Files]({{ site.baseurl }}/memory-bank/core-files/) - Detailed
  information about each core file
- [Structure]({{ site.baseurl }}/memory-bank/structure/) - Understanding the
  Memory Bank organization
- [Memory States]({{ site.baseurl }}/memory-bank/states/) - How memory states
  work
- [Bedtime Protocol]({{ site.baseurl }}/memory-bank/bedtime-protocol/) - The
  preservation process
