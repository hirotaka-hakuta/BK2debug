Rails.application.routes.draw do
  root to: 'homes#top'
  devise_for :users

  get 'home/about' => 'homes#about'
  get 'search' => 'searchs#search'
  get "users/followerindex/:id"=>"users#followerindex" ,as: "followerindex"
  get "users/followedindex/:id"=>"users#followedindex" ,as: "followedindex"
  
  resources :users,only: [:show,:index,:edit,:update] do
   resource :relationships, only: [:create, :destroy]

  end
   
   resources :books do
   resource :favorites, only: [:create, :destroy]
   resources :book_comments, only: [:create, :destroy] 
  end
  
end