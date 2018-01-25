class Like < ApplicationRecord
	belongs_to :likeable, polymorphic: true
	counter_culture :likeable
	belongs_to :user
	
	after_create :issue_notification
	before_destroy :destroy_notification
	
	after_create :add_e_indecator
	after_destroy :reduce_e_indecator
	
  
	include Rails.application.routes.url_helpers
	def issue_notification
		post_summary = self.likeable.content.truncate(30)
		comment_summary = self.likeable.content.truncate(30)
		case self.likeable.user.language.code
		when "ja"
			post_like_message = "<span> #{self.user.name} </span>#{ I18n.t('notification.post-like', locale: :ja)}<span> \"#{post_summary}\" </span>"
			comment_like_message = "<span> #{self.user.name} </span>#{ I18n.t('notification.comment-like', locale: :ja)}<span> \"#{comment_summary}\" </span>"
		when "en"
			post_like_message = "<span> #{self.user.name} </span>#{ I18n.t('notification.post-like', locale: :en)}<span> \"#{post_summary}\" </span>"
			comment_like_message = "<span> #{self.user.name} </span>#{ I18n.t('notification.comment-like', locale: :en)}<span> \"#{comment_summary}\" </span>"
		end
		
		if self.likeable_type == "Post"
			post_path = Rails.application.routes.url_helpers.post_path(country: self.likeable.country.name, id: self.likeable.id)
			notification = Notification.new(user_id: self.likeable.user_id,
											target_user_id: self.user_id,
											path: post_path,
											message: post_like_message,
											post_id: self.likeable.id,
											notification_type: "Like-Post")
		else
			post_path = Rails.application.routes.url_helpers.post_path(country: self.likeable.post.country.name, id: self.likeable.post_id)
			notification = Notification.new(user_id: self.likeable.user_id,
											target_user_id: self.user_id,
											path: post_path,
											message: comment_like_message,
											post_id: self.likeable.post_id,
											comment_id: self.likeable.id,
											notification_type: "Like-Comment")
		end
		notification.save
	end
	
	def destroy_notification
		if self.likeable.user_id != nil && self.user_id != nil
			if self.likeable_type == "Post"
				notification = Notification.find_by(user_id: self.likeable.user_id,
												target_user_id: self.user_id,
												post_id: self.likeable.id,
												notification_type: "Like-Post")
			else
				notification = Notification.find_by(user_id: self.likeable.user_id,
												target_user_id: self.user_id,
												comment_id: self.likeable.id,
												notification_type: "Like-Comment")
			end
			if notification
				notification.destroy
			end
		end
	end
	
	def add_e_indecator
		if Like.where(likeable_id: self.likeable_id, user_id: self.user_id).count <= 5 
			article = Article.find(self.likeable.article_id)
			article.e_indecator += 1
			article.save
		end
	end
	
	def reduce_e_indecator
		if Like.where(likeable_id: self.likeable_id, user_id: self.user_id).count <= 4
			article = Article.find(self.likeable.article_id)
			article.e_indecator -= 1
			article.save
		end
	end
end
