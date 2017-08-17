class AddPublishedTimeToPosts < ActiveRecord::Migration[5.1]
  def change
    add_column :posts, :article_published_time, :datetime
    add_column :posts, :article_locale, :string
  end
end
