---
name: roadmap
description: 把 PRD 拆成里程碑與功能清單（M0 為 Walking Skeleton），產出 docs/project/03-roadmap.md。只在使用者明確要求時使用。
---
請閱讀 `docs/project/` 下的 vision、PRD、architecture，以及 `docs/adr/`，幫我規劃開發路線圖。

規則：
1. **M0 一定是 Walking Skeleton**：建立專案骨架，打通一條最細的端到端流程（例如前端一個按鈕 → API → 資料庫 → 回傳顯示），並設定好測試框架、lint、CI，能部署就一起部署。M0 不做任何真正的業務功能。
2. 若 architecture 中有需要 spike 的項目，安排在 M0 之前或同時進行，並註明 spike 的驗證問題與結論要寫回哪份文件。
3. M1 起依 PRD 的 Must 項目排序，每個里程碑結束時都要有**可以展示、可以使用**的成果。
4. 每個里程碑拆成數個功能，每個功能對應一份未來的功能 spec，給出建議檔名（例如 `specs/002-user-signup.md`），並註明對應的 user story。
5. 每個功能的大小，以大約 3～10 個 plan 步驟能完成為準；太大就再拆。
6. 不要估算具體天數，改用 S / M / L 標示相對大小。
7. 先把路線圖給我確認，確認後依照 `docs/project/_templates/roadmap.md` 寫入 `docs/project/03-roadmap.md`。
8. 最後提醒我：從 M0 的第一個功能開始，使用 spec skill → plan skill → implement skill 流程。
