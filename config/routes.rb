Rails.application.routes.draw do
  apipie
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'
  resources :countries ,defaults: {format: :json}
  resources :interests ,defaults: {format: :json}
  resources :languages ,defaults: {format: :json}
  resources :posts , defaults:{format: :json}
  resources :users , defaults:{format: :json} do
    collection do
      post :register
    end
  end

  resources :sessions, defaults:{format: :json}

  scope defaults: { format: 'json' } do
    post 'api/reply/:id' , to:'replies#create'
    post 'api/delete_reply/:id',to: 'replies#destroy'
    post 'api/like_post/:id', to: 'posts#like'
    post 'api/unlike_post/:id', to: 'posts#unlike'
    post 'api/new_post', to: 'posts#create'
    get 'api/show_post/:id', to: 'posts#show'
    post 'api/list_post/:id', to:'posts#index'
    post 'api/update_post/:id', to: 'posts#update'
    post 'api/delete_post/:id',to: 'posts#destroy'
    post 'api/repost/:id' ,to:'posts#repost'
    post 'api/register', to: 'users#create'
    post 'api/login'   , to: 'auth#authenticate'
    get 'api/current_user',to:'users#current_user'
    get 'api/show/:id' , to: 'users#show'
    post 'api/search'  , to: 'users#search'
    get 'api/recommend', to: 'users#recommend'
    post 'api/update'  , to: 'users#update'
    post 'api/follow'  , to: 'users#follow'
    post 'api/unfollow'  , to: 'users#unfollow'
    get 'api/interests', to: 'interests#index'
    get 'api/countries', to: 'countries#index'
    get 'api/languages', to: 'languages#index'
    post 'api/request_reset_password', to: 'users#request_reset_password'
    post 'api/feed' , to: 'users#feed'

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
