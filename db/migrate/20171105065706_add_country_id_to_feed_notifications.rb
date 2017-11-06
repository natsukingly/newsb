class AddCountryIdToFeedNotifications < ActiveRecord::Migration[5.1]
  def change
    add_column :feed_notifications, :country_id, :integer
  end
end
