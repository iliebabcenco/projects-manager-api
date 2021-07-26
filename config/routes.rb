Rails.application.routes.draw do
  resources :projects do
    resources :comments
  end
  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
