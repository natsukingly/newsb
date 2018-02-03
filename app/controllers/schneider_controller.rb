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
		
		# forbes_business
		# forbes_startup
		# bridge_startup
		# techcrunch_startup
		# itmedia_tech
		# techcrunch_tech1
		# techcrunch_tech2
		# asahi_politics
		
		# cannot be loaded==============
		# yomiuri_politics
		
		redirect_to drafts_admins_path
	end
	
	def forbes_business
		AutoPostRecord.create(site_name: "forbes_business")
		set_doc("https://forbesjapan.com/category/lists/business?cx_hamburger=business")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Business").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_draft(url, category_id, country_id)
			create_shares(@article)
		end
		
		redirect_to drafts_admins_path
	end
	
	def forbes_startup
		AutoPostRecord.create(site_name: "forbes_startup")
		set_doc("https://forbesjapan.com/category/lists/entrepreneurs?cx_hamburger=entrepreneurs")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Startup").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_draft(url, category_id, country_id)
			create_shares(@article)
		end
		redirect_to drafts_admins_path
	end
	
	
	def bridge_startup
		AutoPostRecord.create(site_name: "bridge_startup")
		set_doc("http://thebridge.jp/")
		
		@count = @doc.css('.post .entry-title a').count
		@urls = @doc.css('.post .entry-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Startup").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_draft(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end
	
	def itmedia_tech
		AutoPostRecord.create(site_name: "itmedia_tech")
		set_doc("http://www.itmedia.co.jp/")
		
		@count = @doc.css('#colBoxTopStoriesTop .colBoxTitle a').count
		@urls = @doc.css('#colBoxTopStoriesTop .colBoxTitle a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_draft(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end

	def techcrunch_startup
		AutoPostRecord.create(site_name: "techcrunch_startup")
		set_doc("http://jp.techcrunch.com/startups/")
		
		@count = @doc.css('li.river-block .post-title a').count
		@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Startup").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_draft(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end

	def techcrunch_tech1
		AutoPostRecord.create(site_name: "techcrunch_tech1")
		set_doc("http://jp.techcrunch.com/mobile/")
		
		@count = @doc.css('li.river-block .post-title a').count
		@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_draft(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	def techcrunch_tech2
		AutoPostRecord.create(site_name: "techcrunch_tech2")
		set_doc("http://jp.techcrunch.com/%E3%82%AC%E3%82%B8%E3%82%A7%E3%83%83%E3%83%88/")
		
		@count = @doc.css('li.river-block .post-title a').count
		@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_draft(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	def asahi_politics
		AutoPostRecord.create(site_name: "asahi_politics")
		set_doc("http://www.asahi.com/politics/list/")
		
		@asahi_count = @doc.css('.SectionFst li a').count
		@urls = @doc.css('.SectionFst li a').map{ |url| url.attribute("href").to_s}
		
		
		category_id = Category.find_by(name: "Politics").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			url = "https://www.asahi.com" + url 
			parseURL(url)
			create_draft(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	private 
		# def forbes_business
		# 	set_doc("https://forbesjapan.com/category/lists/business?cx_hamburger=business")
			
		# 	@count = @doc.css('.stream-article .article-image').count
		# 	@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
			
		# 	category_id = Category.find_by(name: "Business").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end
		# end
		
		# def forbes_startup
		# 	set_doc("https://forbesjapan.com/category/lists/entrepreneurs?cx_hamburger=entrepreneurs")
			
		# 	@count = @doc.css('.stream-article .article-image').count
		# 	@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
			
		# 	category_id = Category.find_by(name: "Startup").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end
		# end
		
		
		# def bridge_startup
		# 	set_doc("http://thebridge.jp/")
			
		# 	@count = @doc.css('.post .entry-title a').count
		# 	@urls = @doc.css('.post .entry-title a').map{ |url| url.attribute("href").to_s}	
			
		# 	category_id = Category.find_by(name: "Startup").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end			
		# end
		
		# def itmedia_tech
		# 	set_doc("http://www.itmedia.co.jp/")
			
		# 	@count = @doc.css('#colBoxTopStoriesTop .colBoxTitle a').count
		# 	@urls = @doc.css('#colBoxTopStoriesTop .colBoxTitle a').map{ |url| url.attribute("href").to_s}	
			
		# 	category_id = Category.find_by(name: "Tech").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end		
		# end

		# def techcrunch_startup
		# 	set_doc("http://jp.techcrunch.com/startups/")
			
		# 	@count = @doc.css('li.river-block .post-title a').count
		# 	@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
			
		# 	category_id = Category.find_by(name: "Startup").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end		
		# end

		# def techcrunch_tech1
		# 	set_doc("http://jp.techcrunch.com/mobile/")
			
		# 	@count = @doc.css('li.river-block .post-title a').count
		# 	@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
			
		# 	category_id = Category.find_by(name: "Tech").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end		
		# end	
		
		# def techcrunch_tech2
		# 	set_doc("http://jp.techcrunch.com/%E3%82%AC%E3%82%B8%E3%82%A7%E3%83%83%E3%83%88/")
			
		# 	@count = @doc.css('li.river-block .post-title a').count
		# 	@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
			
		# 	category_id = Category.find_by(name: "Tech").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end		
		# end	
		
		# def asahi_politics
		# 	set_doc("http://www.asahi.com/politics/list/")
			
		# 	@asahi_count = @doc.css('.SectionFst li a').count
		# 	@urls = @doc.css('.SectionFst li a').map{ |url| url.attribute("href").to_s}
			
			
		# 	category_id = Category.find_by(name: "Politics").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		url = "https://www.asahi.com" + url 
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end		
		# end	
		
		# def yomiuri_politics
		# 	set_doc("http://www.yomiuri.co.jp/politics/")
			
		# 	@asahi_count = @doc.css('.span-main-inr li > a').count
		# 	@urls = @doc.css('.span-main-inr li > a').map{ |url| url.attribute("href").to_s}
			
			
		# 	category_id = Category.find_by(name: "Politics").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end		
		# end	
		
		# def hhk_politics
		# 	set_doc("https://www3.nhk.or.jp/news/cat04.html?utm_int=all_header_menu_news-politics")
			
		# 	@nhk_count = @doc.css('#main li a').count
		# 	@urls = @doc.css('#main li a').map{ |url| url.attribute("href").to_s}
			
		# 	category_id = Category.find_by(name: "Politics").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	flash[:notice] = @nhk_count
			
		# 	@urls.each do |url|
		# 		url = "https://www3.nhk.or.jp" + url 
		# 		parseURL(url)
		# 		create_draft(url, category_id, country_id)
		# 	end		
		# end	

		
		
		def set_doc(site_url)
			charset = nil
			html = open(site_url, 'User-Agent' => 'firefox', redirect: true) do |f|
				charset = f.charset # 文字種別を取得
				f.read # htmlを読み込んで変数htmlに渡す
			end
			# ノコギリを使ってhtmlを解析
			@doc = Nokogiri::HTML.parse(html, charset)
		end
		
		def create_draft(url, category_id, country_id)
			if @article_published_time != nil 
				@article = Article.where(country_id: country_id).find_by(title: @article_title) || Article.where(country_id: country_id).find_by(url: url)
				
				# check if the article already exist
				if @article == nil
					@article = Article.new(title: @article_title, 
											source: @article_source, 
											url: url, 
											published_time: @article_published_time,
											keywords: @article_keywords,
											description: @article_description,
											country_id: country_id,
											category_id: category_id)
					if @article_image == nil
						@article.image = "no_image.jpeg"
					else
						@article.remote_image_url = @article_image
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
		
		def create_shares(article)
			user = User.find_by(email: "newsb.sns@gmail.com")
			
			if article
				if article.keywords.nil?
					content = ''
				else
					content = article.keywords.delete("{}").split(',').map{ |keyword| "#" + keyword}.join(' ') 
				end	
				
				if user 
					post = article.posts.build(user_id: user.id,
												country_id: article.country_id,
												category_id: article.category_id,
												content: content,
												comment_permission: false)
					post.save
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
			
			#keywords
			unless doc.css('//meta[name="keywords"]/@content').empty?
				@article_keywords = doc.css('//meta[name="keywords"]/@content')
			end		
			
			unless doc.css('//meta[name="description"]/@content').empty?
				@article_description = doc.css('//meta[name="description"]/@content')
			end	
			
			#PUBLISHED_TIME
			if !(doc.css('//meta[property="article:published_time"]/@content').empty?)
				@article_published_time = doc.css('//meta[property="article:published_time"]/@content').to_s
			elsif !(doc.css('//meta[property="article:published"]/@content').empty?)
				@article_published_time = doc.css('//meta[property="article:published"]/@content').to_s
			elsif !(doc.css('//meta[name="pubdate"]/@content').empty?)
				@article_published_time = doc.css('//meta[name="pubdate"]/@content').to_s
			else
				@article_published_time = ''
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
