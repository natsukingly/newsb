class Article < ApplicationRecord
    mount_uploader :image, ArticleImageUploader
    has_many :posts
    has_many :likes
    
    belongs_to :category

    scope :sortByLikes, ->ids {where(id: ids).sort_by{ |o| ids.index(o.id) }}
    
end
