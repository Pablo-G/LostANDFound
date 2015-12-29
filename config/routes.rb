# coding: utf-8

Rails.application.routes.draw do
  
  resources :user_sessions, only: :create
  resources :lost_objects
  resources :tickets, only: [:index, :show, :create, :update]
  
  # Un ejemplo de cómo crear rutas para páginas "estáticas"
  # get '/ejemplo', to: 'pages#ejemplo'

  # Define la raiz
  root 'pages#index'
  
  # Rutas para manejo de usuario
  # Iniciar/Cerrar sesión:
  delete '/sign_out', to: 'user_sessions#destroy'
  get '/sign_in', to: 'pages#sign_in'
  post '/sign_in', to: 'user_sessions#create'
  post '/register', to: 'users#create', as: :register
  # Registro:
  get '/profile', to: 'users#show', as: :user
  get '/profile/edit', to: 'users#edit', as: :edit_user
  match '/profile', to: 'users#update', via: [:put, :patch]
  match '/profile/update_password', to: 'users#update_password',
        via: [:put, :patch], as: :update_password

  # Para pedir ubicaciones
  get '/locations', to: 'locations#index', as: :location

  # Tickets
  post '/replies', to: 'tickets#create_reply'

  # Verificación de usuarios
  get '/verify/:token', to: 'users#verify', as: :verify

  # Recuperación de contraseña
  resources :password_resets, only: [:new, :create, :edit, :update]
end
