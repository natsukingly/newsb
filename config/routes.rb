Rails.application.routes.draw do
	root "categories#top"
	
	
	
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
		end
		collection do
			get 'load_more'
			get 'autocomplete_tags'
			get 'load_url'
			get 'load_url_top'
		end
	end
	
	resources :comments, except: [:new] do
		member do 
			get 'view_more'
			get 'view_less'
			get 'new'	# new_post_comment
		end
	end	
	
	resources :replies, except: [:new] do
		member do 
			get 'view_more'
			get 'view_less'
		end
	end
	get '/replies/:comment_id/new' => 'replies#new'
	

	devise_for :users, :controllers => {:registrations => :registrations, omniauth_callbacks: 'users/omniauth_callbacks'} 
	resources :users, except: [:create, :new] do
		member do
			get 'posts'
			get 'following'
			get 'followers'
		end
		collection do 
			get 'auto_complete'
			get 'profile_form'
			post 'complete_profile'
		end
	end 
	post '/users/:country_id/change_country' => 'users#change_country', as: :change_country
	post '/users/:language_id/change_language' => 'users#change_language', as: :change_language
	
	
	
	resources :tags, only: [:index, :show] do
		member do
			post 'favorite'
			delete 'unfavorite'
		end
		collection do
			get 'articles_not_found'
			get 'favorite_index'
		end
	end
	
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
	get '/search/:key_word/tags' => "search#tags"
	get '/search/:key_word/articles' => "search#articles"
	get '/search/:key_word/posts' => "search#posts"
	get '/search/:key_word/users' => "search#users"
	
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
