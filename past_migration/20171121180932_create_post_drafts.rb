class CreatePostDrafts < ActiveRecord::Migration[5.1]
  def change
    create_table :post_drafts do |t|
      t.integer :user_id
      t.text :content
      t.integer :article_id
      t.integer :category_id
      t.integer :country_id
      t.boolean :fake_news_report, default: false

      t.timestamps
    end
  end
end
