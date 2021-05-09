
;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(when (version< emacs-version "27.0") (package-initialize))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["black" "red3" "ForestGreen" "yellow3" "blue" "magenta3" "DeepSkyBlue" "gray50"])
 '(custom-enabled-themes (quote (wheatgrass)))
 '(global-display-line-numbers-mode t)
 '(inhibit-startup-screen t)
 '(org-agenda-files (quote ("~/Notes/plans.org")))
 '(org-babel-load-languages (quote ((emacs-lisp . t) (C . t) (python . t) (java . t))))
 '(package-selected-packages (quote (markdown-mode org-link-minor-mode evil)))
 '(tool-bar-mode nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "nil" :slant normal :weight normal :height 120 :width normal)))))

;; The following lines are always needed. Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-switchb)

;; Journal capture
(setq org-capture-templates '(
    ("j" "Journal Entry"
         entry (file+datetree "~/Notes/journal.org")
         "* %T : \n %? \n"
         :empty-lines 1)
))

;; fix tab in org-mode/evil-mode combination +++ NO CHANGE +++
;; (setq evil-want-C-i-jump nil)


;; Install evil-mode
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(package-initialize)

(require 'evil)
(evil-mode 1)

;; shortcut to write brackets
(setq ns-right-option-modifier nil)

(global-visual-line-mode t)


 ;;(set-frame-parameter (selected-frame) 'alpha '(<active> . <inactive>))
 ;;(set-frame-parameter (selected-frame) 'alpha <both>) +++ NO CHANGE +++
 ;; (set-frame-parameter (selected-frame) 'alpha '(85 . 70))
 ;; (add-to-list 'default-frame-alist '(alpha . (85 . 70)))

 (defun toggle-transparency ()
   (interactive)
   (let ((alpha (frame-parameter nil 'alpha)))
     (set-frame-parameter
      nil 'alpha
      (if (eql (cond ((numberp alpha) alpha)
                     ((numberp (cdr alpha)) (cdr alpha))
                     ;; Also handle undocumented (<active> <inactive>) form.
                     ((numberp (cadr alpha)) (cadr alpha)))
               100)
          '(85 . 85) '(100 . 100)))))
(global-set-key (kbd "C-c t") 'toggle-transparency)

(set-frame-font "Monaco" nil t)

;; enable mouse support
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

;; remove the menu bar
(menu-bar-mode -1)

;; quick fix quit
(global-set-key (kbd "ESC <escape> <escape>") 'keyboard-escape-quit)
