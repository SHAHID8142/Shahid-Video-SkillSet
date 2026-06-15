<#
  Shahid Video SkillSet (/svs) — interactive multi-agent installer (Windows PowerShell)

  Lets you choose WHICH agents to install /svs into. Detected agents are pre-selected;
  toggle any on/off, then confirm. Covers every common CLI / AI coding agent.

  Usage:
    ./install.ps1               # interactive picker
    ./install.ps1 -All          # install into every supported agent, no prompts
    ./install.ps1 -Detected     # install only into detected agents (non-interactive)
#>

param([switch]$All, [switch]$Detected)

$ErrorActionPreference = "Stop"
$SkillName = "svs"
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$SrcDir    = Join-Path $ScriptDir "skills\$SkillName"

function Write-Title($t) { Write-Host $t -ForegroundColor White }
function Write-Ok($t)    { Write-Host "  [OK] $t" -ForegroundColor Green }
function Write-Skip($t)  { Write-Host "  [..] $t" -ForegroundColor Yellow }
function Write-Err($t)   { Write-Host "  [X] $t"  -ForegroundColor Red }

if (-not (Test-Path (Join-Path $SrcDir "SKILL.md"))) {
    Write-Err "Could not find skills\$SkillName\SKILL.md next to this script."
    Write-Host "    Run this from inside the cloned Shahid-Video-SkillSet repo."
    exit 1
}

# --- agent registry ----------------------------------------------------------
# Kind: folder (copy skill folder) | mdc (Cursor rule file) | rulefile (markdown rule)
$Agents = @(
    @{ Key="claude";      Label="Claude Code";          Kind="folder";   Path=(Join-Path $HOME ".claude\skills");                          Detect=(Join-Path $HOME ".claude") },
    @{ Key="gemini";      Label="Gemini CLI";           Kind="folder";   Path=(Join-Path $HOME ".gemini\skills");                          Detect=(Join-Path $HOME ".gemini") },
    @{ Key="antigravity"; Label="Antigravity";          Kind="folder";   Path=(Join-Path $HOME ".gemini\antigravity\skills");              Detect=(Join-Path $HOME ".gemini\antigravity") },
    @{ Key="codex";       Label="Codex CLI";            Kind="folder";   Path=(Join-Path $HOME ".codex\skills");                           Detect=(Join-Path $HOME ".codex") },
    @{ Key="opencode";    Label="OpenCode";             Kind="folder";   Path=(Join-Path $HOME ".config\opencode\skills");                 Detect=(Join-Path $HOME ".config\opencode") },
    @{ Key="aider";       Label="Aider";                Kind="folder";   Path=(Join-Path $HOME ".aider\skills");                           Detect=(Join-Path $HOME ".aider") },
    @{ Key="continue";    Label="Continue";             Kind="folder";   Path=(Join-Path $HOME ".continue\skills");                        Detect=(Join-Path $HOME ".continue") },
    @{ Key="agents";      Label="Generic (~/.agents)";  Kind="folder";   Path=(Join-Path $HOME ".agents\skills");                          Detect=(Join-Path $HOME ".agents") },
    @{ Key="cursor";      Label="Cursor";               Kind="mdc";      Path=(Join-Path $HOME ".cursor\rules\svs.mdc");                   Detect=(Join-Path $HOME ".cursor") },
    @{ Key="windsurf";    Label="Windsurf";             Kind="rulefile"; Path=(Join-Path $HOME ".codeium\windsurf\global-rules\svs.md");  Detect=(Join-Path $HOME ".codeium\windsurf") },
    @{ Key="cline";       Label="Cline / Roo (VS Code)";Kind="rulefile"; Path=(Join-Path $HOME ".clinerules\svs.md");                      Detect=(Join-Path $HOME ".clinerules") }
)

function Test-Detected($agent) { return (Test-Path $agent.Detect) }

function Get-SkillBody {
    # Strip YAML frontmatter (content after the 2nd '---').
    $lines = Get-Content (Join-Path $SrcDir "SKILL.md")
    $dash = 0; $out = New-Object System.Collections.Generic.List[string]
    foreach ($l in $lines) {
        if ($l -eq "---") { $dash++; continue }
        if ($dash -ge 2) { $out.Add($l) }
    }
    return ($out -join "`n")
}

function Write-RuleFile($agent) {
    New-Item -ItemType Directory -Force -Path (Split-Path $agent.Path -Parent) | Out-Null
    $body = Get-SkillBody
    if ($agent.Kind -eq "mdc") {
        $fm = "---`ndescription: /svs — World-Class AI Video Director & Remotion Expert. Turns a real codebase (or a script) into a cinematic video. Trigger on /svs or any code-to-video request.`nglobs:`nalwaysApply: false`n---`n`n"
        Set-Content -Path $agent.Path -Value ($fm + $body) -Encoding UTF8
    } else {
        Set-Content -Path $agent.Path -Value ("# /svs — Shahid Video SkillSet (rule)`n`n" + $body) -Encoding UTF8
    }
}

function Install-One($agent) {
    if ($agent.Kind -eq "folder") {
        $dest = Join-Path $agent.Path $SkillName
        if (Test-Path $dest) { Remove-Item -Recurse -Force $dest }
        New-Item -ItemType Directory -Force -Path $dest | Out-Null
        Copy-Item -Recurse -Force (Join-Path $SrcDir "*") $dest
        Write-Ok "$($agent.Label)  ->  $dest"
    } else {
        Write-RuleFile $agent
        Write-Ok "$($agent.Label)  ->  $($agent.Path)"
    }
}

# --- selection ---------------------------------------------------------------
$sel = @{}
foreach ($a in $Agents) {
    if ($All) { $sel[$a.Key] = $true }
    elseif (Test-Detected $a) { $sel[$a.Key] = $true }
    else { $sel[$a.Key] = $false }
}

function Show-Menu {
    Write-Host ""
    Write-Title "Shahid Video SkillSet - choose where to install /svs"
    Write-Title "[x] = will install   [ ] = skipped   (* detected)"
    Write-Host ""
    for ($i = 0; $i -lt $Agents.Count; $i++) {
        $a = $Agents[$i]
        $mark = if ($sel[$a.Key]) { "x" } else { " " }
        $det  = if (Test-Detected $a) { "* " } else { "  " }
        "{0,2}) [{1}] {2}{3,-26} {4}" -f ($i+1), $mark, $det, $a.Label, $a.Path | Write-Host
    }
    Write-Host ""
    Write-Host "   Numbers toggle (e.g. '1 3 5'), 'a'=all, 'n'=none, 'd'=detected, ENTER=install, 'q'=quit."
}

$interactive = -not ($All -or $Detected)
if ($interactive) {
    while ($true) {
        Show-Menu
        $line = Read-Host "  >"
        if ($line -eq "") { break }
        switch -Regex ($line) {
            '^[qQ]$' { Write-Host "Aborted."; exit 0 }
            '^[aA]$' { foreach ($a in $Agents) { $sel[$a.Key] = $true } }
            '^[nN]$' { foreach ($a in $Agents) { $sel[$a.Key] = $false } }
            '^[dD]$' { foreach ($a in $Agents) { $sel[$a.Key] = (Test-Detected $a) } }
            default {
                foreach ($tok in ($line -split '\s+')) {
                    if ($tok -match '^\d+$') {
                        $idx = [int]$tok - 1
                        if ($idx -ge 0 -and $idx -lt $Agents.Count) {
                            $k = $Agents[$idx].Key
                            $sel[$k] = -not $sel[$k]
                        }
                    }
                }
            }
        }
    }
}

# --- install -----------------------------------------------------------------
Write-Host ""
Write-Title "Installing /svs..."
$installed = 0
foreach ($a in $Agents) {
    if (-not $sel[$a.Key]) { continue }
    Install-One $a
    $installed++
}

if ($installed -eq 0) { Write-Skip "Nothing selected - no changes made."; exit 0 }

# --- global memory home ------------------------------------------------------
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
    Write-Skip "~/.svs/profile.md already exists - left untouched"
}

Write-Host ""
Write-Title "Installed /svs into $installed agent location(s)."
Write-Title "Restart your agent (or start a new session) and type:  /svs"
Write-Host ""
Write-Title "Tip: /svs routes design/animation through /sps. Install it too:"
Write-Title "https://github.com/SHAHID8142/Shahid-Personal-SkillSet"
Write-Host ""
