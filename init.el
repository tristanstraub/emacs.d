(setq create-lockfiles nil)
(setq backup-directory-alist
      `((".*" . ,temporary-file-directory)))
(setq auto-save-file-name-transforms
      `((".*" ,temporary-file-directory t)))

;; (message "Deleting old backup files...")
;; (let ((week (* 60 60 24 7))
;;       (current (float-time (current-time))))
;;   (dolist (file (directory-files temporary-file-directory t))
;;     (when (and (backup-file-name-p file)
;;                (> (- current (float-time (fifth (file-attributes file))))
;;                   week))
;;       (message "%s" file)
;;       (delete-file file))))

(setq message-log-max t)
(setq debug-on-error nil)
(setq stack-trace-on-error t)
(set-default-font "Monaco-13")

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(load custom-file 'noerror 'nomessage)

(load-file "~/.emacs.d/paths.el")
(load-file "~/.emacs.d/autopair.el")
(load-file "~/.emacs.d/temps.el")
(load-file "~/.emacs.d/packages.el")
(load-file "~/.emacs.d/theme.el")
(load-file "~/.emacs.d/cedet.el")
(load-file "~/.emacs.d/keys.el")

(load-file "~/.emacs.d/ecb.el")
(load-file "~/.emacs.d/desktop.el")
(load-file "~/.emacs.d/ido.el")
(load-file "~/.emacs.d/misc.el")
(load-file "~/.emacs.d/move.el")
(load-file "~/.emacs.d/iedit.el")
(load-file "~/.emacs.d/undo.el")
(load-file "~/.emacs.d/rename.el")
(load-file "~/.emacs.d/cursors.el")
(load-file "~/.emacs.d/project.el")
(load-file "~/.emacs.d/paredit.el")
(load-file "~/.emacs.d/news.el")
(load-file "~/.emacs.d/snippets.el")
(load-file "~/.emacs.d/layout.el")
(load-file "~/.emacs.d/server.el")
(load-file "~/.emacs.d/wgrep.el")
(load-file "~/.emacs.d/highlights.el")

(load-file "~/.emacs.d/grep.el")
(load-file "~/.emacs.d/expand-region.el")
(load-file "~/.emacs.d/tabs.el")
(load-file "~/.emacs.d/macros.el")
(load-file "~/.emacs.d/sql.el")
;;(load-file "~/.emacs.d/slime.el")

;; ;; ;;
;; ;; ;; fuzzy search
;; ;; ;;

(require 'fuzzy)
(turn-on-fuzzy-isearch)

(load "~/.emacs.d/vendor/nxhtml/autostart.el")

;;(add-to-list 'auto-mode-alist '("\\.html$" . django-html-mumamo-mode))

(add-to-list 'auto-mode-alist '("\\.scss$" . css-mode))

;; (require 'cl)
;; (require 'assoc)
;; (setq vc-follow-symlinks t)
;; (require 'org-install)
;; (dolist (file (directory-files user-emacs-directory 'full (rx ".org" eos)))
;;   (org-babel-load-file file))
;;(emacs-init-time)

;;
;; js2-refactor: this has to be loaded after nxhtml
;;
(load-file "~/.emacs.d/js2-refactor.el")


;; fix some org-mode + yasnippet conflicts:
(defun yas/org-very-safe-expand ()
  (let ((yas/fallback-behavior 'return-nil)) (yas/expand)))

(add-hook 'org-mode-hook
          (lambda ()
            (make-variable-buffer-local 'yas/trigger-key)
            (setq yas/trigger-key [tab])
            (add-to-list 'org-tab-first-hook 'yas/org-very-safe-expand)
            (define-key yas/keymap [tab] 'yas/next-field)
            ))


;; (unless (require 'el-get nil 'noerror)
;;   (with-current-buffer
;;       (url-retrieve-synchronously
;;        "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
;;     (goto-char (point-max))
;;     (eval-print-last-sexp)))

;; (el-get 'sync)


(put 'upcase-region 'disabled nil)

;; Set a Mode Line that tells me which machine, which directory,
;; and which line I am on, plus the other customary information.
(setq-default mode-line-format
              (quote
               (#("-" 0 1
                  (help-echo
                   "mouse-1: select window, mouse-2: delete others ..."))
                 mode-line-mule-info
                 mode-line-modified
                 mode-line-frame-identification
                 "    "
                 mode-line-buffer-identification
                 "    "
                 (:eval (substring
                         (system-name) 0 (string-match "\\..+" (system-name))))
                 ":"
                 default-directory
                 #(" " 0 1
                   (help-echo
                    "mouse-1: select window, mouse-2: delete others ..."))
                 (line-number-mode " Line %l ")
                 global-mode-string
                 #("   %[(" 0 6
                   (help-echo
                    "mouse-1: select window, mouse-2: delete others ..."))
                 ;; (:eval (mode-line-mode-name))
                 mode-line-process
                 minor-mode-alist
                 #("%n" 0 2 (help-echo "mouse-2: widen" local-map (keymap ...)))
                 ")%] "
                 (-3 . "%P")
                 ;;   "-%-"
                 )))

;; (require 'eproject)
;; (require 'eproject-extras)
;; (require 'eproject-peepopen)


;; (define-project-type emacs (generic) (look-for "init.el"))

;; (define-project-type npm (generic) (look-for "package.json"))
;; ;;(define-project-type grunt (generic) (look-for "grunt.js"))
;; (define-project-type yeoman (generic) (look-for "Gruntfile.js"))




;; eproject global bindings
;; (defmacro .emacs-curry (function &rest args)
;;   `(lambda () (interactive)
;;      (,function ,@args)))

;; (defmacro .emacs-eproject-key (key command)
;;   (cons 'progn
;;         (loop for (k . p) in (list (cons key 4) (cons (upcase key) 1))
;;               collect
;;               `(global-set-key
;;                 (kbd ,(format "C-x p %s" k))
;;                 (.emacs-curry ,command ,p)))))

;; (.emacs-eproject-key "k" eproject-kill-project-buffers)
;; (.emacs-eproject-key "v" eproject-revisit-project)
;; (.emacs-eproject-key "b" eproject-ibuffer)
;; (.emacs-eproject-key "o" eproject-open-all-project-files)


;;(require 'semantic-tag-folding)
;;(global-semantic-folding-mode t)

;;(require 'semantic-tag-folding)



;; (defun my-outline-trigger ()
;;   "enable outline mode and hide all the function bodies"
;;   ;; (when (member major-mode '(cc-mode emacs-lisp-mode)) ....)
;;   (outline-minor-mode)
;;   (hide-body))

;; (add-hook 'find-file-hooks 'my-outline-trigger)

;; (defvar hs-special-modes-alist
;;   (mapcar 'purecopy
;;   '((c-mode "{" "}" "/[*/]" nil nil)
;;     (c++-mode "{" "}" "/[*/]" nil nil)
;;     (bibtex-mode ("@\\S(*\\(\\s(\\)" 1))
;;     (java-mode "{" "}" "/[*/]" nil nil)
;;     (js2-mode "{" "}" "/[*/]" nil)))




;;(require 'dirtree)

(setq 
  bookmark-default-file "~/.emacs.d/bookmarks" ;; keep my ~/ clean
  bookmark-save-flag 1) 

(setq tab-width 2)
(setq coffee-tab-width 2)

(setq tab-width 2)


(require 'coffee-mode)
(set 'coffee-tab-width 2)

(add-to-list 'auto-mode-alist
;;             '("\\.coffee$" . rinari-minor-mode) ;;use rinari-mode
             '("\\.coffee$" . coffee-mode)
             )
(defun coffee-custom ()
  "coffee-mode-hook"
  ;; ;; CoffeeScript uses two spaces.
  ;;(make-local-variable 'tab-width)
  ;;(set 'tab-width 2)
  ;; If you don't have js2-mode
  ;; (setq coffee-js-mode 'javascript-mode)
  ;; ;; if you don't want your compiled files to be wrapped
  ;; (setq coffee-args-compile '("-c" "--bare"))
  ;; ;; *Messages* spam
  ;; (setq coffee-debug-mode t)
  ;; Emacs key binding
  (setq coffee-args-compile '())
  (append coffee-args-compile (list "-c" "-b"))
  (define-key coffee-mode-map "\C-c\C-c" 'coffee-compile-buffer)
  )
(add-hook 'coffee-mode-hook 'coffee-custom)




;;; coffee lint mode !! ooooo O-o

;; make coffeelinenode work nicely!
(add-to-list 'load-path "/home/tristan/.emacs.d/vendor/coffeelintnode")
;; (require 'flymake-coffeelint)
;; Make sure we can find the lintnode executable
(setq coffeelintnode-location "/home/tristan/.emacs.d/vendor/coffeelintnode")
(setq coffeelintnode-node-program "/usr/bin/node")
(setq coffeelintnode-coffeelint-excludes (list 'max_line_length))
(setq coffeelintnode-coffeelint-includes '())
(setq coffeelintnode-coffeelint-set "")
;; Start the server when we first open a coffee file and start checking
(setq coffeelintnode-autostart 'true)
(add-hook 'coffee-mode-hook
  (lambda ()
    ;; (coffeelintnode-hook)
    ;; (unless (eq buffer-file-name nil) (flymake-mode 1)) ;dont invoke flymake on temporary
    ;; buffers for the interpreter
    (local-set-key (kbd "C-c C-p") 'flymake-goto-prev-error)
    (local-set-key (kbd "C-c C-n") 'flymake-goto-next-error)))

(add-hook 'js2-mode-hook 
  (lambda ()
    (local-set-key (kbd "C-c C-n") 'js2-next-error)))

;;(require 'flymake-cursor)

(setq-default indent-tabs-mode nil)

;; (setq whitespace-style '(tabs lines trailing lines tab-mark))
(setq whitespace-line-column 119)
;; (global-whitespace-mode 1)


(add-to-list 'load-path "~/.emacs.d/vendor/jshint-mode")
;; (require 'flymake-jshint)
;; (add-hook 'javascript-mode-hook
;;           (lambda () 
;;             (unless (eq buffer-file-name nil) (flymake-mode 1)) ;dont invoke flymake on temporary buffers for the interpreter
;;             (flymake-mode t)))

;; turns on for all files that have a flymake mode
;; (add-hook 'find-file-hook 'flymake-find-file-hook)

(autoload 'json-mode "json-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))

(require 'feature-mode)
(autoload 'feature-mode "feature-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.feature$" . feature-mode))

(setq default-tab-width 2)
(set-variable 'c-basic-offset 2)
(setq-default indent-tabs-mode nil)



(grep-compute-defaults)
;; (setq grep-find-command "find . ! -name \"*~\" ! -name \"#*#\" -type f -print0 | xargs -0 -e grep -nH -e ")

(defun ts/grep-recursive (directory term exclude)
  (interactive
   (list (or directory ".") ;; directory
         (if (use-region-p) ;; term
             (buffer-substring (region-beginning) (region-end))
             (read-string "grep: "))
         ""
         ) ;;exclude
   ) 

  (let ((pipe
         (if exclude
             (concat  "| grep -v -e \"" exclude "\"")
             "")))
    (grep (concat "grep -nH -iR -e \""
                  term  "\" " (concat (file-name-as-directory directory) "*" pipe)))))

(defun ts/grep-project (term)
  (interactive
   (list (if (use-region-p)
             (buffer-substring (region-beginning) (region-end))
             (read-string "grep: "))))
  (grep (concat "grep -nH -iR -e \""
                term  "\" " (project-root) "*")))

(defun ts/notes-search (term)
  (interactive
   (list (if (use-region-p)
             (buffer-substring (region-beginning) (region-end))
             (read-string "search term: "))))
  (ts/grep-recursive (expand-file-name "~/me/notes") term "BEGIN_SRC"))

(require 'project-root)


(setq ido-decorations (quote ("\n-> " "" "\n   " "\n   ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]")))
;;(setq ido-decorations '( "{" "}" " | " " | ..." "[" "]" " [No match]" " [Matched]" " [Not readable]" " [Too big]" " [Confirm]"))

(defun ido-disable-line-truncation () (set (make-local-variable 'truncate-lines) nil))
(add-hook 'ido-minibuffer-setup-hook 'ido-disable-line-truncation)

(defun ts/ido-forward ()
  (interactive)
  (ido-next-match))

(defun ts/ido-backwards ()
  (interactive)
  (ido-prev-match))

(require 'ido-preview)

(defun ts/ido-define-keys () ;; C-n/p is more intuitive in vertical layout
  (define-key ido-completion-map (kbd "C-n") 'ts/ido-forward)
  (define-key ido-completion-map (kbd "C-p") 'ts/ido-backwards)
  )

(add-hook 'ido-setup-hook 'ts/ido-define-keys)


;; (add-hook 'ido-setup-hook
;;           (lambda()
;;             (define-key ido-completion-map (kbd "C-M-p") (lookup-key ido-completion-map (kbd "C-p")))
;;             (define-key ido-completion-map (kbd "C-M-n") (lookup-key ido-completion-map (kbd "C-n"))) ; currently, this makes nothing. Maybe they'll make C-n key lately.
;;             (define-key ido-completion-map (kbd "C-p") 'ido-preview-backward)
;;             (define-key ido-completion-map (kbd "C-n") 'ido-preview-forward)))

(push "~/.emacs.d/vendor/helm" load-path)
(push "~/.emacs.d/vendor/helm-cmd-t" load-path)
(require 'helm-config)
(require 'helm-cmd-t)
(global-set-key (kbd "M-t") 'helm-cmd-t)

;; (setq x-meta-keysym 'meta)
(require 'auto-install)
(setq auto-install-directory "~/.emacs.d/auto-install/")
(require 'anything-match-plugin)
(require 'anything-config)
(require 'anything-grep)



(fset 'format-json
   (lambda (&optional arg) "Keyboard macro." (interactive "p") (kmacro-exec-ring-item (quote ([24 104 21 134217852 106 115 111 110 return] 0 "%d")) arg)))

(global-set-key (kbd "C-x C-j") 'format-json)

;; (add-to-list 'load-path "~/.emacs.d/vendor/ack-and-a-half")
;; (require 'ack-and-a-half)
;; ;; Create shorter aliases
;; (defalias 'ack 'ack-and-a-half)
;; (defalias 'ack-same 'ack-and-a-half-same)
;; (defalias 'ack-find-file 'ack-and-a-half-find-file)
;; (defalias 'ack-find-file-same 'ack-and-a-half-find-file-same)

(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(global-set-key [f11] 'toggle-fullscreen)
(global-set-key [C-tab] 'yas/expand)

;; (set-default-font “Terminus-9”)



 ;; scroll one line at a time (less "jumpy" than defaults)
    
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed t) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time

(setq helm-ff-transformer-show-only-basename nil)
(require 'ack)

(defun ts/ack-project (term)
  (interactive
   (list (if (use-region-p)
             (buffer-substring (region-beginning) (region-end))
             (read-string "grep: "))))
  (ack (concat "ack -nH -iR -e \""
                term  "\" " (project-root) "*")))

