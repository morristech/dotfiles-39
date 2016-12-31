(prelude-require-packages '(org ob-ipython ox-gfm))

(add-hook 'org-mode-hook
          '(lambda ()
             ;; column width
             (set-fill-column 80)
             ;; turn on auto-fill-mode
             (turn-on-auto-fill)))

;;; Export
;; enable export to github-flawored-markdown
(require 'ox-gfm)

;;; Babel
(require 'ob-rust)
;; syntax highlighting in src blocks
(setq org-src-fontify-natively t)
;; TAB acts in code block as if it was issued in the language major mode buffer,
;; affects indentation and stuff
(setq org-src-tab-acts-natively t)
;; load languages
(org-babel-do-load-languages 'org-babel-load-languages
                             '((emacs-lisp . t)
                               (rust . t)
                               (sh . t)))

;;; IPython
(require 'ob-ipython)
;; don't confirm code block evaluation
(setq org-confirm-babel-evaluate nil)
;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;;; LaTeX
(require 'ox-latex)
(setq org-latex-listings t)

;;; XeLaTeX
;; remove "inputenc" from default packages as it clashes with xelatex
(setf org-latex-default-packages-alist
      (remove '("AUTO" "inputenc" t) org-latex-default-packages-alist))

(add-to-list 'org-latex-packages-alist '("" "xltxtra" t))
;; choose Linux Libertine O as serif and Linux Biolinum O as sans-serif fonts
(add-to-list 'org-latex-packages-alist '("" "libertine" t))

;; org to latex customisations, -shell-escape needed for minted
(setq org-latex-pdf-process               ; for regular export
      '("xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"
        "xelatex -shell-escape -interaction nonstopmode -output-directory %o %f"))

;; in order to generate bibliography properly we need texi2dvi
;;(setq org-latex-pdf-process '("texi2dvi --pdf --clean --verbose --batch %f"))