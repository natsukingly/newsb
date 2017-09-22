class AddWeeklyPostsCountToTags < ActiveRecord::Migration[5.1]

  def self.up

    add_column :tags, :weekly_posts_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :tags, :weekly_posts_count

  end

end
