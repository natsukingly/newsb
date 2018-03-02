class Bot
	class << self
		def hello
			puts 'hello world'
		end
		def time
			puts Time.now
		end
		
		def env
			puts Rails.env.development?
		end
		
		def twitter_business
			
			user = User.find_by(email: "newsb.sns@gmail.com")
			country = Country.find_by(name: "Japan") 
			category = Category.find_by(name: "Business")
			todays_articles = category.articles.where(country_id: country.id).where("published_time >= ?", Time.now.ago(2.days)).where.not(posts_count: 0).order(priority_level: :desc, e_indecator: :desc, published_time: :desc).limit(10)
			invalid_ids = TwitterBotLog.all.order(created_at: :asc).limit(30)
			article = todays_articles.where.not(id: invalid_ids).first
			
			puts user.name
			puts country.name
			puts category.name
			puts todays_articles.first.title
			puts article.title
			
			require "twitter"
			client = Twitter::REST::Client.new do |config|
				# applicationの設定
				config.consumer_key         = ENV['TWITTER_KEY']
				config.consumer_secret      = ENV['TWITTER_SECRET']
				# ユーザー情報の設定
				access_token = user.social_profile(:twitter).access_token
				access_secret = user.social_profile(:twitter).access_secret
				config.access_token         = access_token
				config.access_token_secret  = access_secret
			end
			if Rails.env.development?
				client.update(">" + article.description.truncate(70) + " " + "https://news-party-natsukingly.c9users.io/#{self.country.name}/articles/#{self.article.id}" + " " + "#NEWSB #BusinessNews")
			elsif Rails.env.production?
				client.update(">" + article.description.truncate(70) + " " + "http://www.newsbeee.com/#{self.country.name}/articles/#{self.article.id}" + " " + "#NEWSB #BusinessNews")
			end	
			TwitterBotLog.create(article_id: article.id)
		end 

		
	end
end
