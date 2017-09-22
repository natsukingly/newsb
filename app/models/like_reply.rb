class LikeReply < ApplicationRecord
    belongs_to :user
    counter_culture :user, column_name: "liked_count"
    counter_culture :user, column_name: "weekly_liked_count"
    belongs_to :reply
    counter_culture :reply, column_name: "likes_count"
end
