---
name: release-note
description: 從 git commit 紀錄產生 release note，寫入 docs/releases/ 並更新 CHANGELOG.md。只在使用者明確要求產生 release note 時使用。
---
請為使用者指定的版本號（例如 v1.2.0）產生 release note。若未指定，先詢問版本號。

步驟：
1. 找出上一個 tag：`git describe --tags --abbrev=0`（若沒有 tag，就從第一個 commit 開始）。
2. 取得範圍內的 commit：`git log <上一個 tag>..HEAD --pretty=format:"%h %s"`。
3. 依 Conventional Commits 類型分組：
   - `feat` → ✨ 新功能
   - `fix` → 🐛 錯誤修正
   - `perf` / `refactor` → ♻️ 改善
   - 含 `BREAKING CHANGE` 或 `!` → ⚠️ 破壞性變更（放在最前面）
   - `test` / `chore` / `docs` → 不列入使用者版本，只列在「內部變更」
4. 把技術性的 commit 訊息改寫成**使用者看得懂的描述**，並連結相關的 spec 或 ADR。
5. 寫入 `docs/releases/<版本號>.md`（依照 `docs/releases/_template.md`），並把摘要加到 `CHANGELOG.md` 最上方。
6. 不要建立 tag，完成後告訴我可以執行的 tag 指令。
