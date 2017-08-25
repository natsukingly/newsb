class AddTargetUserIdToLikes < ActiveRecord::Migration[5.1]
  def change
    add_column :likes, :target_user_id, :integer
  end
end
