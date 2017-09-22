class AddArticleIdToLikePosts < ActiveRecord::Migration[5.1]
  def change
    add_column :like_posts, :article_id, :integer
  end
end
