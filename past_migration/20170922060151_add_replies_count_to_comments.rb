class AddRepliesCountToComments < ActiveRecord::Migration[5.1]

  def self.up

    add_column :comments, :replies_count, :integer, :null => false, :default => 0

  end

  def self.down

    remove_column :comments, :replies_count

  end

end
