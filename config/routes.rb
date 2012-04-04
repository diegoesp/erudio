# -*- encoding : utf-8 -*-
Erudio::Application.routes.draw do

  root :to => 'pages#home'

  match "/home", :to => "pages#home"
  # Deprecated. Should be erased when the real result page is implemented
  match "/result", :to => "pages#result"
  # API caller for testing different APIs
  match "/api_caller", :to => "pages#api_caller"

  # APIs for the web application
  match "/api_search_teachers", :to => "pages#api_search_teachers"
  match "/api_login", :to => "sessions#api_login"
  match "/api_logout", :to => "sessions#api_logout"
  match "/api_rate_a_teacher", :to => "users#api_rate_a_teacher"
  match "/api_get_teacher_rating", :to => "users#api_get_teacher_rating"

  # Deprecated. Should be erased when the real result page is implemented
  match "/result_search", :to => "pages#result_search"


	# The priority is based upon order of creation:
	# first created -> highest priority.
	
	# Sample of regular route:
	#   match 'products/:id' => 'catalog#view'
	# Keep in mind you can assign values other than :controller and :action
	
	# Sample of named route:
	#   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
	# This route can be invoked with purchase_url(:id => product.id)
	
	# Sample resource route (maps HTTP verbs to controller actions automatically):
	#   resources :products
	
	# Sample resource route with options:
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
	
	# Sample resource route with sub-resources:
	#   resources :products do
	#     resources :comments, :sales
	#     resource :seller
	#   end
	
	# Sample resource route with more complex sub-resources
	#   resources :products do
	#     resources :comments
	#     resources :sales do
	#       get 'recent', :on => :collection
	#     end
	#   end
	
	# Sample resource route within a namespace:
	#   namespace :admin do
	#     # Directs /admin/products/* to Admin::ProductsController
	#     # (app/controllers/admin/products_controller.rb)
	#     resources :products
	#   end
	
	# You can have the root of your site routed with "root"
	# just remember to delete public/index.html.
	# root :to => 'welcome#index'
	
	# See how all your routes lay out with "rake routes"
	
	# This is a legacy wild controller route that's not recommended for RESTful applications.
	# Note: This route will make all actions in every controller accessible via GET requests.
	# match ':controller(/:action(/:id(.:format)))'
end
