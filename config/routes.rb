Rails.application.routes.draw do
  resources :missions do
    collection do
      get :search
    end
  end
  resources :locations
  resources :comments
  resources :posts
  resources :nav_logs


  namespace :api, defaults: {format: 'json'} do
    namespace :v1 do
      resources :nav_logs
      resources :users
      resources :drone
      resources :missions
    end
  end



  post '/auth/login', to: 'api/v1/authentication#login'



  get 'index/index'
  get 'index/about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/drone" => 'drone#index'
  get 'drone/drone_registration'
  get 'drone/drone_list'
  get 'drone/users_list'
  get 'drone/drone_tracker'
  get 'drone/drone_mission'
  put 'drone/status_change'
  put 'drone/mission_status_change'
  get '/drone/nav_logs_json' => 'drone#nav_logs_json'
  post 'drone/drone_create'
  put 'drone/ban_user'
  get 'drone/:id/drone_edit' => 'drone#drone_edit', :as => :drone_drone_edit

  devise_scope :user do
    authenticated :user do
      root to: 'index#index'
    end

    unauthenticated do
      root to: 'devise/sessions#new', as: :unauthenticated_root
    end

  end

  # root 'index#index'
end
