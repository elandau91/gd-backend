Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  
  
  namespace :api do
    namespace :v1 do
      resources :shows
      resources :song_refs
      resources :song_occurances
      resources :show_sets
      resources :users, only: [:create, :index, :destroy, :update]
      post '/login', to: 'auth#create'
      post '/new', to: 'users#create'
      get '/profile', to: 'users#profile'
    end
  end
  
end
