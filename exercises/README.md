# Git 入門課：學生練習講義

五個練習都使用同一個小專案。Sxx 是投影片／講稿的穩定 ID。練習要使用教材倉庫外的獨立副本，不要在這份教材的 Git 倉庫裡初始化或 commit。

## 課前準備

- 安裝 [Git](https://git-scm.com/downloads)，版本 2.28 以上。Windows 使用 Git Bash；macOS / Linux 使用終端機。
- 準備可保存純文字的編輯器。使用 VS Code 且已安裝 `code` 命令時，可設定如下；已有其他可用編輯器就不必更換：

  git config --global core.editor "code --wait"

- 設定 commit 作者資訊時，把範例改成自己的姓名與電子郵件；這不是 GitHub 登入。也可使用 GitHub 設定頁提供的 noreply 電子郵件。

~~~bash
git --version
git config --global user.name "Alex Chen"
git config --global user.email "alex@example.com"
~~~

- 準備可登入的 GitHub 帳號，確認網路能存取 GitHub。[學生講義](../handout.pdf)第 4 章會帶著完成 PAT 設定與第一次推送；已有可透過 HTTPS 正常 `push` 的認證可繼續使用。
- Python 是選用的檢查工具，不是完成 Git 練習的必要條件。依環境使用 `python`、`python3` 或 `py`。

## 準備獨立的練習目錄（S05）

用檔案管理器把本教材的 `exercises/grade-lab` **整個複製**到個人主目錄，改名為 `git-grade-lab`。目標必須是新目錄，不可覆蓋既有專案。已有同名目錄時，改用新名稱，並相應調整後續本機路徑。

打開 Git Bash / 終端機，進入副本：

~~~bash
cd "$HOME/git-grade-lab"
pwd
~~~

應看到以下兩個起始檔案，沒有 `.git`：

~~~text
git-grade-lab/
  README.md
  grades.py
~~~

起始 `README.md`：

~~~markdown
# Grade calculator

Calculate the average of a list of scores.
~~~

起始 `grades.py`：

~~~python
def average(scores):
    return sum(scores) / len(scores)


print("Average:", average([70, 80, 90]))
~~~

可以向 AI 求助，但課堂上請親手輸入每一條命令。

每次編輯後先在編輯器保存。不要輸入 shell 的 `$` 提示符號。除非另外說明，命令都在目前的練習倉庫中執行。

## 練習 1：分開保存兩次修改（S07–S11）

### 建立第一個版本

~~~bash
git init -b main
git status
git add README.md grades.py
git status
git commit -m "Add grade calculator"
git status
~~~

預期目前位於 `main`，已有第一個 commit，工作目錄乾淨。

### 先預測，再 commit

1. 在 README 末尾加入 `Input: a list of scores.`，保存。
2. 執行 `git add README.md`。
3. 再追加 `Output: the average score.`，保存，**先不要 `add`**。
4. 執行下面三個命令，並預測下一個 commit 會包含哪一行。

~~~bash
git status
git diff
git diff --staged
~~~

先只 commit 輸入說明，再把輸出說明保存成另一個 commit。

完成條件：至少有三個 commit；Input 與 Output 分別 commit；工作目錄乾淨；能說明兩種 `diff` 各自比較的對象。

<details>
<summary>完成預測後，再看參考操作</summary>

`git diff` 顯示未暫存的 Output；`git diff --staged` 顯示已暫存的 Input。同一個檔案可以同時有這兩種變更。

~~~bash
git commit -m "Document calculator input"
git diff
git add README.md
git commit -m "Document calculator output"
git log --oneline
git status
~~~

第一次 `commit` 後，Output 仍在工作目錄，並未包含在那次 commit 中。

</details>

### 小檢查：忽略不需要分享的檔案（S12）

建立 `.gitignore`，內容如下。註解必須獨立成行。

~~~gitignore
# Local credentials
.env
# Generated Python files
__pycache__/
*.pyc
~~~

建立 `.env`，只放假資料 `DEMO_ONLY=example`。確認 `.env` 沒有出現在一般 `status` 中，再保存共用規則：

~~~bash
git status
git add .gitignore
git commit -m "Ignore local and generated files"
git status
~~~

這些規則對未追蹤檔案生效；已追蹤的檔案不會自動停止追蹤。忽略也不會清除歷史中的內容。

## 練習 2：撤銷一次錯誤，保留歷史（S13–S15）

先確定工作目錄乾淨，把 README 的**第一行**改為 `# Broken calculator`，其餘行保留。

~~~bash
git add README.md
git commit -m "Change heading by mistake"
git log --oneline
git show HEAD
~~~

確認 `HEAD` 是剛才的錯誤 commit，再執行：

~~~bash
git revert --no-edit HEAD
git log --oneline
git status
~~~

完成條件：標題恢復為 `# Grade calculator`，輸入／輸出說明仍在，工作目錄乾淨；歷史中同時有錯誤 commit 與抵銷 commit。`revert` 會新增revert commit，不會刪掉舊 commit。

以下兩種常見情境是**選項，不要接著依序執行**：

| 想做的事 | 命令 | 工作內容 |
|---|---|---|
| 取消 README 的暫存 | `git restore --staged README.md` | 保留工作目錄修改 |
| 丟棄 README 未暫存的修改 | `git restore README.md` | 用暫存區版本覆蓋；先確定修改不要了 |

## 練習 3：在 branch 上開發，再合併回 `main`（S16–S19）

以下操作只做一次。已跟著講者完成的人直接驗收，不要重複建立同名 branch。

~~~bash
git status
git switch -c handle-empty
~~~

把 `grades.py` 的函式改為以下版本，保留原本的 `print`：

~~~python
def average(scores):
    if not scores:
        return 0
    return sum(scores) / len(scores)
~~~

今天的專案約定：空清單的平均值回傳 0。

~~~bash
git add grades.py
git commit -m "Handle empty score lists"
git switch main
~~~

先開啟 `grades.py`：`main` 應還沒有空清單判斷。再合併：

~~~bash
git merge handle-empty
git branch
git log --oneline --graph --all
git status
~~~

完成條件：目前在 `main`，檔案已有空清單判斷，工作目錄乾淨。`main` 與 `handle-empty` 此時指向同一 commit，來源 branch 名稱仍存在。

可選驗證；依環境替換 `python` 命令：

~~~bash
python -c "from grades import average; assert average([70,80,90]) == 80; assert average([]) == 0"
~~~

## 練習 4：整合兩邊的標題修改（S20–S23）

開始前位於 `main`，工作目錄乾淨。已跟著示範做完的人直接驗收，不必重跑本節。

~~~bash
git switch -c improve-title
~~~

把 README 第一行改為 `# Team grade calculator`，其他內容保留，再執行：

~~~bash
git add README.md
git commit -m "Describe team calculator"
git switch main
~~~

把 `main` 的 README 第一行改為 `# Class grade calculator`，其他內容保留：

~~~bash
git add README.md
git commit -m "Describe class calculator"
git merge improve-title
~~~

**預期 `merge` 會停下來，並提示 README 有衝突。** 執行 `git status`，打開 README，找到：

~~~text
<<<<<<< HEAD
# Class grade calculator
=======
# Team grade calculator
>>>>>>> improve-title
~~~

將整段替換成 `# Team grade calculator for class`，保留其餘說明。確認沒有留下衝突標記，再執行：

~~~bash
git add README.md
git commit -m "Combine team and class descriptions"
git log --oneline --graph --all
git status
~~~

完成條件：`main` 的標題保留 Team 與 class 的意思；輸入／輸出說明仍在；沒有衝突標記；有merge commit 且工作目錄乾淨。

若想取消**尚未完成**的合併，可以執行 `git merge --abort`。本練習從乾淨工作目錄開始；不要假設它能恢復任何未保存的內容。

## 練習 5：推送、審閱並更新同一個 PR（S24–S29）

### 推送本機倉庫

確認目前在 `main`。到 GitHub 建立自己擁有的空倉庫 `git-grade-lab`，**不新增 README、`.gitignore` 或授權檔**。只使用不含敏感資料的課堂專案；公開倉庫方便同學查看與留言，私有倉庫需事先安排存取權限。

把 `YOUR-USER` 換成自己的 GitHub 帳號；若倉庫另有名稱，也修改網址中的 `git-grade-lab`。

~~~bash
git remote add origin https://github.com/YOUR-USER/git-grade-lab.git
git push -u origin main
~~~

到 GitHub 確認可以看到 README、`grades.py` 與 commit 紀錄，且不應包含 `.env`。

### 建立文件 branch 與 PR

~~~bash
git switch -c docs-usage
~~~

在 README 追加用法，例如：

~~~~markdown
## Usage

Run the calculator with Python:

~~~bash
python grades.py
~~~

Expected output: Average: 80.0
~~~~

若使用 `python3` 或 `py`，請相應修改說明。

~~~bash
git diff
git add README.md
git commit -m "Explain how to run the calculator"
git push -u origin docs-usage
~~~

在 GitHub 新增 PR，base 選 `main`，compare 選 `docs-usage`。描述可使用：

~~~text
目的：讓第一次取得這個專案的同學知道如何執行。
變更：新增執行命令與預期輸出。
檢查：核對命令與檔名；若環境有 Python，實際執行並記錄結果。
~~~

### 雙人審閱與更新

1. 各自提出自己的 PR，交換連結。審閱者檢查用法、檔名與預期結果，提出一個具體建議；不需要對方的 `push` 權限。
2. 作者依意見修改本機 README，並維持在 `docs-usage` branch。
3. 保存後 commit 並推送，**原 PR 會更新**：

~~~bash
git add README.md
git commit -m "Clarify usage after review"
git push
~~~

4. 在原 PR 回應意見，並重新檢查 Files changed。
5. 由有權限的人在 GitHub 合併 PR；本課可選 Create a merge commit。
6. 在本機更新 `main`：

~~~bash
git switch main
git pull --ff-only
git status
~~~

完成條件：PR 有目的、檢查說明與審閱紀錄；已依意見更新同一個 PR；PR 已合併；本機 `main` 有最終用法，工作目錄乾淨。

### 講者演示：`clone` 與遠端更新（S26–S27）

學生先看演示，留在自己的操作位置。以下在新目錄取得既有倉庫，不再執行 `init`：

~~~bash
git clone https://github.com/YOUR-USER/git-grade-lab.git git-grade-copy
cd git-grade-copy
git status
~~~

`origin/main` 是本機記住的遠端狀態。`fetch` 會更新它，不會直接改動工作檔案。如果 `main` 兩邊各有新 commit，先確定工作目錄乾淨，再處理非快轉推送被拒絕的情況：

~~~bash
git fetch origin
git merge --no-edit origin/main
~~~

若有衝突，照練習 4 編輯、`add`、`commit`；無衝突就直接完成整合，再執行 `git push`。認證失敗或沒有寫入權限是另外的問題，不適用這個處理方式。示範後返回原本目錄，不在第二份 `clone` 做學生的 PR 練習。

## 課後想一想（S30）

先自行回答，再核對：

1. `add` 後又改檔案，下次 `commit` 會保存哪一版？
2. `commit` 成功後，GitHub 一定看得到嗎？
3. 將功能 branch 合併進 `main` 前，要切到哪裡？
4. 編輯完有衝突的檔案後，還需要做什麼？
5. 如何更新同一個 PR？

<details>
<summary>參考答案</summary>

1. 暫存區中最後一次 `add` 當時的內容。
2. 不一定，還需 `push` 到遠端。
3. `main`；`merge` 的目標是目前所在 branch。
4. 檢查內容、執行 `git add`，再執行 `git commit` 完成合併。
5. 在 PR 的來源 branch 修改、commit 並 `push`，原 PR 會更新。

</details>

## 需要幫忙時

先說明目前目錄、branch、想做的事與錯誤訊息，並附上 `git status` 與相關 `diff`。可查文件，或問同學、助教、AI；執行建議前先理解它會改動哪個狀態，不要直接貼出憑證或私人內容。

[Pro Git 繁體中文](https://git-scm.com/book/zh-tw/v2) · [git diff](https://git-scm.com/docs/git-diff) · [git restore](https://git-scm.com/docs/git-restore) · [git revert](https://git-scm.com/docs/git-revert) · [gitignore](https://git-scm.com/docs/gitignore) · [git pull](https://git-scm.com/docs/git-pull) · [GitHub Pull Requests](https://docs.github.com/en/pull-requests)
