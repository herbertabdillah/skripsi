require 'sidekiq/web'

Rails.application.routes.draw do
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
  get "/dikti", to: "dikti#index"
  resources :students#, only: [:index]
end
