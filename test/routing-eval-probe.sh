#!/usr/bin/env bash
# routing-eval-probe.sh "<natural-language prompt>"
#
# Fires a FRESH headless Claude Code session (which loads ~/.claude/CLAUDE.md,
# where `lazyweb-router install` wrote the autorouter block) and prints ONE JSON
# line describing whether — and to which Lazyweb mode — the session auto-routed,
# with no explicit /lazyweb invocation. This is the live §11.4 routing-eval probe.
#
# Output: {"routed":"lazyweb-design-improve","evidence":"Skill"}  (routed)
#         {"routed":"none","evidence":""}                          (not routed)
set -uo pipefail
PROMPT="${1:?usage: routing-eval-probe.sh \"<prompt>\"}"

OUT="$(claude -p "$PROMPT" \
  --output-format stream-json --verbose \
  --max-turns 2 --permission-mode bypassPermissions 2>/dev/null || true)"

printf '%s' "$OUT" | node -e '
let s = "";
process.stdin.on("data", d => s += d);
process.stdin.on("end", () => {
  let routed = "none", evidence = "";
  outer:
  for (const line of s.split(/\n/)) {
    if (!line.trim()) continue;
    let j; try { j = JSON.parse(line); } catch (e) { continue; }
    if (j.type === "assistant" && j.message && Array.isArray(j.message.content)) {
      for (const c of j.message.content) {
        if (c.type !== "tool_use") continue;
        const inp = c.input || {};
        if (c.name === "Skill" && typeof inp.skill === "string" && inp.skill.includes("lazyweb")) {
          routed = inp.skill; evidence = "Skill"; break outer;
        }
        if (/lazyweb_/.test(c.name)) { routed = c.name; evidence = "mcp"; break outer; }
      }
    }
  }
  process.stdout.write(JSON.stringify({ routed, evidence }));
});'
