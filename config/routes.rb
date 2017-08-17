Rails.application.routes.draw do
  get '/about' => "home#about"

  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' } 
  
  root "posts#index"
  resources :users, except: [:create, :new]
  

  post "/posts/load_url" => "posts#load_url"
  resources :posts, except: [:index, :new]
  
  get '/posts/hashtags/:name' => 'posts#hashtags'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  post '/search' => "search#search"
  get '/search_tags/:search' => "search#search_tags"
  get '/search_articles/:search' => "search#search_articles"
  get '/search_posts/:search' => "search#search_posts"
  get '/search_users/:search' => "search#search_users"
  
end
