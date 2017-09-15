class CreatePosts < ActiveRecord::Migration[5.1]
  def change
    create_table :posts do |t|
      t.integer :user_id
      t.string :title
      t.text :content
      t.string :article_title
      t.string :article_image
      t.string :article_url

      t.timestamps
    end
  end
end
