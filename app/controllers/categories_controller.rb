class CategoriesController < ApplicationController
	before_action :set_category
	before_action :set_new_users, only: [:all_posts, :top, :articles]
	before_action :set_current_topic_for_all, only: [:top]
	before_action :set_current_topic_for_all_posts, only: [:all_posts]

	def all_posts
		if @country.id == 1
			@posts = Post.order(created_at: :desc).includes(:user, :article)
		else
			@posts = Post.where(country_id: @country.id).order(created_at: :desc).includes(:user, :article)
		end
		
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
		@recent_post = Post.where(country_id: @country.id).last
		if @country.id == 1
			@articles = Article.order(likes_count: :desc)
		else
			@articles = Article.where(country_id: @country.id).order(likes_count: :desc)
		end
	end
	
	def articles
		@recent_post = Post.where(country_id: @country.id, category_id: @category.id).last
		if @country.id == 1
			@articles = @category.articles.order(likes_count: :desc).limit(10)
		else 
			@articles = @category.articles.where(country_id: @country.id).order(likes_count: :desc).limit(10)
		end
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

end
