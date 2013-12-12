class CreatePosts < ActiveRecord::Migration
  def self.up
    create_table :posts do |t|
      t.string :title 
      t.text :body 
      t.string :slug 
      t.datetime :published 
      t.integer :status, :default=>0 
      t.text :tags 
      t.datetime :updated_at 
      t.datetime :created_at 
    end
  end
  
  def self.down
    drop_table :posts
  end
end
