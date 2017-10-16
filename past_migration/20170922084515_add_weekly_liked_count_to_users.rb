class AddWeeklyLikedCountToUsers < ActiveRecord::Migration[5.1]

  def self.up

    add_column :users, :weekly_liked_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :users, :weekly_liked_count

  end

end
