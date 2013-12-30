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
end
