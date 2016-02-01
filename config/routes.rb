Rails.application.routes.draw do
  apipie
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :countries ,defaults: {format: :json}
  resources :interests ,defaults: {format: :json}
  resources :languages ,defaults: {format: :json}

  resources :users , defaults:{format: :json} do
    collection do
      post :register
    end
  end

  resources :sessions, defaults:{format: :json}

  scope defaults: { format: 'json' } do
    post 'api/register', to: 'users#create'
    post 'api/login'   , to: 'auth#authenticate'
    get 'api/current_user',to:'users#current_user'
    get 'api/show/:id' , to: 'users#show'
    post 'api/update'  , to: 'users#update'
    get 'api/interests', to: 'interests#index'
    get 'api/countries', to: 'countries#index'
    post 'api/request_reset_password', to: 'users#request_reset_password'

  end

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
