Rails.application.routes.draw do
  resources :posts do
    resources :comments, module: :posts
  end
  resources :courses
  resources :universities
  devise_for :businesses
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
