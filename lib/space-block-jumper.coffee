{Range} = require 'atom'
module.exports =
  configDefaults:
    skipClosestEdge: true
    jumpToBlockSeparator: false

  activate: ->
    atom.workspaceView.command "space-block-jumper:jump-up", ".editor", -> jump(-1)
    atom.workspaceView.command "space-block-jumper:jump-down", ".editor", -> jump(1)
    atom.workspaceView.command "space-block-jumper:jump-select-up", ".editor", -> jump(-1, true)
    atom.workspaceView.command "space-block-jumper:jump-select-down", ".editor", -> jump(1, true)
    atom.workspaceView.command "space-block-jumper:select-block", ".editor", -> selectBlock(1, true)

setCommandContext = ->
  window.sbj_editor = atom.workspace.getActiveEditor()
  window.sbj_buffer = window.sbj_editor.getBuffer()

jump = (direction, select=false) ->
  setCommandContext()
  currLine = window.sbj_editor.getCursor().getBufferRow()

  skipClosestEdge = atom.config.get "space-block-jumper.skipClosestEdge"
  jumpToBlockSeparator = atom.config.get "space-block-jumper.jumpToBlockSeparator"

  newLine = getNewLine currLine, direction, skipClosestEdge, jumpToBlockSeparator

  if direction is -1
    delta = currLine-newLine
    if not select
      window.sbj_editor.moveCursorUp(delta)
    else
      window.sbj_editor.selectUp(delta)
      window.sbj_editor.selectToBeginningOfLine()

  else
    delta = newLine-currLine
    if not select
      window.sbj_editor.moveCursorDown(delta)
    else
      window.sbj_editor.selectDown(delta)
      window.sbj_editor.selectToEndOfLine()

selectBlock = ->
  setCommandContext()
  currLine = window.sbj_editor.getCursor().getBufferRow()

  skipClosestEdge = atom.config.get "space-block-jumper.skipClosestEdge"

  topLine = getNewLine currLine, -1, skipClosestEdge, false, true
  bottomLine = getNewLine currLine, 1, skipClosestEdge, false, true
  bottomLineLength = window.sbj_buffer.lineLengthForRow bottomLine

  blockRange = Range.fromPointWithDelta [topLine, 0], bottomLine-topLine+1, bottomLineLength-1
  window.sbj_editor.setSelectedBufferRange blockRange

getNewLine = (currLine, direction, skipCloseEdge, jumpToBlockSeparator, stayInBlock=false) ->
  nextLine = currLine + direction

  if not isInBounds nextLine
    return currLine

  if jumpToBlockSeparator
    currLine += direction
    while isInBounds(currLine+direction) and isEmptyLine(currLine) == isEmptyLine(currLine+direction)
      currLine += direction
    return currLine+(if not isEmptyLine(currLine) then direction else 0)

  # moving in emptiness
  if isEmptyLine(currLine) and isEmptyLine(nextLine)
    currLine += direction
    while isInBounds(currLine+direction) and isEmptyLine(currLine+direction)
      currLine += direction
    if not stayInBlock
      currLine += direction

  # moving inside a block
  else if not isEmptyLine(currLine) and not isEmptyLine(nextLine)
    currLine += direction
    while isInBounds(currLine+direction) and not isEmptyLine currLine+direction
      currLine += direction

  # moving from an edge of a block
  else if not isEmptyLine(currLine) and isEmptyLine(nextLine) and not stayInBlock
    currLine += direction
    if skipCloseEdge
      while isInBounds(currLine+direction) and not (not isEmptyLine(currLine) and isEmptyLine(currLine+direction))
        currLine += direction
    else
      while isInBounds(currLine+direction) and isEmptyLine(currLine)
        currLine += direction

  # moving to an edge of a block
  else if isEmptyLine(currLine) and not isEmptyLine(nextLine) and not stayInBlock
    currLine += direction
  return currLine

isEmptyLine = (lineNumber) ->
  return window.sbj_editor.bufferRangeForBufferRow(lineNumber, false).isEmpty()

isInBounds = (lineNumber) ->
  lineNumber >= 0 and lineNumber <= getLastRow()

getLastRow = ->
  window.sbj_buffer.getLastRow()

log = (anything) -> console.log(anything)
