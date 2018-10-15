Rails.application.routes.draw do

  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  namespace :admin do
    resources :panel, only: [:index] 
      get "/panel/messages", to: 'panel#messages'
      get "/panel/replies", to: 'panel#replies'
  end
   

  resources :users, only: [:new, :create, :edit, :update, :destroy] 
  
  resource :session, only: [:new, :create, :destroy]
  
  get "/", to: 'messages#index', as: :root

  resources :messages do
    resources :replies, only: [:create, :destroy]

      get :liked, on: :collection

    resources :likes, shallow: true, only: [:create, :destroy]
  end
 

end
