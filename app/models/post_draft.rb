class PostDraft < ApplicationRecord
    belongs_to :user
	belongs_to :country
	belongs_to :category
	belongs_to :article
	has_many :tagged_posts, dependent: :destroy
	has_many :tags, through: :tagged_posts
end
