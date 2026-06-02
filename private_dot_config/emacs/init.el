;;; init.el -*- lexical-binding: t; -*-

;; ── Bootstrap ────────────────────────────────────────────────────────
(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(package-initialize)
(unless package-archive-contents (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))
(setq use-package-always-ensure t)

;; ── Defaults ─────────────────────────────────────────────────────────
(setq inhibit-startup-message t
      ring-bell-function 'ignore
      make-backup-files nil
      auto-save-default nil
      create-lockfiles nil
      use-short-answers t)

(scroll-bar-mode -1)
(tool-bar-mode -1)
(unless (eq system-type 'darwin) (menu-bar-mode -1))
(global-hl-line-mode 1)
(global-display-line-numbers-mode 1)
(column-number-mode 1)
(electric-pair-mode 1)
(save-place-mode 1)
(recentf-mode 1)
(global-auto-revert-mode 1)

;; ── Font ─────────────────────────────────────────────────────────────
(set-face-attribute 'default nil :family "JetBrains Mono Nerd Font" :height 140)

;; ── Theme (Tokyo Night) ──────────────────────────────────────────────
(use-package doom-themes
  :config (load-theme 'doom-tokyo-night t))

(use-package doom-modeline
  :hook (after-init . doom-modeline-mode))

;; ── Completion stack ─────────────────────────────────────────────────
(use-package vertico
  :init (vertico-mode))

(use-package orderless
  :custom (completion-styles '(orderless basic)))

(use-package marginalia
  :init (marginalia-mode))

(use-package consult
  :bind (("C-x b"  . consult-buffer)
         ("M-y"    . consult-yank-pop)
         ("C-s"    . consult-line)
         ("C-c s"  . consult-ripgrep)))

;; ── Which-key ────────────────────────────────────────────────────────
(use-package which-key
  :init (which-key-mode))

;; ── Magit ────────────────────────────────────────────────────────────
(use-package magit
  :bind ("C-x g" . magit-status))

;; ── Dirvish (modern dired) ───────────────────────────────────────────
(use-package dirvish
  :init (dirvish-override-dired-mode)
  :bind (("C-c d"  . dirvish)
         :map dirvish-mode-map
         ("TAB"    . dirvish-subtree-toggle)
         ("q"      . dirvish-quit))
  :custom
  (dirvish-quick-access-entries
   '(("h" "~/"                    "Home")
     ("d" "~/Downloads/"          "Downloads")
     ("p" "~/Documents/projects/" "Projects")))
  :config
  (dirvish-side-follow-mode 1))

;; ── Git gutter ───────────────────────────────────────────────────────
(use-package diff-hl
  :hook (prog-mode . diff-hl-mode)
  :config (diff-hl-flydiff-mode 1))
