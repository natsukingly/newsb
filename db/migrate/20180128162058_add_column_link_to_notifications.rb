class AddColumnLinkToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :link, :boolean, default: :true
  end
end
