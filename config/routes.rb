# coding: utf-8

Rails.application.routes.draw do
  
  resources :user_sessions, only: :create
  resources :lost_objects
  
  # Un ejemplo de cómo crear rutas para páginas "estáticas"
  # get '/ejemplo', to: 'pages#ejemplo'

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


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
