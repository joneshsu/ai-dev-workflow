@AGENTS.md

<!-- 以上匯入所有 AI 工具共用的規則。以下只放 Claude Code 專屬的補充，不要重複 AGENTS.md 的內容。 -->

## Claude Code 專屬補充
- Skills 透過 `.claude/skills`（連結到 `.agents/skills`）載入，可用 `/spec`、`/plan` 等方式呼叫。
- 執行 review skill 時，請使用 `code-reviewer` subagent（`.claude/agents/code-reviewer.md`）。
- 規劃類步驟（brainstorm、prd、architecture、roadmap、plan）建議在 Plan Mode 下進行。
