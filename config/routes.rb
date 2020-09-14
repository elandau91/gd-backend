Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :shows
  resources :song_refs
  resources :song_occurances
  resources :show_sets
end
