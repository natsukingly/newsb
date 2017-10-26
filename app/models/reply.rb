class Reply < ApplicationRecord
	belongs_to :comment
	counter_culture :comment
	
	belongs_to :user
	has_many :likes, as: :likeable
	
	after_create :issue_notification
	after_create :issue_notification_reply
	before_destroy :destroy_related_notifications
	
	
	def issue_notification
		unless self.user_id == self.comment.user_id
			notification = Notification.new(user_id: self.comment.user_id,
											path: "/posts/#{self.comment.post_id}",
											notification_type: "Reply",
											target_user_id: self.user_id,
											post_id: self.comment.post_id,
											comment_id: self.comment_id,
											reply_id: self.id)
			news_title = self.comment.post.article.title.truncate(30)
			notification.message = "<span> #{self.user.name} </span> replied to your comment.<span> #{news_title} </span>"
			notification.save
		end
	end
	
	def issue_notification_reply
		other_reply_user_ids = self.comment.replies.pluck(:user_id).uniq.without(self.user_id).without(self.comment.user_id)
		other_reply_user_ids.each do |user_id|
			# replyした人をのぞく
			notification = Notification.new(user_id: user_id,
											path: "/posts/#{self.comment.post_id}",
											notification_type: "Reply-Reply",
											target_user_id: self.user_id,
											post_id: self.comment.post_id,
											comment_id: self.comment_id,
											reply_id: self.id)
			news_title = self.comment.post.article.title.truncate(30)
			notification.message = "<span> #{self.user.name} </span> replied to the same comment.<span> #{news_title} </span>"
			notification.save
		end
	end
	
	def destroy_related_notifications
		notifications = Notification.where(reply_id: self.id)
		notifications.delete_all
	end
end
