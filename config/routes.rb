WebClinica::Application.routes.draw do
  resource :session, only: [:new, :create, :destroy]
  get '/logout' => 'sessions#destroy', :as => :logout

  resources :cids, except: [:new, :edit, :create, :update, :show, :destroy] do
    collection do
      get 'import' => 'cids#import'
      post 'load' => 'cids#load'
    end
  end

  resources :admins, except: [:show] do
    get 'recreate' => 'admins#recreate'
  end
  resources :secretaries do
    get 'recreate' => 'secretaries#recreate'
  end
  resources :doctors do
    get 'recreate' => 'doctors#recreate'
  end
  resources :password_resets
  resource :office, only: [:edit, :update, :show]
  resources :pacients do
    get 'recreate' => 'pacients#recreate'
    collection do
      get 'search'
    end
  end

  resources :statistics, only: [:index] do
    collection do
      get 'age'
      get 'time'
    end
  end

  resources :agendas do
    get 'recreate' => 'agendas#recreate'
  end

  resources :record_entries

  resources :health_insurances do
    get 'recreate' => 'health_insurances#recreate'
  end

  resources :occupations do
    get 'recreate' => 'occupations#recreate'
  end

  resources :records do
    collection do
      get 'search'
      get 'update_appointment_status' => 'records#update_appointment_status'
    end
    member do
      get 'export' => 'records#export'
    end
  end

  resources :appointments do
    collection do
      get 'day_index' => 'appointments#day_index'
      get 'update_status' => 'appointments#update_status'
    end
  end

  resource :profile, only: [:edit, :update, :show] do
    member do
      get 'reset_password'
    end
  end

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

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

