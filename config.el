;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "John Doe"
      user-mail-address "john@doe.com")

(setq +doom-dashboard-banner-file (expand-file-name "emacs-green.png" doom-private-dir))

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

(setq doom-font (font-spec :family "Iosevka SS08" :size 18))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'kaolin-mono-dark)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq +org-base-path "~/dev/org/")
(setq +daypage-path (concat +org-base-path "days/"))
(setq +org-wiki-path (concat +org-base-path "wiki/"))
(setq +org-wiki-index (concat +org-wiki-path "index.org"))
(setq +org-todo-file (concat +org-base-path "todo.org"))
(setq +org-inbox-file (concat +org-base-path "inbox.org"))
(setq +org-incubator-file (concat +org-base-path "incubator.org"))
(setq +org-quotes-file (concat +org-wiki-path "personal/quotes.org"))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type nil)
(setq mac-command-modifier 'super)
(setq mac-option-key-is-meta t)
(setq mac-command-key-is-meta nil)
(map! "s-x" #'kill-region)

(add-hook 'window-setup-hook 'toggle-frame-maximized t)
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.
;;
(global-subword-mode 1)

(use-package spacemacs-theme
  :defer t
  :custom
  (spacemacs-theme-comment-bg nil)
  (spacemacs-theme-comment-italic t))

(after! undo-tree
  :init (global-undo-tree-mode))

(use-package heaven-and-hell
  :init
  (setq heaven-and-hell-theme-type 'dark)
  (setq heaven-and-hell-themes
        '((light . spacemacs-light)
          (dark . kaolin-mono-dark)))
  :hook (after-init . heaven-and-hell-init-hook)
  :bind ("<f6>" . heaven-and-hell-toggle-theme))

(use-package ivy
  :init
  (setq ivy-initial-inputs-alist nil)
  (setq +ivy-buffer-preview t)
  :custom
  (ivy-use-virtual-buffers t)
  :config
  (ivy-mode 1)
  (use-package ivy-hydra
    :defer t)
  (use-package flx))

(use-package swiper
  :after ivy
  :bind (("C-s" . swiper)))

(use-package counsel
  :after swiper
  :bind ("C-c j" . counsel-rg)
  :config
  (counsel-mode))

(setq ivy-re-builders-alist
      '((counsel-rg . rivy--regex-plus)
        (swiper . ivy--regex-plus)
        (swiper-isearch . ivy--regex-plus)
        (t . ivy--regex-ignore-order)))

(advice-add #'smartparens-mode :before-until (lambda (&rest args) t))

(use-package which-key
  :init (which-key-mode))

(setq projectile-project-search-path '("~/dev/"))
