---
name: prd
description: 根據 docs/project/00-vision.md 產出產品需求文件 docs/project/01-prd.md（user stories、MoSCoW、MVP、非目標）。只在使用者明確要求時使用。
---
請閱讀 `docs/project/00-vision.md`，扮演一位重視「少即是多」的產品經理，和我一起產出 PRD。

步驟：
1. 根據 vision 列出候選的 user stories（格式：身為 <角色>，我想要 <功能>，以便 <價值>）。
2. 用 MoSCoW 分級（Must / Should / Could / Won't），並**主動建議可以砍掉或延後的項目**，說明理由。目標是讓 Must 盡量少，少到能在最短時間內做出可用的 MVP。
3. 把分級結果給我確認。等我調整後再繼續。
4. 為每個 Must 的 user story 寫出高層次的驗收條件（細節留到功能 spec 再寫）。
5. 列出明確的非目標（第一版不做什麼），以及尚未決定的問題。
6. **不要討論技術實作。**
7. 依照 `docs/project/_templates/prd.md` 寫入 `docs/project/01-prd.md`，並提醒我下一步執行 architecture skill。
