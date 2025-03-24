---
layout: default
title: Bedtime Protocol
parent: Memory Bank
nav_order: 4
permalink: /memory-bank/bedtime-protocol/
---

# Bedtime Protocol

The Bedtime Protocol is a critical system process designed to preserve the
operational state of BIG BRAIN before a memory reset occurs. This protocol
ensures that all essential information is captured, verified, and properly
structured to enable perfect recall in the next session.

{: .fs-6 .fw-300 }

## Purpose and Importance

The Bedtime Protocol serves as the bridge between operational sessions, ensuring
continuity and consistency despite the complete memory reset that occurs between
sessions. It transforms volatile, in-memory knowledge into persistent,
structured documentation.

Without proper execution of the Bedtime Protocol, critical context would be
lost, leading to:

- Reduced operational efficiency
- Inconsistent decision-making
- Loss of project momentum
- Degraded understanding of project state

## Protocol Phases

The Bedtime Protocol consists of five distinct phases, each with specific goals
and procedures:

<div class="protocol-phases">
  <div class="phase">
    <div class="phase-number">1</div>
    <div class="phase-content">
      <h3>Capture Phase</h3>
      <p>Document all volatile state information that exists only in active memory.</p>
      <ul>
        <li>Current task context and progress</li>
        <li>Recent decisions and their rationale</li>
        <li>Unsaved changes or work-in-progress</li>
        <li>Mental models and understanding developed during the session</li>
      </ul>
    </div>
  </div>

  <div class="phase">
    <div class="phase-number">2</div>
    <div class="phase-content">
      <h3>Update Phase</h3>
      <p>Systematically update all core Memory Bank files to reflect the current state.</p>
      <ul>
        <li>Update activeContext.md with current focus and next steps</li>
        <li>Revise progress.md to reflect completed tasks and new issues</li>
        <li>Update any other core files as needed</li>
        <li>Ensure documentation of any new patterns discovered</li>
      </ul>
    </div>
  </div>

  <div class="phase">
    <div class="phase-number">3</div>
    <div class="phase-content">
      <h3>Verification Phase</h3>
      <p>Verify the integrity and completeness of the Memory Bank.</p>
      <ul>
        <li>Check for missing information or documentation gaps</li>
        <li>Ensure core files are up-to-date and accurately reflect system state</li>
        <li>Validate that next steps are clearly documented for the next session</li>
        <li>Review for consistency and clarity from a "cold start" perspective</li>
      </ul>
    </div>
  </div>

  <div class="phase">
    <div class="phase-number">4</div>
    <div class="phase-content">
      <h3>Preparation Phase</h3>
      <p>Set up the environment for successful initialization in the next session.</p>
      <ul>
        <li>Ensure all documentation is committed and pushed to the repository</li>
        <li>Create clear entry points for the next session</li>
        <li>Document any environment-specific details needed for restart</li>
        <li>Prepare initialization scripts if needed</li>
      </ul>
    </div>
  </div>

  <div class="phase">
    <div class="phase-number">5</div>
    <div class="phase-content">
      <h3>Shutdown Phase</h3>
      <p>Conclude the current session in a controlled manner.</p>
      <ul>
        <li>Final verification of Memory Bank state</li>
        <li>Confirmation that all changes are saved and persisted</li>
        <li>Ready signal for memory reset</li>
        <li>Graceful conclusion of the session</li>
      </ul>
    </div>
  </div>
</div>

## Execution Commands

The Bedtime Protocol is typically initiated with the command:

```shell
BEDTIME PROTOCOL INITIATE
```

This triggers the guided workflow through all phases of the protocol.
Alternatively, individual phases can be executed with:

```shell
BEDTIME PROTOCOL EXECUTE [PHASE_NAME]
```

Where `[PHASE_NAME]` is one of: `CAPTURE`, `UPDATE`, `VERIFY`, `PREPARE`, or
`SHUTDOWN`.

## Best Practices

For optimal execution of the Bedtime Protocol:

1. **Allow Sufficient Time**: The protocol requires careful attention and should
   not be rushed.

2. **Complete Current Tasks**: When possible, complete in-progress tasks before
   initiating the protocol.

3. **Use Checklists**: Follow phase-specific checklists to ensure completeness.

4. **Think Forward**: Consider what information would be most valuable when
   starting fresh.

5. **Verify Independently**: Review documentation as if you have no prior
   knowledge of the project.

## Troubleshooting

If issues occur during the Bedtime Protocol:

- **Incomplete Information**: Return to the Capture phase and collect missing
  details
- **Inconsistencies**: Resolve contradictions between documentation files
- **Verification Failures**: Address specific issues flagged during verification
- **Time Constraints**: Prioritize updating core files if time is limited

## Example Workflow

A typical Bedtime Protocol execution might look like:

1. Recognize the need to end the current session
2. Execute `BEDTIME PROTOCOL INITIATE`
3. Follow the guided prompts for each phase
4. Document current progress in activeContext.md
5. Update progress.md with completed items and known issues
6. Verify all core files are current and consistent
7. Commit and push all changes to the repository
8. Confirm ready for memory reset
9. End session

---

**Remember**: The thoroughness of your Bedtime Protocol directly impacts the
effectiveness of the next session. Invest the time to do it properly!
