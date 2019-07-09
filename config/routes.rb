Rails.application.routes.draw do
resources :contacts, only: [:new, :create]

  get 'profsignup' => 'home#profsignup'
  get 'businessinfo' => 'home#businessinfo'
  get 'rewardpurchases/myrewards'
  resources :rewardpurchases do
    member do
      post 'redeem'
    end
  end
  get 'valid' => 'home#valid'
  get 'notvalid' => 'home#notvalid'
  get 'home/userpage'
  resources :rewards do
    member do
      post 'rewardpurchase'
      patch :bye
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
  devise_for :users, :controllers => { :registrations => "admin_registrations" }
  root 'home#index'
  get 'ourrewards' => 'rewards#myrewards'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
