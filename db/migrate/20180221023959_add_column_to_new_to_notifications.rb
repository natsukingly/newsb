class AddColumnToNewToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :new, :boolean, default: true
  end
end
