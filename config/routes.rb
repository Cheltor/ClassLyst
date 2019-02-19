Rails.application.routes.draw do
  resources :rewards
  resources :posts do
    resources :comments, module: :posts do
      member do
        put "like",    to:"comments#upvote"
        put "dislike", to:"comments#downvote"
      end
    end
    member do
      put "like",    to:"posts#upvote"
      put "dislike", to:"posts#downvote"
    end
  end
  resources :courses
  resources :universities
  devise_for :businesses
  devise_for :users
  root 'home#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
