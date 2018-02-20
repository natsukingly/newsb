class SchneiderUsaController < ApplicationController
    
	def custom
		@urls = [	{ :url => params[:article][:url1], :category_id => params[:article][:category1]	},
					{ :url => params[:article][:url2], :category_id => params[:article][:category2]	},
					{ :url => params[:article][:url3], :category_id => params[:article][:category3]	},
					{ :url => params[:article][:url4], :category_id => params[:article][:category4]	},
					{ :url => params[:article][:url5], :category_id => params[:article][:category5]	},
					{ :url => params[:article][:url6], :category_id => params[:article][:category6]	},
					{ :url => params[:article][:url7], :category_id => params[:article][:category7]	},
					{ :url => params[:article][:url8], :category_id => params[:article][:category8]	},
					{ :url => params[:article][:url9], :category_id => params[:article][:category9]	},
					{ :url => params[:article][:url10], :category_id => params[:article][:category10] },
				]

		country_id = @country.id
		
		@urls.each do |url|
			unless url[:url] == '' && url[:category_id] == ''
				parseURL(url[:url])
				create_article(url[:url], url[:category_id], country_id)
				create_shares(@article, false, false)
			end
		end	
		redirect_to url_forms_admins_path
	end
	
	
	def prepare_admin_posts
		

		
		
	end


#============ auto_post_method==================================================

	def auto_post
		business
		international
		startup
		tech
		society
		sports
		funny
		entertainment
		relationships
		music
		health
		food
		redirect_to drafts_admins_path
	end
	
	def auto_post_by_category
		category = params[:category]
		case category
		#business
		when "Business" then 
			business
		when "International" then
			international
		when "Startup" then
			startup
		when "Tech" then
			tech
		when "Society" then
			society
		when "Sports" then
			sports
		when "Funny" then
			funny
		when "Entertainment" then
			entertainment
		when "Relationships" then
			relationships
		when "Music" then
			music
		when "Health" then
			health
		when "Food" then
			food
		else
		end	
		
		redirect_to drafts_admins_path
	end

# 	def auto_post_by_item
# 		item = params[:item]
# 		case item 
# 		#business

# 		#startup	

# 		#tech	

# 		#society	

# 		#sports	

# 		#funny	

# 		#entertainment	

# 		#relatinships	

# 		#music movie		

# 		#health	

		
# 		#food	
#         when 
# 		else
# 		end
		
# 		redirect_to drafts_admins_path
# 	end
	

##############PRIVATE###############################
	private 
		def set_doc(site_url)
			charset = nil
			html = open(site_url, 'User-Agent' => 'firefox', redirect: true) do |f|
				charset = f.charset # 文字種別を取得
				f.read # htmlを読み込んで変数htmlに渡す
			end
			# ノコギリを使ってhtmlを解析
			@doc = Nokogiri::HTML.parse(html, charset)
		end
		
		def create_article(url, category_id, country_id)
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
					@article.remote_image_url = @article_image
					
					if @article.save
						
					else
						if @article.errors[:image].any?
							@article.remote_image_url = "http://www.newsbeee.com/images/no_image.jpeg"
							@article.save
						else
							@article_error = true
						end
					end
				end
			end
		end
		
		def create_shares(article, skip_tag, skip_desc)
			unless @article_error == true
				user = User.find_by(email: "newsb.sns@gmail.com")
				user2 = User.find_by(email: "paprikamajorika@gmail.com")
				random_user = [user, user2].sample
				
				if article && article.posts.where(user_id: [user.id, user2.id]).empty?
					if article.keywords.nil? || skip_tag == true
					
						keywords = ''
					else
						keywords = article.keywords.delete("{}").split(',').map{ |keyword| "#" + keyword.delete('[ ,！,・,、,。,.,/]')}.join(' ') 
					end	
					
					
					if article.description.nil? || article.description == ' ' || skip_tag == true
						description = ''
					else
						description = '> ' + article.description + '          '
					end
					content = description + keywords
	
					post = article.posts.build(user_id: random_user.id,
												country_id: article.country_id,
												category_id: article.category_id,
												content: content,
												comment_permission: false)
					if post.save
						@articles_count = @articles_count + 1
					end
				end
			end
		end
		
		
		def create_shares_wo_tags(article)
			unless @article_error == true
				user = User.find_by(email: "newsb.sns@gmail.com")
				user2 = User.find_by(email: "paprikamajorika@gmail.com")
				
				random_user = [user, user2].sample
				
				if article && article.posts.where(user_id: [user.id, user2.id]).empty?
					content = ''
					if user 
						post = article.posts.build(user_id: random_user.id,
													country_id: article.country_id,
													category_id: article.category_id,
													content: content,
													comment_permission: false)
						post.save
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
			if doc.css('//meta[name="keywords"]/@content').empty?
				@article_keywords = ''
			else
				@article_keywords = doc.css('//meta[name="keywords"]/@content').to_s
			end		
			
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
			#for excite news
			elsif !(doc.css('//meta[itemprop="datePublished"]/@content').empty?)
				@article_published_time = doc.css('//meta[itemprop="datePublished"]/@content').to_s
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
		
#============ auto_post_method==================================================
	##########BUSINESS########################################################
		def forbes_business_usa
			AutoPostRecord.where(site_name: "forbes_business_usa").delete_all
			set_doc("https://www.forbes.com/editors-picks")
			
			@count = @doc.css('.article-list article >a').count
			@urls = @doc.css('.article-list article >a').map{ |url| url.attribute("href").to_s}	
			
			category_id = Category.find_by(name: "Business").id
			country_id = Country.find_by(name: "United States").id
			
			@articles_count = 0
			@urls.each do |url|
				url = "http://diamond.jp" + url 
				parseURL(url)
				create_article(url, category_id, country_id)
				create_shares(@article, false, false)
			end
			
			AutoPostRecord.create(site_name: "diamond_business", shared: @articles_count)
		end
	##########society########################################################
	
	#international!!!################################################
		
	#######start up #####################################################	

	############TECH########################################
	
	########society###################################################	
	
		
	#############SPORTS@#############################################

	############FUNNY########################################################

	#######ENTERTAINMENT#####################################################
	
	
	############RELATIONSHIPS####################################################


	##########WEB ###########################

	
	########MOVIE MUSIC
	
	
	####HEALTH####################################################

	
	#######FOOODDDD########################################################	


	#category==================================================================
		def business

		end
				
		def international

		end
		
		def startup

		end
		
		def tech

		end
		
		def society

		end
		
		def sports

		end
		
		def funny

		end
		
		def entertainment

		end
		
		def relationships

		end
		
		def music

		end

		def health

		end
		
		def food

		end	
end
