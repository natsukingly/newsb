class Reply < ApplicationRecord
    belongs_to :comment
    belongs_to :user
    has_many :likes
    
end
