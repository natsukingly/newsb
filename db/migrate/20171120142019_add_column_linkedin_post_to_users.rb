class AddColumnLinkedinPostToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :linkedin_post, :boolean, default: false
    add_column :users, :twitter_post, :boolean, default: false
    add_column :users, :twitter_follower, :integer, default: 0
  end
end
