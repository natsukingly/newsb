class PostDraft < ApplicationRecord
    belongs_to :user
	belongs_to :country
	belongs_to :category
	belongs_to :article
end
