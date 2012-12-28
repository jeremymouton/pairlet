FlirtRails::Application.routes.draw do

  mount RailsAdmin::Engine => '/pairletadmin', :as => 'rails_admin'

  devise_for :users, path_names: { sign_in: "signin", sign_out: "logout", sign_up: "signup",  },
                     controllers: { omniauth_callbacks: "omniauth_signups" }

  resources :flirts
  resources :links
  resources :users

  root :to => 'pages#index'
  match 'flirts' => 'flirts#index', :as => 'user_root'
  match 'accounts' => 'links#index', :as => 'user_accounts'

  match "connections" => "users#mutual_flirts", :as => 'connections'

  resources :relationships, only: [:create, :destroy]
end
