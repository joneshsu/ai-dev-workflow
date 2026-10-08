# docs/ 目錄說明

| 目錄 | 內容 | 由誰產生 | 什麼時候更新 |
|---|---|---|---|
| `project/` | 專案層級：願景、PRD、架構、路線圖 | brainstorm / prd / architecture / roadmap skills | 專案開始時；方向調整時 |
| `specs/` | 功能需求與驗收標準（要做什麼、為什麼） | spec skill | 開始一個新功能前 |
| `plans/` | 實作計畫與步驟清單（怎麼做） | plan skill | 實作前；實作中勾選進度 |
| `bugs/` | Bug 紀錄（現象、根本原因、修正、預防） | bugfix skill | 修正非微小的 bug 時 |
| `adr/` | 架構決策紀錄（為什麼這樣選） | adr skill | 做出重要技術決策時 |
| `releases/` | 每個版本的 release note | release-note skill | 發布版本時 |

另外，`ai-security.md` 是 AI 使用的資安規範，`ai-tools.md` 說明各 AI 工具的設定方式。

原則：
- `project/` 是專案的方向，`specs/` 是單一功能的細節；功能 spec 不能和專案文件衝突。
- `roadmap` 中的每個功能，對應一份 `specs/` 底下的功能 spec。
- spec 和 plan 用相同編號對應（例如 `specs/003-login.md` ↔ `plans/003-login.md`）。
- ADR 一旦接受就不修改內容，只能被新的 ADR 取代。
- 功能完成後，plan 可以封存；spec 和 ADR 要長期保留，它們也是之後 Claude 理解專案的 context。
- 過時的文件要刪除或標記，避免誤導之後的 session。
