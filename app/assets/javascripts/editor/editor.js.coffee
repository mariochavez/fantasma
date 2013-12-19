class Editor
  markdownShortcuts: [
    key: "Ctrl+B"
    style: "bold"
  ,
    key: "Meta+B"
    style: "bold"
  ,
    key: "Ctrl+I"
    style: "italic"
  ,
    key: "Meta+I"
    style: "italic"
  ,
    key: "Ctrl+Alt+U"
    style: "strike"
  ,
    key: "Ctrl+Shift+K"
    style: "code"
  ,
    key: "Meta+K"
    style: "code"
  ,
    key: "Ctrl+Alt+1"
    style: "h1"
  ,
    key: "Ctrl+Alt+2"
    style: "h2"
  ,
    key: "Ctrl+Alt+3"
    style: "h3"
  ,
    key: "Ctrl+Alt+4"
    style: "h4"
  ,
    key: "Ctrl+Alt+5"
    style: "h5"
  ,
    key: "Ctrl+Alt+6"
    style: "h6"
  ,
    key: "Ctrl+Shift+L"
    style: "link"
  ,
    key: "Ctrl+Shift+I"
    style: "image"
  ,
    key: "Ctrl+Q"
    style: "blockquote"
  ,
    key: "Ctrl+Shift+1"
    style: "currentDate"
  ,
    key: "Ctrl+U"
    style: "uppercase"
  ,
    key: "Ctrl+Shift+U"
    style: "lowercase"
  ,
    key: "Ctrl+Alt+Shift+U"
    style: "titlecase"
  ,
    key: "Ctrl+Alt+W"
    style: "selectword"
  ,
    key: "Ctrl+L"
    style: "list"
  ,
    key: "Ctrl+Alt+C"
    style: "copyHTML"
  ,
    key: "Meta+Alt+C"
    style: "copyHTML"
  ,
    key: "Meta+Enter"
    style: "newLine"
  ,
    key: "Ctrl+Enter"
    style: "newLine"
  ]

  constructor: (editor = '#editor-entry', preview = '#post-preview') ->
    @preview = ($ preview)
    @rendered = @preview.find('#rendered-markdown')

    @word_count = ($ '.word-count')

    @converter = new Showdown.converter
      extensions: [ 'ghostdown', 'github' ]

    @editor = CodeMirror.fromTextArea ($ editor)[0],
      mode: 'gfm'
      tabModel: 'indent'
      tabIndex: 2
      lineWrapping: true
      dragDrop: false

    @enableMarkdownShortcuts()

    @enableEditor()
    @renderPreview()

    ($ '.CodeMirror-scroll').on 'scroll', @syncScroll

  enableMarkdownShortcuts: ->
    _.each @markdownShortcuts, (combination) =>
      shortcut.add combination.key, =>
        @editor.addMarkdown style: combination.style

  enableEditor: ->
    @editor.setOption 'readOnly', false
    @editor.on 'change', @renderPreview

  disableEditor: ->
    @editor.setOption 'readOnly', true
    @editor.off 'change', @renderPreview

  renderPreview: =>
    preview = @rendered[0]
    preview.innerHTML = @converter.makeHtml(@editor.getValue())

    @countWords preview

  countWords: (preview)->
    Countable.once preview, (counter)=>
      @word_count.text "#{counter.words} #{_.pluralize('word', counter.words)} "

  syncScroll: _.throttle((event) =>
      codeViewport = ($ event.target)
      editor = _this.editor
      editor.codeContent = ($ '.CodeMirror-sizer') unless editor.codeContent?

      editor.previewContent = editor.preview.find('#post-preview-content') unless editor.previewContent?

      codeHeight = editor.codeContent.height() - codeViewport.height()
      previewHeight = editor.rendered.height() - editor.previewContent.height()
      ratio = previewHeight / codeHeight
      previewPosition = codeViewport.scrollTop() * ratio

      editor.previewContent.scrollTop previewPosition
    , 10)
window.Editor = Editor
