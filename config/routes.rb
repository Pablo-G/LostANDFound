# coding: utf-8

Rails.application.routes.draw do
  
  resources :users, only: [:new, :create]
  resources :user_sessions, only: :create
  resources :lost_objects
  
  # Define las rutas para iniciar y cerrar sesión, y
  # las hace accesibles mediante sign_[out/in]_path
  delete '/sign_out', to: 'user_sessions#destroy', as: :sign_out
  get '/sign_in', to: 'user_sessions#new', as: :sign_in
  
  # Un ejemplo de cómo crear rutas para páginas "estáticas"
  # get '/ejemplo', to: 'pages#ejemplo'

  get 'validate/:id', to:'users#validate'
  # Define la raiz
  root 'pages#index'
  get '/session_index', to: 'pages#session_index'
end
