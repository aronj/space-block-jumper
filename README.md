# Space Block Jumper

Navigational package for the Atom text editor.

This package lets you jump with the cursor vertically across space separated blocks, skipping empty lines. It also lets you select while jumping and has a command that selects current block.

![screenshot](http://i.imgur.com/VZk2uX4.gif)

# Usage
Jumping inside a block takes you to the its edge. When jumping from an edge of a block the cursor skips the closest edge in the new block. Consecutive empty lines are always skipped.
### Settings
Settings | Description
------- | ------
Skip Closest Edge | Disable this to jump to every edge of every block irregardless of where you jump from. (Default: on)
Jump To Block Separator | Enable this to always jump to empty lines. The same behavior as in the package [block-travel](https://atom.io/packages/block-travel). (Default: off)

### Keybinds
Keybind | Action
--------- | ------
<kbd>Alt</kbd>+<kbd>Up</kbd> | Jump up
<kbd>Alt</kbd>+<kbd>Down</kbd> | Jump down
<kbd>Alt</kbd>+<kbd>Shift</kbd>+<kbd>Up</kbd> | Jump and select up
<kbd>Alt</kbd>+<kbd>Shift</kbd>+<kbd>Down</kbd> | Jump and select down
<kbd>Alt</kbd>+<kbd>Cmd</kbd>+<kbd>d</kbd> | Select block around cursor, consecutive usage cycles downward

# Ideas
* Fix bug: not stripping tabs from otherwise empty line
* Improve selection retraction
* Improve selection expansion when using alt+cmd+d
* Always land next to a character
* Multi cursor support
* Modify selection indentation
