
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)

(if (and (boundp 'window-system) window-system)
    (when (string-match "XEmacs" emacs-version)
      (if (not (and (boundp 'mule-x-win-initted) mule-x-win-initted))
          (require 'sym-lock))
      (require 'font-lock)))


(global-set-key (kbd "C-x <up>") 'windmove-up)
(global-set-key (kbd "C-x <down>") 'windmove-down)
(global-set-key (kbd "C-x <right>") 'windmove-right)
(global-set-key (kbd "C-x <left>") 'windmove-left)
(global-set-key (kbd "C-x n") 'windmove-up)
(global-set-key (kbd "C-x p") 'windmove-down)
(global-set-key (kbd "C-x x") 'windmove-right)
(global-set-key (kbd "C-x j") 'windmove-left)
(global-set-key (kbd "C-,") 'other-window)
(global-set-key (kbd "C-.") 'prev-window)

(global-set-key (kbd "C-x ,") 'windmove-left)
(global-set-key (kbd "C-x .") 'windmove-right)
(global-set-key (kbd "C-[ [ q w") 'beginning-of-defun)
(global-set-key (kbd "C-x .") 'windmove-right)

(defun my-round-nb (start end)
"round the nb of the region."
(interactive "r")
(save-restriction
  (narrow-to-region start end)
  (goto-char 1)
  (let ((case-fold-search nil))
    (while (search-forward-regexp "\\([0-9]+\\.[0-9]+\\)" nil t)
      (replace-match (format "%0.2f" (string-to-number (match-string 1)))
                   )))))

(defun prev-window ()
 (interactive)
 (other-window -1))

;;(global-auto-revert-mode t)
 (setq x-select-enable-clipboard t)
;; If you use tex-mode
(require 'tex-mode)`
(add-hook 'latex-mode-hook 'flyspell-mode)
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))

(dolist (mode '(emacs-lisp-mode-hook
                inferior-lisp-mode-hook
                clojure-mode-hook
                python-mode-hook
                js-mode-hook
                R-mode-hook))
  (add-hook mode
            '(lambda ()
               (flyspell-prog-mode))))
(add-hook 'LaTeX-mode-hook '(flyspell-mode t))

(eval-after-load "flyspell"
  '(progn
     (define-key flyspell-mouse-map [down-mouse-3] #'flyspell-correct-word)
     (define-key flyspell-mouse-map [mouse-3] #'undefined)))
;; (add-hook 'python-mode-hook 'guess-style-guess-tabs-mode)
;; (add-hook 'python-mode-hook (lambda ()
;;                               (guess-style-guess-tab-width)))
;; (add-hook 'python-mode-hook
;;   (lambda () (setq python-indent-offset 4)))

(require 'ido)
(ido-mode t)

(setq cua-enable-cua-keys nil)
;;(setq cua-highlight-region-shift-only t) ;; no transient mark mode
;;(setq cua-toggle-set-mark nil) ;; original set-mark behavior, i.e. no transient-mark-mode
(cua-mode t)

(defun comment-or-uncomment-region-or-line ()
  "Comments or uncomments the region or the current line if there's no active region."
  (interactive)
  (let (beg end)
    (if (region-active-p)
        (setq beg (region-beginning) end (region-end))
      (setq beg (line-beginning-position) end (line-end-position)))
    (comment-or-uncomment-region beg end)))

(global-set-key (kbd "C-c C-d") 'desktop-change-dir)

(defadvice show-paren-function
  (after show-matching-paren-offscreen activate)
  "If the matching paren is offscreen, show the matching line in the
    echo area. Has no effect if the character before point is not of
    the syntax class ')'."
  (interactive)
  (let* ((cb (char-before (point)))
         (matching-text (and cb
                             (char-equal (char-syntax cb) ?\) )
                             (blink-matching-open))))
    (when matching-text (message matching-text))))

;; Unbind Pesky Sleep Button
(global-unset-key [(control z)])
(global-unset-key [(control x)(control z)])
;; Windows Style Undo
(global-set-key [(control z)] 'undo)

;;(global-set-key [(control ,)] 'prev-window)
;;(global-set-key [(control .)] 'next-window)

(global-set-key (kbd "C-c j") 'beginning-of-buffer)
(global-set-key (kbd "C-c k") 'end-of-buffer)


(add-hook 'comint-output-filter-functions
          'comint-watch-for-password-prompt)


(autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t)
(add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on)
(add-to-list 'comint-output-filter-functions 'ansi-color-process-output)
(require 'ansi-color)
(defun display-ansi-colors ()
  (interactive)
  (ansi-color-apply-on-region (point-min) (point-max)))

(savehist-mode 1)
(transient-mark-mode 1)

(defun turn-on-comint-history (history-file)
          (setq comint-input-ring-file-name history-file)
          (comint-read-input-ring 'silent))

(add-hook 'eshell-mode-hook
          (lambda ()
            (turn-on-comint-history (getenv "HISTFILE"))))


(add-hook 'term-mode-hook
   (lambda ()
     ;; C-x is the prefix command, rather than C-c
     (term-set-escape-char ?\C-x)
     (define-key term-raw-map "\M-y" 'yank-pop)
     (define-key term-raw-map "\M-w" 'kill-ring-save)))

;;(add-hook 'kill-buffer-hook #'comint-write-input-ring)
;;(add-hook 'kill-emacs-hook
;;          (lambda ()
; ;           (--each (buffer-list)
 ;;             (with-current-buffer it (comint-write-input-ring)))))

(require 'package)
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes '(manoj-dark))
 '(package-selected-packages
   '(realgud magit dumb-jump projectile ggtags elpy exec-path-from-shell ##))
 '(shift-select-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )



(defun my-shell-setup ()
 "Track current directory"
 (add-hook 'comint-output-filter-functions 'my-current-directory nil t))
(setq shell-mode-hook 'my-shell-setup)

;;uncomment this line to disable loading of "default.el" at startup
(setq inhibit-default-init t)

;;enable visual feedback on selections
(setq transient-mark-mode t)

;;default to better frame titles
(setq frame-title-format
      (concat  "%b - emacs@" (system-name)))

;; default to unified diffs
(setq diff-switches "-u")
(setq indent-tabs-mode nil)

(progn
  ;; make indentation commands use space only (never tab character)
  (setq-default indent-tabs-mode nil)
  ;; emacs 23.1, 24.2, default to t
  ;; if indent-tabs-mode is t, it means it may use tab, resulting mixed space and tab
  )
;; Enable mouse support

(unless window-system
  (require 'mouse)
  (xterm-mouse-mode t)
  (global-set-key [mouse-4] (lambda ()
                              (interactive)
                              (scroll-down 1)))
  (global-set-key [mouse-5] (lambda ()
                              (interactive)
                              (scroll-up 1)))
  (defun track-mouse (e))
  (setq mouse-sel-mode t)
  )


(defun my-kill-thing-at-point (thing)
  "Kill the `thing-at-point' for the specified kind of THING."
  (let ((bounds (bounds-of-thing-at-point thing)))
    (if bounds
        (kill-region (car bounds) (cdr bounds))
      (error "No %s at point" thing))))

(defun my-kill-word-at-point ()
  "Kill the word at point."
  (interactive)
  (my-kill-thing-at-point 'word))

(global-set-key (kbd "C-x w") 'my-kill-word-at-point)
(global-set-key (kbd "M-n") 'next-line)
(global-set-key (kbd "M-p") 'previous-line)
(require 'org)
(define-key global-map "\C-cl" 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)
(setq org-log-done t)

(require 'package)
(add-to-list 'package-archives
         '("marmalade" . "http://marmalade-repo.org/packages/"))

(setq magit-save-repository-buffers nil)
(global-set-key (kbd "C-x g") 'magit-status)
(global-set-key (kbd "C-x M-g") 'magit-dispatch-popup)
(setq global-magit-file-mode t)
(setq tags-revert-without-query 1)
(defalias 'yes-or-no-p 'y-or-n-p)
;;(global-set-key "\M-." 'etags-select-find-tag)
(setq-default fill-column 80)
;; whitespace-mode
;; free of trailing whitespace and to use 80-column width, standard indentation
(setq whitespace-style '(trailing lines space-before-tab
                                  indentation space-after-tab)
      whitespace-line-column 80)
(require 'whitespace)
(setq whitespace-line-column 80) ;; limit line length
(setq whitespace-style '(face lines-tail))

(add-hook 'prog-mode-hook 'whitespace-mode)
(global-set-key (kbd "C-c C-x") 'comment-or-uncomment-region-or-line)
(add-hook 'elpy-mode-hook (lambda () (highlight-indentation-mode -1)))
(global-set-key (kbd "C-c g") 'dumb-jump-go)
(put 'scroll-left 'disabled nil)
