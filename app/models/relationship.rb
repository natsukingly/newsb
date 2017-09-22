class Relationship < ApplicationRecord
    
    #press follow button and plus one to following_count to current_user 
    belongs_to :follower, class_name: "User"
    counter_culture :follower, column_name: "following_count"
    
    #press follow button and plus one to following_count to target_user
    belongs_to :following, class_name: "User"
    counter_culture :following, column_name: "followers_count"
end
