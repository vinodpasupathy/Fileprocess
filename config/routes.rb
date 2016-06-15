Rails.application.routes.draw do

  get  'products/import'

  post 'products/import_process'

 
  get  'products/main_category'

  post 'products/main_category'

  get  'products/sub_category'

  post 'products/sub_category'

  get  'products/product_desc'

  post 'products/product_desc'

  get  'products/product_compare'

  post 'products/product_compare'

  
  get  'products/manu_category'

  post 'products/manu_category'

  get  'products/manu_category_sub'

  post 'products/manu_category_sub'

  get  'products/manu_category_desc'

  post 'products/manu_category_desc'

  get  'products/manu_category_compare'

  post 'products/manu_category_compare'



  get  'products/manu_index_category'

  post 'products/manu_index_category'

  get  'products/manu_index_sub_category'

  post 'products/manu_index_sub_category'

  get  'products/manu_index_product_desc'

  post 'products/manu_index_product_desc'

  get  'products/manu_index_product_compare'

  post 'products/manu_index_product_compare'
  


  get 'products/search'
  
  post 'products/search'

  get 'products/search_desc'

  post 'products/search_desc'

  

  get "products/login_page"

  post "products/validate_login"

  get "users/logout" 

  get 'products/new'
  
  post 'products/create'



  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'products#main_category'

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
