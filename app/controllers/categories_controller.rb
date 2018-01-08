class CategoriesController < ApplicationController
	before_action :set_category
	before_action :set_new_users, only: [:all_posts, :articles]
	before_action :set_current_topic_for_all, only: [:top]
	before_action :set_current_topic_for_all_posts, only: [:all_posts]

	def all_posts
		@posts = Post.where(country_id: @country.id).order(created_at: :desc).includes(:user, :article).limit(30)

		if current_user && current_user.feed_notifications.any?
			current_user.feed_notifications.each do |notification|
				notification.check = "True"
				notification.save
			end
		end
	end
	
	def show
		
	end
	
	def top
		@sns_mode = cookies[:sns_mode] || "on"
		@articles = Article.all.where(country_id: @country.id).where("published_time >= ?", Time.now.ago(5.days)).where.not(posts_count: 0).order(e_indecator: :desc, published_time: :desc).limit(30)
		@featured_article = @articles.first
		unless @featured_article.nil?
			@best_post = @articles.first.posts.order(likes_count: :desc).includes(:user).limit(1).first
			@related_articles = Article.where(country_id: @country.id, category_id: @featured_article.category_id).where.not(id: @featured_article.id).limit(5)
		end
		@recent_articles = Article.where(country_id: @country.id).order(published_time: :desc).limit(5)

	end
	
	def articles
		@sns_mode = cookies[:sns_mode] || "on"
		@articles = @category.articles.where(country_id: @country.id).where("published_time >= ?", Time.now.ago(5.days)).where.not(posts_count: 0).order(e_indecator: :desc, published_time: :desc).limit(30)
		@featured_article = @articles.first
		unless @featured_article.nil?
			@best_post = @articles.first.posts.order(likes_count: :desc).includes(:user).limit(1).first
			@related_articles = Article.where(country_id: @country.id, category_id: @featured_article.category_id).where.not(id: @featured_article.id).limit(5)
		end
		@recent_articles = Article.where(country_id: @country.id).order(published_time: :desc).limit(5)
	end
	
	def posts
		if @country.id == 1
			@posts = @category.posts.includes(:user, :article).order(created_at: :desc)
		else
			@posts = @category.posts.where(country_id: @country.id).includes(:user, :article).order(created_at: :desc)
		end
	end
	
	def load_more
		existing_articles = params[:existing_articles]
		@articles = Article.all.order(likes_count: :desc).limit(5)
	end
	
	
	private 
		
		def article_not_found
			if @articles.empty?
				@not_found = true
			end
		end
		
		def save_selected_topic
			session[:selected_topic] = @category.id
		end
		
		def set_category
			if params[:id]
				@category = Category.find(params[:id])
			end
		end
		
		def set_current_topic_for_all
			@all_topic = "True"
		end
		
		def set_current_topic_for_all_posts
			@all_posts = "True"
		end
		
		def set_new_users
			if current_user
				@new_users = User.where(country_id: @country.id).where.not(id: current_user.id).order(created_at: :desc).limit(3)
			else
				@new_users = User.where(country_id: @country.id).order(created_at: :desc).limit(3)
			end
		end
		
		def set_recent_articles
		end

end
