1. 管理者権限で Chocolatey インストール

$ @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

2. 指定したパッケージをインストール

$ cinst packages.config
 or
$ choco install packages.config
