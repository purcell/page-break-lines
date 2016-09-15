[![Melpa Status](http://melpa.org/packages/page-break-lines-badge.svg)](http://melpa.org/#/page-break-lines)
[![Melpa Stable Status](http://stable.melpa.org/packages/page-break-lines-badge.svg)](http://stable.melpa.org/#/page-break-lines)

page-break-lines.el
===================

This Emacs library provides a global mode which displays ugly form feed
characters as tidy horizontal rules.

Screenshot
==========

![page-break-lines screenshot](screenshot.png)

Installation
=============

If you choose not to use one of the convenient
packages in [MELPA][melpa], you'll need to
add the directory containing `page-break-lines.el` to your `load-path`, and
then `(require 'page-break-lines)`.

Usage
=====

Enable `page-break-lines-mode` in an individual buffer like this:

```lisp
(turn-on-page-break-lines-mode)
```

Alternatively, customize `page-break-lines-modes` and enable the mode globally with
`global-page-break-lines-mode`.

Issues and limitations
======================

If `page-break-lines-char` is displayed at a different width to
regular characters, the rule may be either too short or too long:
rules may then wrap if `truncate-lines` is nil. On some systems,
Emacs may erroneously choose a different font for the page break
symbol, which choice can be overridden using code such as:

```lisp
(set-fontset-font "fontset-default"
                  (cons page-break-lines-char page-break-lines-char)
                  (face-attribute 'default :family))
```

Use `describe-char` on a page break char to determine whether this
is the case.

Also see Vasilij Schneidermann's
[form-feed package](https://github.com/wasamasa/form-feed), which
works using font-lock instead of glyph composition, and therefore has
different display trade-offs.

[melpa]: http://melpa.org

<hr>

[![](http://api.coderwall.com/purcell/endorsecount.png)](http://coderwall.com/purcell)

[![](http://www.linkedin.com/img/webpromo/btn_liprofile_blue_80x15.png)](http://uk.linkedin.com/in/stevepurcell)

[Steve Purcell's blog](http://www.sanityinc.com/) // [@sanityinc on Twitter](https://twitter.com/sanityinc)
