class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit, :update, :destroy, :edit_article_post, :update_article_post, :cancel_edit_article_post]
	before_action :yes_found
	before_action :set_category, only: [:load_url]
	before_action :set_new_users, only: [:show]
	after_action :decide_category, only: [:create, :update]
	after_action :not_found, only: [:index, :load_more]


	def index
		@post = Post.new
		@posts = Post.includes([:user, :article]).order(created_at: :desc).limit(5)
	end
	
	
	def load_more
		existing_posts = params[:existing_posts]
		@posts = Post.includes([:user, :article, :comments]).order(created_at: :desc).offset(existing_posts).limit(5)
	end
	
	
	def show
	end
	
	
	def autocomplete_tags
		# to deal with consecutive words and new lines without spacing
		input = params[:input].scan(/#\w+/)
		@last_word = input[0]
		
		@autocomplete_tag_lists = Tag.where('LOWER(name) LIKE(?)', "%#{@last_word.downcase.delete('#')}%").limit(5)
	end


	def load_url
		parseURL
		@post = Post.new
		@article = Article.new
		@category_id = @category.id
	end
	
	def load_url_feed
		parseURL
		@post = Post.new
		@article = Article.new
	end
	
	def load_url_modal
		parseURL
		@post = Post.new
		@article = Article.new
	end
 
	
	def edit
	end
	
	def edit_article_post
	end
	
	def cancel_edit_article_post
	end

	def after_save_draft
		# flash.now[:notice] = "Your post has been saved. You can access to the draft page from user menu."
		respond_to do |format|
	      format.js {  flash.now[:notice] = "hello?" }
	    end
	end
	
	def create
		if params[:commit] == "POST"
			create_article_and_post
			flash[:notice] = "You have successfully published your post."
			redirect_to article_path(@post.article.id)
			
		elsif params[:commit] == "SAVE"
			save_draft
			flash[:notice] = "You have successfully saved your draft."
			render :after_save_draft
		end
	end
	
	def create_from_modal

		create_article_and_post
		flash[:notice] = "Your have successfully published your post."
		redirect_to all_posts_categories_path
	end
	
	
	
	def create_article_post
		@article = Article.find(params[:id])
		@post = @article.posts.build(content: params[:post][:content], 
																category_id: @article.category_id,
																user_id: current_user.id,
																country_id: @country.id)
		@post.save
		flash[:notice] = "Your have successfully published your post."
		redirect_to @article
	end


	def update
		@post.fake_news_report = params[:post][:fake_news_report] || false
		@post.content = params[:post][:content] 
		@post.save
	end
	
	def update_article_post
		@post.fake_news_report = params[:post][:fake_news_report] || false
		@post.content = params[:post][:content] 
		@post.save
		flash[:notice] = "Your post has been updated."
		redirect_to article_path(@post.article.id)
	end


	def destroy
		@post.destroy
		flash[:notice] = "Your post has been successfully deleted."
		redirect_to root_path
	end


	private
		def set_post
			@post = Post.find(params[:id])
		end
		
		def set_category
			if params[:category_id]
					@category = Category.find(params[:category_id].to_i)
			end
		end

		def post_params
			params.require(:post).permit(:content, :category_id)
		end
		
		def article_params
			params.require(:article).permit(:title, :source, :url, :published_time)
		end
		
		#this happens when there is no more contents to render
		def not_found
			if @posts.empty?
				@not_found = true
			end
		end
		
		
		#get article info using nokogiri gem
		def parseURL
			@article_url = params[:placeholder_url]
			url = @article_url
			charset = nil
			html = open(url, 'User-Agent' => 'firefox') do |f|
				charset = f.charset # 文字種別を取得
				f.read # htmlを読み込んで変数htmlに渡す
			end
			# ノコギリを使ってhtmlを解析
			doc = Nokogiri::HTML.parse(html, charset)
			
			#TITLE
			if doc.css('//meta[property="og:title"]/@content').empty?
				@article_title = doc.title.to_s
			else
				@article_title = doc.css('//meta[property="og:title"]/@content').to_s
			end
			
			#SITE_NAME
			if !(doc.css('//meta[property="og:site_name"]/@content').empty?)
				@article_source = doc.css('//meta[property="og:site_name"]/@content').to_s
				
			elsif !(doc.css('//meta[name="site_name"]/@content').empty?)
				@article_source = doc.css('//meta[name="site_name"]/@content').to_s
			else
				@article_source = doc.title.to_s
			end
			
			#SITE_IMAGE
			unless doc.css('//meta[property="og:image"]/@content').empty? || doc.css('//meta[property="og:image"]/@content').empty?
				@article_image = doc.css('//meta[property="og:image"]/@content').to_s
			end
			
			#PUBLISHED_TIME
			unless doc.css('//meta[property="article:published_time"]/@content').empty?
				@article_published_time = doc.css('//meta[property="article:published_time"]/@content').to_s
			end
		end
		
		#method to determine which category the article should belong.
		#use it after creat and update
		def decide_category
			post = @post || @post_draft
			if @article.category != post.category
				a_category_count = @article.posts.where(category: @article.category).count 
				p_category_count = @article.posts.where(category: post.category).count
				if p_category_count > a_category_count
					@article.category = post.category
					@article.save
				end
			end
		end
		
		def set_new_users
			if current_user
				@new_users = User.where(country_id: @country.id).where.not(id: current_user.id).order(created_at: :desc).limit(5)
			else
				@new_users = User.where(country_id: @country.id).order(created_at: :desc).limit(5)
			end
		end
		
		def who_to_follow
			if current_user
				@new_users = User.where(country_id: @country.id).where.not(id: current_user.id).order(created_at: :desc).limit(5)
			else
				@new_users = User.where(country_id: @country.id).order(created_at: :desc).limit(5)
			end
		end
		
		def create_article_and_post
			@article = Article.where(country_id: @country.id).find_by(title: params[:article][:title]) || Article.where(country_id: @country.id).find_by(url: params[:article][:url])
			
			#save an article only when it doesnt already exist
			if @article == nil
				@article = Article.new(article_params)
				if params[:article][:image].to_s == "no_image"
					@article.image = "no_image.jpeg"
				else
					@article.remote_image_url = params[:article][:image].gsub('http:','https:')
				end
				@article.category_id = params[:post][:category_id].to_i
				@article.country_id = @country.id
				@article.save
			end
			
			#save post
			@post = current_user.posts.build(article_id: @article.id)
			@post.category_id = params[:post][:category_id].to_i
			@post.country_id = @country.id
			@post.content = params[:post][:content]
			@post.fake_news_report = params[:post][:fake_news_report] || false
			@post.save
			
			decide_category
		end
		
		def save_draft
			@article = Article.where(country_id: @country.id).find_by(title: params[:article][:title]) || Article.where(country_id: @country.id).find_by(url: params[:article][:url])
			
			if @article == nil
				@article = Article.new(article_params)
				if params[:article][:image].to_s == "no_image"
					@article.image = "no_image.jpeg"
				else
					@article.remote_image_url = params[:article][:image].gsub('http:','https:')
				end
				@article.category_id = params[:post][:category_id].to_i
				@article.country_id = @country.id
				@article.save
			end
			
			#save post
			@post_draft = current_user.post_drafts.build(article_id: @article.id)
			@post_draft.category_id = params[:post][:category_id].to_i
			@post_draft.country_id = @country.id
			@post_draft.content = params[:post][:content]
			@post_draft.fake_news_report = params[:post][:fake_news_report] || false
			@post_draft.save
			
			decide_category
		end
end
