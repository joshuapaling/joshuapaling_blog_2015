---
title: VIM
---

<h1>Vim</h1>

## Insert

`i` before cursor
`a` after cursor
`A` end of line
`I` beginning of line (before first non-blank char)
`o` new line below
`O` new line above

=======

- open file in specific split DONE
- open in vertical split from NERDTree DONE
- move between window splits & nerdtree DONE
- enter should indent new line appropriately
- syntax-specific tab settings (and default to 2 spaces)
- Do I need to install syntax highlighting packages for anything? YES PHP
- indent lines or visual selection
- insert new line without entering insert mode
- find and replace
- multiple cursors
- select next occurance of phrase - Ctrl-N with multiple cursors
- do you ever have multiple files open in the one split?
- how do you tell if a file is saved or not?

DONE
- list methods (Cmd+R in sublime)
- quick open file with fuzzy matching

TO DO
- Install php syntax support


TO DO = SMALL
- margins at 80 chars or wherever
- show white space
- change font size


sudo !! - repeat last command with sudo

Project-wide search: Just search for vim ack

======

STUFF FROM LEN:

Customisations

\n - toggle NT

Splits:
Ctrl-W: everything to do with window management
C-w, V: Vertical split
C-w, S: Horz split
C-w - HJKL - move between splits.


Shift-ZZ save and quit.

C-tags. "Exuberant C-Tags" - like Cmd-R for sublime.

Ctrl-P: fuzzy find and open. Esc to close.

Open file:
:e (type file name)

Ctrl-6 - toggles between previous buffers (have to have no unsaved changes)

Range -select:

Ctrl-v - use arrow keys to select area (visual select for not whole lines)

:EraseBadWhitespace (Er -tab)


.vim - add to dotfiles repo. Add some stuff to gitignore.

Uncomment/Comment: Leader-c

:set paste "Insert Paste"- disables auto-indenting and stuff.
:set nopaste


Indent / outdent: < / >


'==' -make indenting correct.jj

:reg - show all the registers in vim

leader-x - copy from vim to system clipboard
leader-pp - paste from system clipboard in to vim
