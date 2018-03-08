class AutoScrollController < ApplicationController
	
	# articles
	
	def load_articles
		#featured_article = 1
		@mode = cookies[:mode] || "on"
		@existing_articles = params[:existing_articles].to_i + 1
		@loaded_articles = Article.all.where(country_id: @country.id).where("published_time >= ?", Time.zone.now.ago(2.days)).order(priority_level: :desc, e_indecator: :desc, published_time: :desc).offset(@existing_articles).limit(30)
	end
	
	def load_categorized_articles
		#featured_article = 1
		@mode = cookies[:mode] || "on"
		@existing_articles = params[:existing_articles].to_i + 1
		@loaded_articles = Article.where(country_id: @country.id, category_id: params[:category_id].to_i).where("published_time >= ?", Time.zone.now.ago(2.days)).order(priority_level: :desc, e_indecator: :desc, published_time: :desc).offset(@existing_articles).limit(30)
		
	end
	
	def load_searched_articles
		#unknown + 1, doesnt work otherwise
		@existing_articles = params[:existing_articles].to_i + 1
		@keyword = params[:keyword]
		@loaded_articles = Article.where(country_id: @country.id).where('LOWER(title) LIKE(?)', "%#{@keyword.downcase}%").order(e_indecator: :desc, published_time: :desc).offset(@existing_articles).limit(30)
	end

	# posts

	def load_posts
		user = User.find_by(email: "newsb.sns@gmail.com")
		user2 = User.find_by(email: "paprikamajorika@gmail.com")
		@existing_posts = params[:existing_posts].to_i
		@loaded_posts = Post.where(country_id: @country.id).where.not(user_id: [user, user2]).order(created_at: :desc).includes(:user, :article).offset(@existing_posts).limit(30)
	end
	
	def load_article_posts
		@existing_posts = params[:existing_posts].to_i
		@article = Article.find(params[:article_id].to_i)
		if current_user
			@your_posts = @article.posts.where(fake_news_report: false).where(user_id: current_user.id)
			@best_posts = @article.posts.where(fake_news_report: false).order(likes_count: :desc).limit(3)
			@follower_posts = @article.posts.where(fake_news_report: false).where(user_id: current_user.followers.ids).where.not(id: @best_posts.ids)
			inapplicable_ids = @your_posts.ids + @best_posts.ids + @follower_posts.ids
			
			@loaded_posts = @article.posts.where(fake_news_report: false).where.not(id: inapplicable_ids).order(created_at: :desc).offset(@existing_posts).limit(30)
		else
			@your_posts = []
			@best_posts = @article.posts.where(fake_news_report: false).order(likes_count: :desc).limit(3)
			@follower_posts = []
			inapplicable_ids = @best_posts.ids
			
			@loaded_posts = @article.posts.where(fake_news_report: false).where.not(id: inapplicable_ids).order(created_at: :desc).offset(@existing_posts).limit(30)
		end
	end
	
	def load_user_posts
		@existing_posts = params[:existing_posts].to_i
		@loaded_posts = Post.where(user_id: params[:user_id]).includes(:article).order(created_at: :desc).offset(@existing_posts).limit(30)
	end
	
	def load_searched_posts
		@existing_posts = params[:existing_posts].to_i
		@keyword = params[:keyword]
		@loaded_posts = Post.where(country_id: @country.id).where('LOWER(content) LIKE(?)', "%#{@keyword.downcase}%").order(likes_count: :desc).offset(@existing_posts).limit(30)
	end
	
	#draft
	def load_drafts
		@existing_drafts = params[:existing_drafts].to_i
		@loaded_drafts = current_user.post_drafts.order(created_at: :desc).includes(:article).offset(@existing_drafts).limit(30)
	end	
	def load_admin_drafts
		@existing_admin_drafts = params[:existing_admin_drafts].to_i
		@loaded_admin_drafts = current_user.post_drafts.where(hide: false).includes(:article).offset(@existing_admin_drafts).limit(30)
	end		
	
	
	
	# tags
	
	def load_trending_tags
		@existing_tags = params[:existing_tags].to_i
		@loaded_tags = Tag.where(country_id: @country.id).order(created_at: :desc).offset(@existing_tags).limit(30)
	end
	
	def load_favorite_tags
		@existing_tags = params[:existing_tags].to_i
		@loaded_tags = current_user.favorite_tags.order(created_at: :desc).offset(@existing_tags).limit(30)
	end
	
	def load_searched_tags
		#unknown + 1, doesnt work otherwise
		@existing_tags = params[:existing_tags].to_i + 1
		@keyword = params[:keyword]
		@loaded_tags = Tag.where(country_id: @country.id).where('LOWER(name) LIKE(?)', "%#{@keyword.downcase}%").order(created_at: :desc).offset(@existing_tags).limit(30)
	end
	
	
	#notification
	def load_notifications
		@existing_notifications = params[:existing_notifications].to_i
		@loaded_notifications = current_user.notifications.includes(:target_user).order(created_at: :desc).offset(@existing_notifications).limit(30)
	end
	def load_index_notifications
		@existing_notifications = params[:existing_notifications].to_i
		@loaded_index_notifications = current_user.notifications.includes(:target_user).order(created_at: :desc).offset(@existing_notifications).limit(30)
	end
	def load_mobile_notifications
		@existing_notifications = params[:existing_notifications].to_i
		@loaded_mobile_notifications = current_user.notifications.includes(:target_user).order(created_at: :desc).offset(@existing_notifications).limit(30)
	end
	
	
	#user
	def load_weekly_users
		@existing_users = params[:existing_users].to_i
		@loaded_users = User.where(country_id: @country.id).order(liked_count: :desc, followers_count: :desc, created_at: :asc).offset(@existing_users).limit(30)
	end
	
	def load_all_time_users
		@existing_users = params[:existing_users].to_i
		@loaded_users = User.where(country_id: @country.id).order(liked_count: :desc, followers_count: :desc, created_at: :asc).offset(@existing_users).limit(30)
	end
	
	def load_followers
		@existing_users = params[:existing_users].to_i
		@user = User.find(params[:user_id])
		@loaded_users = @user.followers.order(liked_count: :desc).offset(@existing_users).limit(30)
	end
	
	def load_following
		@existing_users = params[:existing_users].to_i
		@user = User.find(params[:user_id])
		@loaded_users = @user.following.order(liked_count: :desc).offset(@existing_users).limit(30)
	end
	
	def load_searched_users
		@existing_users = params[:existing_users].to_i
		@keyword = params[:keyword]
		@loaded_users = User.where(country_id: @country.id).where('LOWER(name) LIKE(?)', "%#{@keyword.downcase}%").order(liked_count: :desc).offset(@existing_users).limit(30)
	end
	
	
	#report
	def load_reports
		@existing_reports = params[:existing_reports].to_i
		@loaded_reports = Report.order(created_at: :desc).offset(@existing_reports).limit(30)
	end

	#public notifications
	def load_newsb_notifications
		@exsisting_notification = params[:existing_newsb_notifications].to_i
		@loaded_newsb_notifications = Notification.where(everyone: true).order(created_at: :desc).offset(@existing_newsb_notifications).limit(30)
	end
	
	
	#THINGS I NEED TO SCROLL 
	# DRAFT & POST DRAFT
	
end
