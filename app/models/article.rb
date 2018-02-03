class Article < ApplicationRecord
    mount_uploader :image, ArticleImageUploader
    # serialize :keywords
    
    has_many :posts
    has_many :post_drafts
    has_many :likes
    
    belongs_to :country
    belongs_to :category, optional: true
    
    scope :published_today, -> { where("published_time >= ?", Time.zone.now.beginning_of_day) }

end
