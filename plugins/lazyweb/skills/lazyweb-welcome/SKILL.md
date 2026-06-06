---
name: lazyweb-welcome
description: |
  Welcome and first-run orientation for Lazyweb. Use after installing the
  Lazyweb plugin, when the user asks what Lazyweb can do, or when they need a
  quick explanation of free screenshots, the paid A/B Test Agent, feedback, and
  next steps.
allowed-tools:
  - Bash
  - Read
  - Write
  - Glob
  - Grep
  - WebSearch
  - AskUserQuestion
  - Agent
---

# Lazyweb Welcome

Use this as the first call after installing Lazyweb.

## Preamble

Run the same lightweight setup checks as the router, unless `LAZYWEB_ROUTER=1`
is already set:

```bash
if [ "${LAZYWEB_ROUTER:-}" != "1" ]; then
  if command -v lazyweb-update-check >/dev/null 2>&1; then
    lazyweb-update-check 2>/dev/null || true
  fi
  if command -v lazyweb-telemetry-flush >/dev/null 2>&1; then
    ( lazyweb-telemetry-flush >/dev/null 2>&1 & ) 2>/dev/null || true
  fi
fi
```

If the update check prints `UPGRADE_AVAILABLE <old> <new>`, tell the user once:

> A newer Lazyweb plugin is available (`<old>` -> `<new>`). Update with
> `claude plugin update lazyweb@lazyweb` or re-run the install command, then
> restart your agent.

Continue either way.

## Response

Reply in concise plain language. Include:

- Lazyweb gives agents real product screenshots and design references before
  they design.
- Free access includes screenshot search, quick references, deep design
  research reports, design improvement ideas, cross-category brainstorming,
  image similarity, categories, collections, and external inspiration-source
  management.
- The only paid feature is the A/B Test Agent.
- Paid access unlocks 20k+ A/B tests for mobile growth, paywalls, onboarding,
  checkout, pricing, lifecycle, and monetization research.
- Upgrade link:
  `https://buy.stripe.com/4gM3cwbdE8Mc46df5fawo07`
- Research taste link:
  `https://www.lazyweb.com/research.md`
- For feedback, ask the agent to run `/lazyweb:lazyweb-feedback`.

Do not run a research workflow from this skill. If the user gives a concrete
task after the welcome, route to the matching Lazyweb sub-skill.
