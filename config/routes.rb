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
  
  resources :intrests, :ads, :profiles, :galleries

  resources :profiles do
  	member do
  		put :update_profile, :accept
      get :sent
  	end
  end
  
  get 'users/autocomplete_user_username'
  root :to => "home#index"
end
