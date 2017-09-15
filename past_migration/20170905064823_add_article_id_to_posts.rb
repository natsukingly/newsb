class AddArticleIdToPosts < ActiveRecord::Migration[5.1]
  def self.up
    add_column :posts, :article_id, :integer
  end
  
  def self.down
    remove_column :posts, :article_id
  end
end
