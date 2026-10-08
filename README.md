# AI 開發流程範本（跨工具版）

把 AI 協作開發流程寫成**與工具無關**的規則和 skills。Claude Code、OpenAI Codex、Cursor、Copilot、Gemini CLI 等工具都可以共用同一套流程，也方便你在不同工具之間切換或混用。

- **階段一：專案規劃（從 0 開始時）**：brainstorm → prd → architecture → roadmap
- **階段二：功能開發（每個功能重複）**：spec → plan → implement → review → adr → release-note
- **Bug 處理（隨時）**：bugfix → review

既有專案：先執行一次 **onboard**，再直接進入階段二。

## 安裝
1. 把整個資料夾的內容複製到專案根目錄。
2. 執行 `bash scripts/setup-ai-tools.sh`，替 Claude Code 與 Gemini CLI 建立連結。
3. `AGENTS.md` **不需要一開始就填完**，它會隨專案階段逐步補上（見 `AGENTS.md` 的「目前階段」表格）：
   - **新專案**：保持原樣，直接從 brainstorm skill 開始。用途、技術棧、指令會由各個 skill 在對應階段提出更新。
   - **既有專案（還沒用過 AI 工具也可以）**：執行 onboard skill。AI 會先唯讀探索程式碼、實際驗證指令、回報現況與衝突，經你確認後再填寫 `AGENTS.md`，並進入階段 3。

```
AGENTS.md                     # ★ 唯一的規則來源，所有工具共用
CLAUDE.md                     # 只有一行 @AGENTS.md，加上 Claude 專屬補充
CHANGELOG.md
.agents/skills/               # ★ 唯一的流程來源（Agent Skills 開放標準）
  onboard/                                          # 既有專案導入
  brainstorm/ prd/ architecture/ roadmap/           # 階段一
  spec/ plan/ implement/ review/ adr/ release-note/ # 階段二
  bugfix/                                           # Bug 處理
.claude/
  agents/code-reviewer.md     # Claude Code 專屬：review 用的 subagent（選用）
  settings.json               # Claude Code 專屬：禁止讀取清單、沙箱、網路限制
scripts/setup-ai-tools.sh     # 建立各工具需要的連結
.codex/config.toml            # Codex 專屬：沙箱、禁止讀取清單、網路限制
.pre-commit-config.yaml       # commit 前掃描機密（gitleaks）
.gitignore
docs/
  ai-tools.md                 # 各工具的對應方式與混用建議
  ai-security.md              # ★ AI 使用資安規範與禁止存取清單
  project/_templates/         # vision、prd、architecture、roadmap 範本
  specs/ plans/ adr/ releases/
```

## 怎麼呼叫
| 步驟 | Claude Code | Codex | 其他工具 |
|---|---|---|---|
| 釐清想法 | `/brainstorm 求職進度追蹤工具` | `$brainstorm 求職進度追蹤工具` | 「請依照 `.agents/skills/brainstorm/SKILL.md` 進行」 |
| 寫功能 spec | `/spec 使用者可以重設密碼` | `$spec 使用者可以重設密碼` | 同上 |
| 實作 | `/implement docs/plans/001-x.md 第 1 步` | `$implement docs/plans/001-x.md 第 1 步` | 同上 |

詳細對應方式請見 [docs/ai-tools.md](docs/ai-tools.md)。

## 階段一：專案規劃
| 步驟 | Skill | 產出 | AI 扮演的角色 | 你要做的事 |
|---|---|---|---|---|
| 1 | brainstorm | `docs/project/00-vision.md` | 產品顧問，一次問一個問題 | 誠實回答；不確定就說不確定 |
| 2 | prd | `docs/project/01-prd.md` | 主張「少即是多」的 PM | 決定 MVP 要砍掉什麼 |
| 3 | architecture | `docs/project/02-architecture.md`、ADR | 務實的架構師，提出 2～3 個方案 | 選定方案，並理解取捨 |
| 4 | roadmap | `docs/project/03-roadmap.md` | 技術主管 | 確認里程碑；M0 一定是 Walking Skeleton |

## 階段二：功能開發
| 步驟 | Skill | 產出 | 你要做的事 |
|---|---|---|---|
| 1 | spec | `docs/specs/NNN-*.md` | 回答釐清問題，確認驗收標準 |
| 2 | plan | `docs/plans/NNN-*.md` | **仔細審查計畫** |
| 3 | implement | 程式碼、測試、每步一個 commit | 每步看 diff 與測試結果 |
| 4 | review | 審查報告 | **建議用另一個 AI 工具執行**，再決定要修正哪些 |
| 5 | adr | `docs/adr/NNNN-*.md` | 補充背景與理由 |
| 6 | release-note | `docs/releases/`、CHANGELOG | 確認後自己打 tag |

## Bug 處理
| 情況 | 做法 |
|---|---|
| 開發中、尚未合併的功能出錯 | 直接在 implement 的當前步驟修正 |
| 已合併／已發布的功能出錯 | **bugfix**：重現 → 失敗的回歸測試 → 根本原因 → 最小修正 → 記錄在 `docs/bugs/` |
| 修正需要改設計或其實是需求問題 | bugfix 先調查，再改走 spec → plan |
| 線上緊急問題 | 先修、後補紀錄，但回歸測試不能省 |

修完後建議用**另一個 AI 工具**執行 review，確認修正沒有引入新的問題。

## 資安
規則分成四層，詳見 [docs/ai-security.md](docs/ai-security.md)：
1. 機密不放在 AI 碰得到的地方（最可靠）
2. 工具權限與沙箱強制限制（`.claude/settings.json`、`.codex/config.toml`）
3. commit 前自動掃描機密（`pre-commit install`）
4. `AGENTS.md` 的資安規則與 review 檢查（只是輔助，不能單獨依賴）

禁止存取的清單以 `docs/ai-security.md` 為準，修改時要同步更新各工具的設定檔。

## 小技巧
- 每個步驟開一個新的 session。結論都在文件裡，新的 session 只需要讀文件；換成另一個工具接手也一樣。
- 發現 AI 重複犯同一個錯時，把規則補進 `AGENTS.md`，所有工具都會一起受益。
- 方向改變時，先更新 `docs/project/` 的文件，再改程式碼。
- 文件份量要跟專案規模相稱。個人 side project，每份文件一兩頁就夠了。

## 拿來當作品集
repo 本身就能展示：從問題出發的產品思考、有紀錄的技術決策、清楚的驗收標準、乾淨的 commit 紀錄，以及**不綁定特定 AI 工具的工程方法**。

## 參考資料
- [Agent Skills 開放標準](https://agentskills.io)
- [AGENTS.md](https://agents.md)
- [Harper Reed – My LLM codegen workflow atm](https://harper.blog/2025/02/16/my-llm-codegen-workflow-atm/)
- [Addy Osmani – How to write a good spec for AI agents](https://addyosmani.com/blog/good-spec/)
- [Martin Fowler – Understanding Spec-Driven Development](https://www.martinfowler.com/articles/exploring-gen-ai/sdd-3-tools.html)
