class Reply < ApplicationRecord
    belongs_to :comment
    counter_culture :comment
    
    belongs_to :user
    has_many :likes, as: :likeable
    
    scope :sortByLikes, ->ids {where(id: ids).sort_by{ |o| ids.index(o.id) }}
end
