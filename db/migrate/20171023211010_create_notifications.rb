class CreateNotifications < ActiveRecord::Migration[5.1]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.string :message
      t.string :path
      t.string :type
      t.boolean :check, default: false

      t.timestamps
    end
  end
end
