Enables persistent undo when using sudoedit.

Rationale
=========

With persistent undo (enabled with `:set undofile`), Vim remembers undo history so it can be undone later, even if you close your editor. However, using `sudoedit` breaks this, since repeated invocations of `sudoedit /path/to/file.xyz` don’t actually pass the same file to Vim (instead a temporary file `/var/tmp/file###.xyz` is created, where `###` changes each time). This plugin+script ensures that the undo history is preserved, as though  `/path/to/file.xyz` were being edited each time.

Limitations
===========

The undo history (`u`/`<C-r>`) is preserved, but the changelist (`g;`/`g,`) currently is not.

Currently this plugin+script preserves undo history when using `sudoedit`, but not when using the otherwise-synonymous `sudo -e`.

Installation
============

Add this directory to Vim’s `runtimepath`, and copy `sudoedit` to a directory on your `PATH`. If using [https://github.com/junegunn/vim-plug](vim-plug), it should be sufficient to include the following in your `.vimrc`

```vim
call plug#begin()
" ...
Plug 'EESchneider/vim_sudoedit_undo', {'do': './install'}
" ...
call plug#end()
```

When uninstalling, remember to `rm ~/.local/bin/sudoedit`. If you would prefer to install to a location other than `~/.local/bin`, use `BIN_DIR=/path/to/preferred/directory ./install`.
