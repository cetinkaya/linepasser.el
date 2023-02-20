# linepasser.el
linepasser.el is an emacs minor mode that allows passing lines of a buffer as arguments to a command provided in the first line of that buffer.


## How to install

You can add the following two lines in your .emacs file to load linepasser.el and start it in text mode.

```lsp
(load "[PATHOFDIRECTORYTHATCONTAINSLINEPASSER.EL]/linepasser.el")
(add-hook 'text-mode-hook 'line-passer-mode)
```

## Example use

To use linepasser, you should first write a command to the first line of the buffer. After than you can press C-x j to pass a line as arguments to that command.

You can count words and characters with `wc`, do calculations with `bc`, get reading of Japanese words with `mecab`, and so on...

![linepasser](linepasser20230220.gif)
