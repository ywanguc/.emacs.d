;; init.el -- Emacs configuration -- Yong Wang
;; 2016 - 2017
;; This is a very simple emacs config.
;;     - LaTex - auctex
;;     - Notes - org
;;     - Python - (sometimes)


;; package repositories
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("melpa" . "http://melpa.org/packages/")))
(package-initialize)
;; packages are installed through M-x list-packages or M-x package-install


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
;;(load-theme 'material-light t) ;; load theme: material-light
(load-theme 'zenburn t)
;;(global-linum-mode t) ;; turn on line numbers. 
(set-face-attribute 'default nil :height 150)

;; ido
(require 'ido)
(ido-mode t)



;; ace-jump-mode (easymotion)
(require 'ace-jump-mode)
(define-key global-map (kbd "C-x j") 'ace-jump-mode)

;; iy-go-to-char
(require 'iy-go-to-char)
;;(add-to-list 'mc/cursor-specific-vars 'iy-go-to-char-start-pos)
(global-set-key (kbd "C-c f") 'iy-go-to-char)
(global-set-key (kbd "C-c F") 'iy-go-to-char-backward)
(global-set-key (kbd "C-c ;") 'iy-go-to-or-up-to-continue)
(global-set-key (kbd "C-c ,") 'iy-go-to-or-up-to-continue-backward)

;; org-mode settings
;; The following lines are always needed.  Choose your own keys.
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)



;; yasnippet
(require 'yasnippet)
(add-to-list 'yas-snippet-dirs "~/.emacs.d/yasnippet-snippets")
(yas-reload-all)
(add-hook 'python-mode-hook #'yas-minor-mode)
(add-hook 'c-mode-hook #'yas-minor-mode)
(add-hook 'c++-mode-hook #'yas-minor-mode)
(add-hook 'java-mode-hook #'yas-minor-mode)
(add-hook 'html-mode-hook #'yas-minor-mode)
(add-hook 'latex-mode-hook #'yas-minor-mode)
(add-hook 'org-mode-hook #'yas-minor-mode)

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


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("5dc0ae2d193460de979a463b907b4b2c6d2c9c4657b2e9e66b8898d2592e3de5" "486759384769d44b22bb46072726c2cfb3ccc3d49342e5af1854784d505ffc01" default)))
 '(package-selected-packages
   (quote
    (writeroom-mode zenburn-theme iy-go-to-char ace-jump-mode yasnippet pyvenv pythonic org material-theme langtool highlight-indentation find-file-in-project exec-path-from-shell company auctex-latexmk))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
