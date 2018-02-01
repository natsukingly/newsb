class Relationship < ApplicationRecord
    
    #press follow button and plus one to following_count to current_user 
    belongs_to :follower, class_name: "User"
    counter_culture :follower, column_name: "following_count"
    
    #press follow button and plus one to following_count to target_user
    belongs_to :following, class_name: "User"
    counter_culture :following, column_name: "followers_count"
    
    after_create :issue_notification
    before_destroy :destroy_notification
    
    after_create :add_follower_count
    before_destroy :reduce_follower_count
    
    def issue_notification
		case self.following.language.code
		when "ja"
			message = "<span> #{self.follower.name} </span>#{ I18n.t('notification.follow', locale: :ja)}"
		when "en"
			message = "<span> #{self.follower.name} </span>#{ I18n.t('notification.follow', locale: :en)}"
		end
        user_path = Rails.application.routes.url_helpers.user_path(country: self.following.country.name, id: self.follower_id)
        notification = Notification.new(user_id: self.following_id,
                                        target_user_id: self.follower_id,
                                        path: user_path,
                                        message: message,
                                        notification_type: "Follow")
        notification.save
    end
    
    def destroy_notification
        notification = Notification.find_by(user_id: self.following_id,
                                        target_user_id: self.follower_id,
                                        notification_type: "Follow")
        if notification
            notification.destroy
        end
    end
    
    def add_follower_count
        #the one who pressed the follow button
        user = self.follower
        user.following_count = user.following_count + 1
        user.save
        
        #the one that will be followed
        user = self.following
        user.followers_count = user.followers_count + 1
        user.save        
    end
    
    def reduce_follower_count
        #the one who pressed the follow button
        user = self.follower
        user.following_count = user.following_count - 1
        user.save
        
        #the one that will be followed
        user = self.following
        unless user.followers_count == 0
            user.followers_count = user.followers_count - 1
        end
        user.save 
    end
    
end
