class Like < ApplicationRecord
    belongs_to :post, optional: true
    belongs_to :user, optional: true
    belongs_to :comment, optional: true
    belongs_to :reply, optional: true
end
