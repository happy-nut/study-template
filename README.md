# study-template

*English · [한국어](README_KR.md)*

A universal **Leitner-box study repo template**. Study *anything* — TOEIC, certifications, interviews, history, medicine. Your AI coding agent acts as the study coach directly; no separate app or note-taking needed. Only the subject changes — the learning method stays the same.

## Works with any agent

The single source of truth for the coaching instructions is **`AGENTS.md`**. Major AI coding tools recognize it:

| Agent | Reads | How |
|---|---|---|
| OpenAI Codex · Cursor · GitHub Copilot, etc. | `AGENTS.md` | natively |
| Claude Code | `CLAUDE.md` → `@AGENTS.md` import | automatic |
| Gemini CLI | `GEMINI.md` → instructed to read `AGENTS.md` | automatic |

`CLAUDE.md` and `GEMINI.md` are thin pointers. **To change the instructions, edit `AGENTS.md` only.**

## How to use

1. **Create a new repo from this template** — the GitHub "Use this template" button, or
   `gh repo create my-study --template happy-nut/study-template --private`
2. In the new repo, launch an AI coding agent (Claude Code · Codex · Cursor · Gemini CLI, etc.) → say **"let's start studying"**
3. The coach interviews you briefly about what you're studying and fills in `PROFILE.md` (one time only)
4. From then on, whatever you ask about or get stuck on automatically becomes a card, and resurfaces at Leitner intervals

## Structure

| File | Role | Changes? |
|------|------|----------|
| `AGENTS.md` | Learning-engine source of truth — boxes, why-chain / recall drill, forgetting curve | ❌ never |
| `CLAUDE.md` / `GEMINI.md` | Per-agent entry points (pointers to AGENTS.md) | ❌ |
| `.claude/skills/` | **Project-scoped** skills (e.g. `mock-interview`) — ship with the repo | ❌ (part of the engine) |
| `PROFILE.md` | What you're studying (subject · goal · question scope) | ✅ the only file you fill in |
| `state.tsv` | Per-card stats (box location is decided by the directory) | automatic |
| `box1`~`box4` | Leitner boxes | automatic |

## Features

- **Automatic card typing** — the coach decides per card whether it's `recall` (recognition drill), `concept` (why-chain), or `mixed`. **You don't pick** — the AI judges from the card's nature.
- **Forgetting curve** — frequently-missed cards resurface sooner; long-neglected cards come up first.
- **Auto-carding** — no pre-made notes. Cards accumulate from the conversation.
- **`mock-interview` skill** — when the boxes are empty, say `"mock interview"` / `"면접 난사"` (or `/mock-interview` in Claude Code) and a specific interviewer persona fires off relentless tail-questions, hunts the edge of what you don't know, and seeds cards on the spot. Built for a fast cold start. It is **project-scoped** — it lives in this repo's `.claude/skills/`, so it travels with every derived repo. Do **not** install it to user scope (`~/.claude/skills/`).

## Updating a derived repo when the template gains features

A GitHub template is **not a fork** — there's no automatic sync link. But the engine and skills are file-separated from your data, so you can pull just those and keep your cards and profile untouched. The engine version lives at the top of `AGENTS.md` as `<!-- engine version: X -->`.

**Method A — git (recommended; syncs skills too)**
```
git remote add template https://github.com/happy-nut/study-template.git   # once
git fetch template
git checkout template/master -- AGENTS.md CLAUDE.md GEMINI.md .claude
```

**Method B — ask the coach**
Say **"update engine"** in the derived repo. The coach checks the latest version and, if you're behind, pulls the engine files **and `.claude/skills/`** — leaving `PROFILE.md`, `box*`, and `state.tsv` alone.
