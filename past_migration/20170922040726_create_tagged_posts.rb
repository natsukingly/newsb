class CreateTaggedPosts < ActiveRecord::Migration[5.1]
  def change
    create_table :tagged_posts do |t|
      t.integer :tag_id
      t.integer :post_id

      t.timestamps
    end
  end
end
