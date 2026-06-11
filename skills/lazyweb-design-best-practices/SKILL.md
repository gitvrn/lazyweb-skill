---
name: lazyweb-design-best-practices
route: 'Design best practices for X — fetch the top community-rated skill for that aspect and apply it as context'
description: |
  Lazyweb's curated router to the best design skills in the world — used as
  context, never installed. Each design aspect below (web animation, frontend
  quality, landing pages, typography, color, design systems, accessibility,
  UX writing, mobile, dashboards) has a ranked, evidence-backed list of the
  top community-rated skills with direct pointers to their instruction files.
  Match the user's design task to a section, fetch the winning skill's
  SKILL.md from its pointer URL, and follow it while doing the task.
  Trigger on: "design best practices for", "what's the best skill for",
  "do this the way the best designers would", "I'm trying to do <design
  thing>, what's the best way".
allowed-tools:
  - Bash
  - Read
  - Write
  - Glob
  - Grep
  - WebSearch
  - WebFetch
  - AskUserQuestion
  - Agent
---

# Lazyweb Design Best Practices

There are hundreds of design skills in the world. This file is Lazyweb's
trusted, researched answer to "which one should my agent use for X?" — built
from a live review sweep of skills.sh, GitHub, design Twitter/X, Reddit, and
Hacker News.

**Researched: 2026-06-11.** Every skill below was verified by fetching its
actual repo and instruction file — nothing here is from memory. Install
counts and stars are as displayed on skills.sh/GitHub on that date.

## How to use this file

1. **Match the user's design task** to one or more topic sections below.
2. **Fetch the #1 pick's instruction file** from its pointer URL (raw
   SKILL.md). Read all of it. That fetched text IS the skill — apply its
   rules, heuristics, and workflow as your operating best practices while
   doing the user's actual task. **Never install anything**; you are
   borrowing the expertise, not the plumbing (ignore frontmatter, tool
   wiring, and local scripts you can't honor).
3. Pull in a #2/#3 pick when its `best for` matches the task better, or
   layer it (several topics below are explicitly "stack two skills").
4. **Cite provenance** in your summary: which fetched skill drove which
   decisions, with its URL.
5. **If a pointer 404s**, search the repo for the moved file before giving
   up; if the repo is gone, drop to the next pick and say so. Never
   paraphrase a skill you could not actually read.
6. **If the topic is missing or this file is older than ~90 days**, run the
   Refresh protocol at the bottom for that topic and tell the user the
   routing table was re-researched.

When the task is about *screen-level UI evidence* — what real apps' paywalls,
onboarding, sign-up, pricing, or checkout screens look like, or A/B test
data — route to the sibling Lazyweb modes instead (`/lazyweb-design-research`,
`/lazyweb-quick-references`, `/lazyweb-paywall-optimization`,
`/lazyweb-signup-optimization`, `/lazyweb-ab-test-research`): verify
connectivity with `lazyweb_health` first, and pass
`"skill": "design-best-practices"` plus `"version"` (from
`cat "$HOME/.lazyweb/VERSION" 2>/dev/null || echo 0.0.0`) in every
`lazyweb_*` call — optional analytics metadata; never drop a real argument
for it. If Lazyweb MCP is missing or auth fails, tell the user: "Lazyweb MCP
is not installed. Run `curl -fsSL https://www.lazyweb.com/install.sh | bash`,
reload this client, then rerun this skill," and continue with the fetched
skills below.

---

## For web animation & motion use these

**tl;dr**
- Animate only `transform` and `opacity`, ease-out for every entrance (never ease-in), keep durations 100-300ms, and always honor `prefers-reduced-motion`.
- Decide IF something should animate by how often it's used — frequent interactions get instant feedback (e.g. `scale(0.97)` press), rare moments can afford choreography.
- Choreograph multi-element sequences (stagger, motion personality) before writing any code; don't tune elements one-by-one.

**Best specific skills**
1. **emilkowalski/skill (emil-design-eng)** — fetch `https://raw.githubusercontent.com/emilkowalski/skill/main/skills/emil-design-eng/SKILL.md` — best for taste-driven micro-interaction polish and reviewing/fixing existing UI animations (easing, duration, what should animate at all). The author wrote the course the rest of the ecosystem copies; concrete checkable rules, not vibes. Evidence: 88.9K installs (top of skills.sh Design & UI), 2.3K stars, announced by @emilkowalski on X, mirrored on 6+ registries. Strength: strong. ← default pick
2. **LottieFiles/motion-design-skill** — fetch `https://raw.githubusercontent.com/LottieFiles/motion-design-skill/main/skills/motion-design/SKILL.md` — best for framework-agnostic motion direction: choreography, motion personality, multi-element sequencing before any code. Evidence: 2.4K installs, 240 stars, vendor-maintained, works across CSS/Framer Motion/GSAP/Lottie. Strength: strong.
3. **vercel-labs/open-agents (web-animation-design)** — fetch `https://raw.githubusercontent.com/vercel-labs/open-agents/main/.agents/skills/web-animation-design/SKILL.md` — best for proactive animation Q&A and structured before/after audits with the broadest trigger coverage (GSAP/React Spring/scroll/springs). Evidence: Vercel-curated, 5.6K-star repo, but only 141 per-skill installs. Strength: directional.
4. **199-biotechnologies/motion-dev-animations-skill** — fetch `https://raw.githubusercontent.com/199-biotechnologies/motion-dev-animations-skill/main/SKILL.md` — best for writing actual Motion.dev/Framer Motion implementation code (scroll reveals, gestures, springs, layout/exit animations). The free alternative to Motion.dev's paywalled official skill. Evidence: 22 stars, no registry traction. Strength: single-source.

*Skip:* the circulated "emil-anim" gists (superseded by Emil's official skill); jezweb/claude-skills motion (registry listings look stale — no motion SKILL.md in the current tree).

*Corpus note:* hard install/star numbers are solid; genuine third-party review threads are scarce — ranking leans on installs, provenance, and direct file inspection.

---

## For general frontend / UI design quality (avoiding "AI slop") use these

**tl;dr**
- Commit to an explicit aesthetic direction (typography, color system, one signature element) BEFORE writing any code — never start from the AI defaults (Inter, purple gradients, card grids, cream+serif+terracotta).
- Work in two passes: generate with creative direction first, then run a rule-based compliance audit (accessibility, keyboard, forms, performance) as a separate quality gate before shipping.
- Match the design system to the product type — a fintech dashboard and a wellness app should not share a palette or type scale.

**Best specific skills**
1. **anthropics/skills — frontend-design** — fetch `https://raw.githubusercontent.com/anthropics/skills/main/skills/frontend-design/SKILL.md` — best for creative direction when generating new UI: it names the default AI design clusters and forces a committed, brief-specific direction before any code. Evidence: 531.9K installs (skills.sh #2 overall), 149K-star official repo, featured in 5+ independent 2026 roundups (Snyk, Composio, Firecrawl). Strength: strong. ← default pick
2. **nextlevelbuilder/ui-ux-pro-max** — fetch `https://raw.githubusercontent.com/nextlevelbuilder/ui-ux-pro-max-skill/main/.claude/skills/ui-ux-pro-max/SKILL.md` — best for auto-generating a complete, product-type-matched design system (style + palette + type + UX rules) with pre-delivery anti-pattern checks. Evidence: 211.5K installs, ~90K stars, called the most popular community design skill in 2026 roundups; organic review threads thin. Strength: strong.
3. **vercel-labs/agent-skills — web-design-guidelines** — fetch `https://raw.githubusercontent.com/vercel-labs/agent-skills/main/skills/web-design-guidelines/SKILL.md` — best for auditing existing UI code against 100+ interaction/accessibility/polish rules reported as file:line findings (quality gate, not generation). It fetches Vercel's live guidelines on every run, so it never goes stale. Evidence: ~383K installs, Vercel-official, recommended alongside frontend-design in multiple guides. Strength: strong.

*Skip:* anthropics canvas-design (poster/art canvases, not product UI); obra/superpowers (great engineering-workflow pack, zero design-quality content).

---

## For landing pages & marketing sites use these

**tl;dr**
- One page, one message, one CTA — match the headline to the traffic source, remove navigation where possible, and make the complete argument on a single page.
- Give the hero a deliberate visual identity (distinctive type + signature element) so it can't be mistaken for a template — visuals and conversion copy are two separate jobs; do both, in that order.
- Audit the built page against accessibility/UX rules before shipping; conversion structure (trust signals, objection handling) is a checklist, not a vibe.

**Best specific skills**
1. **anthropics/skills — frontend-design** — fetch `https://raw.githubusercontent.com/anthropics/skills/main/skills/frontend-design/SKILL.md` — best for the hero section and overall visual identity without the generic AI look. Evidence: 531.8K installs; praised on X specifically for landing pages ("without this, every Claude landing page looks the same"). Strength: strong. ← default pick, pair with #2
2. **coreyhaines31/marketingskills — copywriting** — fetch `https://raw.githubusercontent.com/coreyhaines31/marketingskills/main/skills/copywriting/SKILL.md` — best for conversion copy layout: headline, subheadline, CTAs, social proof, with page-type-specific frameworks ("single message, single CTA; match headline to traffic source"). Evidence: 124.0K installs (repo total 281.9K), built by a known SaaS marketer, featured in 2026 marketing-skill roundups. Strength: strong.
3. **coreyhaines31/marketingskills — cro** — fetch `https://raw.githubusercontent.com/coreyhaines31/marketingskills/main/skills/cro/SKILL.md` — best for conversion-rate diagnosis of page structure: value-prop clarity, trust signals, distraction removal, A/B test ideas. Strength: directional.
4. **vercel-labs/agent-skills — web-design-guidelines** — fetch `https://raw.githubusercontent.com/vercel-labs/agent-skills/main/skills/web-design-guidelines/SKILL.md` — best for the pre-ship audit of the built page (accessibility/UX correctness). Evidence: 383.1K installs. Strength: strong.

*Skip:* inferen-sh landing-page-design (promo wrapper for a paid CLI, little actual guidance); one-off landing-page SKILL.md repos with no registry presence or reviews.

---

## For typography use these

**tl;dr**
- Pair ONE distinctive display font with ONE refined body font, cap at 2 families, and never default to Inter/Roboto/Arial.
- Serve variable fonts with `display=swap` (fewer requests, full weight flexibility) and build text on a real modular type scale, not ad-hoc sizes.
- Typography exists to honor content: set hierarchy with size/weight/spacing before reaching for color or decoration.

**Best specific skills**
1. **anthropics/skills — frontend-design** (typography section) — fetch `https://raw.githubusercontent.com/anthropics/skills/main/skills/frontend-design/SKILL.md` — best for distinctive font selection and pairing on new UI ("avoid generic fonts like Arial and Inter… pair a distinctive display font with a refined body font"). Evidence: 531.9K installs. Strength: strong. ← default pick
2. **petekp/claude-code-setup — typography** — fetch `https://raw.githubusercontent.com/petekp/claude-code-setup/main/skills/typography/SKILL.md` — best for deep typography-only system work: type scales, fluid type, variable fonts, font loading, RTL/CJK. Bringhurst-grounded with 7 reference files. Evidence: repo active (June 2026) but ~6 installs — the only verified skill treating typography as the whole job. Strength: single-source. (Repo was renamed from petekp/claude-skills; older links 404.)
3. **sliday/google-fonts-skill** — fetch `https://raw.githubusercontent.com/sliday/google-fonts-skill/main/SKILL.md` — best for picking concrete Google Fonts pairings and generating the CSS/Tailwind/embed code (1,923-font database, mood search, 8 modular scales). Strength: single-source.
4. **vercel-labs/agent-skills — web-design-guidelines** — best for auditing existing code for typography/readability violations (see pointer above). Strength: strong.

*Skip:* davepoon typography-selector (thin Google-Fonts wrapper — sliday does the same job with a real database); "Typography Expert" directory listings with no fetchable repo.

---

## For color & theming use these

**tl;dr**
- Build color ramps in OKLCH (perceptually uniform), and structure tokens in three tiers — primitive → semantic → component — so dark mode is a token swap, never a color inversion.
- Name tokens by purpose, not appearance (`bg-surface`, not `gray-100`), and plan dark mode from day one — retrofitting is much harder.
- Treat contrast as a hard gate: WCAG AA 4.5:1 body / 3:1 large text minimum (use APCA when you want the stricter modern standard), verified programmatically, not by eye.

**Best specific skills**
1. **meodai/skill.color-expert** — fetch `https://raw.githubusercontent.com/meodai/skill.color-expert/main/SKILL.md` — best for color science: accessible palettes, OKLCH ramps, APCA/WCAG contrast decisions. Deepest verified color corpus (~113 reference docs), actively maintained (pushed 2026-06-10), author maintains the well-known color-names project. Evidence: 485 stars, tops GitHub color-skill search. Strength: strong. ← default pick
2. **wshobson/agents — visual-design-foundations** — fetch `https://raw.githubusercontent.com/wshobson/agents/main/plugins/ui-design/skills/visual-design-foundations/SKILL.md` — best for end-to-end foundations: semantic color tokens + a working dark-mode CSS-variable strategy (`[data-theme]` swap) inside a full design-system pass. Evidence: 8.7K installs, 36.6K-star parent repo. Strength: strong.
3. **ilikescience/design-tokens-skill** — fetch `https://raw.githubusercontent.com/ilikescience/design-tokens-skill/main/SKILL.md` — best for DTCG-spec token plumbing: `.tokens.json` validation, color-space objects, theme resolvers, Terrazzo/Figma pipelines. Author (Matthew Ström) writes prominently on design tokens. Evidence: 12 stars, registry-listed; the only verified skill targeting the W3C DTCG spec directly. Strength: single-source.

*Skip:* anthropics theme-factory (styles slide/doc artifacts with preset palettes — does not build app token systems or contrast-checked palettes); ui-ux-pro-max for this topic specifically (kitchen-sink lookup table, weak on dark-mode token architecture).

---

## For design systems & component libraries (shadcn/Tailwind) use these

**tl;dr**
- Use semantic tokens over raw values everywhere (`bg-primary` and `text-muted-foreground`, never hex or raw Tailwind scales), `gap-*` over `space-y-*`, and built-in component variants before any custom CSS.
- In an existing shadcn project, read the real component APIs and `components.json` instead of guessing; on greenfield, generate the full system first and persist it as a `MASTER.md` source of truth.
- On Tailwind v4, wire theming as variables in `:root`/`.dark` mapped through `@theme inline` — most "broken dark mode" reports trace to skipping that exact pattern.

**Best specific skills**
1. **shadcn-ui/ui — shadcn skill** — fetch `https://raw.githubusercontent.com/shadcn-ui/ui/main/skills/shadcn/SKILL.md` — best for enforcing component-library consistency in an existing shadcn/Tailwind project: correct component APIs, semantic tokens, composition rules (FieldGroup+Field forms). First-party and project-aware. Evidence: 186.0K installs, ships in the 116K-star shadcn repo, documented at ui.shadcn.com/docs/skills. Strength: strong. ← default pick for existing projects
2. **nextlevelbuilder/ui-ux-pro-max** — pointer above — best for generating a complete NEW design system when none exists: its v2 generator reasons from product type to a full system and can persist a `design-system/MASTER.md` source of truth. Evidence: 90.4K stars, top-5 in 4+ independent 2026 roundups. Strength: strong. ← default pick for greenfield
3. **arvindrk/extract-design-system** — fetch `https://raw.githubusercontent.com/arvindrk/extract-design-system/main/skills/extract-design-system/SKILL.md` — best for extracting tokens (colors, type, spacing, radius, shadows) from an existing live site via Playwright to bootstrap a tokenized system matching a real brand. Honest guardrails in the file itself. Evidence: 123.1K registry installs but only 54 stars — popularity may be registry-inflated. Strength: directional.
4. **secondsky/claude-skills — tailwind-v4-shadcn** — fetch `https://raw.githubusercontent.com/secondsky/claude-skills/main/plugins/tailwind-v4-shadcn/skills/tailwind-v4-shadcn/SKILL.md` — best for wiring Tailwind v4 token/theme architecture correctly and debugging broken theming (the exact variable → `@theme inline` → base styles → dark mode pattern plus the five known setup errors). Evidence: 167 stars, graded 'A' on skillsdirectory. Strength: directional.

*Skip:* frontend-design for this topic (one-shot aesthetic direction, no token governance or consistency rules); mattbx/shadcn-skills (8 stars, no traction).

---

## For accessibility use these

**tl;dr**
- Treat accessible code as the baseline on every UI edit, not an audit afterthought — WCAG 2.2 AA across all four POUR principles is the floor, not the stretch goal.
- Automate with axe-core/Lighthouse, but never call it done without keyboard-only navigation and a real screen reader pass (VoiceOver/NVDA) — automated tools catch a minority of issues.
- Don't guess ARIA patterns from memory; pull the documented pattern for the specific widget (and on large sites, audit ~20 representative template pages instead of crawling everything).

**Best specific skills**
1. **addyosmani/web-quality-skills — accessibility** — fetch `https://raw.githubusercontent.com/addyosmani/web-quality-skills/main/skills/accessibility/SKILL.md` — best for general-purpose WCAG 2.2 audit-and-fix with copy-paste ARIA/keyboard/contrast patterns covering all four POUR principles. Evidence: 2.2K-star repo, multiple registries, cited in Snyk's UI/UX skills roundup, Chrome-team-adjacent author. Strength: strong. ← default pick
2. **Community-Access/accessibility-agents** — repo `https://github.com/Community-Access/accessibility-agents` (browse the repo; skills live in subdirectories) — best for team-scale WCAG 2.2 AA enforcement: 79 agents + 18 skills including document (DOCX/PDF/PPTX) accessibility and an MCP scanner for CI. Built by actual assistive-technology users (Taylor Arndt, Jeff Bishop), v5.4.0 May 2026. Strength: directional — the depth pick, not the default.
3. **joedevon/a11y-skills — a11y-code-review** — fetch `https://raw.githubusercontent.com/joedevon/a11y-skills/main/a11y-code-review/SKILL.md` — best for an always-on accessible-code baseline that triggers on every UI edit, not just explicit audit requests ("accessible code is the baseline, not an add-on"). Author co-founded Global Accessibility Awareness Day — unmatched domain authority, but ~no usage signal. Strength: single-source.
4. **snapsynapse/skill-a11y-audit** — repo `https://github.com/snapsynapse/skill-a11y-audit` (SKILL.md at `a11y-audit/SKILL.md`) — best for auditing large live sites efficiently via template-aware page sampling (~20 representative pages instead of 700). Strength: single-source.

*Skip:* mindrally accessibility-a11y (anonymous mega-pack, registry SEO only); CrazyDubya accessibility-auditor (bulk AI-generated dump).

---

## For UX writing & microcopy use these

**tl;dr**
- Every error message must answer three questions: what happened, why, and how to fix it — anything less is decoration.
- Write button labels as verb+object ("Save changes", not "OK"/"Submit"), and treat empty states as onboarding moments, not dead ends.
- Don't apply marketing-copy frameworks to product UI — persuasion copy and microcopy are different jobs; inside the product, clarity beats cleverness every time.

**Best specific skills**
1. **pbakaus/impeccable — clarify** — fetch `https://raw.githubusercontent.com/pbakaus/impeccable/main/.claude/skills/impeccable/reference/clarify.md` — best for fixing unclear labels, error messages, and CTA copy in an existing UI as part of a design-quality pass. Evidence: 37.5K stars, pushed 2026-06-11, 156.3K installs, covered by Firecrawl/Composio/Snyk roundups. Strength: strong. ← default pick
2. **content-designer/ux-writing-skill** — fetch `https://raw.githubusercontent.com/content-designer/ux-writing-skill/main/SKILL.md` — best for writing new microcopy end-to-end with systematic standards: voice/tone charts, fillable templates for errors, empty states, onboarding. The only dedicated, maintained UX-writing SKILL.md found. Evidence: 108 stars, 714 installs, v1.6.0 Mar 2026. Strength: directional.
3. **szilu/ux-designer-skill** — fetch `https://raw.githubusercontent.com/szilu/ux-designer-skill/main/SKILL.md` — best for a lightweight single-skill UX generalist with a dedicated microcopy reference, without pulling in an 18-skill pack. Evidence: 20 stars, no registry rank. Strength: single-source.

*Skip:* coreyhaines31 copywriting for this topic (explicitly scoped to marketing pages, not UI microcopy — it IS the right pick for landing pages above).

---

## For mobile app design (iOS/Android) use these

**tl;dr**
- Follow the platform, don't invent: HIG on iOS, Material 3 on Android — native navigation patterns, no hamburger menus on iOS, no hardcoded fonts.
- Hit the universal floor on every screen: 44×44pt (Apple) / 48×48dp (Material) touch targets (extend hit areas beyond visual bounds if needed), safe areas, swipe-back, Dynamic Type.
- Design for each platform separately rather than shipping one compromise UI to both.

**Best specific skills**
1. **ehmo/platform-design-skills** — fetch `https://raw.githubusercontent.com/ehmo/platform-design-skills/main/skills/ios/SKILL.md` (Android variant alongside it in the repo) — best for enforcing HIG / Material 3 / WCAG conventions on iOS and Android screens: 450+ distilled per-platform rules incl. iPadOS/watchOS/visionOS, with checklists and anti-patterns. Evidence: 390 stars, multi-registry, surfaced in the HN "Claude Skills are awesome" thread. Strength: strong. ← default pick
2. **nextlevelbuilder/ui-ux-pro-max** — pointer above — best for end-to-end mobile-first UI generation (design system + touch/gesture rules) across React Native, Flutter, SwiftUI. Evidence: ~211.4K installs, 90.4K stars; mobile rules verified real. Strength: strong.
3. **wshobson/agents — mobile-ios-design / mobile-android-design** — fetch `https://raw.githubusercontent.com/wshobson/agents/main/plugins/ui-design/skills/mobile-ios-design/SKILL.md` — best for implementing native-feeling screens in code: SwiftUI patterns, NavigationStack, SF Symbols, semantic colors, Material 3 components. Evidence: 36.6K-star repo, actively pushed; per-skill signal weaker. Strength: directional.

*Skip:* sleekdotdesign sleek-design-mobile-apps (~199K installs but it's a REST wrapper for a paid platform requiring an API key); awesome-skills/mobile-app-design (dormant, shallower duplicate of ehmo's pack).

For what real mobile apps' screens actually look like (evidence, not rules), pair with `/lazyweb-quick-references` or `/lazyweb-design-research`.

---

## For dashboards & data visualization use these

**tl;dr**
- Pick chart encodings by the perceptual hierarchy: position beats length beats angle beats area beats color (Cleveland-McGill) — so bars over pies, dot plots over heatmap shades when precision matters.
- For 1000+ data points, aggregate or sample and provide drill-down for detail — never render everything.
- Get chart correctness and visual polish from separate passes: choose the right chart and encoding first, style the dashboard second.

**Best specific skills**
1. **nextlevelbuilder/ui-ux-pro-max** — pointer above — best for end-to-end design system + chart/dashboard guidance: the only widely-installed skill explicitly encoding dashboard/admin product types (Data-Dense Dashboard, Executive Dashboard, Real-Time Monitoring) and 25 chart types. Evidence: 211.5K installs, Snyk roundup. Strength: strong. ← default pick
2. **ntcoding/claude-skillz — data-visualization** — fetch `https://raw.githubusercontent.com/ntcoding/claude-skillz/main/data-visualization/SKILL.md` — best for chart-selection and perceptual-encoding correctness: Cleveland-McGill hierarchy, layout algorithms (dagre, d3-force, ELK.js), performance-by-data-scale rules. Strength: directional.
3. **anthropics/skills — frontend-design** — pointer above — best for visual polish layered on top ("structure is information… should encode something true about the content, not decorate it"). No dataviz brain of its own. Strength: strong.
4. **mhattingpete/dashboard-creator** — fetch `https://raw.githubusercontent.com/mhattingpete/claude-skills-marketplace/main/visual-documentation-plugin/skills/dashboard-creator/SKILL.md` — best for quick self-contained HTML KPI dashboards (no JS framework) for reports and internal monitoring. Too shallow for production admin UIs. Strength: single-source.

*Skip:* aggregator-only "Data Visualization Expert" listings with no traceable repo; directory skills with self-reported, unverifiable trust numbers.

---

## Refresh protocol (when a topic is missing or stale)

This table was researched 2026-06-11. The skill ecosystem turns over fast.
When the user's aspect has no section here, or this file is older than ~90
days, re-run the sweep for that aspect — in parallel where possible:

1. Search skills.sh, GitHub ("claude skill <topic>", awesome-lists),
   `site:reddit.com` (r/ClaudeAI, r/ClaudeCode, r/cursor, r/webdev),
   `site:x.com`, and `site:news.ycombinator.com` — 4-8 searches.
2. **Verify before recommending**: fetch the candidate's repo and raw
   SKILL.md; a skill that can't be fetched and read does not ship. Never
   invent a skill, a rank, an install count, or a quote.
3. Count, don't vibe: a top pick needs ≥2 independent sources; label
   strength honestly (strong / directional / single-source); discount
   signals older than ~6 months; flag a thin corpus.
4. Present in the same format as the sections above, apply the winner to
   the user's task, and update this file's section (and the researched date)
   so the next run benefits.
