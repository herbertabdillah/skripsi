require 'sidekiq/web'

Rails.application.routes.draw do
  root to: 'home#index'
  mount Sidekiq::Web => "/sidekiq" 
  # devise_config = {
  #   :path=>:admin,
  #   :controllers=> {
  #     :sessions=>"active_admin/devise/sessions",
  #     :passwords=>"active_admin/devise/passwords",
  #     :unlocks=>"active_admin/devise/unlocks",
  #     :registrations=>"active_admin/devise/registrations",
  #     :confirmations=>"active_admin/devise/confirmations"
  #   },
  #   :path_names=> {
  #     :sign_in=>"login",
  #     :sign_out=>"logout"
  #   },
  #   :sign_out_via=>[:delete, :get]
  # }
  devise_for :users, ActiveAdmin::Devise.config
  # devise_for :users, devise_config

  ActiveAdmin.routes(self)
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get "/dikti", to: "dikti#index"
  get "/blockchain_data_check", to: "blockchain_data_check#index"
  get "/database", to: "database#index"
  get "/explorer", to: "explorer#index"
  get "/reset", to: "reset#index"
  resources :students#, only: [:index]

  namespace :api do
    resources :course_plans, only: [:show]
  end
end
