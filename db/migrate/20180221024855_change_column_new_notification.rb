class ChangeColumnNewNotification < ActiveRecord::Migration[5.1]
  def change
    change_column :notifications, :new, :boolean, default: nil
  end
end
