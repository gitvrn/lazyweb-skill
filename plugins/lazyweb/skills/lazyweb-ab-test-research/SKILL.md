---
name: lazyweb-ab-test-research
description: |
  Research growth, monetization, onboarding, checkout, paywall, cancellation,
  pricing, activation, or other product A/B tests using Lazyweb experiment
  evidence. Use when the user asks for A/B tests, experiments, test ideas,
  growth hypotheses, or PM strategy based on what other apps have tried.
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

# Lazyweb A/B Test Research

Use Lazyweb experiment evidence to answer growth PM questions. This skill is
generic across screens and categories; it is not paywall-only.

## MCP Setup

Use hosted Lazyweb MCP tools for all database-backed evidence:

- `lazyweb_health` — verify Lazyweb MCP connectivity.
- `list_companies_by_categories` — turn category names into company IDs.
- `lazyweb_find_experiments` — retrieve generic experiment evidence from Lazyweb.
- `lazyweb_recent_experiments` — retrieve the latest 10, 25, or 50 experiment rows.
- `lazyweb_ab_test_research` — PM-facing synthesis wrapper when available.
- `lazyweb_search` — pull visual design references to pair with experiment evidence.

Do not route through legacy paywall-specific research tools. If a paywall appears
in the evidence, treat it as one screen type among many.

`_experiments` is a limited screenshot-diff evidence set. Treat learning text as
directional hypotheses, not statistically measured lift.

## Workflow

1. **Ground the product question.** Identify product/app, category, screen or
   flow, platform, target metric, and constraints. If category is known, call
   `list_companies_by_categories` first and use the returned `company_ids`.

2. **Pull experiment evidence.** Call `lazyweb_find_experiments` with the
   strongest filters available:

```json
{
  "query": "trial reminder onboarding upsell",
  "category": "Health & Fitness",
  "screen_type": "onboarding upsell",
  "company_ids": [123, 456],
  "limit": 30
}
```

Use minimal filters for popular apps or broad best-practice questions. Use rich
filters for niche apps or narrow flows.

When the user asks for high-design-bar companies, premium examples,
best-designed apps, or stronger taste filtering, add:

```json
{"high_design_bar": true}
```

This filters to companies where `companies.high_design_bar = true`. Apply it to
`list_companies_by_categories`, `lazyweb_find_experiments`,
`lazyweb_recent_experiments`, `lazyweb_ab_test_research`, and any paired
`lazyweb_search` calls.

For "recent", "latest", or "what changed lately" requests, call
`lazyweb_recent_experiments` with `limit` set to `10`, `25`, or `50`:

```json
{"limit": 25}
```

For ranked App Store slices, add rank filters:

```json
{
  "category": "Health & Fitness",
  "app_store_overall_rank_max": 50,
  "app_store_category_rank_max": 25,
  "limit": 25
}
```

3. **Supplement with design references.** Call `lazyweb_search` for the same
   screen or flow when visual examples would make the recommendation clearer.
   Read `visionDescription` before relying on any screenshot.

4. **Synthesize like a growth PM.** Answer with:
   - Relevant observed experiments and what changed.
   - Likely hypothesis behind each change.
   - Target metric and guardrail metric.
   - Recommended test sequence.
   - Evidence strength and gaps.
   - Where the user should not overgeneralize.

For `lazyweb_ab_test_research`, leave `interesting_learning` as `false` by
default. Set it to `true` only when the user explicitly asks for uncommon,
surprising, or contrarian learnings; clearly label those as limited evidence.

5. **Be honest about weak evidence.** If `lazyweb_find_experiments` returns few
   or weak matches, say that directly and fall back to general best practices
   only after labeling them as inference.

## Output Shape

For strategy or best-practice questions, answer in chat. For larger audits,
create `.lazyweb/ab-test-research/{topic}-{date}/report.html` only if the user
asks for a durable report.
