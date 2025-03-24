# BIG BRAIN Memory Bank 2.0 - Diagram Files

This directory contains the source Mermaid diagram files and their rendered
images for the BIG BRAIN Memory Bank 2.0 system.

## Directory Contents

- `*.mermaid` - Source Mermaid diagram files
- `*.png` - Rendered PNG images (generated from Mermaid files)
- `*.svg` - Rendered SVG images (generated from Mermaid files)
- `MERMAID_DIAGRAM_GUIDE.md` - Guide for working with Mermaid diagrams

## Available Diagrams

| Diagram                | Source File                    | Description                                        |
| ---------------------- | ------------------------------ | -------------------------------------------------- |
| System Architecture    | system-architecture.mermaid    | High-level view of all architectural layers        |
| Memory Bank Structure  | memory-bank-structure.mermaid  | Organization of memory files and directories       |
| Rule System Structure  | rule-system-structure.mermaid  | Rule categories and relationships                  |
| Command Protocol       | command-protocol.mermaid       | Command structure and processing flow              |
| Workflow Orchestration | workflow-orchestration.mermaid | Workflow types and execution processes             |
| Memory Bank Diagram    | memory-bank-diagram.mermaid    | Legacy workflow diagram for memory bank operations |

## Generating Images

To generate or update PNG and SVG images from the Mermaid source files, use the
provided PowerShell script:

```powershell
cd scripts
.\generate_diagrams.ps1
```

This script requires:

- Node.js
- Mermaid CLI (`@mermaid-js/mermaid-cli` npm package)

If the required dependencies are not installed, the script will prompt you to
install them.

## Creating New Diagrams

When creating new diagrams:

1. Create a new `.mermaid` file in this directory
2. Follow the style guidelines in the `diagram-standards.mdc` rule
3. Use the style classes defined in existing diagrams for consistency
4. Run the `generate_diagrams.ps1` script to render the new diagram
5. Update the table in this README with the new diagram information

## Updating Existing Diagrams

When updating diagrams:

1. Modify the `.mermaid` source file
2. Run the `generate_diagrams.ps1` script to update the rendered images
3. Commit both the source file and generated images

## Using Diagrams in Documentation

To include a diagram in documentation:

```markdown
![Diagram Description](../images/diagram-name.png)
```

Or for documentation in the `docs` directory:

```markdown
![Diagram Description](../assets/diagram-name.png)
```

## Style Guidelines

All diagrams should follow these guidelines:

- Use consistent styling for node types
- Apply the standard color palette defined in the style guide
- Include descriptive comments in the Mermaid source code
- Maintain proper spacing and organization
- Use directional indicators appropriate for the diagram type
- Include version information in comments

For more details, see:

- [Mermaid Diagram Guide](./MERMAID_DIAGRAM_GUIDE.md)
- [Diagram Standards Rule](../.cursor/rules/Codebase/diagram-standards.mdc)
