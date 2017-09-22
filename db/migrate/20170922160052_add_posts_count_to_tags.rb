class AddPostsCountToTags < ActiveRecord::Migration[5.1]

  def self.up

    add_column :tags, :posts_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :tags, :posts_count

  end

end
