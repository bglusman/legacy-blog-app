Rails.application.routes.draw do
  scope '/admin', as: :admin do
    resources :posts
    # This is intentionally not being used
    resources :categories
  end

  resources :posts, only: [:index, :show], controller: 'site' do
    resources :comments
  end

  # This is the only route that will be marked as not used
  get '/legacy-route', to: redirect { |path_params, req|
    "/"
  }

  root 'site#index'
end
