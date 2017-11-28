class Article < ApplicationRecord
    mount_uploader :image, ArticleImageUploader
    has_many :posts
    has_many :post_drafts
    has_many :likes
    
    belongs_to :country
    belongs_to :category
    
    scope :published_today, -> { where("published_time >= ?", Time.zone.now.beginning_of_day) }

end
