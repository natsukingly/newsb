class Post < ApplicationRecord
	belongs_to :user
	belongs_to :country
	belongs_to :category
	belongs_to :article
	
	counter_culture :article
	has_many :likes, as: :likeable, dependent: :destroy
	has_many :comments
	has_many :tagged_posts, dependent: :destroy
	has_many :tags, through: :tagged_posts
	
	scope :popularTags, ->tag_ids { where(tags: article_ids).group(:tag_id).order('count(article_id) desc').pluck(:tag_id) }

	after_create :issue_feed_notifications
	after_create :post_on_sns

	after_create do
		post = Post.find_by(id: self.id)
		hashtags = self.content.scan(/#\w+/)
		hashtags.uniq.map do |hashtag|
		  tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'), country_id: post.country.id)
		  tagged_post = post.tagged_posts.build(tag_id: tag.id)
		  tagged_post.save
		end
	end
  
 
	before_update do
		post = Post.find_by(id: self.id)
		post.tags.clear
		hashtags = self.content.scan(/#\w+/)
		hashtags.uniq.map do |hashtag|
		  tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#'), country_id: post.country.id)
		  tagged_post = post.tagged_posts.build(tag_id: tag.id)
		  tagged_post.save
		end
	end
	
	def issue_feed_notifications
		follower_ids = self.user.followers.pluck(:id)
		unless follower_ids.empty?
			follower_ids.each do |user_id|
				# replyした人をのぞく
				feed_notification = FeedNotification.new(user_id: user_id,
												post_id: self.id,
												country_id: self.country_id)
				feed_notification.save
			end
		end
	end
	
	def post_on_sns
		if self.user.facebook_post == true
			require "koala"
			access_token = self.user.social_profile(:facebook).access_token
			@api = Koala::Facebook::API.new(access_token)
			@api.put_wall_post(self.content, {
				"type": "article",
				"name" => "NEWSB",
				"link" => "https://news-party-natsukingly.c9users.io/articles/#{article.id}",
				"caption" => self.article.title,
				"description" => "NEWSB: The most social news platform in the world",
				"picture" => "https://news-party-natsukingly.c9users.io#{asset_path_in_model(article.image.url)}"
			})
		end
	end
	
	
	def best_comment
		#This sentence below returns an array.
		if self.comments.nil?
			return self.comments.last
		end	
		return self.comments.order(likes_count: :asc).first
	end
	
	private
		def asset_path_in_model(url)
			ActionController::Base.helpers.asset_path(url)
		end
end
