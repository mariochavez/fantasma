$.fn.selectText = ->
  elem = this[0]
  range = undefined
  selection = undefined
  if document.body.createTextRange
    range = document.body.createTextRange()
    range.moveToElementText elem
    range.select()
  else if window.getSelection
    selection = window.getSelection()
    range = document.createRange()
    range.selectNodeContents elem
    selection.removeAllRanges()
    selection.addRange range
