---
name: review
description: 以獨立審查者的角度審查目前分支的變更，對照 spec 與 plan 輸出分級的審查報告，不修改檔案。在使用者要求 review 時使用。
---
請審查目前分支相對於使用者指定基準（未指定則為 `main`）的變更。

如果你的工具支援 subagent（例如 Claude Code 的 `code-reviewer`），請交給 subagent 審查，讓審查者擁有獨立的 context。
如果不支援，請直接依照 `.agents/skills/review/reviewer-checklist.md` 進行審查。
（最佳做法：用「不是寫這段程式碼的那個 AI 工具」來執行 review，例如 Claude Code 實作、Codex 審查，反之亦然。）

審查時需要的資訊（使用 subagent 時，請一併交給它）：
- `git diff` 的範圍
- 對應的 spec 與 plan 檔案路徑（從 `docs/specs/`、`docs/plans/` 中找出相關的）

審查完成後：
1. 依嚴重程度整理成清單給我看。
2. **不要自動修正**，等我決定哪些要處理。
