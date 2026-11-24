<#
.SYNOPSIS
  Bounded AFK loop running fresh Smart Zone sessions until all AFK issues are done.
.DESCRIPTION
  IMPORTANT: Run inside an isolated sandbox/container or dedicated branch.
#>
param(
    [int]$MaxIterations = 10,
    [string]$AgentCmd = "claude"
)

$ErrorActionPreference = "Stop"
$OnceScript = Join-Path $PSScriptRoot "ralph-once.ps1"

for ($i = 1; $i -le $MaxIterations; $i++) {
    Write-Host "`n=== Ralph AFK Iteration $i / $MaxIterations ==="
    $Output = & $OnceScript -AgentCmd $AgentCmd | Tee-Object -Variable Captured
    $Text = $Output -join "`n"

    if ($Text -match "<promise>NO MORE TASKS</promise>") {
        Write-Host "`nAll unblocked AFK tasks completed. Exiting cleanly."
        exit 0
    }
}

Write-Host "`nReached MaxIterations ($MaxIterations). Review progress and remaining issues."
