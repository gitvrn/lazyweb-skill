---
name: lazyweb
description: |
  Lazyweb entry point — one command for every Lazyweb design tool. Routes the user to
  the right skill: welcome/getting started, deep design research, quick screenshot
  references, improving an existing design, A/B test research, cross-category
  brainstorming, feedback, or connecting/disconnecting external inspiration
  libraries. Use when the user types /lazyweb, says "lazyweb", asks what Lazyweb
  can do, or makes a design-evidence or experiment-evidence request and the
  specific internal mode is unclear. Design with evidence, not vibes.
  Trigger on: "lazyweb", "use lazyweb", "what can lazyweb do", "ask lazyweb", and any
  design research / reference / inspiration request where the right internal mode is unclear.
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

# Lazyweb

The single public entry point for Lazyweb's design tools. This skill orients the
user and hands off to the right internal mode. It does not do research itself: it
routes.

## Preamble (run first)

Run this once at the start. It is safe and fast: the update check is time-boxed to a few
seconds, cached for 24h, and never blocks or errors out.

Resolve the plugin root, then run the update check. The plugin's `bin/` is normally on
`$PATH` when installed; if it is not, fall back to this skill's base directory (the
harness shows it to you as "Base directory for this skill"). This skill lives at
`<plugin-root>/skills/lazyweb`, so the plugin root is two directories up.

```bash
export LAZYWEB_ROUTER=1   # internal modes check this to skip their own router-level setup
# Run the non-blocking update check and background the telemetry flush, but ONLY when the
# plugin's bin/ is on PATH (the normal case for an installed plugin). Both are optional.
if command -v lazyweb-update-check >/dev/null 2>&1; then
  lazyweb-update-check 2>/dev/null || true
fi
if command -v lazyweb-telemetry-flush >/dev/null 2>&1; then
  ( lazyweb-telemetry-flush >/dev/null 2>&1 & ) 2>/dev/null || true
fi
[ -f "$HOME/.lazyweb/telemetry-consent" ] && echo "TELEMETRY: $(cat "$HOME/.lazyweb/telemetry-consent" 2>/dev/null)" || echo "TELEMETRY: unset"
```

If `lazyweb-update-check` was not on `PATH` (the block above ran nothing) and you want the
checks, the plugin `bin/` may not be on `PATH` on this host. You are shown this skill's
base directory ("Base directory for this skill"); it is `<plugin-root>/skills/lazyweb`.
Build the absolute path yourself and run `<that base dir>/../../bin/lazyweb-update-check`
(and `.../lazyweb-telemetry-flush`), substituting the real directory — never run the
literal placeholder text. Both are optional and non-blocking; skip if anything is unclear.

If the output shows `UPGRADE_AVAILABLE <old> <new>`, tell the user once:

> A newer Lazyweb plugin is available (`<old>` → `<new>`). Update with
> `claude plugin update lazyweb@lazyweb` (Claude Code) or re-run the install command,
> then restart your agent.

Then continue routing regardless. Never block on the update.

### Telemetry

Lazyweb logs your queries and outcomes locally to `~/.lazyweb/analytics/` so you (and we)
can see what it gets used for. That data stays on your machine. Uploading is separate and
strictly opt-in.

If the preamble printed `TELEMETRY: unset`, continue without asking. Keep telemetry
local-only unless a routed internal mode explicitly offers opt-in later. Do not let
telemetry consent block welcome, setup verification, or research routing.

If the preamble printed `TELEMETRY: community` or `TELEMETRY: off`, do not ask again.

## Routing

Pick the one internal mode that matches the user's request and hand off to it.

| The user wants... | Route to |
|---|---|
| Welcome, getting started, first-run orientation, what Lazyweb can do | `lazyweb-welcome` |
| Deep competitive analysis / best-practices research, a full report with references | `lazyweb-design-research` |
| Just a few screenshots / references, fast — no full report | `lazyweb-quick-references` |
| Improvement ideas for a design they already have | `lazyweb-design-improve` |
| A/B tests, experiments, growth hypotheses, monetization strategy | `lazyweb-ab-test-research` |
| Creative, cross-category ideas ("zig when everyone zags") | `lazyweb-design-brainstorm` |
| Send product feedback, bug reports, feature requests, or onboarding friction to Lazyweb | `lazyweb-feedback` |
| A real multi-screen flow (onboarding, checkout, paywall) step by step | `lazyweb-flows` |
| Connect an external inspiration library (Mobbin, Savee, Dribbble…) | `lazyweb-add-inspo-source` |
| Disconnect an inspiration library | `lazyweb-remove-inspo-source` |

### How to hand off

1. **Clear match (one internal mode):** Read the internal skill file and follow it
   from the top. This skill lives at `<plugin-root>/skills/lazyweb`; internal modes
   live at `<plugin-root>/internal-skills/<target>/SKILL.md` (for example,
   `<plugin-root>/internal-skills/lazyweb-design-research/SKILL.md`). Read that file
   and execute it inline. It sees `LAZYWEB_ROUTER=1` and skips any duplicated
   router-level setup.
   Resolve any bundled resources (the browse tool, helper scripts) relative to the
   plugin root, never the current working directory.

2. **Ambiguous (could be two or more):** ask with AskUserQuestion. Offer the candidate
   modes as options, each with a one-line "best when...", plus a recommendation. Route
   to the chosen one. Do not guess when the cost of guessing wrong is a wasted full
   report.

3. **Bare `/lazyweb` or `/lazyweb:lazyweb` with no task:** route to
   `lazyweb-welcome`. This is the welcome/onboarding mode users see after install.

Do not re-implement an internal mode here. Always hand off to the real skill file so
there is one source of truth.

## Notes

- Only this router is exposed as a public slash skill. Do not tell users to call
  internal skill names directly. For first-run orientation, tell them to run
  `/lazyweb:lazyweb`; the router will load `lazyweb-welcome`.
- All skills are backed by the hosted Lazyweb MCP tools. The current public
  gateway normally exposes `lazyweb_search`, `lazyweb_find_similar`,
  `lazyweb_compare_image`, `lazyweb_list_categories`,
  `lazyweb_list_collections`, `lazyweb_ab_test_research`, and
  `lazyweb_health`. Richer backend/internal surfaces may also expose
  `lazyweb_get_flows`, `lazyweb_find_experiments`, `lazyweb_recent_experiments`,
  and `list_companies_by_categories`. Always list the live tools before assuming
  one of the internal aliases is callable. If MCP is not installed, the skills
  degrade to web research and tell the user how to install it.
- Pass `high_design_bar: true` only to tools whose live schema exposes it when
  the user asks for high-design-bar, premium, best-designed, or stronger
  visual-quality examples. The filter is backed by
  `companies.high_design_bar = true` on the backend/internal surfaces that
  support it.
- Feedback is sent through the Lazyweb CLI command `lazyweb feedback`; the
  packaged skill should not write directly to Supabase.
