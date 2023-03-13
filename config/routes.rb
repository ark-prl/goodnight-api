Rails.application.routes.draw do
  resources :sleeps do
    post :clockin, on: :member
    post :clockout, on: :member
  end

  resources :users do
    get :following, on: :member
    post :follow, on: :member
    post :unfollow, on: :member
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
