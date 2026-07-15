# become

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
   `gh repo create become-a-topic --template happy-nut/become --private`
2. In the new repo, launch an AI coding agent (Claude Code · Codex · Cursor · Gemini CLI, etc.) and say anything — on first contact the coach opens with **"What kind of expert do you want to become?"** and fills in `PROFILE.md` from your answers (one time only)
3. When setup finishes, the coach hands you ready-to-paste prompts for what to type next (seed cards, start a session, …)
4. From then on, whatever you ask about or get stuck on automatically becomes a card, and resurfaces at Leitner intervals

## Structure

| File | Role | Changes? |
|------|------|----------|
| `AGENTS.md` | Learning-engine source of truth — boxes, why-chain / recall drill, forgetting curve | ❌ never |
| `CLAUDE.md` / `GEMINI.md` | Per-agent entry points (pointers to AGENTS.md) | ❌ |
| `.claude/skills/` | **Project-scoped** skills (e.g. `mock-interview`) — ship with the repo | ❌ (part of the engine) |
| `PROFILE.md` | What you're studying (subject · goal · question scope) | ✅ the only file you fill in |
| `box1`~`box4` | Leitner boxes | automatic |

## Features

- **Automatic card typing** — the coach decides per card whether it's `recall` (recognition drill), `concept` (why-chain), or `mixed`. **You don't pick** — the AI judges from the card's nature.
- **Forgetting curve** — frequently-missed cards resurface sooner; long-neglected cards come up first.
- **Auto-carding** — no pre-made notes. Cards accumulate from the conversation.
- **`mock-interview` skill** — when the boxes are empty, say `"mock interview"` / `"면접 난사"` (or `/mock-interview` in Claude Code) and a specific interviewer persona fires off relentless tail-questions, hunts the edge of what you don't know, and seeds cards on the spot. Built for a fast cold start. It is **project-scoped** — it lives in this repo's `.claude/skills/`, so it travels with every derived repo. Do **not** install it to user scope (`~/.claude/skills/`).

## Updating a derived repo when the template gains features

A weekly GitHub Actions workflow checks `become` for engine updates. When changes exist, it opens a **sync pull request** instead of overwriting learning data. `PROFILE.md` and `box1/` through `box4/` are learner-owned and never synchronized. `.become/engine-files.txt` defines the engine-owned paths.

**Method A — automatic pull request (recommended)**

Run the `Sync Become engine` GitHub Actions workflow manually, or review and merge its weekly pull request.

**Method B — sync locally**
```
./scripts/sync-become.sh
git diff
```

Or say **"update engine"** in a derived repo and the coach will run the same tool.
