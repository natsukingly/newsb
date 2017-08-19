class CreateArticles < ActiveRecord::Migration[5.1]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :url
      t.integer :total_likes
      t.integer :total_post
      t.integer :total_comments_replies

      t.timestamps
    end
  end
end
