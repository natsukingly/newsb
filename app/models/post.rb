class Post < ApplicationRecord
	belongs_to :user
	belongs_to :country
	belongs_to :category, optional: true
	belongs_to :article, optional: true
	
	counter_culture :article
	has_many :likes, as: :likeable, dependent: :delete_all
	has_many :comments
	has_many :tagged_posts, dependent: :destroy
	has_many :tags, through: :tagged_posts
	has_many :reports, as: :reportable, dependent: :delete_all
	
	after_create :issue_feed_notifications
	after_create :issue_notifications
	after_create :post_on_sns
	after_create :add_e_indecator
	before_update :destroy_notifications
	
	after_destroy :destroy_notifications
	after_destroy :reduce_e_indecator

	after_create do
		post = Post.find_by(id: self.id)
        hashtag_regex = /[#＃][Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+/
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
        hashtag_regex = /[#＃][Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+/
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
	
	def issue_notifications
		news_title = self.article.title.truncate(30)
		unless self.tagged_user_ids.empty?
			post_path = Rails.application.routes.url_helpers.post_path(country: self.country.name, id: self.id)
			self.tagged_user_ids.each do |tagged_user_id|
				case User.find(tagged_user_id).language.code
				when "ja"
					message = "<span> #{self.user.name} </span>#{ I18n.t('notification.tagged', locale: :ja)}<span> \"#{news_title}\" </span>"
				when "en"
					message = "<span> #{self.user.name} </span>#{ I18n.t('notification.tagged', locale: :en)}<span> \"#{news_title}\" </span>"
				end
				notification = Notification.new(user_id: tagged_user_id,
												path: post_path,
												notification_type: "Tagged",
												target_user_id: self.user_id,
												post_id: self.id,
												message: message)
				notification.save
			end
		end
	end
	
	def destroy_notifications
		notifications = Notification.all.where(notification_type: "Tagged", post_id: self.id)
		notifications.delete_all
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
			if Rails.env.development?
				link_url = "https://news-party-natsukingly.c9users.io/#{self.country.name}/articles/#{self.article.id}"
			elsif Rails.env.production?
				link_url = "http://www.newsbeee.com/#{self.country.name}/articles/#{self.article.id}"
			end
			@api.put_wall_post(self.content, {
				"type": "article",
				"name" => "Newsb!",
				"link" => link_url,
				"caption" => self.article.title,
				"description" => "Newsb!: みんなで考えるニュース",
				"picture" => self.article.image.url
			})
		end
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
		    if Rails.env.development?
		    	client.update(self.content.truncate(70) + " " + "https://news-party-natsukingly.c9users.io/#{self.country.name}/articles/#{self.article.id}" + " " + "#NEWSB!")
		    elsif Rails.env.production?
		    	client.update(self.content.truncate(70) + " " + "http://www.newsbeee.com/#{self.country.name}/articles/#{self.article.id}" + " " + "#NEWSB!")
			end	
		end
	end
	
	
	def best_comment
		#This sentence below returns an array.
		best_comment = self.comments.order(likes_count: :asc).first
		if best_comment.nil?
			return self.comments.last
		end	
		return best_comment
	end
	
	private
		def asset_path_in_model(url)
			ActionController::Base.helpers.asset_path(url)
		end
end
