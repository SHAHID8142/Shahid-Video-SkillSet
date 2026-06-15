<#
  Shahid Video SkillSet (/svs) — global multi-agent installer (Windows PowerShell)
  Installs the `svs` Video Director skill into Claude Code, Antigravity, Gemini CLI,
  Codex, and any generic ~/.agents skill host.

  Usage:  ./install.ps1
#>

$ErrorActionPreference = "Stop"

$SkillName = "svs"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SrcDir    = Join-Path $ScriptDir "skills\$SkillName"

function Write-Title($t) { Write-Host $t -ForegroundColor White }
function Write-Ok($t)    { Write-Host "  [OK] $t" -ForegroundColor Green }
function Write-Skip($t)  { Write-Host "  [..] $t" -ForegroundColor Yellow }

Write-Host ""
Write-Title "Shahid Video SkillSet — installing /svs"
Write-Title "World-Class AI Video Director & Remotion Expert"
Write-Host ""

if (-not (Test-Path (Join-Path $SrcDir "SKILL.md"))) {
    Write-Host "[X] Could not find skills\$SkillName\SKILL.md next to this script." -ForegroundColor Red
    Write-Host "    Run this from inside the cloned Shahid-Video-SkillSet repo."
    exit 1
}

# Agent label -> global skills directory
$Targets = @(
    @{ Label = "Claude Code";    Path = Join-Path $HOME ".claude\skills" },
    @{ Label = "Antigravity";    Path = Join-Path $HOME ".gemini\antigravity\skills" },
    @{ Label = "Gemini CLI";     Path = Join-Path $HOME ".gemini\skills" },
    @{ Label = "Codex";          Path = Join-Path $HOME ".codex\skills" },
    @{ Label = "Generic agents"; Path = Join-Path $HOME ".agents\skills" }
)

$installed = 0
foreach ($t in $Targets) {
    $dest = Join-Path $t.Path $SkillName
    if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
    New-Item -ItemType Directory -Force -Path $dest | Out-Null
    Copy-Item -Recurse -Force (Join-Path $SrcDir "*") $dest
    Write-Ok "$($t.Label)  ->  $dest"
    $installed++
}

# Global memory home
$SvsHome = Join-Path $HOME ".svs"
New-Item -ItemType Directory -Force -Path $SvsHome | Out-Null
$ProfilePath = Join-Path $SvsHome "profile.md"
if (-not (Test-Path $ProfilePath)) {
@"
# /svs — Global Director Profile

> Filled out over time. The skill reads this before every job.

## Brand
- Primary color:
- Accent color:
- Brand font:
- Logo path:

## Defaults
- Default aspect ratio: 16:9   # 16:9 (YouTube) | 9:16 (Reels/TikTok) | 1:1 (square)
- Default fps: 30
- Music: ask each time

## Taste
- Tone: (e.g. sleek / energetic / luxurious / playful)
- Reference videos / inspiration:
"@ | Set-Content -Path $ProfilePath -Encoding UTF8
    Write-Ok "Created ~/.svs/profile.md (global Director profile)"
} else {
    Write-Skip "~/.svs/profile.md already exists — left untouched"
}

Write-Host ""
Write-Title "Installed /svs into $installed agent location(s)."
Write-Title "Restart your agent (or start a new session) and type:  /svs"
Write-Host ""
