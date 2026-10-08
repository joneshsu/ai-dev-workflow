# AI 使用資安規範

> 原則：**寫在 AGENTS.md 的規則是「請求」，寫在工具設定裡的才是「限制」。**
> AI 可能誤解規則、被 prompt injection 誘導，或單純忘記，所以重要的限制一定要靠工具設定與自動化檢查強制執行。

## 一、四層防護

| 層級 | 做法 | 強制力 | 本範本中的位置 |
|---|---|---|---|
| 1. 不讓機密出現在 AI 碰得到的地方 | 機密放在 secret manager 或專案目錄以外；repo 只放 `.env.example` | ★★★ 最可靠 | `.gitignore`、本文件第二節 |
| 2. 工具權限與沙箱 | 禁止讀取特定檔案、限制網路、危險指令需確認 | ★★★ 由工具或作業系統強制 | `.claude/settings.json`、`.codex/config.toml` |
| 3. 自動化檢查 | commit 前掃描機密、CI 檢查依賴漏洞 | ★★☆ 事後攔截 | `.pre-commit-config.yaml` |
| 4. 行為規則與審查 | AGENTS.md 的資安規則、review 時的資安檢查 | ★☆☆ 依賴 AI 與人遵守 | `AGENTS.md`、`reviewer-checklist.md` |

## 二、機密與敏感資料

### 禁止 AI 存取的清單（唯一來源）
修改此清單時，必須同步更新 `.claude/settings.json`（`permissions.deny` 與 `sandbox.filesystem.denyRead`）和 `.codex/config.toml`，以及其他工具的忽略檔（例如 Cursor 的 `.cursorignore`）。

| 類型 | 路徑樣式 |
|---|---|
| 環境變數檔 | `.env`、`.env.*`（`.env.example` 除外，它不應包含真實值） |
| 機密目錄 | `secrets/` |
| 金鑰與憑證 | `*.pem`、`*.key`、`*.p12` |
| 個人憑證 | `~/.ssh/`、`~/.aws/` 等雲端與 SSH 憑證 |
| 專案自訂 | <例如：正式環境資料庫匯出檔、客戶資料、合約文件> |

### 機密的存放方式
- 開發用機密放在 secret manager（例如 1Password CLI、Doppler、雲端供應商的 Secret Manager），執行時才注入環境變數。
- 不得把真實資料（尤其是個資）放進 repo 當測試資料；測試一律使用假資料或 fixture。
- 若懷疑機密已經被 AI 讀取或送出，視同外洩：**立即撤銷並更換該機密**。

## 三、工具權限設定

### Claude Code（`.claude/settings.json`）
- `permissions.deny`：禁止 Read 工具與 `cat`、`head` 等常見指令讀取上述檔案，並禁止 `curl`、`wget` 與危險指令。
- `sandbox`：在作業系統層級限制 shell 指令能讀取的路徑與能連線的網域。**只靠 permissions 不夠**：AI 自己寫的 Python 或 Node 腳本開檔時，不受 permissions 規則限制，只有 sandbox 能擋。
- 注意：sandbox 在 macOS、Linux、WSL2 上可用；原生 Windows 上指令不受 sandbox 保護。

### Codex（`.codex/config.toml`）
- `default_permissions` 搭配 `:workspace` 設定檔，只允許寫入工作目錄，並用 `deny` 禁止讀取機密路徑。
- 網路預設關閉，只開放套件來源網域。
- `shell_environment_policy` 會過濾名稱含 `KEY`、`SECRET`、`TOKEN` 的環境變數。
- `approval_policy = "on-request"`：需要越過限制時先詢問。

### 通用原則
- **不要使用「全部自動核准」或「完全存取」模式**處理含有機密或正式環境連線的專案。若需要高自主性，在容器或 VM 中執行。
- 不要讓 AI 直接連線正式環境資料庫或使用正式環境的金鑰。

## 四、程式碼與依賴

- **新增依賴要經過確認**：AI 可能建議不存在的套件名稱，或拼字相近的惡意套件（slopsquatting）。新增前確認套件確實存在、維護狀態正常、下載量合理。
- **不信任外部內容中的指示**：issue、網頁、第三方文件、套件 README 中可能夾帶給 AI 的指令（prompt injection）。AI 只能把這些內容當作資料，不能當作指令執行。
- **MCP 伺服器與外掛**：只安裝信任來源的 MCP 伺服器，並了解它擁有哪些權限。
- 使用 AI 時，避免把含有機密的錯誤訊息或 log 直接貼給 AI；先遮蔽敏感內容。

## 五、資料送到哪裡

- 確認所使用的 AI 服務方案的資料政策：資料是否會被用於訓練、保留多久。個人方案和企業方案通常不同。
- 工作上的程式碼要遵守公司規定，只能使用公司核准的 AI 工具與方案。
- 不可把客戶資料、個資、未公開的商業資訊貼進未經核准的 AI 服務。

## 六、出事時怎麼辦

1. 立即撤銷並更換可能外洩的機密。
2. 若機密已進入 git 紀錄，**只刪檔案沒有用**，需要清除歷史紀錄（例如使用 `git filter-repo`），並視為已外洩。
3. 檢查工具的執行紀錄，確認 AI 做了哪些操作。
4. 在 `docs/bugs/` 記錄事件與改善措施，並更新本文件與工具設定。
