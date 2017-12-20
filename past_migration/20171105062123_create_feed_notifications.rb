class CreateFeedNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :feed_notifications do |t|
      t.integer :user_id
      t.integer :post_id
      t.boolean :check, default: false

      t.timestamps
    end
  end
end
