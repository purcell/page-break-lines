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

;; Adapted from http://www.emacswiki.org/emacs/PageBreaks

;; TODO:
;; * Allow selective enabling/disabling in certain modes

;; Known issues:
;; * fill-column-indicator.el does not work properly when page-break-lines-mode
;;   is enabled.

;;; Code:

(defgroup page-break-lines nil
  "Displaying page breaks as horizontal rules."
  :prefix "page-break-lines-"
  :group 'faces)

(defcustom page-break-lines-char ?─
  "Character used to render page break lines."
  :group 'page-break-lines)

(defface page-break-lines-face
  '((t :inherit font-lock-comment-face :bold nil :italic nil))
  "Face used to colorize page break lines.
If using :bold or :italic, please ensure `page-break-lines-char'
is available in that variant of your font, otherwise it may be
displayed as a junk character."
  :group 'page-break-lines)

(defun page-break-lines--make-display-table-entry (window)
  "Make an appropriate display table entry for form feeds."
  (when page-break-lines-mode
    (vconcat (mapcar (lambda (c)
                       (make-glyph-code c 'page-break-lines-face))
                     (make-list (1- (window-width window))
                                page-break-lines-char)))))

(defun page-break-lines--update-display-table (window)
  "Create a display-table that displays page-breaks prettily."
  (set-window-display-table
     window
     (let ((table (or (copy-sequence (window-display-table window))
                      (make-display-table))))
       (aset table ?\^L (page-break-lines--make-display-table-entry window))
       table)))

(defun page-break-lines--update-display-tables  ()
  "Function called for updating display table."
  (mapc 'page-break-lines--update-display-table (window-list nil 'no-minibuffer)))



;;;###autoload
(define-minor-mode page-break-lines-mode
  "Toggle Page Break Lines mode.

In Page Break mode, page breaks (^L characters) are displayed as a
horizontal line of `page-break-string-char' characters."
  :global t
  :lighter " PgLn"
  (page-break-lines--update-display-tables)
  (if page-break-lines-mode
      (add-hook 'window-configuration-change-hook
		'page-break-lines--update-display-tables)
    (remove-hook 'window-configuration-change-hook
		 'page-break-lines--update-display-tables)))

;;;###autoload
(defun turn-on-page-break-mode ()
  (page-break-lines-mode 1))

;;;###autoload
(defun turn-off-page-break-mode ()
  (page-break-lines-mode -1))


(provide 'page-break-lines)

;; Local Variables:
;; coding: utf-8
;; byte-compile-warnings: (not cl-functions)
;; eval: (checkdoc-minor-mode 1)
;; End:

;;; page-break-lines.el ends here
