class PostDraft < ApplicationRecord
    belongs_to :user
	belongs_to :country
	belongs_to :category
	belongs_to :article
	
	scope :created_today, -> { where("created_at >= ?", Time.zone.now.beginning_of_day) }
end
