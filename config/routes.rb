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
  resources :shop, except: [:index], path: '', param: :slug do
    member do
      resources :button, param: :button_slug, controller: 'shop/button'
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
