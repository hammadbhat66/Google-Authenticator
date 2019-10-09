Rails.application.routes.draw do
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  root 'home#index'
  devise_for :users, controllers: {sessions: 'sessions'}
  get 'employees/index'
  post 'otp_required',to:"home#check_otp_required"
  get 'clients/index'
  get    '/two_factor' => 'two_factors#show', as: 'admin_two_factor'
  post   '/two_factor' => 'two_factors#create'
  delete '/two_factor' => 'two_factors#destroy'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
