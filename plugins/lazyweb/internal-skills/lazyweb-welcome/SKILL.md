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

Use this as the routed welcome mode for `/lazyweb:lazyweb` after installing Lazyweb.

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

Reply in concise plain language with a structure that is easy to scan. Include:

- A short greeting from Ali, speaking through the user's agent, thanking them for
  installing the Lazyweb MCP.
- Explain that Lazyweb is a free design research library for agents. It gives
  agents real product screenshots, product flows, and UI patterns before they
  design.
- A "Try these first" list:
  1. Ask what the main Lazyweb usage modes are, so the agent explains the
     different skills and when to use each one.
  2. Ask for quick references for a specific screen, like onboarding welcome
     screens, pricing pages, paywalls, dashboards, checkout, or settings.
  3. Ask for deeper design research before changing a landing page, app flow,
     onboarding, paywall, checkout, dashboard, or settings screen.
  4. Ask Lazyweb to compare the current UI against strong product examples and
     turn the patterns into concrete changes.
- A separate "Optional upgrade" note: after design research, the user can add
  A/B test data context so their agent understands patterns that have worked in
  real experiments, not just what looks polished. Paid access costs $49/month
  and unlocks over 20k A/B tests for mobile growth, paywalls, onboarding,
  checkout, pricing, lifecycle, and monetization research.
- Upgrade link:
  `https://buy.stripe.com/4gM3cwbdE8Mc46df5fawo07`
- Research taste link:
  `https://www.lazyweb.com/research.md`
- For feedback, ask the agent to run `/lazyweb:lazyweb` and say they want to send
  Lazyweb feedback.

Do not run a research workflow from this skill. If the user gives a concrete
task after the welcome, route to the matching internal Lazyweb mode.
