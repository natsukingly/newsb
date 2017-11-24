Rails.application.routes.draw do
	get '/:locale' => 'categories#top'
	root 'categories#top'
	devise_for :users, :controllers => {registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks', sessions: 'users/sessions'} 

	scope ":country" do
		
		resources :users, except: [:create, :new] do
			member do
				get 'posts'
				get 'following'
				get 'followers'
				get 'edit_setting'
				post 'save_setting'
				get 'sns_setting'
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
				get 'articles'
				get 'posts'
				get 'load_more'
			end
			collection do
				get 'all_posts'
			end
		end	
		
		resources :articles, only: [:index, :show] do
			member do
				get 'load_more_posts'
			end
			collection do
				get 'load_more'
			end
		end
		
		resources :posts, except: [:new] do
			member do
				post 'create_article_post', as: :create_article	
				get 'edit_article_post', as: :edit_article
				post 'update_article_post', as: :update_article
				get 'cancel_edit_article_post', as: :cancel_edit_article
			end
			collection do
				post 'create_from_modal'
				get 'load_more'
				get 'autocomplete_tags'
				get 'load_url_modal'
				get 'load_url_feed'
			end
		end
		
		resources :comments, except: [:new] do
			member do 
				get 'cancel_edit_comment', as: :cancel_edit
				get 'view_more'
				get 'view_less'
			end
		end	
		
		resources :replies, except: [:new] do
			member do 
				get 'cancel_edit_reply', as: :cancel_edit
				get 'view_more'
				get 'view_less'
			end
		end
		get '/replies/:comment_id/new' => 'replies#new'
		
		resources :post_drafts do
			member do
				post 'publish'
			end
		end
	
		post '/users/:country_id/change_country' => 'users#change_country', as: :change_country
		post '/users/:language_id/change_language' => 'users#change_language', as: :change_language
		
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
		get '/search/:keyword' => "search#search"
		get '/search/:keyword/tags' => "search#tags"
		get '/search/:keyword/articles' => "search#articles"
		get '/search/:keyword/posts' => "search#posts"
		get '/search/:keyword/users' => "search#users"
		
		# rankings
		get '/ranking/weekly_user' => "ranking#user_weekly_ranking"
		get '/ranking/user' => "ranking#user_ranking"
		
		
		
		#LIKES
		post "/comments/params[:comment_id]/like" => "likes#comment_like" , as: :comment_like
		delete "/comments/params[:comment_id]/unlike" => "likes#comment_unlike", as: :comment_unlike
		
		post "/posts/params[:post_id]/like" => "likes#post_like" , as: :post_like
		delete "/posts/params[:post_id]/unlike" => "likes#post_unlike", as: :post_unlike
		
		post "/replies/params[:reply_id]/like" => "likes#reply_like" , as: :reply_like
		delete "/replies/params[:reply_id]/unlike" => "likes#reply_unlike", as: :reply_unlike
	end	
end
