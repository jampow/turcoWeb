ActionController::Routing::Routes.draw do |map|


  map.resources :account_plans
  map.resources :activities
  map.resources :attachments
  map.resources :bank_accounts
  map.resources :bank_account_transactions
  map.resources :carriers
  map.resources :cars
  map.resources :cfops
  map.resources :clients                  , :collection => { :people_photo => :get }
  map.resources :contracts
  map.resources :cost_centers
  map.resources :cst_cofins
  map.resources :cst_icms
  map.resources :cst_ipis
  map.resources :cst_pis
  map.resources :departments
  map.resources :dept_contacts
  map.resources :enterprises
  map.resources :func_contacts
  map.resources :hollydays
  map.resources :invoices
  map.resources :locations                , :collection => { :select_locations => :get,  :generate_bills => :post }
  map.resources :location_receipts
  map.resources :measure_units
  map.resources :messages
  map.resources :ncms
  map.resources :payables
  map.resources :payable_billings
  map.resources :payment_forms
  map.resources :permissions
  map.resources :product_families
  map.resources :product_kinds
  map.resources :products
  map.resources :providers
  map.resources :purchase_orders          , :collection => { :reverse => :get, :print_access_card => :get }
  map.resources :receivables
  map.resources :receivable_billings
  map.resources :sales_orders             , :collection => { :close => :get, :reverse => :get, :production => :get, :save_production => :put }
  map.resources :sellers
  map.resources :seller_credit_accounts
  map.resources :sells_types
  map.resources :stocks
  map.resources :st_cofins
  map.resources :st_icms
  map.resources :st_ipis
  map.resources :st_pis
  map.resources :terms
  map.resources :users
  map.resource  :user_session, :collection => {:timeout => :get}

	map.login  "login" , :controller => "user_sessions", :action => "new"
	map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.root :controller => "home"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

