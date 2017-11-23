class Category < ApplicationRecord
    has_many :posts
    has_many :post_drafts
    has_many :articles
end
