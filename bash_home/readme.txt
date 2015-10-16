--- 設置方法 ---

* 以下の環境変数を登録
set ALTERNATE_EDITOR=C:\tools\emacs\bin\runemacs.exe
set EMACS_SERVER_FILE=C:\bash_home\.emacs.d\server\main_server
set HOME=C:\bash_home

* .gitconfig を編集
user.name, user.email を変更する

* runemacs をスタートアップに登録(任意)
bash から emacs コマンドで起動した場合は、サーバとクライアントが自動判別される
しかし gui ではダメっぽいのでサーバ起動が必須となる。

* c:/tools に emacs(24.5), portablegit(1.9.5), ConEmuPack(151006) を配置

--- git動作変更 ---

* commit ログ記載ツールが vim から emacs(clinet) に変更。※runemacsサーバが起動していなければいけない。
* commit ログ入力完了後は、C-c C-c で完了、C-c C-k でキャンセル
