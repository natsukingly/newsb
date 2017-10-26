class Like < ApplicationRecord
	belongs_to :likeable, polymorphic: true
	belongs_to :user
	after_create :issue_notification
	before_destroy :destroy_notification
  
  
	def issue_notification
		
		if self.likeable_type == "Post"
			post_summary = self.likeable.content.truncate(30)
			notification = Notification.new(user_id: self.likeable.user_id,
											target_user_id: self.user_id,
											path: "/posts/#{self.likeable.id}",
											message: "<span> #{self.user.name} </span> liked your post.<span> \"#{post_summary}\" </span> ",
											post_id: self.likeable.id,
											notification_type: "Like-Post")
		elsif self.likeable_type == "Comment"
			comment_summary = self.likeable.content.truncate(30)
			notification = Notification.new(user_id: self.likeable.user_id,
											target_user_id: self.user_id,
											path: "/posts/#{self.likeable.post_id}",
											message: "<span> #{self.user.name} </span> liked your comment.<span> \"#{comment_summary}\" </span>",
											post_id: self.likeable.post_id,
											comment_id: self.likeable.id,
											notification_type: "Like-Comment")
		else
			reply_summary = self.likeable.content.truncate(30)
			notification = Notification.new(user_id: self.likeable.user_id,
											target_user_id: self.user_id,
											path: "/posts/#{self.likeable.comment.post_id}",
											message: "<span> #{self.user.name} </span> liked your comment.<span> \"#{reply_summary}\" </span>",
											post_id: self.likeable.comment.post_id,
											comment_id: self.likeable.comment_id,
											reply_id: self.likeable.id,
											notification_type: "Like-Reply")
		end
		notification.save
	end
	
	def destroy_notification
		if self.likeable_type == "Post"
			notification = Notification.find_by(user_id: self.likeable.user_id,
											target_user_id: self.user_id,
											post_id: self.likeable.id,
											notification_type: "Like-Post")
		elsif self.likeable_type == "Comment"
			notification = Notification.find_by(user_id: self.likeable.user_id,
											target_user_id: self.user_id,
											comment_id: self.likeable.id,
											notification_type: "Like-Comment")
		else
			notification = Notification.find_by(user_id: self.likeable.user_id,
											target_user_id: self.user_id,
											reply_id: self.likeable.id,
											notification_type: "Like-Reply")
		end
		if notification
			notification.destroy
		end
	end
end
