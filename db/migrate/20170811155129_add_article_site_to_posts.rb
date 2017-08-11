class AddArticleSiteToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :article_site, :string
  end
end
