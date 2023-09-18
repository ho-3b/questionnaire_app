Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"

  devise_for :administrators, skip: [:confirmations, :registrations, :omniauth_callbacks], path: :admin, controllers: {
    sessions: 'admin/account/sessions',
    passwords: 'admin/account/passwords',
  }
  devise_scope :administrator do
    get "admin/confirmation" => 'admin/account/confirmations#show', as: :administrator_confirmation
    put "admin/confirmation" => 'admin/account/confirmations#confirm'
  end
  namespace :admin do

  end
end
