class Post < ActiveRecord::Base
  extend FriendlyId

  friendly_id :title

  structure do
    title         :string, validates: :presence
    body          :text
    slug          :string, index: true
    published     :datetime
    status        :integer, default: 0
    tags          :string, example: ['tag1', 'tag2'], index: true
    timestamps
  end

  attr_accessor :resource_url

  def text_tags
    return '' unless tags
    tags.join ', '
  end

  def text_tags=(value)
    self.tags = (value || '').split(',')
                    .collect{ |tag| tag.strip }
                    .select{ |tag| not tag.empty? }
                    .compact.uniq
  end

  def title_slug
    slug
  end

  def title_slug=(value)
    self.slug = value if self.slug != value && value.present?
  end

  def as_json(options = nil)
    super({ only:
              [:id, :title, :body, :published],
            methods:
              [:text_tags, :title_slug, :resource_url]
          }.merge(options || {}))
  end
end
