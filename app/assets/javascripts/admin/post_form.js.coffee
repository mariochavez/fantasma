class PostForm
  constructor: (editor, form, body, flash = '#flash') ->
    @editor = editor
    @form = ($ form)
    @body = ($ body)
    @flash = ($ flash)

    @form.on 'ajax:beforeSend', @prepareData
    @form.on 'ajax:error', @renderError
    @form.on 'ajax:success', @renderSuccess

  renderSuccess: (event, data, status, xhr) =>
    unless status >= 400
      @hideFlash()

      message = ''
      message = 'saved as a draft' if data.status == 0

      @flash.append @buildNoticeMessage(message)
      link = @flash.find('a')
      link.on 'click', @hideFlash

      @updateForm data

      @clearFlash = setTimeout =>
        clearTimeout @clearFlash
        @hideFlash()
      , 5000

  updateForm: (data) ->
    @form.find('#post_title_slug').val data.title_slug
    @form.find('#post_published').val data.published

    #if data.id? and @form.find('#post_id').length == 0
    #  @form.prepend "<input id='post_id' name='post[id]' type='hidden' value='#{data.id}'>"

    if data.id?
      @form.prepend "<input name='_method' type='hidden' value='patch'>"
      @form.removeClass 'new_post'
      @form.addClass 'edit_post'
      @form.attr
        id: "edit_post_#{data.id}"
        action: "/admin/#{data.id}"

    if data.resource_url?
      window.history.pushState {}, '', data.resource_url

  renderError: (event, xhr, status, error) =>
    @hideFlash()

    message = ''
    message = 'There was a server error, please try later' if xhr.status == 500

    if xhr.status == 422
      message = @getError xhr.responseJSON.errors

    @flash.append @buildAlertMessage(message)
    @flash.find('a').on 'click', @hideFlash

  getError: (modelErrors) ->
    errorMessages = for field, errors of modelErrors
      "#{@capitalize field} #{errors[0]}"

    errorMessages[0]

  capitalize: (text) ->
    text = (if not text? then "" else String(text))
    text.charAt(0).toUpperCase() + text.slice(1)

  buildNoticeMessage: (message) ->
    "<div id='flash-notice'><i class='fa fa-check-circle'></i>Your post has been #{message}.<a href='#'><i class='fa fa-times-circle'></i></a></div>"

  buildAlertMessage: (message) ->
    "<div id='flash-alert'><i class='fa fa-exclamation-triangle'></i>Your post could not be saved. #{message}.<a href='#'><i class='fa fa-times-circle'></i></a></div>"

  hideFlash: (event) =>
    event.preventDefault() if event?

    @flash.children().off()
    @flash.empty()

  prepareData: (event, xhr, settings) =>
    @body.text @editor.getValue()

    data = @form.serialize()
    settings.data = data

window.PostForm = PostForm
