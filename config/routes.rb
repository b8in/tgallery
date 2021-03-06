Tgallery::Application.routes.draw do

  scope "(:locale)", locale: /en|ru/ do
    devise_for :users, controllers: { registrations: "registrations" }

    get '/homes/change_locale', as: 'change_locale'

    get '/categories', to: "categories#index"
    get '/categories/:category_name', to:"categories#show_by_name", as:"category"
    get '/categories/:category_name/:id', to: "pictures#show", as:"picture"
    get '/pictures', to: "pictures#index", as:"pictures"
    get '/comments', to: "user_comments#index", as:"user_comments"
    get '/events', to: "events#index", as: "events"
    get '/events/:user_id/:event_name', to:"events#show", as:"event"

    root to:"homes#index"
  end

  mount Resque::Server, at: "/resque"
  post '/pusher/auth'
  post '/pictures/refresh_captcha_div'
  post '/load_all_comments', to: "user_comments#load_all_comments"
  match '/auth/facebook/callback' => 'services#create'

  resources :services, only: [:create, :destroy]
  resource :likes, only: [:create], as: 'set_like'
  resource :user_comments, only: [:create], as: "create_comment"
  resource :watching_categories, only: [:create, :destroy]

  ActiveAdmin.routes(self)

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
  # Note: This route will make all actions in every controller accessible via GET features.
  # match ':controller(/:action(/:id))(.:format)'
end
