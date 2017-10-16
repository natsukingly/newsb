class AddPostsCountToArticles < ActiveRecord::Migration[5.1]

  def self.up

    add_column :articles, :posts_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :articles, :posts_count

  end

end
