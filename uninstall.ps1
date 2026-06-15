<#
  Shahid Video SkillSet (/svs) — uninstaller (Windows PowerShell)
  Removes /svs from every agent location (skill folders + Cursor/Windsurf/Cline rule files).
  The global ~/.svs profile is kept unless you pass -Purge.

  Usage:  ./uninstall.ps1 [-Purge]
#>

param([switch]$Purge)

$ErrorActionPreference = "Stop"
$SkillName = "svs"

function Write-Title($t) { Write-Host $t -ForegroundColor White }
function Write-Ok($t)    { Write-Host "  [OK] $t" -ForegroundColor Green }
function Write-Skip($t)  { Write-Host "  [..] $t" -ForegroundColor Yellow }

Write-Host ""
Write-Title "Shahid Video SkillSet - uninstalling /svs"
Write-Host ""

$Agents = @(
    @{ Label="Claude Code";          Kind="folder";   Path=(Join-Path $HOME ".claude\skills") },
    @{ Label="Gemini CLI";           Kind="folder";   Path=(Join-Path $HOME ".gemini\skills") },
    @{ Label="Antigravity";          Kind="folder";   Path=(Join-Path $HOME ".gemini\antigravity\skills") },
    @{ Label="Codex CLI";            Kind="folder";   Path=(Join-Path $HOME ".codex\skills") },
    @{ Label="OpenCode";             Kind="folder";   Path=(Join-Path $HOME ".config\opencode\skills") },
    @{ Label="Aider";                Kind="folder";   Path=(Join-Path $HOME ".aider\skills") },
    @{ Label="Continue";             Kind="folder";   Path=(Join-Path $HOME ".continue\skills") },
    @{ Label="Generic (~/.agents)";  Kind="folder";   Path=(Join-Path $HOME ".agents\skills") },
    @{ Label="Cursor";               Kind="mdc";      Path=(Join-Path $HOME ".cursor\rules\svs.mdc") },
    @{ Label="Windsurf";             Kind="rulefile"; Path=(Join-Path $HOME ".codeium\windsurf\global-rules\svs.md") },
    @{ Label="Cline / Roo (VS Code)";Kind="rulefile"; Path=(Join-Path $HOME ".clinerules\svs.md") }
)

$removed = 0
foreach ($a in $Agents) {
    $target = if ($a.Kind -eq "folder") { Join-Path $a.Path $SkillName } else { $a.Path }
    if (Test-Path $target) {
        Remove-Item -Recurse -Force $target
        Write-Ok "Removed $($a.Label)  ($target)"
        $removed++
    } else {
        Write-Skip "$($a.Label) - not installed"
    }
}

$SvsHome = Join-Path $HOME ".svs"
if ($Purge) {
    if (Test-Path $SvsHome) { Remove-Item -Recurse -Force $SvsHome; Write-Ok "Purged global profile ~/.svs" }
} else {
    Write-Skip "Kept global profile ~/.svs (use -Purge to remove it)"
}

Write-Host ""
Write-Title "Removed /svs from $removed location(s)."
Write-Host ""
