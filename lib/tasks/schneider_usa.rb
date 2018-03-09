class SchneiderUsa
	
	class << self
	#============ auto_post_method==================================================
		def hello
			puts 'hello world, Im SchneiderUSA'
		end
		
		def auto_post_business
			huffpost_business_usa
		end
		
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
		end

		def auto_post_by_category(category)
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
		end

	##############PRIVATE###############################
		private 
			def set_doc(site_url)
				require 'nokogiri'
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
				#for buzzfeed usa
				elsif !(doc.css('header.buzz-header time').empty?)
					@article_published_time = doc.css('header.buzz-header time').attribute("data-unix").to_s
				#for diamond online
				elsif !(doc.css('header.article-header time').empty?)
					time = doc.css('header.article-header time').to_s
					@article_published_time = DateTime.parse(time)
				#for abc news
				elsif !(doc.css('//meta[name="Last-Modified"]/@content').empty?)
					@article_published_time = doc.css('//meta[name="Last-Modified"]/@content').to_s
				#for livedoor 
				elsif !(doc.css('#main .topicsHeader time').empty?)
					time = doc.css('#main .topicsHeader time.topicsTime').inner_html
					@article_published_time = Time.strptime(time,"%Y年 %m月 %d日 %H時%M分")
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
			def huffpost_business_usa
				AutoPostRecord.where(site_name: "huffpost_business_usa").delete_all
				set_doc("https://www.huffingtonpost.com/section/business")
				
				@urls = @doc.css('#main .a-page__content .zone--original-center .bn-card a.card__image__wrapper').map{ |url| url.attribute("href").to_s}	
	
			
				category_id = Category.find_by(name: "Business").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					url = "https://www.huffingtonpost.com" + url 
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "huffpost_business_usa", shared: @articles_count)
			end
			def nypost_business_usa
				AutoPostRecord.where(site_name: "nypost_business_usa").delete_all
				set_doc("https://nypost.com/business/")
				
				@urls = @doc.css('div.column__main article .entry-thumbnail >a').map{ |url| url.attribute("href").to_s}	
	
	
				category_id = Category.find_by(name: "Business").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					url = url
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "nypost_business_usa", shared: @articles_count)
			end	
		##########society########################################################
			def huffpost_society_usa
				AutoPostRecord.where(site_name: "huffpost_society_usa").delete_all
				set_doc("https://www.huffingtonpost.com/section/us-news")
				
				@urls = @doc.css('#main .a-page__content .zone--original-center .bn-card a.card__image__wrapper').map{ |url| url.attribute("href").to_s}	
	
			
	
				category_id = Category.find_by(name: "Society").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					url = "https://www.huffingtonpost.com" + url 
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "huffpost_society_usa", shared: @articles_count)
			end	
			
			def abc_society_usa
				AutoPostRecord.where(site_name: "abc_society_usa").delete_all
				set_doc("http://abcnews.go.com/US")
				
				@urls = @doc.css('body #main-container .def-band article.headlines .headlines-ul li a').map{ |url| url.attribute("href").to_s}	
				
				category_id = Category.find_by(name: "Society").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				set_doc("http://abcnews.go.com/Politics")
				@urls.each do |url|
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "abc_society_usa", shared: @articles_count)
			end			
			
		#international!!!################################################
			def huffpost_international_usa
				AutoPostRecord.where(site_name: "huffpost_international_usa").delete_all
				set_doc("https://www.huffingtonpost.com/section/world-news")
				
				@urls = @doc.css('#main .a-page__content .zone--original-center .bn-card a.card__image__wrapper').map{ |url| url.attribute("href").to_s}	
				
	
				category_id = Category.find_by(name: "International").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					url = "https://www.huffingtonpost.com" + url 
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "huffpost_international_usa", shared: @articles_count)
			end	
			
			def abc_international_usa
				AutoPostRecord.where(site_name: "abc_international_usa").delete_all
				set_doc("http://abcnews.go.com/International")
				
				@urls = @doc.css('body #main-container .def-band article.headlines .headlines-ul li a').map{ |url| url.attribute("href").to_s}	
				
				category_id = Category.find_by(name: "International").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "abc_international_usa", shared: @articles_count)
			end	
		#######start up #####################################################	
			def techcrunch_startup_usa
				AutoPostRecord.where(site_name: "techcrunch_startup_usa").delete_all
				set_doc("https://beta.techcrunch.com/startups/")
				
				@urls = @doc.css('div.content  a.post-block__title__link').map{ |url| url.attribute("href").to_s}   	
				
				category_id = Category.find_by(name: "Startup").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					url = url
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "techcrunch_startup_usa", shared: @articles_count)
			end	
	
		############TECH########################################
			def nypost_tech_usa
				AutoPostRecord.where(site_name: "nypost_tech_usa").delete_all
				set_doc("https://nypost.com/tech/")
				
				@urls = @doc.css('div.column__main article .entry-thumbnail >a').map{ |url| url.attribute("href").to_s}	
	
	
				category_id = Category.find_by(name: "Tech").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					url = url
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "nypost_tech_usa", shared: @articles_count)
			end		
			
			def techcrunch_tech_usa
				AutoPostRecord.where(site_name: "techcrunch_tech_usa").delete_all
				
				#gadgets======
				set_doc("https://beta.techcrunch.com/gadgets/")
				
				@urls = @doc.css('div.content  a.post-block__title__link').map{ |url| url.attribute("href").to_s}   	
				
				category_id = Category.find_by(name: "Tech").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					url = url
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				#apps======
				set_doc("https://beta.techcrunch.com/apps/")
				
				@urls = @doc.css('div.content  a.post-block__title__link').map{ |url| url.attribute("href").to_s}   	
				
				@urls.each do |url|
					url = url
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "techcrunch_tech_usa", shared: @articles_count)
			end	
			
		#############SPORTS@#############################################
			def nypost_sports_usa
				AutoPostRecord.where(site_name: "nypost_sports_usa").delete_all
				set_doc("https://nypost.com/sports/")
				
				@urls = @doc.css('div.sports-latest article header h3 >a').map{ |url| url.attribute("href").to_s}	
	
	
	
				category_id = Category.find_by(name: "Sports").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					url = url
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "nypost_sports_usa", shared: @articles_count)
			end	
		############FUNNY########################################################
			def buzzfeed_funny_usa
				AutoPostRecord.where(site_name: "buzzfeed_funny_usa").delete_all
				set_doc("https://www.buzzfeed.com/news")
				
				@count = @doc.css('div.feed-cards .story-card >a').count
				@urls = @doc.css('div.feed-cards .story-card >a').map{ |url| url.attribute("href").to_s}	
				
				category_id = Category.find_by(name: "Funny").id
				country_id = Country.find_by(name: "United States").id
				
	
				@articles_count = 0
				@urls.each do |url|
					url = "https://www.buzzfeed.com" + url 
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares_wo_tags(@article)
				end	
				AutoPostRecord.create(site_name: "buzzfeed_funny_usa", shared: @articles_count)
				
			end	
		#######ENTERTAINMENT#####################################################
			def huffpost_entertainment_usa
				AutoPostRecord.where(site_name: "huffpost_entertainment_usa").delete_all
				set_doc("https://www.huffingtonpost.com/section/entertainment")
				
				@urls = @doc.css('#main .a-page__content .zone--original-center .bn-card a.card__image__wrapper').map{ |url| url.attribute("href").to_s}	
	
	
				category_id = Category.find_by(name: "Entertainment").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					url = "https://www.huffingtonpost.com" + url 
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "huffpost_entertainment_usa", shared: @articles_count)
			end	
			
			def popsugar_entertainment_usa
				AutoPostRecord.where(site_name: "popsugar_entertainment_usa").delete_all
				set_doc("https://www.popsugar.com/celebrity/")
				
				@urls = @doc.css('#content-wrapper article .post-image >a').map{ |url| url.attribute("href").to_s}	
				
	
				category_id = Category.find_by(name: "Entertainment").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "popsugar_entertainment_usa", shared: @articles_count)
			end	
		
		############RELATIONSHIPS####################################################
			def popsugar_relationships_usa
				AutoPostRecord.where(site_name: "popsugar_relationships_usa").delete_all
				set_doc("https://www.popsugar.com/love/")
				
				@urls = @doc.css('#content-wrapper article .post-image >a').map{ |url| url.attribute("href").to_s}	
				
	
				category_id = Category.find_by(name: "Relationships").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "popsugar_relationships_usa", shared: @articles_count)
			end		
		
	
		##########WEB ###########################
	
		
		########MOVIE MUSIC
		
		
		####HEALTH####################################################
			def popsugar_health_usa
				AutoPostRecord.where(site_name: "popsugar_health_usa").delete_all
				set_doc("https://www.popsugar.com/Healthy-Living")
				
				@urls = @doc.css('#content-wrapper .ikb-post >a').map{ |url| url.attribute("href").to_s}	
				
	
				category_id = Category.find_by(name: "Health").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "popsugar_health_usa", shared: @articles_count)
			end	
			def buzzfeed_health_usa
				AutoPostRecord.where(site_name: "buzzfeed_health_usa").delete_all
				set_doc("https://www.buzzfeed.com/health")
				
				@count = @doc.css('ul.grid-posts .grid-posts__item a.lede__link').count
				@urls = @doc.css('ul.grid-posts .grid-posts__item a.lede__link').map{ |url| url.attribute("href").to_s}	
	
				
				category_id = Category.find_by(name: "Health").id
				country_id = Country.find_by(name: "United States").id
				
	
				@articles_count = 0
				@urls.each do |url|
					url = "https://www.buzzfeed.com" + url 
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares_wo_tags(@article)
				end	
				AutoPostRecord.create(site_name: "buzzfeed_health_usa", shared: @articles_count)
				
			end	
		
		#######FOOODDDD########################################################	
			def popsugar_food_usa
				AutoPostRecord.where(site_name: "popsugar_food_usa").delete_all
				set_doc("https://www.popsugar.com/food/")
				
				@urls = @doc.css('#content-wrapper article .post-image >a').map{ |url| url.attribute("href").to_s}	
				
	
				category_id = Category.find_by(name: "Food").id
				country_id = Country.find_by(name: "United States").id
				
				@articles_count = 0
				@urls.each do |url|
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares(@article, false, false)
				end
				
				AutoPostRecord.create(site_name: "popsugar_food_usa", shared: @articles_count)
			end	
			
			def buzzfeed_food_usa
				AutoPostRecord.where(site_name: "buzzfeed_food_usa").delete_all
				set_doc("https://www.buzzfeed.com/food")
				
				@count = @doc.css('ul.grid-posts .grid-posts__item a.lede__link').count
				@urls = @doc.css('ul.grid-posts .grid-posts__item a.lede__link').map{ |url| url.attribute("href").to_s}	
	
				
				category_id = Category.find_by(name: "Food").id
				country_id = Country.find_by(name: "United States").id
				
	
				@articles_count = 0
				@urls.each do |url|
					url = "https://www.buzzfeed.com" + url 
					parseURL(url)
					create_article(url, category_id, country_id)
					create_shares_wo_tags(@article)
				end	
				AutoPostRecord.create(site_name: "buzzfeed_food_usa", shared: @articles_count)
				
			end	
	
	
			#category==================================================================
			def business
		        huffpost_business_usa
		        nypost_business_usa
			end
					
			def international
				huffpost_international_usa
				abc_international_usa 
			end
			
			def startup
				techcrunch_startup_usa	
			end
			
			def tech
				nypost_tech_usa
				techcrunch_tech_usa
			end
			
			def society
		        huffpost_society_usa
		        abc_society_usa 
			end
			
			def sports
				nypost_sports_usa
			end
			
			def funny
				buzzfeed_funny_usa
			end
			
			def entertainment
		        huffpost_entertainment_usa
		        popsugar_entertainment_usa
			end
			
			def relationships
				popsugar_relationships_usa
			end
			
			def music
		
			end
		
			def health
				popsugar_health_usa
				buzzfeed_health_usa
			end
			
			def food
				popsugar_food_usa
				buzzfeed_food_usa
			end	

	end
end
