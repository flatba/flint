Rails.application.routes.draw do
  root "flint#index"

  get 'privacy-policy' => 'flint#privacyPolicy'

  resources :restaurants
  get 'restaurant/edit' => 'restaurants#edit'

  ###!!! このルートは本来はオカシイ。production版では修正が必要 !!!!###
  resources :messages

  # deviseの設定
  # devise_for :users, :controllers => {
  #   :omniauth_callbacks => 'users/omniauth_callbacks',
  #   :registrations => 'users/registrations'
  # }

  devise_for :users, :controllers => {:omniauth_callbacks => "users/omniauth_callback"}


  # メソッドの呼び出し
  get 'addLike' => 'flint#addLike'
  get 'updateMatch' => 'flint#updateMatch'
  get 'match' => 'flint#match'
  get 'user' => 'flint#user'
  get 'show/:id' => 'flint#show'
  get 'notification' => 'notifications#index'
  get 'create/:url' => "restaurant#create"

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
