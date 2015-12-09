# coding: utf-8

Rails.application.routes.draw do
  
  resources :user_sessions, only: :create
  resources :lost_objects
  
  # Un ejemplo de cómo crear rutas para páginas "estáticas"
  # get '/ejemplo', to: 'pages#ejemplo'

  get 'validate/:id', to:'users#validate'
  # Define la raiz
  root 'pages#index'
  get '/session_index', to: 'pages#session_index'
  
  # Rutas para manejo de usuario
  # Iniciar/Cerrar sesión:
  delete '/sign_out', to: 'user_sessions#destroy'
  get '/sign_in', to: 'user_sessions#new'
  # Registro:
  get '/register', to: 'users#new', as: :new_user
  post '/register', to: 'users#create'
  get '/profile', to: 'users#show', as: :user
  get '/profile/edit', to: 'users#edit', as: :edit_user
  match '/profile', to: 'users#update', via: [:put, :patch]
  match '/profile/update_password', to: 'users#update_password',
        via: [:put, :patch], as: :update_password

  # Verificación de usuarios
  get '/verify/:token', to: 'users#verify', as: :verify
  
end
