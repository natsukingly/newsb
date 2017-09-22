class AddLikedCountToUsers < ActiveRecord::Migration[5.1]

  def self.up

    add_column :users, :liked_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :users, :liked_count

  end

end
