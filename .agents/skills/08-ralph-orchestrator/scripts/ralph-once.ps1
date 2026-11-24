<#
.SYNOPSIS
  Single Smart Zone iteration (HITL verification pass) for AFK issues.
.DESCRIPTION
  Collects current issues/*.md and the last 5 git commits, then invokes a headless
  AI coding agent CLI in a fresh session to implement ONE unblocked AFK issue.
#>
param(
    [string]$AgentCmd = "claude" # Override with your headless CLI (e.g., claude, gemini, codex)
)

$ErrorActionPreference = "Stop"

$IssueFiles = Get-ChildItem -Path "issues" -Filter "ISSUE-*.md" -ErrorAction SilentlyContinue
if (-not $IssueFiles) {
    Write-Host "No ISSUE-*.md files found in issues/."
    exit 0
}

$IssuesContent = ($IssueFiles | ForEach-Object {
    "--- FILE: $($_.Name) ---`n" + (Get-Content $_.FullName -Raw)
}) -join "`n`n"

$RecentCommits = (git log -n 5 --oneline 2>$null) -join "`n"
if (-not $RecentCommits) { $RecentCommits = "(no commits yet)" }

$Prompt = @"
You are operating in a fresh Smart Zone session. Read AGENTS.md first.

=== RECENT COMMITS ===
$RecentCommits

=== CURRENT ISSUES ===
$IssuesContent

=== INSTRUCTIONS ===
1. Pick ONE unblocked issue with `type: AFK` and `status: TODO` (priority: critical-bug > dev-infra > tracer-bullet > feature > polish).
2. If NO unblocked AFK TODO issues remain, output exactly: <promise>NO MORE TASKS</promise> and stop.
3. Load `.agents/skills/04-strict-tdd-loop/SKILL.md` and implement ONLY that issue using strict Red-Green-Refactor.
4. Run all tests and typechecks, commit atomically, update the issue status to `READY_FOR_REVIEW`, and stop immediately.
"@

Write-Host "Launching single Smart Zone pass using '$AgentCmd'..."
$Prompt | & $AgentCmd -p --permission-mode acceptEdits
