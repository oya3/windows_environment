1. �Ǘ��Ҍ����� Chocolatey �C���X�g�[��

$ @powershell -NoProfile -ExecutionPolicy Bypass -Command "iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))" && SET PATH=%PATH%;%ALLUSERSPROFILE%\chocolatey\bin

2. �w�肵���p�b�P�[�W���C���X�g�[��

$ cinst packages.config
 or
$ choco install packages.config
