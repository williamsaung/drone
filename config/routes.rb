Rails.application.routes.draw do
  resources :missions
  resources :locations
  resources :comments
  resources :posts
  resources :nav_logs

  get 'index/index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/drone" => 'drone#index'
  get 'drone/drone_registration'
  get 'drone/drone_list'
  get 'drone/users_list'
  get 'drone/drone_tracker'
  get 'drone/drone_mission'
  put 'drone/status_change'

  get 'drone/nav_logs_json'
  get 'nav_logs/test' => 'nav_logs#test'
  post 'nav_logs/test' => 'nav_logs#test_post'
  post 'drone/drone_create'
  put 'drone/ban_user'
  devise_scope :user do
    authenticated :user do
      root to: 'drone#drone_list'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end
  end
  # root 'index#index'
end
