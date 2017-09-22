class Reply < ApplicationRecord
    belongs_to :comment
    counter_culture :comment
    
    belongs_to :user
    has_many :like_replies
    
    scope :sortByLikes, ->ids {where(id: ids).sort_by{ |o| ids.index(o.id) }}
end
