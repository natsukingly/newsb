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
		AutoPostRecord.where(site_name: "forbes_business").delete_all
		AutoPostRecord.create(site_name: "forbes_business")
		set_doc("https://forbesjapan.com/category/lists/business?cx_hamburger=business")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Business").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end
		
		redirect_to drafts_admins_path
	end
	
	def gendai_business
		AutoPostRecord.where(site_name: "gendai_business").delete_all
		AutoPostRecord.create(site_name: "gendai_business")
		set_doc("http://gendai.ismedia.jp/list/genre/economics")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Business").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end
		
		redirect_to drafts_admins_path
	end	
	
	def jcast_business
		AutoPostRecord.where(site_name: "jcast_business").delete_all
		AutoPostRecord.create(site_name: "jcast_business")
		set_doc("https://www.j-cast.com/economy/")
		
		@urls = @doc.css('.category-entry-list li.entry-item >a').map{ |url| url.attribute("href").to_s}	
		
		
		category_id = Category.find_by(name: "Business").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			# url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	def forbes_startup
		AutoPostRecord.where(site_name: "forbes_startup").delete_all
		AutoPostRecord.create(site_name: "forbes_startup")
		set_doc("https://forbesjapan.com/category/lists/entrepreneurs?cx_hamburger=entrepreneurs")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	


		category_id = Category.find_by(name: "Startup").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end
		redirect_to drafts_admins_path
	end
	
	
	def bridge_startup
		AutoPostRecord.where(site_name: "bridge_startup").delete_all
		AutoPostRecord.create(site_name: "bridge_startup")
		set_doc("http://thebridge.jp/")
		
		@count = @doc.css('.post .entry-title a').count
		@urls = @doc.css('.post .entry-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Startup").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end
	
	def itmedia_tech
		AutoPostRecord.where(site_name: "itmedia_tech").delete_all
		AutoPostRecord.create(site_name: "itmedia_tech")
		set_doc("http://www.itmedia.co.jp/")
		
		@count = @doc.css('#colBoxTopStoriesTop .colBoxTitle a').count
		@urls = @doc.css('#colBoxTopStoriesTop .colBoxTitle a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end

	def techcrunch_startup
		AutoPostRecord.where(site_name: "techcrunch_startup").delete_all
		AutoPostRecord.create(site_name: "techcrunch_startup")
		set_doc("http://jp.techcrunch.com/startups/")
		
		@count = @doc.css('li.river-block .post-title a').count
		@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Startup").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end

	def techcrunch_tech1
		AutoPostRecord.where(site_name: "techcrunch_tech1").delete_all
		AutoPostRecord.create(site_name: "techcrunch_tech1")
		set_doc("http://jp.techcrunch.com/mobile/")
		
		@count = @doc.css('li.river-block .post-title a').count
		@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	def techcrunch_tech2
		AutoPostRecord.where(site_name: "techcrunch_tech2").delete_all
		AutoPostRecord.create(site_name: "techcrunch_tech2")
		set_doc("http://jp.techcrunch.com/%E3%82%AC%E3%82%B8%E3%82%A7%E3%83%83%E3%83%88/")
		
		@count = @doc.css('li.river-block .post-title a').count
		@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	def jcast_tech
		AutoPostRecord.where(site_name: "jcast_tech").delete_all
		AutoPostRecord.create(site_name: "jcast_tech")
		set_doc("https://www.j-cast.com/it/")
		
		@urls = @doc.css('.category-entry-list li.entry-item >a').map{ |url| url.attribute("href").to_s}	
		
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			# url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end			
	
	
	
	def asahi_politics
		AutoPostRecord.where(site_name: "asahi_politics").delete_all
		AutoPostRecord.create(site_name: "asahi_politics")
		set_doc("http://www.asahi.com/politics/list/")
		
		@asahi_count = @doc.css('.SectionFst li a').count
		@urls = @doc.css('.SectionFst li a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Politics").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			url = "https://www.asahi.com" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	# def jiji_politics
	# 	AutoPostRecord.create(site_name: "jiji_politics")
	# 	set_doc("https://www.jiji.com/jc/list?g=pol")
		
	# 	@urls = @doc.css('.MainInner a').map{ |url| url.attribute("href").to_s}

	# 	category_id = Category.find_by(name: "Politics").id
	# 	country_id = Country.find_by(name: "Japan").id
		
	# 	@urls.each do |url|
	# 		url = "https://www.jiji.com" + url 
	# 		parseURL(url)
	# 		create_article(url, category_id, country_id)
	# 		create_shares(@article)
	# 	end	
	# 	redirect_to drafts_admins_path
	# end	
	def jcast_politics
		AutoPostRecord.where(site_name: "jcast_politics").delete_all
		AutoPostRecord.create(site_name: "jcast_politics")
		set_doc("https://www.j-cast.com/politics/")
		
		@urls = @doc.css('.category-entry-list li.entry-item >a').map{ |url| url.attribute("href").to_s}	
		
		
		category_id = Category.find_by(name: "Politics").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			# url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	def excite_news_politics
		AutoPostRecord.where(site_name: "excite_news_politics").delete_all
		AutoPostRecord.create(site_name: "excite_news_politics")
		set_doc("https://www.excite.co.jp/News/politics_g/")
		
		@urls = @doc.css('.newsList dt.clear >a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Politics").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	
	def  excite_news_sports
		AutoPostRecord.where(site_name: "excite_news_sports").delete_all
		AutoPostRecord.create(site_name: "excite_news_sports")
		set_doc("https://www.excite.co.jp/News/sports_g/")
		
		@urls = @doc.css('.newsList dt.clear >a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Sports").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path		
	end
	
	def  excite_news_sports2
		AutoPostRecord.where(site_name: "excite_news_sports2").delete_all
		AutoPostRecord.create(site_name: "excite_news_sports2")
		set_doc("https://www.excite.co.jp/News/soccer/")
		
		@urls = @doc.css('.newsList dt.clear >a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Sports").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path		
	end	
	
	# def nhk_politics
	# 	AutoPostRecord.create(site_name: "nhk_politics")
	# 	set_doc("https://www3.nhk.or.jp/news/cat04.html")
		
	# #########下の表記のみ有効　href取得できず
	# 	@urls = @doc.css('a')



	# 	
		
	# 	category_id = Category.find_by(name: "Politics").id
	# 	country_id = Country.find_by(name: "Japan").id
		
	# 	@urls.each do |url|
	# 		url = "https://www3.nhk.or.jp" + url
	# 		parseURL(url)
	# 		create_article(url, category_id, country_id)
	# 		create_shares(@article)
	# 	end	
	# 	redirect_to drafts_admins_path
	# end		
	
	
	def rocket_news_funny
		AutoPostRecord.where(site_name: "rocket_news_funny").delete_all
		AutoPostRecord.create(site_name: "rocket_news_funny")
		set_doc("https://rocketnews24.com/")
		
		@count = @doc.css('div.post.type-post .post-header .entry-title a').count
		@urls = @doc.css('div.post.type-post .post-header .entry-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Funny").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	def buzzfeed_funny
		AutoPostRecord.where(site_name: "buzzfeed_funny").delete_all
		AutoPostRecord.create(site_name: "buzzfeed_funny")
		set_doc("https://www.buzzfeed.com/jp")
		
		@count = @doc.css('div.feed-cards .story-card >a').count
		@urls = @doc.css('div.feed-cards .story-card >a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Funny").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			url = "https://www.buzzfeed.com" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares_wo_tags(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	
	def yahoo_entertainment
		AutoPostRecord.where(site_name: "yahoo_entertainment").delete_all
		AutoPostRecord.create(site_name: "yahoo_entertainment")
		set_doc("https://news.yahoo.co.jp/list/?c=entertainment")
		
		@count = @doc.css('div.mainBox li.ListBoxwrap a').count
		@urls = @doc.css('div.mainBox li.ListBoxwrap a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Entertainment").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end
	
	def netarika_entertainment
		AutoPostRecord.where(site_name: "netarika_entertainment").delete_all
		AutoPostRecord.create(site_name: "netarika_entertainment")
		set_doc("https://netallica.yahoo.co.jp/news/geinou/")
		
		@count = @doc.css('ul.js-articleList li.js-article a').count
		@urls = @doc.css('ul.js-articleList li.js-article a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Entertainment").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	def gunosy_entertainment
		AutoPostRecord.where(site_name: "gunosy_entertainment").delete_all
		AutoPostRecord.create(site_name: "gunosy_entertainment")
		set_doc("https://gunosy.com/categories/9")
		
		@urls = @doc.css('.article_list .list_title a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Entertainment").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	def netarika_music
		AutoPostRecord.where(site_name: "netarika_music").delete_all
		AutoPostRecord.create(site_name: "netarika_music")
		set_doc("https://netallica.yahoo.co.jp/news/entertainment/")
		
		@count = @doc.css('ul.js-articleList li.js-article a').count
		@urls = @doc.css('ul.js-articleList li.js-article a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Movies・Music").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	def gunosy_music
		AutoPostRecord.where(site_name: "gunosy_music").delete_all
		AutoPostRecord.create(site_name: "gunosy_music")
		set_doc("https://gunosy.com/categories/11")
		
		@urls = @doc.css('.article_list .list_title a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Movies・Music").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	def gunosy_movie
		AutoPostRecord.where(site_name: "gunosy_movie").delete_all
		AutoPostRecord.create(site_name: "gunosy_movie")
		set_doc("https://gunosy.com/categories/10")
		
		@urls = @doc.css('.article_list .list_title a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Movies・Music").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	
	def netarika_health
		utoPostRecord.where(site_name: "netarika_health").delete_all
		AutoPostRecord.create(site_name: "netarika_health")
		set_doc("https://netallica.yahoo.co.jp/news/beauty/")
		
		@count = @doc.css('ul.js-articleList li.js-article a').count
		@urls = @doc.css('ul.js-articleList li.js-article a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Health").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end	
	
	def jcast_health
		AutoPostRecord.where(site_name: "jcast_health").delete_all
		AutoPostRecord.create(site_name: "jcast_health")
		set_doc("https://www.j-cast.com/health/")
		
		@urls = @doc.css('.category-entry-list li.entry-item >a').map{ |url| url.attribute("href").to_s}	
		
		
		category_id = Category.find_by(name: "Health").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			# url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	
	
	
	
	def netarika_food
		AutoPostRecord.where(site_name: "netarika_food").delete_all
		AutoPostRecord.create(site_name: "netarika_food")
		set_doc("https://netallica.yahoo.co.jp/news/gourmet/")
		
		@count = @doc.css('ul.js-articleList li.js-article a').count
		@urls = @doc.css('ul.js-articleList li.js-article a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Food").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	def gunosy_food
		AutoPostRecord.where(site_name: "gunosy_food").delete_all
		AutoPostRecord.create(site_name: "gunosy_food")
		set_doc("https://gunosy.com/categories/8")
		
		@urls = @doc.css('.article_list .list_title a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Food").id
		country_id = Country.find_by(name: "Japan").id
		
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		redirect_to drafts_admins_path
	end		
	
	# def yahoo_health
	# 	AutoPostRecord.create(site_name: "yahoo_health")
	# 	set_doc("https://news.yahoo.co.jp/hl?c=c_life&p=1")
		
	# 	@count = @doc.css('ul.listBd li span.thumb a').count
	# 	@urls = @doc.css('ul.listBd li span.thumb a').map{ |url| url.attribute("href").to_s}	
		
	# 	category_id = Category.find_by(name: "Health").id
	# 	country_id = Country.find_by(name: "Japan").id
		
	# 	@urls.each do |url|
	# 		parseURL(url)
	# 		create_article(url, category_id, country_id)
	# 		create_shares(@article)
	# 	end	
	# 	redirect_to drafts_admins_path
	# end	
	

	private 
		# def forbes_business
		# 	set_doc("https://forbesjapan.com/category/lists/business?cx_hamburger=business")
			
		# 	@count = @doc.css('.stream-article .article-image').count
		# 	@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
			
		# 	category_id = Category.find_by(name: "Business").id
		# 	country_id = Country.find_by(name: "Japan").id
			
		# 	@urls.each do |url|
		# 		parseURL(url)
		# 		create_article(url, category_id, country_id)
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
		# 		create_article(url, category_id, country_id)
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
		# 		create_article(url, category_id, country_id)
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
		# 		create_article(url, category_id, country_id)
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
		# 		create_article(url, category_id, country_id)
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
		# 		create_article(url, category_id, country_id)
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
		# 		create_article(url, category_id, country_id)
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
		# 		create_article(url, category_id, country_id)
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
		# 		create_article(url, category_id, country_id)
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
		# 		create_article(url, category_id, country_id)
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
					if @article_image == nil
						@article.image = "no_image.jpeg"
					else
						@article.remote_image_url = @article_image
					end
					@article.save
				end
				
				
				
				
				# Create post_draft for all admin users
				# User.where(admin: true).each do |user|
				# 	unless PostDraft.where(user_id: user.id, article_id: @article.id).any? || Post.where(user_id: user.id, article_id: @article.id).any?
				# 		@post_draft = user.post_drafts.build(article_id: @article.id)
				# 		@post_draft.category_id = category_id
				# 		@post_draft.country_id = country_id
				# 		@post_draft.save
					
				# 		decide_category
				# 	end
				# end
				
				
			end
		end
		
		def create_shares(article)
			user = User.find_by(email: "newsb.sns@gmail.com")
			user2 = User.find_by(email: "paprikamajorika@gmail.com")
			
			random_user = [user, user2].sample
			
			if article && article.posts.where(user_id: random_user.id).empty?
				
				if article.keywords.nil?
					keywords = ''
				else
					keywords = article.keywords.delete("{}").split(',').map{ |keyword| "#" + keyword.delete('[ ,！,・,、,。]')}.join(' ') 
				end	
				
				
				if article.description.nil? || article.description == ' ' 
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
				post.save
			end
		end
		
		def create_shares_wo_tags(article)
			user = User.find_by(email: "newsb.sns@gmail.com")
			user2 = User.find_by(email: "paprikamajorika@gmail.com")
			
			random_user = [user, user2].sample
			
			if article && article.posts.where(user_id: random_user.id).nil?
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
			unless doc.css('//meta[name="keywords"]/@content').empty?
				@article_keywords = doc.css('//meta[name="keywords"]/@content').to_s
			end		
			
			if !(doc.css('//meta[name="description"]/@content').empty?)
				@article_description = doc.css('//meta[name="description"]/@content').to_s
			elsif !(doc.css('//meta[property="og:description"]/@content').empty?)
				@article_description = doc.css('//meta[property="og:description"]/@content').to_s
			end	

			
			#PUBLISHED_TIME
			if !(doc.css('//meta[property="article:published_time"]/@content').empty?)
				@article_published_time = doc.css('//meta[property="article:published_time"]/@content').to_s
			elsif !(doc.css('//meta[property="article:published"]/@content').empty?)
				@article_published_time = doc.css('//meta[property="article:published"]/@content').to_s
			elsif !(doc.css('//meta[name="pubdate"]/@content').empty?)
				@article_published_time = doc.css('//meta[name="pubdate"]/@content').to_s
			#for buzzfeed
			elsif !(doc.css('header.buzz-header').empty?)
				@article_published_time = Date.parse(doc.css('header.buzz-header time.buzz-timestamp__time').text)
			#for netarika
			elsif !(doc.css('//meta[name="epoch-publish-date-seconds"]/@content').empty?)
				time = doc.css('//meta[name="epoch-publish-date-seconds"]/@content').to_s
				@article_published_time = Time.at(time.to_i)
			#for NHK
			elsif !(doc.css('#main article.module--detail time').empty?)
				@article_published_time = doc.css('#main article.module--detail time').attribute("datetime").to_s
			#for excite news
			elsif !(doc.css('//meta[itemprop="datePublished"]/@content').empty?)
				@article_published_time = doc.css('//meta[itemprop="datePublished"]/@content').to_s
		
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
