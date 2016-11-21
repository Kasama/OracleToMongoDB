Rails.application.routes.draw do

  root 'index#index'

  # First Exercise
  get 'first_exercise' => 'first_exercise#index', as: :first_ex
  # Single table simple part
    get 'simple_table' => 'simple_table#simple_menu', as: :simple_table
    post 'simple_table' => 'simple_table#simple_table', as: :simple_table_for
  # Double table (both referencing and embedding)
    get 'double_table' => 'double_table#double_menu', as: :double_table
    post 'double_table' => 'double_table#function_selector', as: :selector_table

  # Third Exercise
  get 'validation' => 'validation#validation', as: :validation

  # Fourth Exercise
  get 'create_find' => 'find_wrapper#show', as: :find_wrapper
  post 'submit_find' => 'find_wrapper#submit', as: :find_wrapper_submit

  # Fifth Exercise
  get 'benchmark' => 'benchmark#index', as: :benchmark

  get  'attrs_for_table' => 'oracle#get_attrs', as: :oracle_attrs

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
