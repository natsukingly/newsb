class Country < ApplicationRecord
    has_many :articles
    has_many :posts
    has_many :tags
    has_many :users
end
