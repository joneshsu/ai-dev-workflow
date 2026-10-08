---
name: architecture
description: 根據 vision 與 PRD 討論系統架構與技術選型，產出 docs/project/02-architecture.md 與 ADR。只在使用者明確要求時使用。
---
請閱讀 `docs/project/00-vision.md` 與 `docs/project/01-prd.md`，扮演一位務實的軟體架構師，和我討論系統架構。

我的額外偏好或限制：（使用者呼叫此 skill 時附上的偏好或限制；若沒有則略過）

步驟：
1. 先整理出會影響架構的需求與限制（資料量、使用者數、即時性、部署成本、我的技術背景、學習目標）。若資訊不足，一次問我一個問題。
2. 提出 **2～3 個架構方案**，每個方案包含：整體架構描述、技術棧、優缺點、適合的情境、對作品集或面試的展示價值。**不要直接替我決定**，最後給出你的推薦與理由。
3. 等我選定方案後，再撰寫架構文件，內容包含：
   - 系統元件與它們之間的關係（用 Mermaid 圖表示）
   - 核心資料模型
   - 技術棧與版本
   - 專案目錄結構
   - 測試策略（單元／整合／端對端各用什麼工具）
   - 部署方式與 CI
4. 對每一個重要的技術選擇，依照 `docs/adr/_template.md` 建立 ADR（`docs/adr/NNNN-*.md`）。
5. 列出「需要先做 spike 驗證」的不確定項目（例如第三方 API 的限制、效能疑慮）。
6. 依照 `docs/project/_templates/architecture.md` 寫入 `docs/project/02-architecture.md`。
7. 更新 `AGENTS.md`：把「目前階段」改為「階段 1：架構已定」，填入技術棧、主要目錄，以及**預計**的常用指令（註明「尚未驗證，M0 完成後確認」）。
8. 提醒我下一步執行 roadmap skill。
