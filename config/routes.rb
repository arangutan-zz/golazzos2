Gollazos::Application.routes.draw do
#---------------------------------------------------------------------
#-----------GOLAZZOS 1.0
  #get "activities/index"
  #get "friendship/index"
  #get "redireccion/index"
  #get "redireccion/new"
  #get "metrics/index"
  #get "metrics/emails"
  #resources :invitations do
  #  post 'postear', :on => :collection
  #end
#
  #resources :partidos do
   # post 'repartir', :on => :collection
   # resources :bets
  #end
#
 # resources :users do
  #  resources :profiles
  #end
  #resources :redireccion
  #resources :friendships
  #resources :activities
  #get "home/index"
  #get "home/index2"
  #get "home/reglamento"
  #get "home/contacto"
#
  #get "home/invitacion"
  #post "home/inivitacion"
  #LOGIN WITH FACEBOOK OMNIAUTH
  #match 'auth/:provider/callback', to: 'sessions#create'
  #match 'auth/failure', to: redirect('/')
  #match 'signout', to: 'sessions#destroy', as: 'signout'
  #VIRALIDAD TOKEN
  #match "home/:invitation_token" ,to: "home#referido"
  #match "/:invitation_token" ,to: "home#index"
#---------------------------------------------------------------------


  #map.home '/home/:invitation_token', :controller => 'users', :action => 'new'
  #map.home '/home/:invitation_token', :controller => 'home', :action => 'referido'
  #match "home/:invitation_token" ,to: "home#referido"



  #devise_for :users
  #devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  #devise_for :users,  :controllers => { :omniauth_callbacks => "users/omniauth_callbacks", :registrations => "registrations" } 




  #VIRALIDAD TOKEN
  #match "home/:invitation_token" ,to: "home#index2"
  #match "/:invitation_token" ,to: "home#index2"
  #match 'users', to: 'sessions#create', :as => 'user_root'


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

  root :to => 'home#index'
   #root :to => 'redireccion#index'
   
  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end
