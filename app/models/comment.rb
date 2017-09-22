class Comment < ApplicationRecord
	belongs_to :post
	counter_culture :post
	
	belongs_to :user
	has_many :like_comments
	has_many :replies
	
	scope :sortByLikes, ->ids {where(id: ids).sort_by{ |o| ids.index(o.id) }}

	
end
