class Comment < ApplicationRecord
	belongs_to :post
	counter_culture :post
	
	belongs_to :user
	has_many :likes, as: :likeable
	has_many :replies
	
	after_create :issue_notification
	before_destroy :destroy_related_notifications
	
	def issue_notification
		unless self.user_id == self.post.user_id
			notification = Notification.new(user_id: self.post.user_id,
											path: "/posts/#{self.post_id}",
											notification_type: "Comment",
											target_user_id: self.user_id,
											post_id: self.post.id,
											comment_id: self.id)
			news_title = self.post.article.title.truncate(30)
			notification.message = "<span> #{self.user.name} </span> commented on your post.<span> #{news_title} </span>"
			notification.save
		end
	end
	
	def destroy_related_notifications
		notifications = Notification.where(comment_id: self.id)
		notifications.delete_all
	end
end
