Rails.application.routes.draw do
  devise_for :users, skip: [:sessions]
  as :user do
    get 'signin', to: 'devise/sessions#new', as: :new_user_session
    post 'signin', to: 'devise/sessions#create', as: :user_session
    delete 'signout', to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  ## External routes
  # button route
  get 'webpay/b-pay/:shop_id+:button_slug/', to: 'transaction/web_pay_plus#button', as: 'create_webpay_button'
  post 'webpay/b-pay/:shop_id+:button_slug/', to: 'transaction/web_pay_plus#button'
  #web pay process
  match 'webpay/result', to: 'transaction/web_pay_plus#result', via: [:get, :post]
  match 'webpay/end', to: 'transaction/web_pay_plus#end', via: [:get, :post]
  ## Dashboard Routes
  root to: 'dashboard#index'
  # shop routes
  resources :shop, except: [:index], path: '', param: :slug do
    member do
      resources :button, param: :button_slug, controller: 'shop/button'
      resources :email, param: :email_slug, controller: 'shop/email'
      resources :page, param: :page_slug, controller: 'shop/page'
    end
  end


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
