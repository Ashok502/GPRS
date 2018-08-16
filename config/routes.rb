Rails.application.routes.draw do
  mount ActionCable.server => '/cable'
  post '/tinymce_assets' => 'images#create'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_scope :user do
  	get 'login', to: 'devise/sessions#new'
  	get 'signup', to: 'devise/registrations#new'
  	delete 'logout', to: 'devise/sessions#destroy'
  end

  resources :conversations, only: [:create] do
    member do
      post :close
    end
  end

  resources :posts do
    resources :comments
  end
  
  resources :intrests, :ads, :profiles, :galleries, :categories, :orders, :events

  resources :cities, only: :index
  resources :states, only: :index

  resources :dashboards, only: ['index']

  resources :coupons do
    collection do
      get :apply
      get :apply_code
    end
  end

  resources :products do
    resources :reviews
    member do
      get :add_to_cart
      delete :item_delete
    end
  end

  resources :profiles do
  	member do
  		put :update_profile, :accept
      get :sent
  	end
    collection do
      post :feedback
    end
  end
  
  get 'users/autocomplete_user_username'
  get '/order/express' => 'orders#express', :as => :pay
  root :to => "home#index"
end
