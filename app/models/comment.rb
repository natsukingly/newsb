class Comment < ApplicationRecord
	belongs_to :post
	counter_culture :post
	
	belongs_to :user
	has_many :likes, as: :likeable
	has_many :replies
	has_many :reports, as: :reportable, dependent: :delete_all
	
	after_create :issue_notification
	after_create :issue_notification_for_comments
	after_create :add_e_indecator
	
	before_destroy :destroy_related_notifications
	after_destroy :reduce_e_indecator
	
	
	
	def issue_notification
		news_title = self.post.article.title.truncate(30)
		case self.post.user.language.code
		when "ja"
			message = "<span> #{self.user.name} </span>#{ I18n.t('notification.comment', locale: :ja)}<span> \"#{news_title}\" </span>"
		when "en"
			message = "<span> #{self.user.name} </span>#{ I18n.t('notification.comment', locale: :en)}<span> \"#{news_title}\" </span>"
		end
		unless self.user_id == self.post.user_id
			post_path = Rails.application.routes.url_helpers.post_path(country: self.post.country.name, id: self.post.id)
			notification = Notification.new(user_id: self.post.user_id,
											path: post_path,
											notification_type: "Comment",
											target_user_id: self.user_id,
											post_id: self.post.id,
											message: message,
											comment_id: self.id)
			notification.save
		end
	end
	
	def issue_notification_for_comments
		post_path = Rails.application.routes.url_helpers.post_path(country: self.post.country.name, id: self.post.id)
		post_content = self.post.content.truncate(30)
		case self.post.user.language.code
		when "ja"
			comment_comment_message = "<span> #{self.user.name} </span>#{ I18n.t('notification.comment-comment', locale: :ja)}<span> \"#{post_content}\" </span>"
		when "en"
			comment_comment_message = "<span> #{self.user.name} </span>#{ I18n.t('notification.comment-comment', locale: :en)}<span> \"#{post_content}\" </span>"
		end		
		
		comment_user_ids = self.post.comments.pluck(:user_id).uniq
		if comment_user_ids.any?
			comment_user_ids.each do |comment_user_id|
				unless comment_user_id == self.user_id
					notification = Notification.new(user_id: comment_user_id,
													path: post_path,
													notification_type: "Comment-Comment",
													target_user_id: self.user_id,
													post_id: self.post.id,
													message: comment_comment_message,
													comment_id: self.id)
					notification.save
				end
			end
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
