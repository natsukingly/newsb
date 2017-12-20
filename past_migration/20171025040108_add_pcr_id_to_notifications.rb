class AddPcrIdToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :pcr_id, :integer
  end
end
