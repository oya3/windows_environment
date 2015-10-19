## 設置方法

1. bash_home を cドライブ直下に配置
>$ mv bash_home c:\bash_home

1. 環境変数を登録
>$ set ALTERNATE_EDITOR=C:\tools\emacs\bin\runemacs.exe
>$ set EMACS_SERVER_FILE=C:\bash_home\.emacs.d\server\main_server
>$ set HOME=C:\bash_home

1. c:\bash_home の .gitconfig を編集
user.name, user.email を自分の名称に変更

1. tools フォルダを cドライブ直下に配置
>$ mkdir c:\tools

1. c:\tools フォルダに emacs 配置(IMEパッチ版

    1. emacs 非公式 IMEパッチ適用済み64bit版    
    https://github.com/chuntaro/NTEmacs64    

    1. portable git    
    https://github.com/msysgit/msysgit/releases/tag/Git-1.9.5-preview20150319   
    ※今現在、管理は git for windows に移管されているが、とりあえず旧バージョンを使用。  
    本来は、https://git-for-windows.github.io/ から取得するべきと思われる。  
    また、git for windows版は、chocolatey ではインストールできない。  
    よって、新旧に対応できるよう今現在は c:\toolsフォルダ に配置するよう設計している。  

1. その他、必要なツールをインストール
tools_settings/packages.config を参考に chocolatey でインストールできるものはインストールするべき。
※emacs は IMEパッチ版がインストールされないので注意。
※portablegitは、git for windows 版はインストールできない
※おすすめは以下の通り
　・ winmerge-jp（プラグインは別途インストールが必要)
　・ conemu
　・ 7zip
　・ qttabbar（設定は別途必要）
　・ google-chrome-x64
    1. chocolatey のインストールは管理者権限で以下を実施すること。  
        >$ @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin
    1. packages.config ファイルを作成後、以下のコマンドでインストールが開始される。  
        >$ cinst packages.config




