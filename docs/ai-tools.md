# 多 AI 工具共用說明

## 設計原則
1. **規則只寫一份**：`AGENTS.md` 是唯一的規則來源，其他工具的設定檔只「匯入」或「連結」它。
2. **流程只寫一份**：每個步驟寫成 `.agents/skills/<名稱>/SKILL.md`，採用 [Agent Skills 開放標準](https://agentskills.io)，只使用 `name` 與 `description` 兩個必要欄位，避免工具專屬的擴充欄位。
3. **文件就是交接**：每個步驟的結論都寫進 `docs/`。換工具、換模型、換 session，都只需要讀文件，不依賴對話紀錄。
4. **工具專屬功能只當「加分」**：例如 Claude Code 的 subagent。沒有這些功能的工具也要能完成整個流程。

## 各工具對應方式
| 工具 | 讀取規則 | 讀取 skills | 呼叫 skill 的方式 |
|---|---|---|---|
| Claude Code | `CLAUDE.md`（第一行 `@AGENTS.md` 匯入） | `.claude/skills/`（連結到 `.agents/skills/`） | `/spec`、`/plan` …… |
| OpenAI Codex | `AGENTS.md` | `.agents/skills/` | `$spec`、`$plan` …… |
| Gemini CLI | `GEMINI.md`（連結到 `AGENTS.md`） | 依版本支援情況而定 | 依工具說明 |
| Cursor / GitHub Copilot 等 | `AGENTS.md` | 依版本支援情況而定 | 依工具說明 |

> 各工具更新很快，以上對應請以各工具最新的官方文件為準。
> 若某個工具不支援 skills，也可以直接說：「請依照 `.agents/skills/spec/SKILL.md` 的步驟，為 <功能> 寫 spec。」效果相同。

執行 `bash scripts/setup-ai-tools.sh` 會自動建立上表中的連結。

## 混用工具的建議
- **交叉審查**：用 A 工具實作，用 B 工具執行 review skill。不同模型的盲點不同，比較容易抓到問題。
- **依任務挑選工具**：例如需要大量討論的 brainstorm、architecture 用你覺得推理最好的工具；大量、機械性的實作交給速度快或成本低的工具。
- **一次只讓一個工具改同一個分支**：避免互相覆蓋。可以用 git worktree 讓不同工具在不同分支並行工作。
- **記錄是誰做的**：在 commit 訊息加上 `Co-authored-by` 或註明使用的工具，日後回顧時能比較各工具的表現。
