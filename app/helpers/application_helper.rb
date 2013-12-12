module ApplicationHelper
  def select_first_css
    @selected = true if @selected.nil?

    if @selected
      @selected = false
      'selected'
    else
      ''
    end
  end

  def first_post_title(posts)
    return '' if posts.empty?

    @post ||= posts.first
    @post.title
  end

  def first_post_body(posts)
    return '' if posts.empty?

    @post ||= posts.first
    @post.body
  end
end
