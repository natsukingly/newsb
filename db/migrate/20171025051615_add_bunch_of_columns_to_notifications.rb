class AddBunchOfColumnsToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :post_id, :integer
    add_column :notifications, :comment_id, :integer
    add_column :notifications, :reply_id, :integer
    remove_column :notifications, :pcr_id
  end
end
