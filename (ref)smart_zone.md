# Smart Zone 專案初期治理憲法與技能庫藍圖

本文件專為 `hayashimatsu/how_to_work_with_ai-agent` 儲存庫設計，旨在建立一套**「專案最初期（Day 0 ~ Phase 1）強制遵守的 AI Agent 治理與執行標準」**。

當任何新的 AI Agent（無論是規劃者、實作者或審查者）被指派進入新專案時，必須先透過本體系的憲法與 Skills，確立**「如何審視專案」、「如何拆解任務」以及「如何維持在 Smart Zone（< 100K tokens）內高品質交付」**的統一標準。

---

## 一、 儲存庫標準目錄結構（建議直接建置於 GitHub Repo 中）

請在你的 GitHub 專案（以及未來任何新開的專案模板）中建立以下結構。此結構同時相容於 Claude Code、Cursor、Windsurf 與自建的 Agent Orchestrator：

```text
how_to_work_with_ai-agent/
├── AGENTS.md                           # 【最高憲法】新 Agent 進入專案必讀的全局標準（Push 機制）
├── CLAUDE.md -> AGENTS.md              # 符號連結，確保不同工具皆自動載入同一份憲法
├── .agents/
│   └── skills/                         # 【按需拉取技能庫】（Pull 機制，實作時按需載入）
│       ├── 01-project-bootstrap-grill/
│       │   └── SKILL.md                # 專案初期需求與邊界無情拷問技能
│       ├── 02-architecture-first-prd/
│       │   └── SKILL.md                # 終點狀態與深層模組定義書生成技能
│       ├── 03-vertical-slice-kanban/
│       │   └── SKILL.md                # 曳光彈垂直切片與 DAG 看板拆解技能
│       ├── 04-strict-tdd-loop/
│       │   └── SKILL.md                # 紅綠重構強制測試驅動開發技能
│       └── 05-fresh-context-review/
│           └── SKILL.md                # 零上下文污染的獨立程式碼與架構審查技能
├── prompts/
│   └── lifecycle_orchestration.md      # 【全景藍圖引導詞】人類／調度器在各階段喚醒 Agent 的標準 Prompt
├── issues/                             # 【暫存任務看板】存放執行中的垂直切片 Ticket（完成即銷毀，防 Doc Rot）
│   └── .gitkeep
└── scripts/
    ├── ralph-once.sh                   # 單次 Smart Zone 閉環驗證腳本（HITL）
    └── ralph-afk.sh                    # 全自動夜班看板執行腳本（AFK）
```

---

## 二、 專案治理憲法：`AGENTS.md`（新 Agent 進場第一道防線）

> **檔案用途**：此檔案為 **Push（強制推送）** 層級，必須保持極度精簡（控制在 1,500 tokens 以內），確保新 Agent 進場時不會消耗 Smart Zone 額度，同時立刻建立行為準則。

```markdown
# AGENTS.md — 專案初期治理與執行憲法 (Smart Zone Protocol)

歡迎加入本專案。在執行任何讀取、規劃或寫碼動作前，你必須嚴格遵守以下最高指導原則：

## 1. 核心物理限制：Smart Zone 紀律
- **100K Token 紅線**：你的推理與注意力品質在超過 100K tokens（或視窗 40%）後會呈平方級退化（Dumb Zone）。
- **單一任務單一生命週期**：你每次被喚醒只負責完成「一個」明確定義的原子任務。嚴禁在單一 Session 中連續開發多個不相關的功能。
- **探索隔離原則**：當你需要理解未知的程式碼庫或外部文件時，必須派發唯讀的「探索子代理（Explore Sub-Agent）」執行大量讀取，僅將精煉後的結構摘要回傳至主對話框。

## 2. 專案初期審視標準（Project Bootstrap Standards）
在專案從 0 到 1 的初期階段，你必須用以下四個標準審視所有任務：
1. **拒絕盲目 Specs-to-Code**：規格書只是終點線索，程式碼的模組形狀才是戰場。規劃時必須明確指出要建立或修改的「深層模組（Deep Modules）」。
2. **深層模組優先（Deep Modules > Shallow Modules）**：嚴禁將業務邏輯拆散成數十個零碎、互相依賴的小檔案。將高內聚邏輯封裝進「公開介面極簡、內部實作完整」的深層模組中，以便從外部建立單一測試邊界。
3. **垂直切片（Tracer Bullets > Horizontal Layers）**：嚴禁按技術層級開發（例如先寫完所有底層資料結構再寫上層邏輯）。任何初期任務必須是貫穿「輸入 -> 核心處理 -> 輸出驗證」的最小端到端垂直切片。
4. **無回饋不寫碼（Feedback Loops First）**：在撰寫任何業務邏輯前，必須先確認自動化測試指令與靜態型別檢查可正常運作。

## 3. 技能調用與知識獲取規則（Pull vs. Push）
- **執行階段（Pull）**：根據你當前被指派的任務階段，主動讀取 `.agents/skills/` 目錄下對應的 `SKILL.md` 並嚴格遵循其步驟。
- **審查階段（Push）**：若你被指派為 Reviewer，你必須強制載入所有相關的 `SKILL.md` 作為驗收標準，逐條檢核產出物。
- **防文件腐敗（Anti-Doc-Rot）**：`issues/` 目錄下的 PRD 與 Ticket 皆為「用完即丟的暫存資產」。一旦任務通過測試與人工 QA 並合併，必須立即刪除或關閉對應的暫存規格檔，程式碼與測試案例才是唯一的真理來源。
```

---

## 三、 專案初期特化技能庫（`.agents/skills/` 完整定義檔）

以下五個 `SKILL.md` 檔案可直接存入儲存庫中，供新加入的 Agent 在專案初期階段調用。

### 技能 1：專案初期需求與邊界拷問（`.agents/skills/01-project-bootstrap-grill/SKILL.md`）

```markdown
---
name: project-bootstrap-grill
description: 在專案初期或新功能啟動時，透過無情、逐一的結構化提問，協助人類與 Agent 在寫碼前達成「共享設計概念（Shared Design Concept）」。
---

# Skill: Project Bootstrap Grill (專案初期無情拷問)

## 觸發時機
當使用者提出一個初步的專案構想、Client Brief、會議紀錄或模糊需求，且尚未確立系統邊界與實作細節時。

## 執行標準與步驟
1. **低耗能環境探勘**：
   - 若專案已有初始檔案，派發唯讀 Sub-Agent 掃描目錄結構、技術棧與現有介面，切勿在主對話框傾倒大量檔案內容。
2. **建立設計決策樹（Design Tree）**：
   - 在腦中將專案初期必須決定的維度拆解為樹狀分支，優先順序為：
     1. 核心輸入與輸出契約（Data/API/Hardware/UI Contracts）
     2. 邊界條件與失敗模式（Edge Cases & Failure Modes）
     3. 狀態持久化與資料流向
     4. 測試與驗證邊界（如何證明它會動？）
     5. 明確排除範圍（Out of Scope，初期絕對不做的事）
3. **單點爆破式提問（嚴格遵守）**：
   - **每次回覆只能問 1 個問題**，絕不一次丟出問題清單。
   - **每個問題必須附上你的「推薦答案（Recommended Answer）」**及簡短理由，降低人類決策成本。
   - 沿著設計樹的依賴關係逐層推進，直到所有影響初期架構的模糊地帶皆被消除。
4. **停止條件**：
   - 當所有設計分支皆已收斂且雙方達成共識時，明確宣告：「設計概念已對齊，隨時可進入 `/architecture-first-prd` 階段。」在獲得人類確認前，**嚴禁擅自生成完整規格書或開始寫程式**。
```

### 技能 2：架構優先的終點狀態規格書（`.agents/skills/02-architecture-first-prd/SKILL.md`）

```markdown
---
name: architecture-first-prd
description: 將對齊後的設計概念轉化為「終點狀態文件（Destination Document）」，重點鎖定深層模組邊界與測試策略，防止盲目的 Specs-to-Code。
---

# Skill: Architecture-First PRD (架構優先終點規格書)

## 觸發時機
完成 `project-bootstrap-grill` 拷問階段，準備將共識固化為可執行的架構藍圖時。

## 執行標準與輸出模板
請在 `issues/PRD-[專案或功能代號].md` 生成規格書，**必須**包含以下六個區塊，缺一不可：

1. **Problem Statement（問題陳述）**：用 2-3 句話精準定義要解決的核心痛點。
2. **Solution Overview（解決方案總覽）**：系統運作的端到端核心機制。
3. **User / System Stories（行為驗收故事）**：以「當 [條件] 發生時，系統應產生 [可觀測結果]」的格式列出核心行為。
4. **Deep Module Architecture（深層模組與介面設計 — 最關鍵區塊）**：
   - 明確列出本次要「新建」或「修改」的**深層模組（Deep Modules）**。
   - 定義每個模組的**極簡公開介面（Input/Output Signature）**與內部封裝職責。
   - 嚴禁設計碎片化的淺層模組（Shallow Modules）。
5. **Testing & Verification Strategy（測試與回饋迴圈策略）**：
   - 定義每個深層模組的外部測試邊界（Test Boundary）。
   - 說明使用何種「本地可替換依賴（Local Substitutables，如 In-Memory DB、Mock Sensor Stream）」進行無外部依賴的快速自動化測試。
6. **Out of Scope（初期排除範圍）**：
   - 明確記錄在拷問階段決定「不做」的功能與原因，防止後續 Agent 過度設計。
```

### 技能 3：曳光彈垂直切片與 DAG 看板拆解（`.agents/skills/03-vertical-slice-kanban/SKILL.md`）

```markdown
---
name: vertical-slice-kanban
description: 將 PRD 拆解為互不阻塞、可獨立抓取且貫穿全系統層級的「曳光彈垂直切片（Tracer Bullets）」任務看板。
---

# Skill: Vertical Slice Kanban (垂直切片任務拆解)

## 觸發時機
`PRD` 建立完成後，準備將任務派發給單一或多個並行 Agent 執行前。

## 核心拆分鐵律
1. **嚴禁水平切片（No Horizontal Slicing）**：
   - 絕對不允許出現「Issue 1: 建立所有資料庫 Schema」、「Issue 2: 撰寫所有後端邏輯」、「Issue 3: 串接前端/模擬器」這類拆分。
2. **Issue #1 必須是曳光彈（Tracer Bullet）**：
   - 第一個任務必須是一條最細的垂直切片，直接貫穿「最簡輸入 -> 核心深層模組 -> 最簡可視化/日誌輸出」，確保第一個任務完成時就能進行端到端整體驗證。
3. **Smart Zone 容量評估**：
   - 每個 Issue 的實作規模必須確保 Agent 能在 **60K tokens 以內**完成探索、TDD 寫碼與測試驗證。若過大，必須再垂直切分。
4. **依賴關係圖（DAG）與執行模式標註**：
   - 將每個切片輸出為獨立的本地檔案 `issues/ISSUE-00X-[slug].md`，並在檔頭標註 YAML Metadata：
     ```yaml
     id: ISSUE-001
     title: [動詞開頭的垂直切片名稱]
     type: AFK # 或 HITL (需人類介入的原型/視覺調整)
     blocked_by: [] # 填入前置依賴的 ISSUE ID，無依賴則為空陣列，供多 Agent 並行抓取
     target_modules: [module_a, module_b]
     ```
   - 每個 Issue 內文必須包含明確的 **Definition of Done (DoD)** 與可執行的驗收測試指令。
```

### 技能 4：嚴格紅綠重構測試驅動開發（`.agents/skills/04-strict-tdd-loop/SKILL.md`）

```markdown
---
name: strict-tdd-loop
description: 強制執行 Red-Green-Refactor 循環，防止 AI 針對既有程式碼寫出作弊測試，確保高品質自動化回饋迴圈。
---

# Skill: Strict TDD Loop (嚴格測試驅動開發)

## 觸發時機
Agent 接手任何 `type: AFK` 的實作 Issue 並開始動手寫碼時。

## 強制執行流程
1. **閱讀目標切片與介面契約**：
   - 僅讀取該 Issue 指定的 `target_modules` 與對應的 PRD 介面定義，避免讀取無關檔案浪費 Context。
2. **階段一：RED（先寫失敗測試）**：
   - 針對 Issue 的第一個驗收行為，在深層模組的**外部測試邊界**撰寫測試案例。
   - **執行測試指令，並確認測試失敗（Confirm Red）**（失敗原因必須是功能尚未實作，而非語法錯誤）。
   - 在看到失敗日誌前，嚴禁建立或修改業務邏輯檔案。
3. **階段二：GREEN（最小化實作通過測試）**：
   - 撰寫剛好能讓該測試通過的最簡潔業務邏輯程式碼。
   - 再次執行測試指令，確認測試通過（Confirm Green）。
4. **階段三：REFACTOR（重構與型別把關）**：
   - 檢查程式碼是否符合深層模組原則（是否不小心拆出過多零碎小檔案？）。
   - 執行專案的靜態型別檢查（Typecheck）與 Linter，修復所有警告與錯誤。
5. **完成交付**：
   - 重複 2~4 步驟直到該 Issue 的所有 DoD 皆通過測試，執行單一原子化的 `git commit`，並更新該 Issue 狀態為 `READY_FOR_REVIEW`。
```

### 技能 5：零上下文污染的獨立審查（`.agents/skills/05-fresh-context-review/SKILL.md`）

```markdown
---
name: fresh-context-review
description: 在全新的隔離 Context 中，以高階推理標準對實作產出的 Git Diff 進行架構與品質審查。
---

# Skill: Fresh Context Review (隔離上下文審查)

## 觸發時機
Implementer Agent 完成單一 Issue 並產生 Commit 後，由調度器清空 Context 開啟全新 Session 執行。

## 審查標準清單（Audit Checklist）
你必須強制載入 `AGENTS.md` 與相關 Skills，並針對本次 `git diff` 進行以下五項嚴格審查：
1. **架構形狀審查（Deep Module Check）**：實作是否破壞了深層模組邊界？是否引入了不必要的跨模組耦合或零碎的淺層檔案？
2. **測試真實性審查（Anti-Cheat Test Check）**：檢視新增的測試檔案，確認其測試的是模組的外部行為契約，而非透過過度 Mock 內部函式來「作弊通過測試」。
3. **垂直切片完整性**：本次變更是否真正打通了端到端資料流，還是只寫了一半的水平層級？
4. **安全與邊界條件**：是否處理了空值、異常輸入與資源釋放？
5. **輸出決策**：
   - 若完全通過：輸出 `<review>APPROVED</review>`。
   - 若有任何違規：以條列式指出具體檔案與行號，並輸出 `<review>CHANGES_REQUESTED</review>`，退回給新的 Implementer Session 修正。
```

---

## 四、 專案全生命週期階段引導 Prompts（對應全景藍圖）

在你的專案重塑藍圖中，人類（日班）與自動化腳本（夜班）需要透過精準的 Prompt 來引導 Agent 切換角色並維持在 Smart Zone。以下為各階段的標準引導 Prompt：

### 階段 0：新 Agent 進場初始化（Onboarding Prompt）
> **使用時機**：當你在專案初期新增任何一個 Agent 實例，或要求 Agent 接手審查現有專案狀態時使用。

```text
請先讀取專案根目錄的 `AGENTS.md` 作為你在本專案的最高行為準則，並掃描 `.agents/skills/` 目錄下所有技能的 YAML 描述（僅讀取檔頭描述，勿一次載入全文以節省 Context）。

接著，請派發一個唯讀的「探索子代理（Explore Sub-Agent）」檢視目前的專案目錄結構與 `issues/` 看板狀態。
完成後，請向我簡短回報（不超過 150 字）：
1. 你所理解的本專案核心架構治理標準（Smart Zone、深層模組、垂直切片）。
2. 目前專案所處的生命週期階段，以及你建議下一步應該調用哪一個 Skill。
```

### 階段 1：日班啟動 — 專案初期構想與無情拷問（HITL）
> **使用時機**：專案剛起步，你只有一個初步想法、草圖或需求筆記，需要與 Agent 對齊「共享設計概念」。

```text
我們現在正處於專案的最初期階段（Day 0 Bootstrap）。以下是我的初步專案構想與目標：
[在此貼上你的專案構想 / 需求描述 / 會議紀錄]

請立即載入並嚴格執行 `.agents/skills/01-project-bootstrap-grill/SKILL.md`。
記住：
1. 每次只能問我「一個」問題，並附上你的推薦答案。
2. 優先拷問系統的輸入/輸出邊界、核心深層模組劃分、驗證方式以及初期不該做的事（Out of Scope）。
3. 在我們走完所有設計決策樹之前，不要產出規格書或寫任何程式碼。現在請開始你的第一個問題。
```

### 階段 2：日班固化 — 生成架構優先的 PRD（HITL）
> **使用時機**：`/grill-me` 拷問結束，雙方對專案架構與邊界已達成共識。

```text
我們已經完成了所有設計分支的對齊。現在請執行 `/clear`（或忽略前面冗長的試探過程，保持上下文精煉），並載入 `.agents/skills/02-architecture-first-prd/SKILL.md`。

請根據我們剛才達成的所有共識，在 `issues/` 目錄下建立本專案的第一份終點狀態規格書（PRD）。
特別注意：在「Deep Module Architecture」區塊中，請幫我把核心業務邏輯收斂為最少數量的深層模組，並明確寫出每個模組的公開介面與外部測試邊界。
```

### 階段 3：日班拆解 — 生成曳光彈垂直切片看板（HITL）
> **使用時機**：PRD 生成完畢，準備將大目標拆解為可在 Smart Zone 內獨立執行的任務看板。

```text
請讀取剛生成的 `issues/PRD-*.md`，並載入 `.agents/skills/03-vertical-slice-kanban/SKILL.md`。

請將這份 PRD 拆解為一系列可獨立抓取的本地 Issue 檔案（存放於 `issues/` 目錄）。
請在生成檔案前，先向我展示你的「任務拆解草案與依賴關係圖（DAG）」，讓我確認：
1. `ISSUE-001` 是否為一條真正貫穿全系統層級的「曳光彈垂直切片（Tracer Bullet）」？
2. 每個切片的預估複雜度是否都能讓單一 Agent 在 60K tokens 以內完成？
3. 哪些任務沒有前置依賴（`blocked_by: []`），適合後續開多條 Git Worktree 並行開發？
```

### 階段 4：夜班執行 — 單兵 Smart Zone 自動化迴圈（AFK Implementer Prompt）
> **使用時機**：放入 `scripts/ralph-once.sh` 或 `scripts/ralph-afk.sh` 中，讓無頭模式（Headless）Agent 在全新 Session 中自動執行。

```text
你是一個在全新 Smart Zone Context 中啟動的自主開發代理（Autonomous Implementer）。
請嚴格遵守 `AGENTS.md` 的規範，並按以下步驟執行單一任務：

1. **狀態感知**：檢視目前提供的 `issues/*.md` 看板內容與最近 5 筆 `git log`。
2. **任務選取**：
   - 若所有 `type: AFK` 且未被阻塞的任務皆已完成，請直接輸出 `<promise>NO MORE TASKS</promise>` 並結束。
   - 否則，從 `type: AFK` 且 `blocked_by` 皆已解決的任務中，依照「1. 緊急修復 -> 2. 曳光彈垂直切片 -> 3. 功能擴充」的優先級，**僅挑選一個** Issue 作為本次 Session 的唯一目標。
3. **嚴格 TDD 實作**：
   - 載入 `.agents/skills/04-strict-tdd-loop/SKILL.md` 並嚴格執行 Red-Green-Refactor 循環。
   - 在確認測試失敗（Confirm Red）前嚴禁寫入業務邏輯。
4. **收尾與交付**：
   - 確保所有自動化測試與靜態型別檢查 100% 通過。
   - 建立一個乾淨的 Git Commit，並在該 Issue 檔案中標記狀態為 `READY_FOR_REVIEW`。
   - 完成這一個 Issue 後立即停止，絕不在此 Session 中開啟第二個任務。
```

### 階段 5：夜班把關 — 零上下文污染獨立審查（Fresh-Context Reviewer Prompt）
> **使用時機**：由自動化腳本在 Implementer Commit 後，開啟一個**全新的 Session** 呼叫高階模型執行。

```text
你是一個獨立的架構與程式碼審查代理（Fresh-Context Reviewer）。你的上下文完全乾淨，未受實作過程的偏見影響。

請強制載入以下所有標準文件（Push 機制）：
- `AGENTS.md`
- `.agents/skills/04-strict-tdd-loop/SKILL.md`
- `.agents/skills/05-fresh-context-review/SKILL.md`

請檢視最近一筆 Git Commit 的變更內容（`git show HEAD`）以及對應的 Issue 規格，嚴格按照 `05-fresh-context-review` 的五項標準進行審計，並給出 `<review>APPROVED</review>` 或 `<review>CHANGES_REQUESTED</review>` 的最終裁決。
```

### 階段 6：日班驗收與防腐敗清理（Human QA & Cleanup Prompt）
> **使用時機**：當垂直切片通過自動化審查後，你親自進行手動 QA 並準備清理暫存文件。

```text
我已經親自完成了對本輪垂直切片的人工 QA 驗收，系統行為符合預期。
為了防止專案發生「文件腐敗（Doc Rot）」並污染未來 Agent 的注意力，請執行以下收尾動作：

1. 刪除 `issues/` 目錄下所有已通過驗收的暫存 `ISSUE-*.md` 檔案（若該 PRD 下所有切片皆已完成，一併刪除對應的 `PRD-*.md`）。
2. 檢查 `AGENTS.md` 是否需要根據本輪開發發現的新架構邊界進行微調（保持其精簡度在 1,500 tokens 以內）。
3. 提交一筆 `chore: clean up completed ephemeral specs` 的 Commit，讓知識庫回歸「以程式碼與測試為唯一真理來源」的乾淨狀態。
```