Rails.application.routes.draw do

  get 'sessions/new'

  root 'static_pages#home'
  get 'static_pages/about'
  get 'static_pages/help'
  get 'tutorial/:id', to: 'static_pages#tutorial'


  get 'auth/:provider/callback', to: 'sessions#create'
  get 'auth/failure', to: redirect('/')
  get 'signup', to: 'static_pages#signup', as: 'signup'
  get 'signout', to: 'sessions#destroy', as: 'signout'

  get 'photos/pixlr', to: 'photos#pixlr'
  get 'photos/search', to: 'photos#search'


  
  resources :relationships
  resources :users, only: [:show, :edit, :update]
  resources :photos do
    resources :comments
  end

  namespace :api do
    namespace :v1 do
      post 'users/uploaded', to: 'users#personal_feed'
      post 'users/favourites', to: 'users#favourites_feed'
      resources :users
      post 'photos/feed', to: 'photos#feed'
      post 'photos/search', to: 'photos#search'
      post 'photos/:id/like', to: 'photos#like'
      resources :photos
      resources :comments, only: :create
      

    end
  end

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
