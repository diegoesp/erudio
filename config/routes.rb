# -*- encoding : utf-8 -*-
Erudio::Application.routes.draw do
  
  root :to => 'teachers#home'

  resources :users do
    get "login", :on => :member
    get "logout"
  end
    
  resources :teachers do
    get "home"
    get "search" , :on => :collection
    get "rating"
    get "rate"
  end
  
  resources :zones do
    get "contiguous" , :on => :collection
  end
  
  # Deprecated. Should be erased when the real result page is implemented
  match "/result_search", :to => "pages#result_search"
  match "/result", :to => "pages#result"
  
  # API caller for testing different APIs
  match "/api_caller", :to => "pages#api_caller"
  
end