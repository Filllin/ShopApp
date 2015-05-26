Rails.application.routes.draw do

  root 'default#home'

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users

  get 'contacts' => "default#contacts", as: :contacts

  get 'about' => "default#about", as: :about

  get 'oplata-i-dostavka' => "default#payment", as: :payment

  get 'cart' => "customer#cart", as: :cart

  get 'order/review' => "customer#review", as: :order_review

  get 'category/:slug' => "category#view_category", as: :view_category

  get 'sub_category/:slug' => "category#view_sub_category", as: :view_sub_category

  get 'author/:slug' => "author#view_author", as: :view_author

  get 'izdatelstvo/:slug' => "publisher#view_publisher", as: :view_publisher

  get 'customer_product_destroy' => "customer#destroy", as: :customer_product_destroy

  get 'update_quantity' => "customer#update_quantity", as: :product_update_quantity

  get 'order_a_products' => "customer#new", as: :order_a_products

  post 'create_customer' => "customer#create", as: :create_customer

  get ':sub_category/:slug' => "product#view_product", as: :view_product

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
