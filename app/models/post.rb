class Post < ActiveRecord::Base
  structure do
    title         :string, validates: :presence
    body          :text, validates: :presence
    slug          :string
    published     :datetime
    status        :integer, default: 0
    tags          :serialized, example: ['tag1', 'tag2']
    timestamps
  end
end
