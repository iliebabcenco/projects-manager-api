Rails.application.routes.draw do
  resources :projects do
    resources :comments
  end
end
