Rails.application.routes.draw do
	root "home#about"

	resources :categories, only: [:show] do
		member do
			get 'articles'
			get 'posts'
			get 'load_more'
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
		collection do
			get 'load_more'
			get 'autocomplete_tags'
			get 'load_url'
		end
	end
	
	resources :comments do
		member do 
			get 'view_more'
			get 'view_less'
		end
	end	
	
	resources :replies, except: [:new] do
		member do 
			get 'view_more'
			get 'view_less'
		end
	end
	get '/replies/:comment_id/new' => 'replies#new'
	
	
	devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
	resources :users, except: [:create, :new] do
		member do
			get 'following'
			get 'followers'
			get 'posts'
		end
		collection do 
			get 'ranking'
			get 'auto_complete'
		end
	end 

	
	resources :tags, only: [:index] do
		member do
			post 'favorite'
			delete 'unfavorite'
		end
		collection do
			get 'articles_not_found'
			get 'show_favorite'
		end
	end
	
	resources :relationships, only: [] do
		member do
			post 'follow'
			post 'unfollow'
		end
	end
	
	get '/posts/hashtags/:name' => 'posts#hashtags'
	

	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
	get '/search_result' => "search#search_posts"
	get '/search_tags/:search' => "search#search_tags"
	get '/search_articles/:search' => "search#search_articles"
	get '/search_posts/:search' => "search#search_posts"
	get '/search_users/:search' => "search#search_users"
	
	
	#LIKES
	post "/comments/params[:comment_id]/like" => "likes#comment_like" , as: :comment_like
	delete "/comments/params[:comment_id]/unlike" => "likes#comment_unlike", as: :comment_unlike
	
	post "/posts/params[:post_id]/like" => "likes#post_like" , as: :post_like
	delete "/posts/params[:post_id]/unlike" => "likes#post_unlike", as: :post_unlike
	
	post "/replies/params[:reply_id]/like" => "likes#reply_like" , as: :reply_like
	delete "/replies/params[:reply_id]/unlike" => "likes#reply_unlike", as: :reply_unlike
	
end
