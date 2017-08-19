Rails.application.routes.draw do
  resources :replies
  resources :comments
  get '/about' => "home#about"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  
  root "posts#index"
  resources :users, except: [:create, :new]
  
  get '/posts/:id/other_posts' => 'posts#other_posts'
  post "/posts/load_url" => "posts#load_url"
  resources :posts, except: [:index, :new]
  
  get '/optimized_index' => "posts#optimized_index"
  get '/test' => "posts#test"
  
  get '/article_index' => 'posts#article_index', as: :article_index
  get '/posts/hashtags/:name' => 'posts#hashtags'
  
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post '/search' => "search#search"
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
