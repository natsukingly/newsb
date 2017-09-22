class CreateLikeReplies < ActiveRecord::Migration[5.1]
  def change
    create_table :like_replies do |t|
      t.integer :reply_id
      t.integer :user_id

      t.timestamps
    end
  end
end
