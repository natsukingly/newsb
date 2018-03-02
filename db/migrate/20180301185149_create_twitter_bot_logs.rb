class CreateTwitterBotLogs < ActiveRecord::Migration[5.1]
  def change
    create_table :twitter_bot_logs do |t|
      t.integer :article_id

      t.timestamps
    end
  end
end
