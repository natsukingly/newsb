class TaggedPost < ApplicationRecord
    belongs_to :post
    belongs_to :tag
    counter_culture :tag, column_name: "posts_count"
    counter_culture :tag, column_name: "weekly_posts_count"
end
