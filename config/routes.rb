Rails.application.routes.draw do
  resources :replies
  resources :comments
  get '/about' => "home#about"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  
  # follower/folowing
  get '/users/:id/following' => 'users#show_following'
  get '/users/:id/followers' => 'users#show_followers'
  get '/users/:id/user_post_index' => 'users#show_user_posts'
  
  post '/:following_id/follow' => 'relationships#follow'
  post '/:following_id/unfollow' => 'relationships#unfollow'
  
  root "posts#index"
  resources :users, except: [:create, :new]
  get '/user_ranking' => "users#user_ranking"
  
  
  
  get '/posts/:article/show_article' => 'posts#show_article'
  
  get '/posts/:id/other_posts' => 'posts#other_posts'
  post "/posts/load_url" => "posts#load_url"
  post "/posts/:placeholder_url/load_url" => "posts#load_url"
  resources :posts, except: [:index, :new]
  
  get '/optimized_index' => "posts#optimized_index"
  get '/test' => "posts#test"
  
  get '/article_index' => 'posts#article_index', as: :article_index
  get '/post_index' => 'posts#post_index'
  get '/posts/hashtags/:name' => 'posts#hashtags'
  
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
