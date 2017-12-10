class AddColumnEveryoneToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :everyone, :boolean, default: false
  end
end
