# -*- encoding : utf-8 -*-
Erudio::Application.routes.draw do
  
  root :to => 'teachers#home'

  resources :users do
    get "login", :on => :collection     # /users/login
    get "logout", :on => :collection    # /users/logout
  end
    
  resources :teachers do
    get "home", :on => :collection      # Root
    get "search" , :on => :collection   # /teachers/search
    get "rating", :on => :member        # /1/rating
    get "rate", :on => :member          # /1/rate
  end
  
  resources :zones do
    get "contiguous" , :on => :member   # /1/contiguous
  end
  
  # Deprecated. Should be erased when the real result page is implemented
  match "/result_search", :to => "pages#result_search"
  match "/result", :to => "pages#result"
  
  # API caller for testing different APIs
  match "/api_caller", :to => "pages#api_caller"
  
end