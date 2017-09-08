class RemoveArticleTitleAndArticleImageAndArticleUrlAndArticleSiteAndArticlePublishedTimeAndArticleLocaleFromPosts < ActiveRecord::Migration[5.1]
  
  def self.up
    remove_column :posts, :article_title
    remove_column :posts, :article_image
    remove_column :posts, :article_url
    remove_column :posts, :article_site
    remove_column :posts, :article_published_time
    remove_column :posts, :article_locale
  end
  
  def self.down
    add_column :posts, :article_title, :string
    add_column :posts, :article_image, :string
    add_column :posts, :article_url, :string
    add_column :posts, :article_site, :string
    add_column :posts, :article_published_time, :datetime
    add_column :posts, :article_locale, :string
  end
end
