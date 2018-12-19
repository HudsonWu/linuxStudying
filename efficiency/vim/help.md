# Learn to use help

+ Enter `:help` or `:h` to browse help
+ Enter `:help pattern` or `:h pattern` for help on the topic pattern

## Command completion can be used when entering a help topic: 

1. Type `:h patt` then press `Ctrl-D` to list all topics that contain "patt"

2. Type `:h patt` then press `Tab` to scroll through the topics that start with "patt"
If you have set the 'wildmenu' option (by using `:set wildmenu`), then `:h patt` followed by `Tab` opens a menu on the statusline, with all help topics containing "patt", you can select any item in the menu with the arrow keys or more presses of the `Tab` key to fill in the rest of your command line

## Links

1. Enter `:h` to open the main help page
2. Type `/quick` to search for "quick" (should find the `quickref` link)
3. Press `Ctrl-]` to follow the link (jump to the `quickref` topic)
4. After browsing the `quickref` topic, press `Ctrl-T` to go back to the previous topic
5. You can also press `Ctrl-O` to jump to older locations, or `Ctrl-I` to jump to newer locations

## Searching

1. Search within a help file using `/` like you would when searching any file

2. Search all the help files with the `:helpgrep` command, for example:
```
:helpgrep \csearch.\{,12}file

\c means the pattern is case insensitive
The pattern finds "search" then up to 12 characters followed by "file"

You will then see the first match, To see other matches for the same patter, use:
:cnext
:cprev
:cnfile
:cpfile
:cfirst
:clast
:cc    //which brings you back to the current match after you scrolled the helpfile
:copen  //which will list out all the matches in a separate window
```

## Context

Each help topic has a context:
```
Prefix    Example        Context
:        :h :r        ex command(command starting within a colon)
none     :h r         normal mode
v_       :h v_r       visual mode
i_       :h i_CTRL-W  insert mode
c_       :h c_CTRL-R  ex command line
/        :h /\r       search pattern
'        :h 'ro'      option
-        :h -r        Vim argument
```
Sometimes you want to know what a particular control key means to Vim. For example, to see all help topics containing "ctrl-r", type `:h ctrl-r` then press `Ctrl-D`. The following examples show the help for pressing various keys in different contexts.
```
Example          Help for key
:h CTRL-R      Ctrl-R in normal mode
:h i_CTRL-R    Ctrl-R in insert mode
:h c_CTRL-R    Ctrl-R in command mode
:h v_CTRL-V    Ctrl-V in visual mode
```

## References

+ <http://vimdoc.sourceforge.net/>
+ <http://vim.wikia.com/wiki/Learn_to_use_help>
