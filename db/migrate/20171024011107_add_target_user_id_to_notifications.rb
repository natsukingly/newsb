class AddTargetUserIdToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :target_user_id, :integer
  end
end
