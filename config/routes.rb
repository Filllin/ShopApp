Rails.application.routes.draw do

  root 'default#home'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  match 'contacts' => "default#contacts", via: 'get', as: :contacts

  match 'about' => "default#about", via: 'get', as: :about

  match 'oplata-i-dostavka' => "default#payment", via: 'get', as: :payment

  match 'cart' => "customer#cart", via: 'get', as: :cart

  match 'order/review' => "customer#review", via: 'get', as: :order_review

  match 'category/:slug' => "category#view_category", via: 'get', as: :view_category

  match 'sub_category/:slug' => "category#view_sub_category", via: 'get', as: :view_sub_category

  match 'author/:slug' => "author#view_author", via: 'get', as: :view_author

  match 'izdatelstvo/:slug' => "publisher#view_publisher", via: 'get', as: :view_publisher

  match 'customer_product_destroy' => "customer#destroy", via: 'get', as: :customer_product_destroy

  match 'update_quantity' => "customer#update_quantity", via: 'get', as: :product_update_quantity

  match 'order_a_products' => "customer#new", via: 'get', as: :order_a_products

  match 'create_customer' => "customer#create", via: 'post', as: :create_customer

  match 'search' => "default#search", via: 'get', as: :search

  match ':sub_category/:slug' => "product#view_product", via: 'get', as: :view_product

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
