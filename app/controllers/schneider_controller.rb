class SchneiderController < ApplicationController
	
	def fetch_articles
	end
	def crawl

		#forbes
		set_doc("https://forbesjapan.com/category/lists/business?cx_hamburger=business")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}
	end
	
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
				create_shares(@article)
			end
		end	
		redirect_to url_forms_admins_path
	end
	
	
	def prepare_admin_posts
		

		
		redirect_to drafts_admins_path
	end
	
	def forbes_business
		AutoPostRecord.where(site_name: "forbes_business").delete_all
		set_doc("https://forbesjapan.com/category/lists/business?cx_hamburger=business")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Business").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end
		
		AutoPostRecord.create(site_name: "forbes_business", shared: @articles_count)
		redirect_to drafts_admins_path
	end
	
	def gendai_business
		AutoPostRecord.where(site_name: "gendai_business").delete_all
		set_doc("http://gendai.ismedia.jp/list/genre/economics")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Business").id
		country_id = Country.find_by(name: "Japan").id
		
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end
		
		AutoPostRecord.create(site_name: "forbes_business", shared: @articles_count)
		redirect_to drafts_admins_path
	end	
	
	def jcast_business
		AutoPostRecord.where(site_name: "jcast_business").delete_all
		set_doc("https://www.j-cast.com/economy/")
		
		@urls = @doc.css('.category-entry-list li.entry-item >a').map{ |url| url.attribute("href").to_s}	
		
		
		category_id = Category.find_by(name: "Business").id
		country_id = Country.find_by(name: "Japan").id
		

		@articles_count = 0
		@urls.each do |url|
			# url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "jcast_business", shared: @articles_count)
		redirect_to drafts_admins_path
	end		
	
	def huffpost_society
		AutoPostRecord.where(site_name: "huffpost_society").delete_all
		set_doc("https://www.j-cast.com/economy/")
		
		@urls = @doc.css('.category-entry-list li.entry-item >a').map{ |url| url.attribute("href").to_s}	
		
		
		category_id = Category.find_by(name: "Business").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			# url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "huffpost_society", shared: @articles_count)
		redirect_to drafts_admins_path
	end
	
	
	def forbes_startup
		AutoPostRecord.where(site_name: "forbes_startup").delete_all
		set_doc("https://forbesjapan.com/category/lists/entrepreneurs?cx_hamburger=entrepreneurs")
		
		@count = @doc.css('.stream-article .article-image').count
		@urls = @doc.css('.stream-article .article-image').map{ |url| url.attribute("href").to_s}	


		category_id = Category.find_by(name: "Startup").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end
		AutoPostRecord.create(site_name: "forbes_startup", shared: @articles_count)
		redirect_to drafts_admins_path
	end
	
	
	def bridge_startup
		AutoPostRecord.where(site_name: "bridge_startup").delete_all
		set_doc("http://thebridge.jp/")
		
		@count = @doc.css('.post .entry-title a').count
		@urls = @doc.css('.post .entry-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Startup").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "bridge_startup", shared: @articles_count)
		redirect_to drafts_admins_path
	end
	
	def itmedia_tech
		AutoPostRecord.where(site_name: "itmedia_tech").delete_all
		set_doc("http://www.itmedia.co.jp/")
		
		@count = @doc.css('#colBoxTopStoriesTop .colBoxTitle a').count
		@urls = @doc.css('#colBoxTopStoriesTop .colBoxTitle a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "itmedia_tech", shared: @articles_count)
		redirect_to drafts_admins_path
	end

	def techcrunch_startup
		AutoPostRecord.where(site_name: "techcrunch_startup").delete_all
		set_doc("http://jp.techcrunch.com/startups/")
		
		@count = @doc.css('li.river-block .post-title a').count
		@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Startup").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "techcrunch_startup", shared: @articles_count)
		redirect_to drafts_admins_path
	end

	def techcrunch_tech1
		AutoPostRecord.where(site_name: "techcrunch_tech1").delete_all
		set_doc("http://jp.techcrunch.com/mobile/")
		
		@count = @doc.css('li.river-block .post-title a').count
		@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "techcrunch_tech1", shared: @articles_count)
		redirect_to drafts_admins_path
	end	
	
	def techcrunch_tech2
		AutoPostRecord.where(site_name: "techcrunch_tech2").delete_all
		set_doc("http://jp.techcrunch.com/%E3%82%AC%E3%82%B8%E3%82%A7%E3%83%83%E3%83%88/")
		
		@count = @doc.css('li.river-block .post-title a').count
		@urls = @doc.css('li.river-block .post-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "techcrunch_tech2", shared: @articles_count)
		redirect_to drafts_admins_path
	end	
	
	def jcast_tech
		AutoPostRecord.where(site_name: "jcast_tech").delete_all
		set_doc("https://www.j-cast.com/it/")
		
		@urls = @doc.css('.category-entry-list li.entry-item >a').map{ |url| url.attribute("href").to_s}	
		
		
		category_id = Category.find_by(name: "Tech").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			# url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "jcast_tech", shared: @articles_count)
		redirect_to drafts_admins_path
	end			
	
	
	
	def asahi_society
		AutoPostRecord.where(site_name: "asahi_society").delete_all
		set_doc("http://www.asahi.com/politics/list/")

		@asahi_count = @doc.css('.SectionFst li a').count
		@urls = @doc.css('.SectionFst li a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Society").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			url = "https://www.asahi.com" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "asahi_society", shared: @articles_count)
		redirect_to drafts_admins_path
	end	
	
	def jcast_society
		AutoPostRecord.where(site_name: "jcast_society").delete_all
		set_doc("https://www.j-cast.com/society/")
		
		@urls = @doc.css('.category-entry-list li.entry-item >a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Society").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			# url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "jcast_society", shared: @articles_count)
		redirect_to drafts_admins_path
	end	
	
	def excite_news_society
		AutoPostRecord.where(site_name: "excite_news_society").delete_all
		set_doc("https://www.excite.co.jp/News/society_g/")
		
		@urls = @doc.css('.newsList dt.clear >a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Society").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "excite_news_society", shared: @articles_count)
		redirect_to drafts_admins_path
	end		
	
	
	def  excite_news_sports
		AutoPostRecord.where(site_name: "excite_news_sports").delete_all
		set_doc("https://www.excite.co.jp/News/sports_g/")
		
		@urls = @doc.css('.newsList dt.clear >a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Sports").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "excite_news_sports", shared: @articles_count)
		redirect_to drafts_admins_path		
	end
	
	def  excite_news_sports2
		AutoPostRecord.where(site_name: "excite_news_sports2").delete_all
		set_doc("https://www.excite.co.jp/News/soccer/")
		
		@urls = @doc.css('.newsList dt.clear >a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Sports").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "excite_news_sports2", shared: @articles_count)
		redirect_to drafts_admins_path		
	end	
	
	def rocket_news_funny
		AutoPostRecord.where(site_name: "rocket_news_funny").delete_all
		set_doc("https://rocketnews24.com/")
		
		@count = @doc.css('div.post.type-post .post-header .entry-title a').count
		@urls = @doc.css('div.post.type-post .post-header .entry-title a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Funny").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "rocket_news_funny", shared: @articles_count)
		redirect_to drafts_admins_path
	end		
	
	def buzzfeed_funny
		AutoPostRecord.where(site_name: "buzzfeed_funny").delete_all
		set_doc("https://www.buzzfeed.com/jp")
		
		@count = @doc.css('div.feed-cards .story-card >a').count
		@urls = @doc.css('div.feed-cards .story-card >a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Funny").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			url = "https://www.buzzfeed.com" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares_wo_tags(@article)
		end	
		AutoPostRecord.create(site_name: "buzzfeed_funny", shared: @articles_count)
		redirect_to drafts_admins_path
	end		
	
	
	def yahoo_entertainment
		AutoPostRecord.where(site_name: "yahoo_entertainment").delete_all
		set_doc("https://news.yahoo.co.jp/list/?c=entertainment")
		
		@count = @doc.css('div.mainBox li.ListBoxwrap a').count
		@urls = @doc.css('div.mainBox li.ListBoxwrap a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Entertainment").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "yahoo_entertainment", shared: @articles_count)
		redirect_to drafts_admins_path
	end
	
	def netarika_entertainment
		AutoPostRecord.where(site_name: "netarika_entertainment").delete_all
		set_doc("https://netallica.yahoo.co.jp/news/geinou/")
		
		@count = @doc.css('ul.js-articleList li.js-article a').count
		@urls = @doc.css('ul.js-articleList li.js-article a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Entertainment").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "netarika_entertainment", shared: @articles_count)
		redirect_to drafts_admins_path
	end	
	
	def gunosy_entertainment
		AutoPostRecord.where(site_name: "gunosy_entertainment").delete_all
		set_doc("https://gunosy.com/categories/9")
		
		@urls = @doc.css('.article_list .list_title a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Entertainment").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "gunosy_entertainment", shared: @articles_count)
		redirect_to drafts_admins_path
	end		
	
	def googirl_relationships
		
	end
	
	def honnest_relationships
		AutoPostRecord.where(site_name: "honnest_relationships").delete_all
		set_doc("https://zexy-enmusubi.net/honnest/")
		
		@urls = @doc.css('ul.recent-entries a.recent-entries-title-link').map{ |url| url.attribute("href").to_s}
		
		category_id = Category.find_by(name: "Relationships").id
		country_id = Country.find_by(name: "Japan").id

		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "honnest_relationships", shared: @articles_count)
		redirect_to drafts_admins_path		
	end
	
	def howcollect_relationships
		AutoPostRecord.where(site_name: "howcollect_relationships").delete_all
		set_doc("http://howcollect.jp/list/index/category/1")
		
		@urls = @doc.css('.main-container .line-article >a').map{ |url| url.attribute("href").to_s}.uniq
		# @urls.delete('/category/love')

		category_id = Category.find_by(name: "Relationships").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			url = "http://howcollect.jp/" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "howcollect_relationships", shared: @articles_count)
		redirect_to drafts_admins_path
	end
	
	def tabilabo_relationships
		AutoPostRecord.where(site_name: "tabilabo_relationships").delete_all
		set_doc("https://tabi-labo.com/category/love")
		
		@urls = @doc.css('#main a').map{ |url| url.attribute("href").to_s}.uniq
		@urls.delete('/category/love')

		category_id = Category.find_by(name: "Relationships").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			url = "https://tabi-labo.com" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "tabilabo_relationships", shared: @articles_count)
		redirect_to drafts_admins_path		
	end


###WEB ###########################
	# def lig_web
	# 	AutoPostRecord.where(site_name: "lig_web").delete_all
	# 	AutoPostRecord.create(site_name: "lig_web")
	# 	set_doc("https://gunosy.com/categories/10")
		
	# 	@urls = @doc.css('#js_main .l-article-list .l-article-list-left >a').map{ |url| url.attribute("href").to_s}
	# 	@urls1 = @doc.css('a.gtm_archive_link').map{ |url| url.attribute("href").to_s}
		
	# 	category_id = Category.find_by(name: "Web").id
	# 	country_id = Country.find_by(name: "Japan").id
		
	# 	binding.pry
		
	# 	@urls.each do |url|
	# 		parseURL(url)
	# 		create_article(url, category_id, country_id)
	# 		create_shares(@article)
	# 	end	
	# 	redirect_to drafts_admins_path
	# end


#MOVIE MUSIC
	def gunosy_movie
		AutoPostRecord.where(site_name: "gunosy_movie").delete_all
		set_doc("https://gunosy.com/categories/10")
		
		@urls = @doc.css('.article_list .list_title a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Movies・Music").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "gunosy_movie", shared: @articles_count)
		redirect_to drafts_admins_path
	end		

	def netarika_music
		AutoPostRecord.where(site_name: "netarika_music").delete_all
		set_doc("https://netallica.yahoo.co.jp/news/entertainment/")
		
		@count = @doc.css('ul.js-articleList li.js-article a').count
		@urls = @doc.css('ul.js-articleList li.js-article a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Movies・Music").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "netarika_music", shared: @articles_count)
		redirect_to drafts_admins_path
	end	
	
	def gunosy_music
		AutoPostRecord.where(site_name: "gunosy_music").delete_all
		set_doc("https://gunosy.com/categories/11")
		
		@urls = @doc.css('.article_list .list_title a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Movies・Music").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "gunosy_music", shared: @articles_count)
		redirect_to drafts_admins_path
	end		
	
	def netarika_health
		AutoPostRecord.where(site_name: "netarika_health").delete_all
		set_doc("https://netallica.yahoo.co.jp/news/beauty/")
		
		@count = @doc.css('ul.js-articleList li.js-article a').count
		@urls = @doc.css('ul.js-articleList li.js-article a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Health").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "netarika_health", shared: @articles_count)
		redirect_to drafts_admins_path
	end	
	
	def jcast_health
		AutoPostRecord.where(site_name: "jcast_health").delete_all
		set_doc("https://www.j-cast.com/health/")
		
		@urls = @doc.css('.category-entry-list li.entry-item >a').map{ |url| url.attribute("href").to_s}	
		
		
		category_id = Category.find_by(name: "Health").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			# url = "https://www.excite.co.jp" + url 
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "jcast_health", shared: @articles_count)
		redirect_to drafts_admins_path
	end		
	
	def netarika_food
		AutoPostRecord.where(site_name: "netarika_food").delete_all
		set_doc("https://netallica.yahoo.co.jp/news/gourmet/")
		
		@count = @doc.css('ul.js-articleList li.js-article a').count
		@urls = @doc.css('ul.js-articleList li.js-article a').map{ |url| url.attribute("href").to_s}	
		
		category_id = Category.find_by(name: "Food").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "netarika_food", shared: @articles_count)
		redirect_to drafts_admins_path
	end		
	
	def gunosy_food
		AutoPostRecord.where(site_name: "gunosy_food").delete_all
		set_doc("https://gunosy.com/categories/8")
		
		@urls = @doc.css('.article_list .list_title a').map{ |url| url.attribute("href").to_s}

		category_id = Category.find_by(name: "Food").id
		country_id = Country.find_by(name: "Japan").id
		
		@articles_count = 0
		@urls.each do |url|
			parseURL(url)
			create_article(url, category_id, country_id)
			create_shares(@article)
		end	
		AutoPostRecord.create(site_name: "gunosy_food", shared: @articles_count)
		redirect_to drafts_admins_path
	end		

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
					if @article_image == nil
						@article.image = "no_image.jpeg"
					else
						@article.remote_image_url = @article_image
					end
					@article.save
				end
			end
		end
		
		def create_shares(article)
			user = User.find_by(email: "newsb.sns@gmail.com")
			user2 = User.find_by(email: "paprikamajorika@gmail.com")
			
			random_user = [user, user2].sample
			
			if article && !(article.posts.where(user_id: [user.id, user2.id]).nil?)
				
				if article.keywords.nil?
					keywords = ''
				else
					keywords = article.keywords.delete("{}").split(',').map{ |keyword| "#" + keyword.delete('[ ,！,・,、,。,.,/]')}.join(' ') 
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
				if post.save
					@articles_count = @articles_count + 1
				end
			end
		end
		
		def create_shares_wo_tags(article)
			user = User.find_by(email: "newsb.sns@gmail.com")
			user2 = User.find_by(email: "paprikamajorika@gmail.com")
			
			random_user = [user, user2].sample
			
			if article && !(article.posts.where(user_id: [user.id, user2.id]).nil?)
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
				if @article_source == "ホンネスト - produced by 婚活サイト ゼクシィ縁結び"
					@article_published_time = Time.at(@article_published_time.to_i)
				end
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
			elsif !(doc.css('//meta[name="article:published_time"]/@content').empty?)
				time = doc.css('//meta[name="article:published_time"]/@content').to_s
				@article_published_time = Time.at(time)
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
