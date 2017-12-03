class Comment < ApplicationRecord
	belongs_to :post
	counter_culture :post
	
	belongs_to :user
	has_many :likes, as: :likeable
	has_many :replies
	has_many :reports, as: :reportable, dependent: :delete_all
	
	after_create :issue_notification
	after_create :add_e_indecator
	
	before_destroy :destroy_related_notifications
	after_destroy :reduce_e_indecator
	
	
	
	def issue_notification
		unless self.user_id == self.post.user_id
			notification = Notification.new(user_id: self.post.user_id,
											path: post_path(self.post.id),
											notification_type: "Comment",
											target_user_id: self.user_id,
											post_id: self.post.id,
											comment_id: self.id)
			news_title = self.post.article.title.truncate(30)
			notification.message = "<span> #{self.user.name} </span> commented on your post.<span> \"#{news_title}\" </span>"
			notification.save
		end
	end
	
	def destroy_related_notifications
		notifications = Notification.where(comment_id: self.id)
		notifications.delete_all
	end
	
	
	def add_e_indecator
		if Comment.where(article_id: self.post.article_id, user_id: self.user_id).count <= 2 
			article = Article.find(self.post.article_id)
			article.e_indecator += 5
			article.save
		end
	end
	
	def reduce_e_indecator
		if Comment.where(article_id: self.post.article_id, user_id: self.user_id).count <= 1 
			article = Article.find(self.post.article_id)
			article.e_indecator -= 5
			article.save
		end
	end
end
