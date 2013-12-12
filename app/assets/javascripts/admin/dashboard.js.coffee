class Dashboard
  constructor: (posts_list = '#posts-list', post_preview = '#post-preview') ->
    @posts_list = ($ posts_list)
    @post_preview = ($ post_preview)

    @posts_list.find('ol > li > a').on 'click', @selectPost

  selectPost: (event) =>
    post = $(event.target).closest('a')
    post.addClass 'selected'
    $.getJSON "/admin/#{post.data('postId')}", @renderUpdate

  renderUpdate: (data) =>
    html_fragment = "<h1>#{data.title}</h1>#{data.body}"
    @post_preview.find('#wrapper').html html_fragment

window.Dashboard = Dashboard
