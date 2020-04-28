Rails.application.routes.draw do
  
  resources :profiles
  devise_scope :user do
    # get '/users/sign_up', to: 'users/registrations#new', as: 'new_registration'
    #authenticated is currently set to pantry to be changed later
    authenticated :user do
      # root to: 'users#current_user_home'
      root to: 'profiles#current_user_home' ,as: :authenticated_root
      # root 'profiles#show', as: :authenticated_root
    end

    unauthenticated do
      root 'devise/sessions#new', as: :unauthenticated_root
    end
  end

  resource :user, only: [:edit] do
    collection do
      patch 'update_password'
    end
  end
  
  post 'time_clocks/sign_out', to: 'time_clocks#sign_out'
  get 'time_clocks/sign_in', to: 'time_clocks#sign_in'
  post 'time_clocks/new_job', to: 'time_clocks#new_job'
  post 'expenses/new_job', to: 'expenses#new_job'
  post 'jobs/new_job', to: 'jobs#new_job'
  patch 'staffs/update_password', to: 'staffs#update_password', as: 'update_password'
  # get 'hoaroutes/getkml', to: 'hoaroutes#getkml'
  # get 'hoaroutes/getroute', to: 'hoaroutes#getroute', as: 'route'

  # get 'get_events', to: "profiles#get_events"
  get 'jobs/invoices', to: 'jobs#invoices', as: 'invoices'
  get 'jobs/invoice/:id', to: 'jobs#invoice', as: 'invoice'
  get 'time_clocks/payroll', to: 'time_clocks#payroll', as: 'payroll'
  post 'time_clocks/payroll', to: 'time_clocks#payroll'
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :account_types
  resources :employee_skills
  resources :water_sources
  resources :waste_systems
  resources :time_clocks
  resources :street_types
  resources :streetdirs
  resources :states
  resources :staffs
  # resources :drivers
  resources :properties
  resources :projects
  resources :payee_types
  resources :job_subcategories
  resources :invoices
  resources :heat_types
  resources :heat_fuels
  resources :expense_types
  resources :expenses
  resources :employment_types
  resources :event_types
  resources :counties
  resources :contractors
  resources :contractor_categories
  resources :contacts
  resources :company_categories
  resources :calendars
  resources :building_types
  resources :auto_milage_logs
  resources :cars
  resources :auto_maintenance_logs
  resources :afs_accounts
  resources :jobs
  resources :clients
  resources :job_categories
  resources :payees
  resources :accounts_payables
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
