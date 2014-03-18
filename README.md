# Space Block Jumper

Navigational package for the atom text editor.

This package lets you jump with the cursor vertically across space separated blocks, skipping empty lines. It also lets you select while jumping and has a command that selects current block.

![screenshot](http://i.imgur.com/VZk2uX4.gif)

# Usage
Jumping inside a block takes you to the its edge. Jumping outward from an edge takes you to the next block. By default 'Skip Closest Edge' is enabled which will skip the closest edge for far side edge in the next block. By disabling it you can instead visit every edge even though moving in only one direction. 'Jump To Block Separator' introduces the same behaviour as [block-travel](https://atom.io/packages/block-travel) by landing between blocks.

Keybind | Action
------- | ------
<kbd>alt</kbd>+<kbd>up</kbd> | jump up
<kbd>alt</kbd>+<kbd>down</kbd> | jump down
<kbd>alt</kbd>+<kbd>shift</kbd>+<kbd>up</kbd> | jump and select up
<kbd>alt</kbd>+<kbd>shift</kbd>+<kbd>down</kbd> | jump and select down
<kbd>alt</kbd>+<kbd>cmd</kbd>+<kbd>d</kbd> | select block around cursor, consecutive usage cycles downward

# Ideas
* Improve selection retraction
* Improve selection expansion when using alt+cmd+d
* Always land next to a character
* Multi cursor support
* Modify selection indentation
