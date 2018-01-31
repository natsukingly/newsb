class AddColumnLanguageIdToNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :notifications, :language_id, :integer
    add_column :notifications, :country_id, :integer
  end
end
