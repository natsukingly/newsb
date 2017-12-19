class CreateContacts < ActiveRecord::Migration[5.1]
  def change
    create_table :contacts do |t|
      t.integer :user_id
      t.string :email
      t.text :message
      t.boolean :check, default: false
      t.boolean :done, default: false

      t.timestamps
    end
  end
end
