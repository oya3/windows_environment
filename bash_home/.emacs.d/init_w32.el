;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - coding system                                      ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; �f�t�H���g�̕����R�[�h
(set-default-coding-systems 'utf-8-unix)

;; �e�L�X�g�t�@�C���^�V�K�o�b�t�@�̕����R�[�h
(prefer-coding-system 'utf-8-unix)

;; �t�@�C�����̕����R�[�h
(set-file-name-coding-system 'utf-8-unix)

;; �L�[�{�[�h���͂̕����R�[�h
(set-keyboard-coding-system 'utf-8-unix)

;; �T�u�v���Z�X�̃f�t�H���g�����R�[�h
(setq default-process-coding-system '(undecided-dos . utf-8-unix))

;; ���ˑ����� ���������Ή�
(set-charset-priority 'ascii 'japanese-jisx0208 'latin-jisx0201
                      'katakana-jisx0201 'iso-8859-1 'cp1252 'unicode)
(set-coding-system-priority 'utf-8 'euc-jp 'iso-2022-jp 'cp932)

;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ key binding - keyboard                                        ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; Alt�L�[���g�p������Meta�L�[���g�p
(setq w32-alt-is-meta t)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - input method                                       ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; ���[�h���C���̕\��������
(setq-default w32-ime-mode-line-state-indicator "[Aa] ")
(setq w32-ime-mode-line-state-indicator-list '("[Aa]" "[��]" "[Aa]"))

;; IME������
(w32-ime-initialize)

;; �f�t�H���gIME
(setq default-input-method "W32-IME")

;; IME�ύX
;; (global-set-key (kbd "C-\\") 'toggle-input-method)

;; ����/�ϊ��L�[���͎��̃G���[���b�Z�[�W�}�~
(global-set-key (kbd "<M-kanji>") 'ignore)
(global-set-key (kbd "<kanji>") 'ignore)

;; ;; w32-ime-buffer-switch-p �� t �ɂ��� helm �𗘗p����ꍇ�ɁA�~�j�o�b�t�@�Ŋ����𐳏��
;; ;; �g����悤�ɂ���΍�i���̐ݒ肪�Ȃ��ƁAime ������ɐ؂�ւ�����肷��j
;; (setq w32-ime-buffer-switch-p t)


;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;
;;; @ language - fontset                                            ;;;
;;; ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; ;;;

;; �t�H���g�T�C�Y����
(global-set-key (kbd "C-<wheel-up>")   '(lambda() (interactive) (text-scale-increase 1)))
(global-set-key (kbd "C-=")            '(lambda() (interactive) (text-scale-increase 1)))
(global-set-key (kbd "C-<wheel-down>") '(lambda() (interactive) (text-scale-decrease 1)))
(global-set-key (kbd "C--")            '(lambda() (interactive) (text-scale-decrease 1)))

;; �t�H���g�T�C�Y ���Z�b�g
(global-set-key (kbd "M-0") '(lambda() (interactive) (text-scale-set 0)))

