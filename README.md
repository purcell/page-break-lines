page-break-lines.el
===================

This Emacs library provides a global mode which displays ugly form feed
characters as tidy horizontal rules.

Installation
=============

If you choose not to use one of the convenient
packages in [Melpa][melpa] and [Marmalade][marmalade], you'll need to
add the directory containing `page-break-lines.el` to your `load-path`, and
then `(require 'page-break-lines)`.

Usage
=====

Enable `page-break-lines-mode` in an individual buffer like this:

     (turn-on-page-break-lines-mode)

Alternatively, customize `page-break-lines-modes` and enable the mode globally with
`global-page-break-lines-mode`.

[marmalade]: http://marmalade-repo.org
[melpa]: http://melpa.milkbox.net

<hr>

[![](http://api.coderwall.com/purcell/endorsecount.png)](http://coderwall.com/purcell)

[![](http://www.linkedin.com/img/webpromo/btn_liprofile_blue_80x15.png)](http://uk.linkedin.com/in/stevepurcell)
