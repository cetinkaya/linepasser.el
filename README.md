# linepasser.el
linepasser.el is an emacs minor mode that allows passing lines of a buffer as arguments to a command provided in the first line of that buffer.


## How to install

You can add the following two lines in your .emacs file to load linepasser.el and start it in text mode.

```lsp
(load "/WHEREYOUPUTLINEPASSER/linepasser.el")
(add-hook 'text-mode-hook 'line-passer-mode)
```

