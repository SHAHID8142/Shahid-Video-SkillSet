<#
  Shahid Video SkillSet (/svs) — uninstaller (Windows PowerShell)
  Removes the `svs` skill from every agent location. The global ~/.svs profile is
  kept unless you pass -Purge.

  Usage:  ./uninstall.ps1 [-Purge]
#>

param([switch]$Purge)

$ErrorActionPreference = "Stop"
$SkillName = "svs"

function Write-Title($t) { Write-Host $t -ForegroundColor White }
function Write-Ok($t)    { Write-Host "  [OK] $t" -ForegroundColor Green }
function Write-Skip($t)  { Write-Host "  [..] $t" -ForegroundColor Yellow }

Write-Host ""
Write-Title "Shahid Video SkillSet — uninstalling /svs"
Write-Host ""

$Targets = @(
    @{ Label = "Claude Code";    Path = Join-Path $HOME ".claude\skills" },
    @{ Label = "Antigravity";    Path = Join-Path $HOME ".gemini\antigravity\skills" },
    @{ Label = "Gemini CLI";     Path = Join-Path $HOME ".gemini\skills" },
    @{ Label = "Codex";          Path = Join-Path $HOME ".codex\skills" },
    @{ Label = "Generic agents"; Path = Join-Path $HOME ".agents\skills" }
)

$removed = 0
foreach ($t in $Targets) {
    $dest = Join-Path $t.Path $SkillName
    if (Test-Path $dest) {
        Remove-Item -Recurse -Force $dest
        Write-Ok "Removed $($t.Label)  ($dest)"
        $removed++
    } else {
        Write-Skip "$($t.Label) — not installed"
    }
}

$SvsHome = Join-Path $HOME ".svs"
if ($Purge) {
    if (Test-Path $SvsHome) {
        Remove-Item -Recurse -Force $SvsHome
        Write-Ok "Purged global profile ~/.svs"
    }
} else {
    Write-Skip "Kept global profile ~/.svs (use -Purge to remove it)"
}

Write-Host ""
Write-Title "Removed /svs from $removed location(s)."
Write-Host ""
