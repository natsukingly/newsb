Rails.application.routes.draw do
  resources :replies
  resources :comments do
    member do 
      get 'view_more'
      get 'view_less'
    end
  end
  
  get '/about' => "home#about"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  
  resources :articles, only: [:index, :show] do
    member do
    end
    collection do
      get 'load_more'
    end
  end
  
  resources :tags, only: [] do
    member do
      get 'articles'
      get 'articles_week'
      get 'articles_month'
      get 'posts'
      get 'posts_week'
      get 'posts_month'
      get 'users'
      get 'users_week'
      get 'users_month'
    end
    collection do
    end
  end
  
  
  
  
  
  # follower/folowing
  get '/users/:id/following' => 'users#show_following'
  get '/users/:id/followers' => 'users#show_followers'
  get '/users/:id/user_post_index' => 'users#show_user_posts'
  get '/users/auto_complete' => 'users#auto_complete'
  
  
  post '/:following_id/follow' => 'relationships#follow'
  post '/:following_id/unfollow' => 'relationships#unfollow'
  post '/:following_id/follow_icon' => 'relationships#follow_icon'
  post '/:following_id/unfollow_icon' => 'relationships#unfollow_icon'
  
  root "posts#index"
  resources :users, except: [:create, :new]
  get '/user_ranking' => "users#user_ranking"
  get '/mobile_post_form' => 'posts#mobile_post_form'
  
  
  get '/posts/autocomplete_tags' => 'posts#autocomplete_tags'
  get '/posts/autocomplete_personalized_tags' => 'posts#autocomplete_personalized_tags'
  get '/posts/:tag_name/customize_side_nav' => 'posts#customize_side_nav'
  get '/posts/reset_personalized_tags' => 'posts#reset_personalized_tags'
  
  get '/posts/:id/other_posts' => 'posts#other_posts'
  post "/posts/load_url" => "posts#load_url"
  post "/posts/:placeholder_url/load_url" => "posts#load_url"
  get "/posts/mobile_load_url" => "posts#mobile_load_url"
  
  resources :posts, except: [:index, :new] do
    collection do
      get 'load_more'
    end
  end
  
  
  
  
  get '/optimized_index' => "posts#optimized_index"
  get '/test' => "posts#test"
  
  get '/post_index' => 'posts#post_index'
  get '/posts/hashtags/:name' => 'posts#hashtags'
  
  
  get '/replies/:comment_id/new' => 'replies#new'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '/search_result' => "search#search_posts"
  get '/search_tags/:search' => "search#search_tags"
  get '/search_articles/:search' => "search#search_articles"
  get '/search_posts/:search' => "search#search_posts"
  get '/search_users/:search' => "search#search_users"
  
  
  
  post "/comments/params[:comment_id]/like" => "likes#comment_like" , as: :comment_like
  delete "/comments/params[:comment_id]/unlike" => "likes#comment_unlike", as: :comment_unlike
  
  post "/posts/params[:post_id]/like" => "likes#post_like" , as: :post_like
  delete "/posts/params[:post_id]/unlike" => "likes#post_unlike", as: :post_unlike
  
  post "/replies/params[:reply_id]/like" => "likes#reply_like" , as: :reply_like
  delete "/replies/params[:reply_id]/unlike" => "likes#reply_unlike", as: :reply_unlike
  
  
  
end
