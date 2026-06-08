---
name: lazyweb-paywall-optimization
description: |
  Optimize a mobile or web paywall by reading the target screen, diagnosing
  conversion friction, and producing 2-4 falsifiable redesign hypotheses backed
  by Lazyweb paywall references, experiment evidence, conventions, and divergent
  design moves. Use when the user wants to redesign, improve, critique, or
  optimize a paywall screen for paid conversion.
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

# Paywall Optimization

Optimize a paywall with evidence-backed conversion hypotheses, not generic
component advice.

## CRITICAL: Output Behavior

**This skill produces FILES, not a plan.** Regardless of whether you are in plan mode
or not, ALWAYS:

1. Write the HTML report to `.lazyweb/paywall-optimization/{topic}-{date}/report.html`
2. Embed Lazyweb references directly with returned `imageUrl`; save only current-state and web-captured screenshots under `.lazyweb/paywall-optimization/{topic}-{date}/references/`
3. Do NOT create `report.md` or any other Markdown report artifact
4. Do NOT write optimization content into a plan file
5. After saving, summarize the 2-4 hypotheses and tell the user where the report is
6. Ask the user if the paywall direction looks good
7. If in plan mode, exit plan mode after the user confirms
8. Suggest next steps: "You can now implement the strongest hypothesis, ask
   `/lazyweb-ab-test-research` for deeper experiment mining, or ask `/lazyweb`
   for adjacent design references."

## When to Use This

- User wants to improve, redesign, optimize, critique, or evaluate a paywall
- User has a paywall screenshot, URL, product brief, or current paywall copy
- User asks how to increase paid conversion, trial starts, annual-plan share, or checkout continuation from a paywall
- User asks for concrete paywall redesign hypotheses, not just a broad A/B test corpus search

## When NOT to Use This

- User asks only for A/B test examples, experiment IDs, or monetization research -> route to `lazyweb-ab-test-research`
- User wants generic pricing-page references outside an app paywall -> route to `lazyweb-design-research` or `lazyweb-quick-references`
- User wants creative UI ideas unrelated to conversion -> route to `lazyweb-design-brainstorm`

## Lazyweb MCP Setup

Use hosted Lazyweb MCP tools at `https://www.lazyweb.com/mcp` for database-backed evidence. First list the available tools and run `lazyweb_health`.

Required public tools:
- `lazyweb_health` - verify Lazyweb MCP connectivity
- `lazyweb_ab_test_research` - retrieve and synthesize paywall/conversion experiment evidence when paid access is available
- `lazyweb_search` - find paywall references and convention examples
- `lazyweb_compare_image` - find visually similar screens when the target paywall image is available as `image_base64` + `mime_type` or `image_url`
- `lazyweb_find_similar` - expand from a strong Lazyweb screenshot result
- `lazyweb_get_flows` - optional ordered paywall, checkout, upgrade, or onboarding journeys

If Lazyweb MCP is not installed or auth fails, tell the user: "Lazyweb MCP is
not installed. Run `curl -fsSL https://www.lazyweb.com/install.sh | bash`,
reload this client, then rerun this skill." Continue with web research only if
the user wants a degraded fallback.

The public A/B wrapper is paid. If `lazyweb_ab_test_research` returns
`ab_test_subscription_required`, include the returned paid-access details, then
continue with free Lazyweb visual references and clearly label the report as
reference-grounded but not experiment-backed.

## Ground the Paywall

Before searching, establish the target:

1. Run `lazyweb-context-detect` when available to infer project, platform, and stack.
2. Capture or read the target paywall. Prefer an actual screenshot or URL over prose. If the target is a local app, capture the current screen. If the target is remote, use the provided image or URL.
3. Ask one concise question only when the product, platform, conversion goal, or target screen is missing and cannot be inferred.

Read the paywall first. Identify:
- Components present: header, hero, benefits, pricing, CTAs, trust signals, FAQ, footer, close/skip affordance
- Layout pattern: full-screen, bottom sheet, single-column stack, comparison grid, plan cards, checkout step, interstitial
- Strategic moves: anchoring, trial framing, urgency, social proof, risk reversal, tier framing, locked-feature framing
- Offer: trial vs no trial, single vs multi-tier, intro price vs flat price, annual vs monthly emphasis
- User state: cold first session, warm feature wall, post-onboarding, checkout continuation, cancellation save, or upgrade moment

## Evidence Workflow

Use multiple evidence angles:

1. **Experiment evidence.** Call `lazyweb_ab_test_research` with the product, category, conversion goal, constraints, and target paywall description or image URL. Use experiment evidence as the strongest source when available.
2. **Visual references.** Run 3-5 `lazyweb_search` queries for paywalls matching the product category, user state, conversion goal, and layout. Read `visionDescription` before using a result.
3. **Visual similarity.** If the target image is available and `lazyweb_compare_image` is exposed, retrieve structurally similar paywalls.
4. **Flows.** If the question depends on sequencing, call `lazyweb_get_flows` for paywall, checkout, onboarding, upgrade, or cancellation journeys.
5. **Divergent moves.** Search outside the obvious category when the user asks for bolder options. Extract the mechanism, not the literal design.

Use `high_design_bar: true` only when the live schema exposes it and the user asks for premium, stronger, high-design-bar, best-designed, or visually stronger examples.

## Optimization Framework

The unit of analysis is a hypothesis, not a component list.

A good hypothesis takes this form:

> Making [specific change] should [specific conversion outcome] because [specific mechanism].

Good:
"Replacing the flat plan list with a comparison grid that highlights what is
locked at the monthly tier should lift annual-plan share because users see what
they lose by choosing monthly."

Bad:
"Improve the pricing UX."
"Add social proof to enhance conversion."

Propose 2-4 hypotheses. Each one must:
- Name the specific conversion metric it should move
- Describe the concrete screen change well enough to implement
- Address a named conversion friction
- Cite experiment evidence or visual/convention evidence
- Be meaningfully different from the other hypotheses
- Be falsifiable

Hard rules:
- Do not recommend a convention the user's paywall already uses unless the recommendation changes how it is used.
- Do not propose unmotivated visual polish.
- Do not write two hypotheses with the same mechanism.
- Do not claim measured lift unless the Lazyweb evidence explicitly provides it.
- Treat experiment learning text as directional unless the tool returns validated performance data.

## HTML Report Contract

Create a polished, scannable HTML report with:

- Target paywall read: screenshot, components, layout, offer, user state, and current friction
- Evidence summary: experiment evidence, visual references, similar screens, and flow context used
- 2-4 hypothesis cards: title, hypothesis sentence, mechanism, expected metric, implementation changes, supporting evidence, and risk
- Convention check: what the target already has, what is missing, and what is unusual
- Divergent options: optional bolder mechanisms that transfer from adjacent categories
- Prioritization: rank hypotheses by expected impact, implementation effort, evidence strength, and brand/product fit

Every reference card should show company/product, screen context, why it matters,
and whether it came from Lazyweb, web research, or the target product.
