---
name: correct-en
description: Correct English sentences written by English learners. Use this skill whenever the user provides English text and wants it corrected, proofread, or improved.
---

# correct-en

Correct English text written by an English learner.

## Guidelines

- Target audience: Japanese English learners
- Input: text provided via `$ARGUMENTS`
- Technical terms: keep as-is (e.g., API, async, Docker, ActiveRecord, Git, CI/CD)
- English level: CEFR B1–B2 — clear, concise, common vocabulary; short sentences; avoid long or difficult expressions

## Instructions

1. Correct the English text provided in `$ARGUMENTS`.
2. Output in the following format:

```
## Meaning of the Original

(Japanese translation of the original English text as-is, to show what a native speaker would understand.)

## Corrected Text

(Corrected English text here)

## Changes Made

(List each correction as a bullet. Show the original phrase, the corrected phrase, and a brief explanation in Japanese of why the change was made.)

## Advice

(One or two short tips in Japanese to help the learner improve. Focus on the most important pattern from their mistakes.)
```
