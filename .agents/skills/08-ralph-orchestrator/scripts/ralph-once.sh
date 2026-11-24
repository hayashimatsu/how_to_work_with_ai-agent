#!/usr/bin/env bash
set -euo pipefail

AGENT_CMD="${AGENT_CMD:-claude}"

if ! ls issues/ISSUE-*.md >/dev/null 2>&1; then
  echo "No ISSUE-*.md files found in issues/."
  exit 0
fi

ISSUES_CONTENT=""
for f in issues/ISSUE-*.md; do
  ISSUES_CONTENT+="--- FILE: $(basename "$f") ---"$'\n'"$(cat "$f")"$'\n\n'
done

RECENT_COMMITS="$(git log -n 5 --oneline 2>/dev/null || echo '(no commits yet)')"

PROMPT=$(cat <<EOF
You are operating in a fresh Smart Zone session. Read AGENTS.md first.

=== RECENT COMMITS ===
$RECENT_COMMITS

=== CURRENT ISSUES ===
$ISSUES_CONTENT

=== INSTRUCTIONS ===
1. Pick ONE unblocked issue with \`type: AFK\` and \`status: TODO\` (priority: critical-bug > dev-infra > tracer-bullet > feature > polish).
2. If NO unblocked AFK TODO issues remain, output exactly: <promise>NO MORE TASKS</promise> and stop.
3. Load \`.agents/skills/04-strict-tdd-loop/SKILL.md\` and implement ONLY that issue using strict Red-Green-Refactor.
4. Run all tests and typechecks, commit atomically, update the issue status to \`READY_FOR_REVIEW\`, and stop immediately.
EOF
)

printf '%s' "$PROMPT" | "$AGENT_CMD" -p --permission-mode acceptEdits
