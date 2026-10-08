---
name: adr
description: 記錄一個架構決策（ADR），寫入 docs/adr/。在使用者要求記錄技術決策時使用。
---
請為以下技術決策撰寫 ADR：

（使用者呼叫此 skill 時附上的決策主題）

步驟：
1. 若背景資訊不足，先問我：遇到什麼問題、考慮過哪些方案、最後選了什麼、為什麼。
2. 依照 `docs/adr/_template.md` 撰寫，檔名為 `docs/adr/NNNN-<kebab-case-標題>.md`（NNNN 為下一個流水號）。
3. 內容保持精簡，重點是「為什麼」，不是實作細節。
4. 若這個決策取代了舊的 ADR，請把舊 ADR 的狀態改為「已被 NNNN 取代」。
