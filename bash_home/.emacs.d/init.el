;; -*- coding: utf-8 -*-

;; ~/.emacs.d/init.el

;; command list
;; C-/ : アンドゥ
;; C-\ : リドゥ
;; C-x C-b : バッファーリスト表示[f2]

;; [f4] : 関数一覧表示
;; C-x C-l : 関数一覧表示

;; C-x C-b : バッファー一覧表示
;; [f2] : バッファー一覧表示
;; [f5] : カレントフォルダ一覧
;; [f6] : カレントディレクトリ選択

;; C-x k : バッファー削除
;; C-x 0 : カーソルのあるウィンドウを閉じる　
;; C-x 1 : 他のウィンドウを全て閉じる 　　　　
;; C-x 2 : ウインドウを上下に分割 　　　　　　
;; C-x 3 : ウインドウを左右に分割 　　　　　　
;; C-x o : ウィンドウ間のカーソル移動 　　　　
;; C-x k : ウィンドウ削除 　　　　　　　　　　

;; 水平
;; C-a : 行頭
;; M-b : １単語戻る
;; C-b : １文字戻る
;; C-f : １文字進む
;; M-f : １単語進む
;; C-e : 行末

;; 垂直
;; M-< : ファイル先頭
;; C-x, [ : １ページ戻る
;; C-v : １スクリーン戻る
;; M-[ : １段落戻る
;; C-p : １行戻る
;; C-n : １行進む
;; M-] : 一段落進む
;; M-v : １スクリーン進む
;; C-x, ] : １ページ進む
;; M-> : ファイル末尾

;; C-@ : 選択開始
;; C-SPACE : 選択開始
;; C-RET : 矩形選択開始 + (M-n : 連番付加)
;; C-w : マークから現在位置までの範囲を削除する
;; M-w : マークから現在位置までの範囲をキルリング（貼り付け用のバッファ）にコピー
;; C-y : キルリングの最新の内容を貼り付ける

;; C-d : カーソルの文字を削除（デリート）
;; M-d : カーソルの単語を削除（削除した単語はキルリングに蓄積）
;; C-k : カーソルから行末までを削除（削除したものはキルリングに蓄積）

;; C-x, C-u : マークから現在位置までの範囲の文字を大文字にする
;; M-u : 単語を大文字にする
;; C-x, C-l : マークから現在位置までの範囲の文字を小文字にする
;; M-l : 単語を小文字にする

;; C-x r : 置換（正規表現)
;; C-x g : グレップ（正規表現）

;; C-c ; : リージョン範囲をコメントアウト
;; C-;   : １行コメント
;; --- magit ---
;; M-x magit-status : git status を実施
;;     --- status中コマンド ---
;;     s   : stage
;;     u   : unstage
;;     c c : commit (C-x # : コミットログ記載完了時に実行するコマンド)
;; --- helm ---
;; * do リアルタイムで検索結果が表示される
;; * do の場合、日本語検索がうまく動作しない。日本語検索の場合は、ag を利用する。
;; M-i :いつでもどこでもカレントバッファーをhelm検索
;; M-x helm-(do-)ag : カレントディレクトリ配下のグレップ検索
;;     helm-(do-)ag-project-root : .svn, .git, .hg プロジェクト配下のグレップ検索
;;     helm-resume : 直前の検索結果を呼び出す
;;     helm-ls-git-ls : .git 管理下のファイル一覧
;;     - 検索結果表示中 -
;;     改行 : 該当ファイルにジャンプ
;;     C-z  : 該当ファイルを表示
;; 参考サイト
;; * 来年も使いたいelispランキング2013
;;   http://qiita.com/l3msh0/items/97909d6e2c92af3acc00#1-9

;;;---------------------------------
;;; ntemacs 取得元
;;;---------------------------------
;; 公式 32bit版
;;  http://ftp.gnu.org/pub/gnu/emacs/windows/
;; 非公式 IMEパッチ適用済み32bit版
;;  http://cha.la.coocan.jp/files/emacs-24.5-shared-libgcc-nodebug.zip
;; 非公式 IMEパッチ適用済み64bit版
;;  https://github.com/chuntaro/NTEmacs64

;;;---------------------------------
;;; 基本設定
;;;---------------------------------
;; ※ 半角円マーク(￥)はバックスラッシュ(\)に置き換えてあるので注意。
;; ※ emacsを初回起動したら M-x package-refresh-contents を実施する。
;; ※ helm 導入につき、コマンド入力中の tab 補完は機能しない。
;; ①環境変数 HOME を設定          - windows 環境変数 HOME=c:/bash_home と
;;                                   (setenv "PATH" (format "C:/tools/emacs/bin;C:/tools/PortableGit/bin;%s" (getenv "PATH")))
;; ②プロキシー設定(必要があれば)  - (setq url-proxy-services '(("http" . "172.17.10.213:8080")))
;; ③magit の git path 設定        - (setq magit-git-executable "C:/tools/PortableGit/bin/git.exe"))
;; ④magit コマンドが実施できるよう各cloneディレクトリで git config を実施すること。
;;   ※現状、config 設定しても commit は実施できない。原因は不明。config 設定しなくても log, stage, unstage は実施できる。（大家はconfig設定はしていない）
;;   本来は、git と emacs の home ディレクトリが同一なので、--global で指定した内容が反映されるため config 設定は不要。だが、
;;   windows 環境で portablgit + ntemacs の場合、home ディレクトリが違うため以下の操作が必要
;;   ※以下の操作が面倒なら、portablgit/home の .gitconfig ファイルの内容を C:\tools\PortableGit\etc\gitconfig に反映してもいいかも
;;   参考：【GitHub】Please tell me who you are.
;;         http://qiita.com/kkkaaakkku/items/c487e10c74b0cddf1d10
;;   git config --local user.name "Kazunori OYA"
;;   git config --local user.email "terje@oya3.net"
;;   git config --local core.autocrlf false
;;   git config --local push.default simple
;;   # ssh でアクセスする代替方法
;;   git config --local url."https://".insteadOf git://
;;   # SSL certificate problem: unable to get local issuer certificate
;;   # と文句言われた場合の方法
;;   git config --local http.sslVerify false
;; ⑤git-gutter+ の git path 設定  - (setq git-gutter+-git-executable "C:/tools/PortableGit/bin/git.exe")
;; 
;; flymake&flycheck を使う場合
;; (1) scss-mode(sass-mode) で利用 - $ gem install sass を実施
;; (2) coffee-mode で利用          - $ npm install -g coffeelint を実施
;; (3) javascript-mode で利用      - $ npm install -g jshint を実施
;; ;; emacs-version predicates
;;(setq emacs24.3-p (string-match "^24\.3" emacs-version)
;;      emacs24.4-p (string-match "^24\.4" emacs-version))
;; 型はtype-ofで調べられる。
;;(type-of window-system)
;;(eq (type-of window-system) 'symbol)
;;(symbolp window-system)

;; server start for emacs-client
(require 'server)
(setq server-auth-dir "~/.emacs.d/server")  ;;Server file location
(setq server-name "main_server")   ;;Server mutex file name
(unless (server-running-p)
  (server-start))

;; proxy
(setq url-proxy-services '(("http" . "172.17.10.213:8080")))

;; 環境別ファイル読み込み(windows=w32.ini,mac=mac.ini)
(load (locate-user-emacs-file (concat "init_" (prin1-to-string window-system) ".el") ) )

;; 環境変数 HOME = c:/bash_home を登録すること。
;;(setenv "PATH" (format "C:/tools/emacs/bin;C:/Ruby/216/bin;%s" (getenv "PATH")))
;; git command が利用できるよう portablgit/bin も PATH に追加した。2015/10/13 
(setenv "PATH" (format "C:/tools/emacs/bin;C:/tools/PortableGit/bin;C:/bash_home/.emacs.d/bin;%s" (getenv "PATH")))
;; 実行パスにもPATHを反映させておく必要がある。
;; 参考 : http://emacs-jp.github.io/tips/environment-variable.html
(setq exec-path (parse-colon-path (getenv "PATH")))

(add-to-list 'load-path "~/.emacs.d/site-lisp")

;; melpa 設定
;; 24.3 以降は package.el は内包されている。24.3 未満は自分でインストールが必要
(require 'package)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/") t)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/") t)
(package-initialize)


;; 複数ウィンドウを開かないようにする
(setq ns-pop-up-frames nil)

;; (setq default-input-method "MW32-IME")
;; ;; default-input-method の設定を有効にする
;; (mw32-ime-initialize)

;; 日本語設定
;; (set-keyboard-coding-system 'japanese-shift-jis)
;; (setq default-input-method "W32-IME")
;; (w32-ime-initialize)

;; 起動メッセージを表示しない
(setq inhibit-startup-message t)

;; *scratch* buffer のメッセージを消す。
(setq initial-scratch-message t)

;; ツールバーを非表示
(tool-bar-mode 0)

;; キャレットが '(' や ')' の直後にある場合に対応する括弧を強調
(show-paren-mode t)
(setq show-paren-delay 0)
;; (setq show-paren-style 'single)

;;(require 'color-theme)
;;(color-theme-gnome2)

(if window-system (progn
                    ;; font 設定
                    ;; (set-face-font 'default "ＭＳ Ｐ明朝-12")
                    (set-face-font 'default "ＭＳ ゴシック-11")
                    ;; 画面Color(背景)
                    (set-background-color "#1f1f1f")
                    (set-foreground-color "LightGray")
                    (set-cursor-color "Gray")
                    ;; ウィンドウを透明化
                    (add-to-list 'default-frame-alist '(alpha . 95))
                    ))

;; バックスラッシュを円記号から斜線に置き換える
;; http://qiita.com/acple@github/items/85fc9e52d15e0de8bb87
(setq-default buffer-display-table (or (default-value 'buffer-display-table)
                                       standard-display-table
                                       (make-display-table)))
(aset buffer-display-table ?\\ [?\x2572])


;; タイトルバーに編集中のファイルのパス名を表示
(setq frame-title-format (format "emacs@%s : %%f" (system-name)))

;; buffer 選択中に同名ファイルに番号をつける。
(require 'uniquify)
(setq uniquify-buffer-name-style 'post-forward-angle-brackets)

;; 時計表示
(display-time-mode t)

;; 左ペインに行番号表示
(require 'linum)
(setq linum-format "%4d")
(global-linum-mode)
;;(line-number-mode t) ; 行数表示
(column-number-mode t) ; カラム数表示
;; 処理速度改善処理らしい。。。
(setq linum-delay t)
(defadvice linum-schedule (around my-linum-schedule () activate)
  (run-with-idle-timer 0.2 nil #'linum-update-current))

;; ウィンドウ幅で折り返さない設定
;;通常のウィンドウ用の設定
(setq-default truncate-lines t)
;;ウィンドウを左右に分割したとき用の設定
(setq-default truncate-partial-width-windows t)

;; ディレクトリ表示
;; direx-el
;; (use popwin-el devloper ver.)
;; https://github.com/m2ym/direx-el
;; (require 'direx)

(require 'direx)
(setq direx:leaf-icon "  "
      direx:open-icon "- "
      direx:closed-icon "+ ")
;; (setq direx:leaf-icon "  "
;;       direx:open-icon "\&#9662; "
;;       direx:closed-icon "&#9654; ")
(global-set-key [f5] 'direx:jump-to-directory-other-window)
(global-set-key [f6] 'direx-project:jump-to-project-root-other-window)
(global-set-key [f7] 'direx:find-directory)

;; スクロールバー
;;(scroll-bar-mode -1) ; 標準OFF
;; (require 'yascroll)
;; (global-yascroll-bar-mode 1)

;; 矩形選択
(cua-mode t)
(setq cua-enable-cua-keys nil) ;; 変なキーバインド禁止

;; マウスの右クリックの割り当て(押しながらの操作)をはずす
(if window-system (progn
                    (global-unset-key [down-mouse-3])
                    ;; マウスの右クリックメニューを使えるようにする
                    (defun bingalls-edit-menu (event)  (interactive "e")
                      (popup-menu menu-bar-edit-menu))
                    (global-set-key [mouse-3] 'bingalls-edit-menu)))

;; tabbar有効化
(tabbar-mode 1)
;; タブ上でマウスホイール操作無効
(tabbar-mwheel-mode -1)
;; 画像を使わないことで軽量化する
(setq tabbar-use-images nil)
;; バッファ切り替え
;; (global-set-key [\M-up] 'tabbar-forward-tab)
;; (global-set-key [\M-down] 'tabbar-backward-tab)
(global-set-key [\M-right] 'tabbar-forward-tab)
(global-set-key [\M-left] 'tabbar-backward-tab)

;; 全バッファを一つのグループにしまう
;;(setq tabbar-buffer-groups-function (lambda () (list "Buffers")))
(setq tabbar-buffer-groups-function nil)


;; tabbar上でウィールマウスボタンで削除
(defun my-tabbar-buffer-help-on-tab (tab)
  "Return the help string shown when mouse is onto TAB."
  (if tabbar--buffer-show-groups
      (let* ((tabset (tabbar-tab-tabset tab))
             (tab (tabbar-selected-tab tabset)))
        (format "mouse-1: switch to buffer %S in group [%s]"
                (buffer-name (tabbar-tab-value tab)) tabset))
    (format "\
mouse-1: switch to buffer %S\n\
mouse-2: kill this buffer\n\
mouse-3: delete other windows"
            (buffer-name (tabbar-tab-value tab)))))

(defun my-tabbar-buffer-select-tab (event tab)
  "On mouse EVENT, select TAB."
  (let ((mouse-button (event-basic-type event))
        (buffer (tabbar-tab-value tab)))
    (cond
     ((eq mouse-button 'mouse-2)
      (with-current-buffer buffer
        (kill-buffer)))
     ((eq mouse-button 'mouse-3)
      (delete-other-windows))
     (t
      (switch-to-buffer buffer)))
    ;; Don't show groups.
    (tabbar-buffer-show-groups nil)))

(setq tabbar-help-on-tab-function 'my-tabbar-buffer-help-on-tab)
(setq tabbar-select-tab-function 'my-tabbar-buffer-select-tab)

;; 現在行を目立たせる(半透明）
(defface hlline-face
  '((((class color)
      (background dark))
     ;; (:background "dark slate gray"))
     (:background "#181828"))
    (((class color)
      (background light))
     ;; (:background "ForestGreen"))
     (:background "#080810"))
    (t
     ()))
  "*Face used by hl-line.")
;; 現在行を目立たせる2（アンダー）
(defface hlline-face2
  '((((class color)
      (background dark))
     ;;(:background "dark state gray"))
     (:background "gray10"
                  :underline "#d0d0d0"))
    (((class color)
      (background light))
     (:background "ForestGreen"
                  :underline nil))
    (t ()))
  "*Face used by hl-line.")
(defface hlline-face3
  '((((class color)
      (background dark))
     (:background "gray20"))
;;                  :underline "#404040"))
    (((class color)
      (background light))
     (:background "ForestGreen"))
    (t
     ()))
  "*Face used by hl-line.")

;;(setq hl-line-face 'hlline-face) ;
(setq hl-line-face 'hlline-face3) ;
;; (setq hl-line-face 'underline) ; 下線
(global-hl-line-mode)

;; 行間
(setq-default line-spacing 0)

;; 空白関係
;; 空白関係
(require 'whitespace)
(setq whitespace-style '(
                        face           ; faceで可視化
;                         trailing       ; 行末
                         tabs           ; タブ
                         tab-mark       ;
                         spaces         ; スペース
                         space-mark     ; 表示のマッピング
;                         empty
                         newline        ; 改行
                         newline-mark
                         ))

(setq whitespace-display-mappings
      '((space-mark ?\u3000 [?\u25a1])
        ;; WARNING: the mapping below has a problem.
        ;; When a TAB occupies exactly one column, it will display the
        ;; character ?\xBB at that column followed by a TAB which goes to
        ;; the next TAB column.
        ;; If this is a problem for you, please, comment the line below.
;;        (space-mark ?\u0020 [?\xB7])  ; 半角スペース
        (newline-mark ?\n   [?\u21B5 ?\n]) ; 改行記号
        (tab-mark ?\t [?\u00BB ?\t] [?\\ ?\t]) ; タブマーク
        )
      )

;; スペース（全角／半角）はを可視化
(setq whitespace-space-regexp "\\([\x0020|\u3000]+\\)")

(set-face-foreground 'whitespace-tab "#808000") ; "#4e9b4d")
(set-face-background 'whitespace-tab 'nil)
(set-face-underline  'whitespace-tab t)
(set-face-foreground 'whitespace-space "#808000") ; "#4e9b4d")
(set-face-background 'whitespace-space 'nil)
(set-face-bold-p 'whitespace-space t)
(set-face-foreground 'whitespace-newline  "#808000") ; "DimGray")
(set-face-background 'whitespace-newline 'nil)
(setq whitespace-action '(auto-cleanup)) ; 保存前に自動でクリーンアップ
(global-whitespace-mode 1)

;; タブキー
(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)

;; バックスペース
(global-set-key "\C-h" 'delete-backward-char)

;; ;; バッファーリスト表示
;; (global-set-key (kbd "C-x C-b") 'ibuffer)
;;     (autoload 'ibuffer "ibuffer" "List buffers." t)
(global-set-key [f2] 'ibuffer)

;; ホイールスクロール設定　１秒３行かな。。。
(setq mouse-wheel-scroll-amount '(3 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse

;; スクロール設定
;;(require 'smooth-scroll)
;;(smooth-scroll-mode t)
;; (setq scroll-conservatively 10000)
(setq scroll-margin 1
      scroll-conservatively 0
      ;; scroll-up-aggressively 0.01
      ;; scroll-down-aggressively 0.01
      scroll-step 1
      auto-window-vscroll nil)

;; 逆改ページ
(global-set-key "\C-z" 'scroll-down)
;; (global-set-key "\M-p" 'scroll-down)
;; (global-set-key "\M-n" 'scroll-up)

;; ;; 変更されたら自動で読み込む
;; for Windows.
;; (global-auto-revert-mode 1)
;; ;; and display "half modal" warning about it
;; (require 'w32-msgbox)
;; (defun inform-revert-modified-file (&optional p1 p2)
;;   "bdimych custom function"
;;   (let ((revert-buffer-function nil))
;;     (revert-buffer p1 p2)
;;     ;; (w32-msgbox (buffer-file-name) "Emacs: Modified file automatically reverted" 'vb-ok-only 'vb-information nil t)
;;     (w32-msgbox (buffer-file-name) "Emacs: どっかで編集されたんで読み込みお直したよ" 'vb-ok-only 'vb-information nil t)
;;     )
;;   )
;; (setq revert-buffer-function 'inform-revert-modified-file)
(defun shk-deferred-auto-revert (&optional ignore-auto noconfirm)
    (interactive)
    (if (called-interactively-p)
        (progn
          (setq header-line-format nil)
          (let ((revert-buffer-function nil))
            (revert-buffer ignore-auto t)))
      (setq header-line-format
            (format "%s. Press C-c R to reload it"
                    (propertize "This file has changed on disk"
                                'face '(:foreground "#f00"))))))
(setq revert-buffer-function 'shk-deferred-auto-revert)
(global-set-key [(control c)(R)] 'shk-deferred-auto-revert)

(global-auto-revert-mode t)

;; マウス マークセット
(setq mouse-drag-copy-region t)

;; 検索(全般)時には大文字小文字の区別する
(setq case-fold-search nil)
;; インクリメンタルサーチ時には大文字小文字の区別する
(setq isearch-case-fold-search nil)
;; 検索時（先頭⇔末尾）ラップしない
(setq isearch-wrap-function (lambda () (error "no more matches")))
;; Tabで検索文字列を補完
(define-key isearch-mode-map (kbd "TAB") 'isearch-yank-word)
;; 日本語の検索文字列をミニバッファに表示
(define-key isearch-mode-map (kbd "<compend>")
  '(lambda() (interactive) (isearch-update)))
(define-key isearch-mode-map (kbd "<kanji>")
  'isearch-toggle-input-method)
(add-hook
 'isearch-mode-hook
 '(lambda() (setq w32-ime-composition-window (minibuffer-window)))
 )
(add-hook
 'isearch-mode-end-hook
 '(lambda() (setq w32-ime-composition-window nil))
 )

;; replace
(define-key global-map (kbd "C-x r") 'query-replace-regexp)

;; grep
;; --include は複数指定可能。 複数の拡張子を指定したければ、 --include="*.cpp" --include="*.h" のようにできるはず。
(define-key global-map (kbd "C-x g") 'grep)
(require 'grep)
(setq grep-command-before-query "grep -nH -r --include=\"*.*\" -P ")
(defun grep-default-command ()
  (if current-prefix-arg
      (let ((grep-command-before-target
             (concat grep-command-before-query
                     (shell-quote-argument (grep-tag-default)))))
        (cons (if buffer-file-name
                  (concat grep-command-before-target
                          " *."
                          (file-name-extension buffer-file-name))
                (concat grep-command-before-target " ."))
              (+ (length grep-command-before-target) 1)))
    (car grep-command)))
(setq grep-command (cons (concat grep-command-before-query " .")
                         (+ (length grep-command-before-query) 1)))

;; undo & redo
(require 'redo+)
(global-set-key (kbd "C-\\") 'redo)
(setq undo-no-redo t) ; 過去のundoがredoされないようにする
(setq undo-limit 600000)
(setq undo-strong-limit 900000)

;; undo-tree
;; (require 'undo-tree)
;; (global-undo-tree-mode)

;; ;; session save
;; (global-set-key [f11] 'load-file)
;; (global-set-key [f12] 'desktop-save)

;; 関数一覧
;; 対応言語は "C++","C","Pascal","Java","Emacs-Lisp","Lisp Interaction","Perl","CPerl","TeX","Text","HTML","Ruby"
(load-library "navi")
(global-set-key [f4] 'call-navi)
(global-set-key "\C-x\C-l" 'call-navi)
(defun call-navi ();; (defvar navi-listing-window-shrink-size nil)

  (interactive)
  (navi (buffer-name))
  )
(setq navi-listing-window-height nil)
;; (defvar navi-listing-window-shrink-size nil)
;; (defvar navi-source-window-scroll-size  nil)


;; ctags
;; $ ctags -R -e *

;; GNU global タグジャンプ
(autoload 'gtags-mode "gtags" "" t)
;; (require 'gtags)
(setq gtags-mode-hook
      '(lambda ()
         (local-set-key "\M-t" 'gtags-find-tag) ;関数の定義元へ
         (local-set-key "\M-r" 'gtags-find-rtag) ;関数の参照先へ
         (local-set-key "\M-s" 'gtags-find-symbol) ;変数の定義元/参照先へ
         (local-set-key "\C-t" 'gtags-pop-stack) ;前のバッファに戻る
         ;; (define-key gtags-select-mode-map "p" 'previous-line)
         ;; (define-key gtags-select-mode-map "n" 'next-line)
         (define-key gtags-select-mode-map "\C-t" 'gtags-pop-stack)
         (define-key gtags-select-mode-map "\C-m" 'gtags-select-tag)
         )
      )

;; 自動補完有効化
(require 'auto-complete)
(global-auto-complete-mode t)
(require 'auto-complete-config)
;;(add-to-list 'ac-dictionary-directories "~/.emacs.d/site-lisp/ac-dict")
(ac-config-default)
(setq ac-use-menu-map t)
(ac-set-trigger-key "TAB")
(setq ac-delay 1.0) ; auto-completeまでの時間
(setq ac-auto-show-menu 2.0) ; メニューが表示されるまで

;;------------------------------------------------------------------------------
;; (require 'magit)
;; ;;参考 http://d.hatena.ne.jp/yuto_sasaki/20120310/1331386970
;; ;;参考 http://gom.hatenablog.com/entry/20090524/1243170341
;; ;;参考 http://qiita.com/takc923/items/c7a11ff30caedc4c5ba7
(setq magit-git-executable "C:/tools/PortableGit/bin/git.exe")

;;------------------------------------------------------------------------------
;; anything やめて helm に変更
;; (require 'anything)
;; (require 'anything-match-plugin)
;;
;; helm 便利かも。りあえず使用して様子見る(2015/10/06)
;; 参考 :
;;     https://www.naney.org/diki/d/2014-12-03-Emacs-helm.html
;;     http://d.hatena.ne.jp/a_bicky/20140104/1388822688
;; 
;; (require 'helm)
;; helm-config を require しなと動作しないらしい。
(when (require 'helm-config nil t)
  (helm-mode 1)

  (add-to-list 'helm-completing-read-handlers-alist '(find-file . nil))
  (add-to-list 'helm-completing-read-handlers-alist '(write-file . nil))
  (define-key global-map (kbd "M-x")     'helm-M-x)
  ;; (define-key global-map (kbd "C-x C-f") 'helm-find-files)
  ;; (define-key global-map (kbd "C-x C-r") 'helm-recentf)
  (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
  (define-key global-map (kbd "C-c i")   'helm-imenu)
  (define-key global-map (kbd "C-x b")   'helm-buffers-list)
  ;; (global-set-key [f2] 'helm-buffers-list)

  (define-key helm-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
  (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
  (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)

  ;; (setq helm-samewindow nil)
  ;; (setq popwin:special-display-config '(
  ;;                                       ("helm" :regexp t)
  ;;                                       ))
  
  ;; Disable helm in some functions
  (add-to-list 'helm-completing-read-handlers-alist '(find-alternate-file . nil))

  ;; Emulate `kill-line' in helm minibuffer
  (setq helm-delete-minibuffer-contents-from-point t)
  (defadvice helm-delete-minibuffer-contents (before helm-emulate-kill-line activate)
    "Emulate `kill-line' in helm minibuffer"
    (kill-new (buffer-substring (point) (field-end))))

  (defadvice helm-ff-kill-or-find-buffer-fname (around execute-only-if-exist activate)
    "Execute command only if CANDIDATE exists"
    (when (file-exists-p candidate)
      ad-do-it))

  (defadvice helm-ff-transform-fname-for-completion (around my-transform activate)
    "Transform the pattern to reflect my intention"
    (let* ((pattern (ad-get-arg 0))
           (input-pattern (file-name-nondirectory pattern))
           (dirname (file-name-directory pattern)))
      (setq input-pattern (replace-regexp-in-string "\\." "\\\\." input-pattern))
      (setq ad-return-value
            (concat dirname
                    (if (string-match "^\\^" input-pattern)
                        ;; '^' is a pattern for basename
                        ;; and not required because the directory name is prepended
                        (substring input-pattern 1)
                      (concat ".*" input-pattern)))))))

;; --- old start ---
;; (require 'helm-config)
;; (helm-mode 1)
;; ;; カーソル以降の１行削除/
;; (define-key helm-find-files-map (kbd "C-h") 'delete-backward-char)
;; ;; TABで補完（bashの補完の動作と違う... 候補が表示されたら↑↓で選択するらしい。 magit-status を補完検索するなら [git status] のようにすれば最短で検索可能かも？？？）
;; (define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
;; (define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)
;; ;; M-x 時のコマンドの並び順を入力した文字別に変更
;; (define-key global-map (kbd "M-x")     'helm-M-x)
;; ;; C-x f(C-x C-f) 時のコマンドの並び順を入力した文字別に変更
;; (define-key global-map (kbd "C-x C-f") 'helm-find-files)
;; ;; (define-key global-map (kbd "C-x C-r") 'helm-recentf)
;; ;; (define-key global-map (kbd "M-y")     'helm-show-kill-ring)
;; ;; (define-key global-map (kbd "C-c i")   'helm-imenu)
;; (define-key global-map (kbd "C-x b")   'helm-buffers-list)
;; --- old end ---

;; w32-ime-buffer-switch-p を t にして helm を利用する場合に、ミニバッファで漢字を正常に
;; 使えるようにする対策（この設定がないと、ime が勝手に切り替わったりする）
;; ;; (setq w32-ime-buffer-switch-p t)
(advice-add 'helm
            :around (lambda (orig-fun &rest args)
                      (let ((select-window-functions nil))
                        (apply orig-fun args))))


;; helm-swoop は migemo もあわせて利用するのがいいらしいが、日本語入力を手間だと思っていないので migemo は捨てる。
;; 参考 : http://rubikitch.com/2014/12/25/helm-swoop/
;;      : http://fukuyama.co/helm-swoop
;; helm-swoop を require しないと駄目っぽい。
(require 'helm-swoop)
;; キーバインドはお好みで
(global-set-key (kbd "M-i") 'helm-swoop)
(global-set-key (kbd "M-I") 'helm-swoop-back-to-last-point)
(global-set-key (kbd "C-c M-i") 'helm-multi-swoop)
(global-set-key (kbd "C-x M-i") 'helm-multi-swoop-all)
;; isearch実行中にhelm-swoopに移行
(define-key isearch-mode-map (kbd "M-i") 'helm-swoop-from-isearch)
;; helm-swoop実行中にhelm-multi-swoop-allに移行
(define-key helm-swoop-map (kbd "M-i") 'helm-multi-swoop-all-from-helm-swoop)
;; Save buffer when helm-multi-swoop-edit complete
(setq helm-multi-swoop-edit-save t)
;; 値がtの場合はウィンドウ内に分割、nilなら別のウィンドウを使用
(setq helm-swoop-split-with-multiple-windows nil)
;; ウィンドウ分割方向 'split-window-vertically or 'split-window-horizontally
(setq helm-swoop-split-direction 'split-window-vertically)
;; (setq helm-swoop-split-direction 'split-window-horizontally)
;; nilなら一覧のテキストカラーを失う代わりに、起動スピードをほんの少し上げる
(setq helm-swoop-speed-or-color t)

;; grep のかわりに ag 使う
;; (require 'helm-ag)
;; http://blog.kowalczyk.info/software/the-silver-searcher-for-windows.html
;; https://github.com/syohex/emacs-helm-ag

;; (require 'helm-ls-git)

;;------------------------------------------------------------------------------

;; ;; git-gutter-fringe+ から git-gutter+ が使われている。
;; ;; git-gutter-fringe+ を install すると git-gutter+ もインストールされるため、require 'git-gutter-fringe+ をする必要があるっぽい。
;; ;; git-gutter-fringe+ は flymake と表示位置がかぶるがflymakeがflymakeが優先（あと勝）？っぽい。
;; github : https://github.com/nonsequitur/git-gutter-plus
;; 参考   : http://syohex.hatenablog.com/entry/20131002/1380724469
(require 'git-gutter-fringe+)
(global-git-gutter+-mode t)
(setq git-gutter+-git-executable "C:/tools/PortableGit/bin/git.exe")
(eval-after-load 'git-gutter+
  '(progn
     ;;; Jump between hunks(変更箇所へジャンプ)
     (define-key git-gutter+-mode-map (kbd "C-x n") 'git-gutter+-next-hunk)
     (define-key git-gutter+-mode-map (kbd "C-x p") 'git-gutter+-previous-hunk)
     ))

;;------------------------------------------------------------------------------
;; flycheck
(require 'flycheck)
(add-hook 'after-init-hook #'global-flycheck-mode)
(flycheck-add-next-checker 'javascript-jshint
                          'javascript-gjslint)

;; flycheck error をポップアップ表示に変更
;; (require 'flycheck-pos-tip)
(eval-after-load 'flycheck
  '(custom-set-variables
    '(flycheck-display-errors-function #'flycheck-pos-tip-error-messages)))

;;------------------------------------------------------------------------------
;; haml モード
;; (require 'haml-mode)
(add-to-list 'auto-mode-alist '("\\.haml$" . haml-mode))

;;------------------------------------------------------------------------------
;; scss モード
;; (require 'scss-mode)
(add-to-list 'auto-mode-alist '("\\.scss$" . scss-mode))
(autoload 'scss-mode "scss-mode")
(add-hook 'scss-mode-hook 'ac-css-mode-setup)
(add-hook 'scss-mode-hook
          (lambda ()
            ;;(define-key scss-mode-map "\M-{" 'my-css-electric-pair-brace)
            ;;(define-key scss-mode-map ";" 'my-semicolon-ret)
            (setq css-indent-offset 2)
            (setq scss-compile-at-save nil)
            ;;(setq ac-sources '(;;ac-source-yasnippet
            ;;                   ;; ac-source-words-in-same-mode-buffers
            ;;                   ac-source-words-in-all-buffer
            ;;                   ac-source-dictionary
            ;;                   ))
            ;; (flymake-mode t)
            ))
(add-to-list 'ac-modes 'scss-mode)

;;------------------------------------------------------------------------------
;; yaml モード
;; (require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-hook 'yaml-mode-hook
          '(lambda ()
             (define-key yaml-mode-map (kbd "RET") 'newline-and-indent)
             )
          )

;;------------------------------------------------------------------------------
;; C/C++ mode
;; ;; Qt 考慮する
;; (setq c-C++-access-key "\\<\\(slots\\|signals\\|private\\|protected\\|public\\)\\>[ \t]*[(slots\\|signals)]*[ \t]*:")
;; (font-lock-add-keywords 'c-mode '(("\\<\\(Q_OBJECT\\|public slots\\|public signals\\|private slots\\|private signals\\|protected slots\\|protected signals\\)\\>" . font-lock-constant-face)))
(add-hook 'c-mode-hook
          '(lambda()
             (setq c-set-style "cc-mode")
             (c-set-offset 'innamespace 0)
             (setq tab-width 4)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 4)
             (setq c-tab-always-indent t)
             (local-set-key (kbd "RET") 'newline-and-indent)
             (gtags-mode 1)
             ;; (local-set-key "\M-t" 'gtags-find-tag) ;関数の定義元へ
             ;; (local-set-key "\M-r" 'gtags-find-rtag) ;関数の参照先へ
             ;; (local-set-key "\M-s" 'gtags-find-symbol) ;変数の定義元/参照先へ
             ;; (local-set-key "\C-t" 'gtags-pop-stack) ;前のバッファに戻る
             )
          )

;;------------------------------------------------------------------------------
(add-to-list 'auto-mode-alist '("\\.h$" . c++-mode))
(add-hook 'c++-mode-hook
          '(lambda()
             (setq c-set-style "cc-mode")
             (c-set-offset 'innamespace 0)
             (setq tab-width 4)
             (setq indent-tabs-mode t)
             (setq c-basic-offset 4)
             (setq c-tab-always-indent t)
             (local-set-key (kbd "RET") 'newline-and-indent)
             (gtags-mode 1)
             ;; (local-set-key "\M-t" 'gtags-find-tag) ;関数の定義元へ
             ;; (local-set-key "\M-r" 'gtags-find-rtag) ;関数の参照先へ
             ;; (local-set-key "\M-s" 'gtags-find-symbol) ;変数の定義元/参照先へ
             ;; (local-set-key "\C-t" 'gtags-pop-stack) ;前のバッファに戻る
             )
          )

;;------------------------------------------------------------------------------
;; (require 'csharp-mode)
(add-to-list 'auto-mode-alist '("\\.cs$" . csharp-mode))
(add-hook 'csharp-mode-hook
          '(lambda()
             (setq comment-column 40)
             (setq c-basic-offset 4)
             ;;(font-lock-add-magic-number)
             (local-set-key (kbd "RET") 'newline-and-indent)
             ;; ;; オフセットの調整
             ;; (c-set-offset 'substatement-open 0)
             ;; (c-set-offset 'case-label '+)
             ;; (c-set-offset 'arglist-intro '+)
             ;; (c-set-offset 'arglist-close 0)
             )
          )
(add-to-list 'ac-modes 'csharp-mode) ; auto-complete 発動

;;------------------------------------------------------------------------------
;; php mode
;; C-cRETでマニュアルのトップページへジャンプ、
;; C-cC-fでカーソル位置の単語についての説明ページを開いてくれます。
;; 設定参考URL：
;;  http://php-mode.sourceforge.net/html-manual/Completion.html
;;  http://www.ne.jp/asahi/alpha/kazu/php.html
;; マニュアル内包する方法?
;;  php マニュアルダウンロードし~/.emacs.d/php-chunked-xhtmlに展開
;;   http://php.net/get/php_manual_ja.tar.gz/from/a/mirror
;; php-complete-function を実施したないらマニュアルからphp-completion-fileを作成してくらしい。。。
;; $ cd ~/.emacs.d/php-chunked-xhtml
;; $ ls -1 function*.html \
;;   | sed -e 's/^function\.\([-a-zA-Z_0-9]*\)\.html/\1/' \
;;   | tr - _ \
;;  > php-completion-file

;; (require 'php-mode)
(add-hook 'php-mode-hook
          '(lambda ()
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (setq c-basic-offset 4)
             ;; (setq c-tab-always-indent t)
             (local-set-key (kbd "RET") 'newline-and-indent)
             (require 'php-completion)
             (php-completion-mode t)
             (define-key php-mode-map (kbd "C-o") 'phpcmp-complete)
             ;; (setq php-manual-path "~/.emacs.d/php-chunked-xhtml")
             (setq php-manual-url "http://www.phppro.jp/phpmanual")
             ;; (define-key php-mode-map "\C-\M-i" 'php-complete-function)
             (when (require 'auto-complete nil t)
               (make-variable-buffer-local 'ac-sources)
               (add-to-list 'ac-sources 'ac-source-php-completion)
               (auto-complete-mode t))
             )
          )
;;(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'ac-modes 'php-mode) ; auto-complete 発動

;;------------------------------------------------------------------------------
;; ruby mode
(add-hook 'ruby-mode-hook
          '(lambda ()
             (setq tab-width 2)
             (setq ruby-indent-level tab-width)
             (setq ruby-deep-indent-paren-style nil)
             (local-set-key (kbd "RET") 'newline-and-indent)
             (local-set-key "\M-t" 'find-tag) ;関数の定義元へ
             (local-set-key "\C-t" 'pop-tag-mark) ;前のバッファに戻る
             )
          )


(autoload 'ruby-mode "ruby-mode"
  "Mode for editing ruby source files" t)
(add-to-list 'auto-mode-alist '("\\.rb$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile$" . ruby-mode))

(require 'ruby-block)
(ruby-block-mode t)
(setq ruby-block-highlight-toggle t)

;; perl mode やめて cperl-mode
(add-hook 'cperl-mode-hook
          '(lambda ()
             ;; インデント設定
             (setq tab-width 4)
             (setq indent-tabs-mode nil)
             (cperl-set-style "PerlStyle")
             (custom-set-variables
              '(cperl-indent-parens-as-block t)
              '(cperl-close-paren-offset -4)
              '(cperl-indent-subs-specially nil))
             ;; ドキュメントを表示する
             (define-key global-map (kbd "M-p") 'cperl-perldoc)
             (local-set-key (kbd "RET") 'newline-and-indent)
             )
          )

(add-to-list 'auto-mode-alist '("\\.pl\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.wperl\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.pm\\'" . cperl-mode))
(add-to-list 'auto-mode-alist '("\\.cgi\\'" . cperl-mode))

;; ruby-mode のエンコードマップの追加で対応できるっぽい
(add-to-list 'ruby-encoding-map '(japanese-cp932 . cp932))

(add-hook 'js-mode-hook
          '(lambda()
             (setq tab-width 2)
             (setq js-indent-level 2)
             (setq indent-tabs-mode nil)
             (local-set-key (kbd "RET") 'newline-and-indent)
             (gtags-mode 1)
             )
          )

;;------------------------------------------------------------------------------
;; coffee-mode
;; (require 'coffee-mode)
(custom-set-variables '(coffee-tab-width 2))
(add-to-list 'ac-modes 'coffee-mode) ; auto-complete 発動

;; 以下はやめて flycheck に統一。
;; (require 'flymake-easy)
;; (require 'flymake-coffee)
;; (custom-set-variables '(coffee-tab-width 2))
;; (add-to-list 'ac-modes 'coffee-mode) ; auto-complete 発動
;; ;; flymake-coffeeを利用するには nodejs で[$ npm install -g coffeelint]が必要
;; (add-hook 'coffee-mode-hook 'flymake-coffee-load)
;; (setq flymake-coffee-coffeelint-configuration-file
;;       (expand-file-name "~/.emacs.d/.coffeelint-config.json"))

;;------------------------------------------------------------------------------
;; web-mode
;; (add-to-list 'auto-mode-alist '("\\.phtml$"     . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php$" . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.jsp$"       . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.as[cp]x$"   . web-mode))
;; (add-to-list 'auto-mode-alist '("\\.erb$"       . web-mode))
;;(add-to-list 'auto-mode-alist '("\\.html?$"     . web-mode))

(add-hook 'web-mode-hook
          '(lambda()
             (setq web-mode-markup-indent-offset 2)
             (setq web-mode-css-indent-offset 2)
             (setq web-mode-code-indent-offset 2)
             )
          )
(add-to-list 'ac-modes 'web-mode) ; auto-complete 発動

;;------------------------------------------------------------------------------
;; visual-basic-mode
(require 'visual-basic-mode)
(setq auto-mode-alist (append '(("\\.\\(frm\\|bas\\|cls\\|rvb\\)$" .
                                 visual-basic-mode)) auto-mode-alist))

;;------------------------------------------------------------------------------
;; realtime-preview (markdownをリアルタイムでプレビュー表示)
(require 'realtime-preview)


;;------------------------------------------------------------------------------
;; javascript
(setq js-indent-level 2)

;; ediff コマンド
;; n ... 次
;; p ... 前
;; q ... 終了
;; コントロール用のバッファを同一フレーム内に表示
(setq ediff-window-setup-function 'ediff-setup-windows-plain)
;; diffのバッファを上下ではなく左右に並べる
(setq ediff-split-window-function 'split-window-horizontally)

;; ウィンドウ移動
;; shift ↑↓⇔
(setq windmove-wrap-around t)
(windmove-default-keybindings)

;; リージョン コメント＆アンコメント
(global-set-key (kbd "C-c ;") 'comment-or-uncomment-region)
;; １行コメント＆アンコメント
(defun one-line-comment ()
  (interactive)
  (save-excursion
    (beginning-of-line)
    (set-mark (point))
    (end-of-line)
    (comment-or-uncomment-region (region-beginning) (region-end))))
(global-set-key (kbd "C-;") 'one-line-comment)


;; ------------------------------------------------------------------------------
;; Meadow時代のofficeファイルをテキスト化するパッケージ（独自改良版）
(require 'xdoc2txt)


;; ------------------------------------------------------------------------------
;; indent-guide
(indent-guide-global-mode)


;; ------------------------------------------------------------------------------
;; google-translate.el
;; (require 'google-translate)

;; キーバインドの設定（お好みで）
(global-set-key [(C x) (C t)] 'google-translate-at-point)

;; 翻訳のデフォルト値を設定（en -> ja）
(custom-set-variables
  '(google-translate-default-source-language "en")
  '(google-translate-default-target-language "ja"))

;; ------------------------------------------------------------------------------
;; popwin.el 使い方が全くわからん。。。設定してもしなくても同じ挙動になる。
(require 'popwin)
;; (popwin-mode nil)
;; (setq display-buffer-alist 'popwin:display-buffer)
(setq display-buffer-function 'popwin:display-buffer)
(setq popwin:popup-window-position 'bottom)
(push '("*helm" :regexp t :position bottom) popwin:special-display-config)

;; direx
(push '(direx:direx-mode :position left :width 50 :dedicated t) popwin:special-display-config)
;; google-translate.elの翻訳バッファをポップアップで表示させる
(push '("*Google Translate*") popwin:special-display-config)


;; ------------------------------------------------------------------------------
;; フレームサイズを記憶する。
;;
;; (if window-system (progn
;;                     (defun my-window-size-save ()
;;                       (let* ((rlist (frame-parameters (selected-frame)))
;;                              (ilist initial-frame-alist)
;;                              (nCHeight (frame-height))
;;                              (nCWidth (frame-width))
;;                              (tMargin (if (integerp (cdr (assoc 'top rlist)))
;;                                           (cdr (assoc 'top rlist)) 0))
;;                              (lMargin (if (integerp (cdr (assoc 'left rlist)))
;;                                           (cdr (assoc 'left rlist)) 0))
;;                              buf
;;                              (file "~/.emacs.d/.framesize.el"))
;;                         (if (get-file-buffer (expand-file-name file))
;;                             (setq buf (get-file-buffer (expand-file-name file)))
;;                           (setq buf (find-file-noselect file)))
;;                         (set-buffer buf)
;;                         (erase-buffer)
;;                         (insert (concat
;;                                  ;; 初期値をいじるよりも modify-frame-parameters
;;                                  ;; で変えるだけの方がいい?
;;                                  "(delete 'width initial-frame-alist)\n"
;;                                  "(delete 'height initial-frame-alist)\n"
;;                                  "(delete 'top initial-frame-alist)\n"
;;                                  "(delete 'left initial-frame-alist)\n"
;;                                  "(setq initial-frame-alist (append (list\n"
;;                                  "'(width . " (int-to-string nCWidth) ")\n"
;;                                  "'(height . " (int-to-string nCHeight) ")\n"
;;                                  "'(top . " (int-to-string tMargin) ")\n"
;;                                  "'(left . " (int-to-string lMargin) "))\n"
;;                                  "initial-frame-alist))\n"
;;                                  ;;"(setq default-frame-alist initial-frame-alist)"
;;                                  ))
;;                         (save-buffer)
;;                         ))

;;                     (defun my-window-size-load ()
;;                       (let* ((file "~/.emacs.d/.framesize.el"))
;;                         (if (file-exists-p file)
;;                             (load file))))

;;                     (my-window-size-load)

;;                     ;; Call the function above at C-x C-c.
;;                     (defadvice save-buffers-kill-emacs
;;                       (before save-frame-size activate)
;;                       (my-window-size-save))
;;                     ))

;;
;; 参考: http://d.hatena.ne.jp/Tan90909090/20121124/1353757368
;;
(defconst my-save-frame-file
  "~/.emacs.d/.framesize"
  "フレームの位置、大きさを保存するファイルのパス")
(defun my-save-frame-size()
  "現在のフレームの位置、大きさを`my-save-frame-file'に保存します"
  (interactive)
  (let* ((param (frame-parameters (selected-frame)))
         (current-height (frame-height))
         (current-width (frame-width))
         (current-top-margin (if (integerp (cdr (assoc 'top param)))
                                 (cdr (assoc 'top param))
                                 0))
         (current-left-margin (if (integerp (cdr (assoc 'left param)))
                                  (cdr (assoc 'left param))
                                  0))
         (buf nil)
         (file my-save-frame-file)
         )
    ;; ファイルと関連付けられたバッファ作成
    (unless (setq buf (get-file-buffer (expand-file-name file)))
      (setq buf (find-file-noselect (expand-file-name file))))
    (set-buffer buf)
    (erase-buffer)
    ;; ファイル読み込み時に直接評価させる内容を記述
    (insert
     (concat
      "(set-frame-size (selected-frame) "(int-to-string current-width)" "(int-to-string current-height)")\n"
      "(set-frame-position (selected-frame) "(int-to-string current-left-margin)" "(int-to-string current-top-margin)")\n"
      ))
    (save-buffer)))
(defun my-load-frame-size()
  "`my-save-frame-file'に保存されたフレームの位置、大きさを復元します"
  (interactive)
  (let ((file my-save-frame-file))
    (when (file-exists-p file)
        (load-file file))))

(add-hook 'emacs-startup-hook 'my-load-frame-size)
(add-hook 'kill-emacs-hook 'my-save-frame-size)
(run-with-idle-timer 60 t 'my-save-frame-size)















; 起動時に自動で前回の状態になる !!この行はファイル末尾に記載すること!!
(desktop-read)
(add-hook 'kill-emacs-hook 'desktop-save-in-desktop-dir)

