class ChangedPostsIndexedSlug < ActiveRecord::Migration
  def self.up
    add_index :posts, :slug, unique: true
  end

  def self.down
  end
end
