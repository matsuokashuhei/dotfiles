---
name: pipeline-workflow
description: "Use when developing a feature end-to-end with structured stages: requirements gathering, exploration, planning, implementation, simplification, review, and testing as a coordinated multi-agent pipeline with quality gates"
---

# Pipeline Workflow

Sequential multi-agent pipeline with Inspector quality gates between every stage. Each agent has exactly one role. Uses Anthropic official agents where available.

## Pipeline Flow

```
Interviewer → [Inspector] → Explorer → Planner → [Inspector] → Implementer → [Inspector] → Simplifier → Review (4 agents parallel) → [Inspector] → Tester → [Inspector] → Done
```

## Agent Roster

| Stage | Agent | Source | Role |
|-------|-------|--------|------|
| Requirements | `pipeline--interviewer` | Custom | User interview, specification |
| Exploration | `feature-dev--code-explorer` | Official | Codebase deep analysis |
| Planning | `feature-dev--code-architect` | Official | Architecture design, implementation plan |
| Implementation | `pipeline--implementer` | Custom | TDD coding |
| Simplification | `pr-review-toolkit--code-simplifier` | Official | Code clarity polish |
| Review (general) | `pr-review-toolkit--code-reviewer` | Official | Code quality, CLAUDE.md compliance |
| Review (errors) | `pr-review-toolkit--silent-failure-hunter` | Official | Error handling audit |
| Review (comments) | `pr-review-toolkit--comment-analyzer` | Official | Comment accuracy |
| Review (types) | `pr-review-toolkit--type-design-analyzer` | Official | Type design quality (conditional) |
| Testing | `pipeline--tester` | Custom | Test design, execution, coverage |
| Quality Gate | `pipeline--inspector` | Custom | Artifact inspection |

## Execution Steps

### Step 0: Setup

Create an isolated workspace:
```
Use EnterWorktree or create a new git branch for isolation.
```

### Step 1: Requirements Gathering

Spawn Agent with `pipeline--interviewer`:
- Provide: the feature description from the user
- The interviewer will ask the user questions via AskUserQuestion
- Wait for the interviewer to produce a requirements specification

### Step 1.5: Inspect Requirements

Spawn Agent with `pipeline--inspector`:
- Provide: the requirements specification text + instruction "Inspect: After Interviewer"
- If FAIL: send the deficiency list back to a new interviewer agent instance for revision
- If PASS: present the specification to the user for final confirmation
- Max 3 retry loops before escalating to user

### Step 2: Codebase Exploration

Spawn 2-3 Agents with `feature-dev--code-explorer` **in parallel**, each with a different focus:
- Agent 1: Find features similar to the requirement and trace their implementation
- Agent 2: Map the architecture and abstractions for the relevant area
- Agent 3: Identify testing patterns, extension points, and existing utilities (optional)

Provide each agent: the requirements specification text for context.

Collect their findings and compile a codebase context summary. This summary will be provided to the Planner.

### Step 3: Implementation Planning

Spawn Agent with `feature-dev--code-architect`:
- Provide: the requirements specification + the codebase exploration summary
- Additionally instruct the architect to produce output in this format:
  - Task checklist with: target files, test files, verification commands, completion criteria per task
  - TDD order within each task (test → implement → verify)
  - Ensure every requirement from the specification maps to at least one task
- Wait for the architect to produce an implementation plan/blueprint

### Step 3.5: Inspect Plan

Spawn Agent with `pipeline--inspector`:
- Provide: the implementation plan text + the requirements specification + instruction "Inspect: After Planner"
- If FAIL: send the deficiency list back to a new architect agent instance for revision
- If PASS: present the plan to the user for approval
- Max 3 retry loops before escalating to user

### Step 4: Implementation

Spawn Agent with `pipeline--implementer`:
- Provide: the full implementation plan text (paste it, do not make the agent read a file)
- The implementer will work through tasks with TDD
- Wait for the implementer to produce a completion report

### Step 4.5: Inspect Implementation

Spawn Agent with `pipeline--inspector`:
- Provide: the implementer's report + the plan + instruction "Inspect: After Implementer"
- Inspector should run the project's linter, type checker, and dependency checker if available
- If FAIL: send the deficiency list back to a new implementer agent instance
- If PASS: proceed to simplification
- Max 3 retry loops before escalating to user

### Step 5: Code Simplification

Spawn Agent with `pr-review-toolkit--code-simplifier`:
- Provide: list of changed files from the implementer's report
- The simplifier will refine code for clarity while preserving functionality
- This stage is a polish pass — it should NOT change behavior

### Step 6: Code Review (4 agents in parallel)

Spawn the following agents **in parallel** in a single message:

**Always run:**
1. `pr-review-toolkit--code-reviewer` — general code quality, CLAUDE.md compliance, bug detection
2. `pr-review-toolkit--silent-failure-hunter` — error handling audit, silent failure detection

**Conditionally run:**
3. `pr-review-toolkit--comment-analyzer` — if comments/docstrings were added or modified
4. `pr-review-toolkit--type-design-analyzer` — if new types/classes were introduced

Provide each agent: the git diff, the implementation plan, and CLAUDE.md content.

**Aggregate results**: Collect all reports and merge into a unified review:
- If ANY agent reports Critical issues: overall FAIL → send issues to a new implementer agent, then re-run review
- If all agents report no Critical issues: overall PASS → proceed to inspect
- Max 3 review-fix loops before escalating to user

### Step 6.5: Inspect Review

Spawn Agent with `pipeline--inspector`:
- Provide: all review reports (merged) + instruction "Inspect: After Reviewer"
- If FAIL: send deficiencies back to the appropriate review agent
- If PASS: proceed to testing
- Max 3 retry loops before escalating to user

### Step 7: Testing

Spawn Agent with `pipeline--tester`:
- Provide: list of changed files, the implementation plan's test requirements, the implementer's test report
- If tester returns FAIL: send failures to a new implementer agent, then re-run tester
- If tester returns PASS: proceed to inspect

### Step 7.5: Inspect Tests

Spawn Agent with `pipeline--inspector`:
- Provide: the tester's report + the requirements specification (for acceptance criteria) + instruction "Inspect: After Tester"
- If FAIL: send deficiencies back to a new tester agent instance
- If PASS: proceed to completion
- Max 3 retry loops before escalating to user

### Step 8: Completion

Use the `finishing-a-development-branch` skill to:
- Create a PR or merge as appropriate
- Clean up the worktree if used

## Handoff Rules

1. The orchestrator (you) relays context between agents as TEXT — agents do not read each other's files
2. Always provide the FULL specification/plan text to each agent — do not abbreviate
3. Each agent's output becomes input for the next stage
4. Inspector always receives: the artifact to inspect + the relevant reference document + the inspection mode
5. Explorer findings are compiled into a summary and provided to the Planner
6. Review reports are merged into a single unified report for Inspector

## Feedback Loop Rules

- Max 3 retries per stage before escalating to the user with AskUserQuestion
- Each retry creates a NEW agent instance (do not reuse)
- Provide the inspector's deficiency list as the primary input for the retry
- Include the original context (plan/spec) in every retry

## Red Flags — Never Do These

- Never skip the interviewer stage
- Never skip user confirmation after requirements and plan
- Never let review agents modify code
- Never let the tester modify production code
- Never let the inspector modify anything
- Never proceed past a FAIL inspection without fixing
- Never exceed 3 retry loops without user escalation
- Never skip the simplifier — it reduces review churn
