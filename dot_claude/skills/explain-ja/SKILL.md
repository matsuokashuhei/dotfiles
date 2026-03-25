---
name: explain-ja
description: Use when the user provides English text and wants to understand it in Japanese, including vocabulary and grammar breakdowns.
---

# explain-ja

Explain English text in Japanese with vocabulary, grammar, and interpretation support.

## Guidelines

- Input: text provided via `$ARGUMENTS`
- Technical terms: do not translate (e.g., API, async, Docker, Git, CI/CD)
- Formatting: wrap English words in backticks within Japanese text
- Interpretation awareness: when an English phrase can be read in multiple ways, explain each English reading and show the corresponding Japanese translation

## Instructions

Translate `$ARGUMENTS` to Japanese.

## Output

```markdown
## Translation

(Japanese translation)

### Words and Phrases

(Key words and phrases with meanings and usage. Be concise.)

### Grammar

(Grammar points found in the text. Be concise.)

## Interpretation Notes

(If any English phrase can be read multiple ways, list interpretations. Omit if only one natural reading.)

- **[English phrase]**
  - ● [English meaning used] → [Japanese translation chosen]
  - ○ [other English reading] → [alternative Japanese translation]
```

## Alternatives

(Casual rewrite. Be concise.)

### Casual

#### Words and Phrases

(Vocabulary notes for key words. Be concise.)

#### Grammar

(Grammar points found in the text. Be concise.)

### Formal

(Formal rewrite. Be concise.)

#### Words and Phrases

(Vocabulary notes for key words. Be concise.)

#### Grammar

(Grammar points found in the text. Be concise.)

### Globish

(Globish rewrite. Be concise.)

#### Words and Phrases

(Vocabulary notes for key words. Be concise.)

#### Grammar

(Grammar points found in the text. Be concise.)
