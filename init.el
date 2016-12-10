;; init.el -- Emacs configuration -- Yong Wang

;; package repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
;; packages are installed through M-x list-packages
;; - exec-path-from-shell
;; - langtool
;; - material-theme
;; - org
;; - auctex
;; - auctex-latexmk



;; required to sync path with shell (needed for python)
(exec-path-from-shell-initialize)


;; language tool (grammar check)
(require 'langtool)
(setq langtool-language-tool-jar "/usr/local/Cellar/languagetool/3.5/libexec/languagetool-commandline.jar")
;;(setq langtool-default-language "en-US")
(global-set-key "\C-x4w" 'langtool-check)
(global-set-key "\C-x4W" 'langtool-check-done)
(global-set-key "\C-x4l" 'langtool-switch-default-language)
(global-set-key "\C-x44" 'langtool-show-message-at-point)
(global-set-key "\C-x4c" 'langtool-correct-buffer)


;; basic settings
(setq inhibit-startup-message t) ;; hide startup message
(load-theme 'material-light t) ;; load theme: material-light
(global-linum-mode t) ;; turn on line numbers
(set-face-attribute 'default nil :height 150)

;; org-mode settings
;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)
;; python
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))








;; setup for auctex
(require 'reftex)
(setq exec-path (append '("/usr/texbin" "/Applications/Emacs.app/Contents/MacOS/libexec" "/Applications/Emacs.app/Contents/MacOS/bin" "/usr/local/bin" "/Library/Tex/texbin") exec-path));
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(add-hook 'LaTeX-mode-hook 'visual-line-mode)
(add-hook 'LaTeX-mode-hook 'flyspell-mode)
(add-hook 'LaTeX-mode-hook 'LaTeX-math-mode)
(add-hook 'LaTeX-mode-hook 'turn-on-reftex)
(setq reftex-plug-into-AUCTeX t)
(setq TeX-PDF-mode t)
;; make latexmk available via C-c C-c
;; Note: SyncTeX is setup via ~/.latexmkrc (see below)
(add-hook 'LaTeX-mode-hook (lambda ()
  (push
    '("latexmk" "latexmk -pdf %s" TeX-run-TeX nil t
      :help "Run latexmk on file")
    TeX-command-list)))
(add-hook 'TeX-mode-hook '(lambda () (setq TeX-command-default "latexmk")))
;; use Skim as default pdf viewer
;; Skim's displayline is used for forward search (from .tex to .pdf)
;; option -b highlights the current line; option -g opens Skim in the background  
(setq TeX-view-program-selection '((output-pdf "PDF Viewer")))
(setq TeX-view-program-list
     '(("PDF Viewer" "/Applications/Skim.app/Contents/SharedSupport/displayline -b -g %n %o %b")))
(server-start); start emacs in server mode so that skim can talk to it
;; You need to put the following three lines in .latexmkrc
;;$pdflatex = 'pdflatex -interaction=nonstopmode -synctex=1 %O %S';
;;$pdf_previewer = 'open -a skim';
;;$clean_ext = 'bbl rel %R-blx.bib %R.synctex.gz';


