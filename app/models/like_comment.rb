class LikeComment < ApplicationRecord
    belongs_to :user
    counter_culture :user, column_name: "liked_count"
    counter_culture :user, column_name: "weekly_liked_count"
    belongs_to :comment
    counter_culture :comment, column_name: "likes_count"
end
