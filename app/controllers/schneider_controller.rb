class SchneiderController < ApplicationController
	
	def fetch_articles
	end
	def crawl

		#forbes
		set_doc("https://forbesjapan.com/category/lists/business?cx_hamburger=business")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}
	end
	
	def prepare_admin_posts
		
		forbes_business
		forbes_startup
		redirect_to drafts_admins_path
		
	end
	
	private 
		def forbes_business
			set_doc("https://forbesjapan.com/category/lists/business?cx_hamburger=business")
			
			@count = @doc.css('.stream-article .article-image').count
			@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
			
			category_id = Category.find_by(name: "Business").id
			country_id = Country.find_by(name: "Japan").id
			
			@urls.each do |url|
				parseURL(url)
				create_draft(url, category_id, country_id)
			end
		end
		
		def forbes_startup
			set_doc("https://forbesjapan.com/category/lists/entrepreneurs?cx_hamburger=entrepreneurs")
			
			@count = @doc.css('.stream-article .article-image').count
			@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
			
			category_id = Category.find_by(name: "Startup").id
			country_id = Country.find_by(name: "Japan").id
			
			@urls.each do |url|
				parseURL(url)
				create_draft(url, category_id, country_id)
			end
		end
		
		
	
		
		def set_doc(site_url)
			charset = nil
			html = open(site_url, 'User-Agent' => 'firefox') do |f|
				charset = f.charset # 文字種別を取得
				f.read # htmlを読み込んで変数htmlに渡す
			end
			# ノコギリを使ってhtmlを解析
			@doc = Nokogiri::HTML.parse(html, charset)
		end
		
		def create_draft(url, category_id, country_id)
			
			if @article_published_time < 24.hours.ago
				@article = Article.where(country_id: country_id).find_by(title: @article_title) || Article.where(country_id: country_id).find_by(url: url)
				
				# check if the article already exist
				if @article == nil
					@article = Article.new(title: @article_title, 
											source: @article_source, 
											url: url, 
											published_time: @article_published_time,
											country_id: country_id,
											category_id: category_id)
					if @article_image == nil
						@article.image = "no_image.jpeg"
					else
						@article.remote_image_url = @article_image.gsub('http:','https:')
					end
					@article.save
				end
				
				# Create post_draft for all admin users
				User.where(admin: true).each do |user|
					unless PostDraft.where(user_id: user.id, article_id: @article.id).any? || Post.where(user_id: user.id, article_id: @article.id).any?
						@post_draft = user.post_drafts.build(article_id: @article.id)
						@post_draft.category_id = category_id
						@post_draft.country_id = country_id
						@post_draft.save
					
						decide_category
					end
				end
			end
		end
		
		def parseURL(url)
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
		
end
