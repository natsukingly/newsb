Rails.application.routes.draw do
  root "posts#index"
  
  post "/posts/load_url" => "posts#load_url"
  resources :posts, except: [:index, :new] do
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
