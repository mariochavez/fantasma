class ChangedPostsIndexedTags < ActiveRecord::Migration
  def self.up
    add_index :posts, :tags, using: 'gin'
  end

  def self.down
  end
end
