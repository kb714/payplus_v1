Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  as :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  ## Dashboard Routes
  root to: 'dashboard#index'
  # shop routes
  get 'shop/create'
  get 'shop/show'
  get 'shop/edit'

  ## api routes
  namespace :api do
    namespace :v1 do
      post 'shop/store'
      put 'shop/update'
      delete 'shop/destroy'
    end
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
