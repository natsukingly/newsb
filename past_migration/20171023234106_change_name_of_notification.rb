class ChangeNameOfNotification < ActiveRecord::Migration[5.1]
  def self.up
    rename_column :notifications, :type, :notification_type
  end

  def self.down
    # rename back if you need or do something else or do nothing
    rename_column :notifications, :notification_type, :type
  end
end
