class Country < ApplicationRecord
    has_many :articles
    has_many :posts
    has_many :post_drafts
    has_many :tags
    has_many :users
    belongs_to :language
end
