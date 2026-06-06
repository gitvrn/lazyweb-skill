---
name: lazyweb-feedback
description: |
  Send Lazyweb product feedback, bug reports, feature requests, or onboarding
  friction to Lazyweb. Use when the user asks to send feedback, report an issue,
  ask Lazyweb to log a suggestion, or share what is confusing about the plugin,
  MCP, CLI, screenshot references, or A/B Test Agent.
allowed-tools:
  - Bash
  - Read
  - Write
  - Glob
  - Grep
  - AskUserQuestion
  - Agent
---

# Lazyweb Feedback

Send concise user feedback to Lazyweb through the `lazyweb feedback` CLI command.

## Collect

If the user's feedback is not already clear, ask for the missing concrete
feedback text. Optional fields:

- `category`: `bug`, `feature`, `confusing`, `billing`, `ab-test-agent`,
  `screenshots`, `install`, or `other`
- `severity`: `low`, `medium`, `high`, or `blocking`
- `contact`: email or handle if the user wants follow-up
- `source`: where the feedback came from, such as `codex-plugin`,
  `claude-plugin`, `mcp`, `cli`, or `welcome`

Do not ask for optional fields if the user already gave enough context.

## Send

Prefer the CLI because this skill package is installed separately from the
backend:

```bash
lazyweb feedback "<feedback text>" \
  --category "<category>" \
  --severity "<severity>" \
  --source "<source>" \
  --contact "<contact>" \
  --json
```

Omit optional flags when unknown. If the command is unavailable, tell the user:

> I could not find the `lazyweb` CLI on PATH, so I cannot log this feedback from
> here. Install or update the Lazyweb CLI, then run `lazyweb feedback "..."`
> with the same feedback text.

If the command reports missing Supabase configuration, tell the user:

> Feedback logging is configured through the Lazyweb CLI. Set `SUPABASE_URL` and
> an insert-capable `SUPABASE_ANON_KEY` or `SUPABASE_SERVICE_ROLE_KEY`, then run
> the feedback command again.

After a successful send, confirm with the returned feedback id if present.
