class LikePost < ApplicationRecord
    belongs_to :user
    counter_culture :user, column_name: "liked_count"
    counter_culture :user, column_name: "weekly_liked_count"
    belongs_to :post
    belongs_to :article
    counter_culture :post, column_name: "likes_count"
    counter_culture :article, column_name: "likes_count"
end
