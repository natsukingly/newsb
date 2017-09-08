class AddColumnArticleIdToLikes < ActiveRecord::Migration[5.1]
  def self.up
    add_column :likes, :article_id, :integer
  end
  
  def self.down
    remove_column :likes, :article_id
  end
end
