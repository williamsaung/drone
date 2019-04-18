Rails.application.routes.draw do
  resources :mission_records
  get 'mission_records/index'
  get 'polygon/polygon'
  get 'welcome/index'
  get 'forecasts/show'
  get 'forecasts/details'
  get 'forecasts/http'
  put 'base/open_door'
  put 'base/close_door'

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
      get 'last_navlog', to: '/api/v1/nav_logs#last_navlog'
      resources :users
      resources :drone
      patch 'mission_status_change', to: 'drone#mission_status_change'
      resources :missions
      get 'users_mission', to: 'missions#users_mission'
      get 'users_mission_last', to: 'missions#users_mission_last'
      get 'ongoing_mission', to: 'missions#ongoing_mission'
      post 'emergency_mission_sim', to: 'drone#emergency_mission_sim'

      resources :drone_availables
    end
  end


  post '/auth/login', to: 'api/v1/authentication#login'



  get 'index/index'
  get 'index/about'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get "/drone" => 'drone#index'
  get 'drone/drone_registration'
  get 'drone/drone_list' => "drone#drone_list"
  get 'drone/users_list'
  get 'drone/users_mission'
  get 'drone/drone_tracker'
  get 'drone/drone_mission'

  get 'drone/done'
  # get 'drone/drone_tracker' => 'drone#check_status'
  put 'drone/status_change'

  get 'drone/drone_tracker' => 'drone#check_status'
  put 'drone/terminate_mission'

  put 'drone/mission_status_change'
  put 'drone/check_status'
  get 'drone/check_status'
  get '/drone/nav_logs_json' => 'drone#nav_logs_json'
  post 'drone/drone_create'
  put 'drone/ban_user'
  get 'drone/:id/drone_edit' => 'drone#drone_edit', :as => :drone_drone_edit

  patch 'drone/:id/drone_edit' => 'drone#drone_update'
  put 'drone/:id'=> 'drone#drone_update'

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
