class AddFollowersCountToUsers < ActiveRecord::Migration[5.1]

  def self.up

    add_column :users, :followers_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :users, :followers_count

  end

end
