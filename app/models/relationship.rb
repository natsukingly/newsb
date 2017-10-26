class Relationship < ApplicationRecord
    
    #press follow button and plus one to following_count to current_user 
    belongs_to :follower, class_name: "User"
    counter_culture :follower, column_name: "following_count"
    
    #press follow button and plus one to following_count to target_user
    belongs_to :following, class_name: "User"
    counter_culture :following, column_name: "followers_count"
    
    after_create :issue_notification
    before_destroy :destroy_notification
    
    def issue_notification
        notification = Notification.new(user_id: self.following_id,
                                        target_user_id: self.follower_id,
                                        path: "/users/#{self.follower_id}",
                                        message: "<span> #{self.follower.name} </span> is now following you.",
                                        notification_type: "Follow")
        notification.save
    end
    
    def destroy_notification
        notification = Notification.find_by(user_id: self.following_id,
                                        target_user_id: self.follower_id,
                                        notification_type: "Follow")
        notification.destroy
    end
end
