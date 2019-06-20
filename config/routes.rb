Rails.application.routes.draw do
  get 'profsignup' => 'home#profsignup'
  get 'businessinfo' => 'home#businessinfo'
  get 'rewardpurchases/myrewards'
  resources :rewards do
    member do
      post 'rewardpurchase'
    end
  end
  resources :posts do
    resources :comments, module: :posts do
      member do
        put "like",    to:"comments#upvote"
        put "dislike", to:"comments#downvote"
        patch :hide
      end
    end
    member do
      put "like",    to:"posts#upvote"
      put "dislike", to:"posts#downvote"
      patch :flag
    end
  end
  resources :courses do
    member do
      post 'enroll'
    end
  end 
  resources :enrolls
  resources :universities
  devise_for :businesses
  devise_for :users
  root 'home#index'
  get 'ourrewards' => 'rewards#myrewards'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
