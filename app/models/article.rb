class Article < ApplicationRecord
    mount_uploader :image, ArticleImageUploader
    has_many :posts
    has_many :likes
end
