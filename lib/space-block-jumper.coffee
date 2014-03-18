{Range} = require 'atom'
module.exports =
  configDefaults:
    skipClosestEdge: true

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
  newLine = getNewLine currLine, direction

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

  topLine = getNewLine currLine, -1, true
  bottomLine = getNewLine currLine, 1, true
  bottomLineLength = window.sbj_buffer.lineLengthForRow bottomLine

  blockRange = Range.fromPointWithDelta [topLine, 0], bottomLine-topLine+1, bottomLineLength-1
  window.sbj_editor.setSelectedBufferRange blockRange

getNewLine = (currLine, direction, stayInBlock=false) ->
  nextLine = currLine + direction

  if not isInBounds nextLine
    return currLine

  skipCloseEdge = atom.config.get "space-block-jumper.skipClosestEdge"

  # moving in emptiness
  if isEmptyLine(currLine) and isEmptyLine(nextLine)
    while isInBounds(currLine+direction) and isEmptyLine(currLine+direction)
      currLine += direction
    if not stayInBlock
      currLine += direction

  # moving inside a block
  else if not isEmptyLine(currLine) and not isEmptyLine(nextLine)
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
