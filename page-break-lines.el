;;; page-break-lines.el --- Display ugly ^L page breaks as tidy horizontal lines

;; Copyright (C) 2012 Steve Purcell

;; Author: Steve Purcell <steve@sanityinc.com>
;; URL: https://github.com/purcell/page-break-lines
;; Version: DEV
;; Keywords: convenience, faces

;; This program is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:

;; This library provides a global mode which displays form feed
;; characters as horizontal rules.

;; Install from Melpa or Marmalade, or add to `load-path' and use
;; (require 'page-break-lines).

;; Use `page-break-lines-mode' to enable the mode in specific buffers,
;; or customize `page-break-lines-modes' and enable the mode globally with
;; `global-page-break-lines-mode'.

;; Issues and limitations:

;; If `page-break-lines-char' is a different width to regular
;; characters, the rule may be either too short or too long: rules may
;; wrap if `truncate-lines' is nil.

;; Adapted from code http://www.emacswiki.org/emacs/PageBreaks

;;; Code:

(defgroup page-break-lines nil
  "Displaying page breaks as horizontal rules."
  :prefix "page-break-lines-"
  :group 'faces)

(defcustom page-break-lines-char ?─
  "Character used to render page break lines."
  :type 'character
  :group 'page-break-lines)

(defcustom page-break-lines-modes '(emacs-lisp-mode compilation-mode)
  "Modes in which to enable `page-break-lines-mode'."
  :type '(repeat symbol)
  :group 'page-break-lines)

(defface page-break-lines
  '((t :inherit font-lock-comment-face :bold nil :italic nil))
  "Face used to colorize page break lines.
If using :bold or :italic, please ensure `page-break-lines-char'
is available in that variant of your font, otherwise it may be
displayed as a junk character."
  :group 'page-break-lines)



(defun page-break-lines--update-display-table (window)
  "Modify a display-table that displays page-breaks prettily.
If the buffer inside WINDOW has `page-break-lines-mode' enabled,
its display table will be modified as necessary."
  (with-current-buffer (window-buffer window)
    (if page-break-lines-mode
        (progn
          (unless buffer-display-table
            (setq buffer-display-table (make-display-table)))
          (aset buffer-display-table ?\^L
                (vconcat (mapcar (lambda (c)
                       (make-glyph-code c 'page-break-lines))
                     (make-list (1- (window-width window))
                                page-break-lines-char)))))
      (when buffer-display-table
        (aset buffer-display-table ?\^L nil)))))

(defun page-break-lines--update-display-tables  ()
  "Function called for updating display table."
  (mapc 'page-break-lines--update-display-table (window-list nil 'no-minibuffer)))



;;;###autoload
(define-minor-mode page-break-lines-mode
  "Toggle Page Break Lines mode.

In Page Break mode, page breaks (^L characters) are displayed as a
horizontal line of `page-break-string-char' characters."
  :lighter " PgLn"
  :group 'page-break-lines
  (page-break-lines--update-display-tables))

;;;###autoload
(defun turn-on-page-break-lines-mode ()
  "Enable `page-break-lines-mode' in this buffer."
  (page-break-lines-mode 1))

;;;###autoload
(defun turn-off-page-break-lines-mode ()
  "Disable `page-break-lines-mode' in this buffer."
  (page-break-lines-mode -1))


(add-hook 'window-configuration-change-hook
          'page-break-lines--update-display-tables)



;;;###autoload
(defun page-break-lines-mode-maybe ()
  "Enable `page-break-lines-mode' in the current buffer if desired.
When `major-mode' is listed in `page-break-lines-modes', then
`page-break-lines-mode' will be enabled."
  (if (and (not (minibufferp (current-buffer)))
           (memq major-mode page-break-lines-modes))
      (page-break-lines-mode 1)))

(define-global-minor-mode global-page-break-lines-mode
  page-break-lines-mode page-break-lines-mode-maybe
  :group 'page-break-lines)


(provide 'page-break-lines)

;; Local Variables:
;; coding: utf-8
;; byte-compile-warnings: (not cl-functions)
;; eval: (checkdoc-minor-mode 1)
;; End:

;;; page-break-lines.el ends here
