class Article < ApplicationRecord
    mount_uploader :image, ArticleImageUploader
    has_many :posts
    has_many :likes
    
    belongs_to :country
    belongs_to :category

end
