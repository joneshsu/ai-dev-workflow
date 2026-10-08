#!/usr/bin/env bash
# 讓不同 AI 工具共用同一份規則與 skills。
# 唯一來源：AGENTS.md、.agents/skills/
# 在專案根目錄執行：bash scripts/setup-ai-tools.sh
set -euo pipefail
cd "$(dirname "$0")/.."

link() {  # link <目標> <連結路徑>
  local target="$1" path="$2"
  if [ -L "$path" ]; then echo "✓ 已存在：$path"; return; fi
  if [ -e "$path" ]; then echo "⚠ $path 已存在且不是連結，請手動處理"; return; fi
  mkdir -p "$(dirname "$path")"
  ln -s "$target" "$path" && echo "＋ 建立連結：$path → $target"
}

# Claude Code：讀取 .claude/skills/
link ../.agents/skills .claude/skills

# Gemini CLI：預設讀取 GEMINI.md（也可在 .gemini/settings.json 設定 contextFileName 為 AGENTS.md）
link AGENTS.md GEMINI.md

# Codex、Cursor、GitHub Copilot 等工具直接讀取 AGENTS.md；Codex 直接讀取 .agents/skills/，不需額外設定。
echo "完成。Windows 使用者若無法建立 symlink，請開啟開發人員模式，或改用 WSL / Git Bash 執行。"
