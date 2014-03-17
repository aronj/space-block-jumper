# Space Block Jumper

Navigational package for the atom text editor.

This package lets you jump with the cursor vertically across space separated blocks, skipping empty lines. It also lets you select while jumping and has a command that selects current block.

You only jump outside of a block from the edge of it. If you are inside you jump to the edge in that direction.

By default 'Skip Closest Edge' is enabled which will skip the closest edge of the block you are jumping to.
By disabling it you can visit every edge even though moving in only one direction.

![screenshot](http://i.imgur.com/VZk2uX4.gif)

# Usage
Keybind | Action
------- | ------
<kbd>alt</kbd>+<kbd>up</kbd> | jump up
<kbd>alt</kbd>+<kbd>down</kbd> | jump down
<kbd>alt</kbd>+<kbd>shift</kbd>+<kbd>up</kbd> | jump and select up
<kbd>alt</kbd>+<kbd>shift</kbd>+<kbd>down</kbd> | jump and select down
<kbd>alt</kbd>+<kbd>cmd</kbd>+<kbd>d</kbd> | select block around cursor, consecutive usage cycles downward

# Ideas
-Multi cursor support
-Improve selection retraction
-Selection indentation
