class CreateLikes < ActiveRecord::Migration[5.1]
  def change
    create_table :likes do |t|
      t.integer :user_id
      t.integer, :comment_id
      t.integer :post_id
      t.integer :reply_id
      t.string :target_type

      t.timestamps
    end
  end
end
