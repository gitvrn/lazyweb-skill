import { test } from "node:test";
import assert from "node:assert/strict";
import { existsSync, readFileSync } from "node:fs";
import path from "node:path";
import { fileURLToPath } from "node:url";

const root = path.resolve(path.dirname(fileURLToPath(import.meta.url)), "..");

function read(relativePath) {
  return readFileSync(path.join(root, relativePath), "utf8");
}

test("packages and routes generic A/B test research skill", () => {
  assert.ok(
    existsSync(path.join(root, "plugins/lazyweb/skills/lazyweb-ab-test-research/SKILL.md")),
    "missing packaged lazyweb-ab-test-research skill",
  );
  const router = read("plugins/lazyweb/skills/lazyweb/SKILL.md");
  assert.match(router, /lazyweb-ab-test-research/);
  assert.match(router, /A\/B tests, experiments, growth hypotheses, monetization strategy/);
});

test("public tool allowlist includes experiment compatibility tools", () => {
  const validation = read("scripts/validate-plugin.mjs");
  assert.match(validation, /"lazyweb_find_experiments"/);
  assert.match(validation, /"lazyweb_recent_experiments"/);
  assert.match(validation, /"lazyweb_ab_test_research"/);
});

test("README documents high design bar and generic experiment tools", () => {
  const readme = read("README.md");
  assert.match(readme, /high_design_bar:\s*true/);
  assert.match(readme, /companies\.high_design_bar\s*=\s*true/);
  assert.match(readme, /lazyweb_find_experiments/);
  assert.match(readme, /not be\s+treated as paywall-only/);
});

test("A/B research skill documents limited data and interesting learning default", () => {
  const skill = read("plugins/lazyweb/skills/lazyweb-ab-test-research/SKILL.md");
  assert.match(skill, /_experiments.*limited screenshot-diff evidence set/s);
  assert.match(skill, /interesting_learning.*false/s);
  assert.match(skill, /high_design_bar/);
});

test("design skills all mention high design bar filtering", () => {
  const files = [
    "plugins/lazyweb/skills/lazyweb-design-improve/SKILL.md",
    "plugins/lazyweb/skills/lazyweb-design-research/SKILL.md",
    "plugins/lazyweb/skills/lazyweb-quick-references/SKILL.md",
    "plugins/lazyweb/skills/lazyweb-design-brainstorm/SKILL.md",
    "plugins/lazyweb/skills/lazyweb-ab-test-research/SKILL.md",
  ];
  for (const file of files) {
    assert.match(read(file), /high_design_bar/, `${file} should mention high_design_bar`);
  }
});

test("x_paywall_design skill is not packaged", () => {
  assert.equal(existsSync(path.join(root, "plugins/lazyweb/skills/x_paywall_design_research")), false);
  assert.equal(existsSync(path.join(root, "plugins/lazyweb/skills/x_paywall_design")), false);
});
