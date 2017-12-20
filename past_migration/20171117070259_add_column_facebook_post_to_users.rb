class AddColumnFacebookPostToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :facebook_post, :boolean, default: false
  end
end
