Rails.application.routes.draw do

  get 'reports/create'

	#home
	get '/about' => 'home#about'
	get '/terms' => 'home#terms', as: :terms
	get '/cookie_policy' => 'home#cookie_policy', as: :cookie_policy
	get '/privacy' => 'home#privacy', as: :privacy
	get '/contact' => 'home#contact', as: :contact
	post '/contact/post' => 'home#contact', as: :post_contact

	get '/:locale' => 'categories#top'
	root 'categories#top'
	
	scope ':locale' do
		get '/about' => 'home#about', as: :about_page
		get '/terms' => 'home#terms', as: :terms_page
		get '/cookie_policy' => 'home#cookie_policy', as: :cookie_policy_page
		get '/privacy' => 'home#privacy', as: :privacy_page
		get '/contact' => 'home#contact', as: :contact_page
		post '/contact/post' => 'home#post_contact', as: :post_contact_page
		get '/contact/message_received' => 'home#contact_message_received', as: :contact_message_received_page
	end
	
	resources :admins, only: [] do
		member do
			post 'hide_draft'
			post 'publish_draft'
			post 'check_report'
			post 'uncheck_report'
			delete 'delete_newsb_notification'
		end
		collection do
			get 'drafts'
			get 'reports'
			get 'unchecked_reports'
			get 'all_reports'
			post 'publish'
			get 'newsb_notifications_index'
			post 'create_newsb_notification'
		end
	end
	
	get '/schneider/crawl' => 'schneider#crawl', as: :crawl
	post '/schneider/prepare_admin_posts', as: :prepare_admin_posts

	devise_for :users, :controllers => {registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions', passwords: 'users/passwords'}
	
	scope ":country" do
		
		resources :users, except: [:create, :new] do
			member do
				get 'posts'
				get 'following'
				get 'followers'
				get 'edit_setting'
				post 'save_setting'
				post 'save_locale_setting'
				post 'save_email_setting'
				post 'save_password_setting'
				get 'edit_sns_setting'
				get 'edit_password_setting'
				get 'edit_email_setting'
				get 'edit_locale_setting'
			end
			collection do 
				get 'auto_complete'
				get 'complete_profile_form'
				post 'complete_profile'
				post 'check_notifications'
				get 'notification_index'
				post 'error_message' 
				get 'drafts'
			end
		end 
		
		resources :categories, only: [:show] do
			member do
				get 'posts'
				get 'load_more'
			end
			collection do
				get 'all_posts'
			end
		end	
		get "/categories/:name/articles" => "categories#articles" , as: :categorized_articles
		
		
		resources :articles, only: [:index, :show] do
			member do
				get 'load_more_posts'
			end
			collection do
				get 'load_more'
			end
		end
		
		resources :posts, except: [:new, :update, :destroy] do
			member do
				post 'change_comment_permission'
				post 'create_article_post', as: :create_article	
				get 'edit_article_post', as: :edit_article
				post 'update_article_post', as: :update_article
				get 'cancel_edit_article_post', as: :cancel_edit_article
			end
			collection do
				post 'update', as: :update
				post 'destroy', as: :destroy
				post 'create_from_modal'
				post 'create_from_article'
				get 'load_more'
				get 'autocomplete_tags'
				get 'load_url_modal'
				get 'load_url_mobile'
				get 'load_url_feed'
				post 'create_report'
			
			end
		end
		
		resources :comments, except: [:new, :update, :destroy] do
			member do 
				get 'cancel_edit_comment', as: :cancel_edit
				get 'view_more'
				get 'view_less'
			end
			collection do
				
				post 'create_report'
				post 'destroy', as: :destroy
				post 'update', as: :update
			end
		end	
		
		resources :reports
		
		resources :post_drafts do
			member do
				post 'publish'
			end
		end
	
		post '/users/:country_name/change_country' => 'users#change_country', as: :change_country
		post '/users/:code/change_language' => 'users#change_language', as: :change_language
		
		resources :snss, only: [] do
			member do 
				post 'share_facebook'
				post 'unshare_facebook'
				post 'share_linkedin'
				post 'unshare_linkedin'
				post 'share_twitter'
				post 'unshare_twitter'
			end
		end
		
		
		resources :tags, only: [:index] do
			member do
				post 'favorite'
				delete 'unfavorite'
			end
			collection do
				get 'articles_not_found'
				get 'favorite_index'
			end
		end
		get '/tags/:name' => 'tags#show', as: :tag
	
		# post '/hashtags/:tag/posts' => 'users#change_country', as: :change_country
		
		
		resources :relationships, only: [] do
			member do
				post 'follow'
				post 'unfollow'
				post 'follow_icon'
				post 'unfollow_icon'
			end
		end
		
		get '/posts/hashtags/:name' => 'posts#hashtags'
		
	
		# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
		get '/search' => "search#search"
		get '/search/:keyword/tags' => "search#tags", as: :search_tags
		get '/search/:keyword/articles' => "search#articles", as: :search_articles
		get '/search/:keyword/posts' => "search#posts", as: :search_posts
		get '/search/:keyword/users' => "search#users", as: :search_users
		
		# rankings
		get '/ranking/weekly_user' => "ranking#user_weekly_ranking"
		get '/ranking/user' => "ranking#user_ranking"
		
		
		
		#LIKES
		post "/comments/:comment_id/like" => "likes#comment_like" , as: :comment_like
		delete "/comments/:comment_id/unlike" => "likes#comment_unlike", as: :comment_unlike
		
		post "/posts/:post_id/like" => "likes#post_like" , as: :post_like
		delete "/posts/:post_id/unlike" => "likes#post_unlike", as: :post_unlike
		
		post "/replies/:reply_id/like" => "likes#reply_like" , as: :reply_like
		delete "/replies/:reply_id/unlike" => "likes#reply_unlike", as: :reply_unlike
		
		
		# auto scroll routing
		get "/auto_scroll/load_articles" => "auto_scroll#load_articles", as: :load_articles
		get "/auto_scroll/load_categorized_articles" => "auto_scroll#load_categorized_articles", as: :load_categorized_articles
		get "/auto_scroll/load_searched_articles" => "auto_scroll#load_searched_articles", as: :load_searched_articles
		
		get "/auto_scroll/load_posts" => "auto_scroll#load_posts", as: :load_posts
		get "/auto_scroll/load_article_posts" => "auto_scroll#load_article_posts", as: :load_article_posts
		get "/auto_scroll/load_user_posts" => "auto_scroll#load_user_posts", as: :load_user_posts
		get "/auto_scroll/load_searched_posts" => "auto_scroll#load_searched_posts", as: :load_searched_posts
	
		get "/auto_scroll/load_drafts" => "auto_scroll#load_drafts", as: :load_drafts
		get "/auto_scroll/load_admin_drafts" => "auto_scroll#load_admin_drafts", as: :load_admin_drafts
		
		get "/auto_scroll/load_trending_tags" => "auto_scroll#load_trending_tags", as: :load_trending_tags
		get "/auto_scroll/load_favorite_tags" => "auto_scroll#load_favorite_tags", as: :load_favorite_tags
		get "/auto_scroll/load_searched_tags" => "auto_scroll#load_searched_tags", as: :load_searched_tags	
		
		get "/auto_scroll/load_notifications" => "auto_scroll#load_notifications", as: :load_notifications
		get "/auto_scroll/load_index_notifications" => "auto_scroll#load_index_notifications", as: :load_index_notifications
		get "/auto_scroll/load_mobile_notifications" => "auto_scroll#load_mobile_notifications", as: :load_mobile_notifications


		get "/auto_scroll/load_weekly_users" => "auto_scroll#load_weekly_users", as: :load_weekly_users
		get "/auto_scroll/load_all_time_users" => "auto_scroll#load_all_time_users", as: :load_all_time_users
		get "/auto_scroll/load_serached_users" => "auto_scroll#load_searched_users", as: :load_searched_users
		get "/auto_scroll/load_following" => "auto_scroll#load_following", as: :load_following
		get "/auto_scroll/load_followers" => "auto_scroll#load_followers", as: :load_followers
	
		get "/auto_scroll/load_reports" => "auto_scroll#load_reports", as: :load_reports
		get "/auto_scroll/load_newsb_notifications" => "auto_scroll#load_newsb_notifications", as: :load_newsb_notifications
	end	
end
