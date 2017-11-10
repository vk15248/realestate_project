Rails.application.routes.draw do
  get 'map/index'
  post 'map/index'

  post 'like/create'

  delete 'like/destroy'

  resources :real_estates
  root 'static_pages#home'
  get '/login', to: 'session#new'
  post '/login', to: 'session#create'
  delete '/logout', to: 'session#destroy'
  get '/signup', to: 'users#new'
  get 'map', to: 'map#index'

  resources :users

  resources :real_estates, :shallow => true do
    resources :album
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
