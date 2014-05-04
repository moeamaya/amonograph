Amonograph::Application.routes.draw do

  devise_for :users
  devise_scope :user do
    get '/signup', to: 'devise/registrations#new', as: 'signup'
    get '/login', to: 'devise/sessions#new', as: 'login'
  end

  root "home#index"

  resources :drawings
  get "upload", to: "drawings#new", as: "upload"

  #get '/signup', to: 'devise/registrations#new'
  #get 'login', to: 'sessions#new', as: 'login'
  get 'logout', to: 'devise/sessions#destroy'
end
