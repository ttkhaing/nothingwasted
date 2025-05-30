Rails.application.routes.draw do
  get 'mypage', to: 'users#show'
  get 'mypage/edit', to: 'users#edit', as: :edit_mypage
  patch 'mypage', to: 'users#update'
  root "homes#top"
  devise_for :users
   get "home/about" => "homes#about", as: "about"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  resources :items
end
