class Post < ApplicationRecord
	belongs_to :user
	belongs_to :country
	belongs_to :category
	belongs_to :article
	
	counter_culture :article
	has_many :likes, as: :likeable, dependent: :delete_all
	has_many :comments
	has_many :tagged_posts, dependent: :destroy
	has_many :tags, through: :tagged_posts
	has_many :reports, as: :reportable, dependent: :delete_all
	
	after_create :issue_feed_notifications
	after_create :post_on_sns
	after_create :add_e_indecator
	
	after_destroy :reduce_e_indecator

	after_create do
		post = Post.find_by(id: self.id)
        hashtag_regex = /[#|＃]\w*[一-龠_ぁ-ん_ァ-ヴーａ-ｚＡ-Ｚa-zA-Z0-9]+|[#|＃]\[a-zA-Z0-9_]+|[#|＃]\[a-zA-Z0-9_]/
		hashtags = self.content.scan(hashtag_regex)
		hashtags.uniq.map do |hashtag|
		  tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#').delete('＃'), country_id: post.country.id)
		  tagged_post = post.tagged_posts.build(tag_id: tag.id)
		  tagged_post.save
		end
	end
  
 
	before_update do
		post = Post.find_by(id: self.id)
		post.tags.clear
        hashtag_regex = /[#|＃]\w*[一-龠_ぁ-ん_ァ-ヴーａ-ｚＡ-Ｚa-zA-Z0-9]+|[#|＃]\[a-zA-Z0-9_]+|[#|＃]\[a-zA-Z0-9_]/
		hashtags = self.content.scan(hashtag_regex)
		hashtags.uniq.map do |hashtag|
		  tag = Tag.find_or_create_by(name: hashtag.downcase.delete('#').delete('＃'), country_id: post.country.id)
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
	
	def add_e_indecator
		if self.article != nil && Post.where(article_id: self.article_id, user_id: self.user_id).count <= 1 
			article = Article.find(self.article_id)
			article.e_indecator += 10
			article.save
		end
	end
	
	def reduce_e_indecator
		if self.article != nil && Post.where(article_id: self.article_id, user_id: self.user_id).count == 0 
			article = Article.find(self.article_id)
			article.e_indecator -= 10
			article.save
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
				"link" => "https://news-party-natsukingly.c9users.io/#{self.country.name}/articles/#{self.article.id}",
				"caption" => self.article.title,
				"description" => "NEWSB: The most social news platform in the world",
				"picture" => "https://dev-newsb.s3.amazonaws.com#{asset_path_in_model(self.article.image.url)}"
			})
		end
		# linkedin api との協調がとれないので保留中。
		# if self.user.linkedin_post == true
		# 	require 'linkedin'
		# 	require 'json'
		# 	access_token = self.user.social_profile(:linkedin).access_token
		# 	access_secret = self.user.social_profile(:linkedin).access_secret
		# 	client = LinkedIn::Client.new(ENV['LINKEDIN_KEY'], ENV['LINKEDIN_SECRET'])
		# 	client.add_share({:comment => self.content, :content => {
		# 			"title"=> self.article.title,
		# 			"description" => "NEWSB: The most social news platform in the world",
		# 			"submitted-url" => "https://news-party-natsukingly.c9users.io/articles/#{self.article.id}",
		# 			"submitted-image-url" => "https://news-party-natsukingly.c9users.io#{asset_path_in_model(self.article.image.url)}",
		# 		}
		# 	})
		# end
		if self.user.twitter_post == true
			require "twitter"
		    client = Twitter::REST::Client.new do |config|
				# applicationの設定
				config.consumer_key         = ENV['TWITTER_KEY']
				config.consumer_secret      = ENV['TWITTER_SECRET']
				# ユーザー情報の設定
				access_token = self.user.social_profile(:twitter).access_token
				access_secret = self.user.social_profile(:twitter).access_secret
			    config.access_token         = access_token
			    config.access_token_secret  = access_secret
		    end
		    client.update(self.content.truncate(70) + " " + "https://news-party-natsukingly.c9users.io/#{self.country.name}/articles/#{self.article.id}" + " " + "#NEWSB")
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
