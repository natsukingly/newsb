class Tag < ApplicationRecord
    has_many :tagged_posts, dependent: :destroy
    has_many :posts, through: :tagged_posts
    belongs_to :country
end
