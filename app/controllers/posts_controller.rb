class PostsController < ApplicationController
	before_action :set_post, only: [:show, :edit,:create_report]
	before_action :set_post_from_form, only: [:update, :destroy]
	before_action :yes_found
	before_action :set_category, only: [:load_url]
	before_action :set_new_users, only: [:show]
	before_action :set_side_articles, only: [:show]
	before_action :authenticate, only: [:create, :create_from_modal, :create_report]
	before_action -> { authenticate_user(@post, article_path(@post.article_id)) }, only: [:update, :destroy]
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
    	hashtag_regex = /[#＃][Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+/
		input = params[:input].scan(hashtag_regex)
		@last_word = input[0]
		@form = params[:form]
		@country_id = params[:country_id]
		@autocomplete_tag_lists = Tag.where(country_id: @country_id).where('LOWER(name) LIKE(?)', "#{@last_word.downcase.delete('#').delete('＃')}%").limit(5)
	end


	def load_url
		parseURL
		@post = Post.new
		@article = Article.new
		
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
	
	def load_url_mobile
		parseURL
		@post = Post.new
		@article = Article.new
	end
 
 
	
	def edit
	end


	# def after_save_draft
	# 	# flash.now[:notice] = "Your post has been saved. You can access to the draft page from user menu."
	# 	respond_to do |format|
	# 	  format.js {  flash.now[:notice] = "hello?" }
	# 	end
	# end
	
	def create
		create_article_and_post
	end
	
	def create_from_article
		@article = Article.find(params[:post][:article_id].to_i)
		shared_article = current_user.posts.where(article_id: @article.id, content: "").any?
		if shared_article == true && params[:post][:content] == ""
			flash[:alert] = t('flash.post.already_shared')
			redirect_to article_path(@article.id)
		else
			@post = @article.posts.build(user_id: current_user.id,
							country_id: @country.id,
							content: params[:post][:content],
							category_id: @article.category_id)	
			unless params[:post][:tagged_user_ids].nil?
				@post.tagged_user_ids = params[:post][:tagged_user_ids].split(",")
			end
			if @post.save
				flash[:notice] = t('flash.post.create_success')
				redirect_to article_path(@article.id)
			else 
				
				flash[:alert] = t('flash.post.create_fail')
				redirect_to article_path(@article.id)
			end
		end		
	end
	
	def create_from_modal
		create_article_and_post
		flash[:notice] = t('flash.post.create_success')
		redirect_to article_path(@post.article.id)
		
	end

	def update
		@post.content = params[:post][:content] 
		if @post.save
			flash[:notice] = t('flash.post.update_success')
			if @post.article
				redirect_to article_path(@post.article_id)
			else
				redirect_to @post
			end
		else
			flash[:alert] = t('flash.post.update_fail')
			if @post.article
				redirect_to article_path(@post.article_id)
			else
				redirect_to @post
			end
		end
		
	end
	
	def change_comment_permission
		@post = Post.find(params[:id])
		if @post.comment_permission == true
			@post.comment_permission = false
			@post.save
			flash[:notice] = t('flash.post.deny_comment_permission')
		else
			@post.comment_permission = true
			@post.save
			flash[:notice] = t('flash.post.allow_comment_permission')
		end
		redirect_to @post
	end
	
	def search_users_to_tag
		keyword = params[:keyword].delete(' ,　')
		# @users_to_tag = User.all
		suggestion = false
		selected_user_ids = params[:selected_users].split(',')
		
		if keyword == ''
			@users_to_tag = []
			@selected_users = User.all.where(id: selected_user_ids)
		else
			@users_to_tag = current_user.followers.where('LOWER(name) LIKE(?)', "%#{keyword.downcase}%").where.not(id: selected_user_ids).limit(20)
			@selected_users = User.all.where(id: selected_user_ids)
		end
	end
	
	def already_tagged_users
		post_id = params[:post_id].to_i
		@already_tagged_users_ids = Post.find(post_id).tagged_user_ids
		@already_tagged_users = @already_tagged_users_ids.map{|id| User.find(id) }
		@already_tagged_users_ids_json = @already_tagged_users_ids.join(',').html_safe
	end
	
	
	def destroy
		article_id = @post.article_id
		if @post.destroy
			flash[:notice] = t('flash.post.delete_success')
			redirect_to article_path(article_id)
		else 
			flash[:alert] = t('flash.post.delete_fail')
			redirect_to article_path(article_id)
		end
	end


	private

		
		def set_post
			@post = Post.find(params[:id])
		end
		
		def set_post_from_form
			@post = Post.find(params[:post][:id])
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
			
			@article_url = params[:placeholder_url].delete(' ,　')
			
			url = @article_url
			charset = nil
			html = open(url, 'User-Agent' => 'firefox', :read_timeout => 10) do |f|
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
			elsif !(doc.css('//meta[name="twitter:site"]/@content').empty?)
				@article_source = doc.css('//meta[name="twitter:site"]/@content').to_s
			else
				@article_source = doc.title.to_s
			end
			#SITE_IMAGE
			unless doc.css('//meta[property="og:image"]/@content').empty? || doc.css('//meta[property="og:image"]/@content').empty?
				@article_image = doc.css('//meta[property="og:image"]/@content').to_s
			end
			
			#keywords
			unless doc.css('//meta[name="keywords"]/@content').empty?
				@article_keywords = doc.css('//meta[name="keywords"]/@content').to_s
			end
			
			#description
			if !(doc.css('//meta[name="description"]/@content').empty?)
				@article_description = doc.css('//meta[name="description"]/@content').to_s
			elsif !(doc.css('//meta[property="og:description"]/@content').empty?)
				@article_description = doc.css('//meta[property="og:description"]/@content').to_s
			end			
			
			#PUBLISHED_TIME
			if !(doc.css('//meta[property="article:modified_time"]/@content').empty?)
				@article_published_time = doc.css('//meta[property="article:modified_time"]/@content').to_s
			elsif !(doc.css('//meta[property="article:published_time"]/@content').empty?)
				@article_published_time = doc.css('//meta[property="article:published_time"]/@content').to_s
			elsif !(doc.css('//meta[property="article:published"]/@content').empty?)
				@article_published_time = doc.css('//meta[property="article:published"]/@content').to_s
			elsif !(doc.css('//meta[name="pubdate"]/@content').empty?)
				@article_published_time = doc.css('//meta[name="pubdate"]/@content').to_s
			#for netarika & buzzfeed
			elsif !(doc.css('//meta[name="epoch-publish-date-seconds"]/@content').empty?)
				time = doc.css('//meta[name="epoch-publish-date-seconds"]/@content').to_s
				@article_published_time = Time.at(time.to_i)
			#for techcrunch
			elsif !(doc.css('//meta[name="sailthru.date"]/@content').empty?)
				@article_published_time = doc.css('//meta[name="sailthru.date"]/@content').to_s
			#for NHK
			elsif !(doc.css('#main article.module--detail time').empty?)

				@article_published_time = doc.css('#main article.module--detail time').attribute("datetime").to_s
			#for excite news and gunosy
			elsif !(doc.css('//meta[itemprop="datePublished"]/@content').empty?)
				@article_published_time = doc.css('//meta[itemprop="datePublished"]/@content').to_s
			#for line blog
			elsif !(doc.css('time[itemprop="datePublished"]/@datetime').empty?)
				@article_published_time = doc.css('time[itemprop="datePublished"]/@datetime').to_s
			#for tabilabo
			elsif !(doc.css('.contents-container .article-date').empty?)
				time = doc.css('.contents-container .article-date').to_s
				@article_published_time = DateTime.parse(time)
			#for record china
			elsif !(doc.css('#contents #microtime/@value').empty?)
				@article_published_time = doc.css('#contents #microtime/@value').to_s
			#for diamond online
			elsif !(doc.css('header.article-header time').empty?)
				time = doc.css('header.article-header time').to_s
				@article_published_time = DateTime.parse(time)
			else
				@article_published_time = ''
			end
			if  @article_published_time.to_i > 3000
				 @article_published_time = Time.at(@article_published_time.to_i)
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
				if params[:article][:image].to_s == ''
					@article.image = "no_image.jpeg"
				else
					@article.remote_image_url = params[:article][:image]
				end
				@article.category_id = params[:post][:category_id].to_i
				@article.country_id = @country.id
				
				article_keywords = params[:article][:keywords]
				unless article_keywords.empty?
					keywords_regex = /[Ａ-Ｚａ-ｚA-Za-z一-鿆0-9０-９ぁ-ヶｦ-ﾟー]+/
					keywords = article_keywords.scan(keywords_regex)
					keywords = "{#{ keywords.uniq.map {|keyword| "#{ keyword }" }.join(",") }}"
					@article.keywords = keywords
				end
				@article.description = params[:article][:description].to_s
				
				if @article.save
					
				else
					if @article.errors[:image].any?
						@article.remote_image_url = "http://www.newsbeee.com/images/no_image.jpeg"
						@article.save
					else
							
						
					end
				end

			end
	
			shared_article = current_user.posts.where(article_id: @article.id, content: "").any?
			if shared_article == true && params[:post][:content] == ""
				flash[:notice] = t('flash.post.already_shared')
				redirect_to root_path
			else
				
				@post = current_user.posts.build(article_id: @article.id)
				@post.category_id = params[:post][:category_id].to_i
				@post.country_id = @country.id
				@post.content = params[:post][:content]
				unless params[:post][:tagged_user_ids].nil?
					@post.tagged_user_ids = params[:post][:tagged_user_ids].split(",")
				end

				if @post.save
					unless @post.article.category_lock == true
						decide_category
					end
					flash[:notice] = t('flash.post.create_success')
					redirect_to article_path(@post.article_id)
				else
					flash[:alert] = t('flash.post.create_fail')
					redirect_to root_path
				end
			end
		end

		# def save_draft
		# 	@article = Article.where(country_id: @country.id).find_by(title: params[:article][:title]) || Article.where(country_id: @country.id).find_by(url: params[:article][:url])
			
		# 	if @article == nil
		# 		@article = Article.new(article_params)
		# 		if params[:article][:image].to_s == "no_image"
		# 			@article.image = "no_image.jpeg"
		# 		else
		# 			@article.remote_image_url = params[:article][:image].gsub('http:','https:')
		# 		end
		# 		@article.category_id = params[:post][:category_id].to_i
		# 		@article.country_id = @country.id
		# 		@article.save
		# 	end
			
		# 	#save post
		# 	@post_draft = current_user.post_drafts.build(article_id: @article.id)
		# 	@post_draft.category_id = params[:post][:category_id].to_i
		# 	@post_draft.country_id = @country.id
		# 	@post_draft.content = params[:post][:content]
		# 	@post_draft.fake_news_report = params[:post][:fake_news_report] || false
		# 	@post_draft.save
			
		# 	decide_category
		# end
		
		def set_side_articles
			if @post.article
				@side_articles = Article.where(category_id: @post.article.category_id, country_id: @post.country_id).where.not(id: @post.article.id).order(e_indecator: :desc).limit(5)
			else
				@side_articles = Article.where(country_id: @post.country_id).order(e_indecator: :desc).limit(5)	
			end
		end
end
