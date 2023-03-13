Rails.application.routes.draw do
  resources :sleeps do
    post :clockin, on: :member
    put :clockout, on: :member
  end

  resources :users do
    get :following, on: :member
    post :follow, on: :member
    delete :unfollow, on: :member
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
