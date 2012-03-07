ActionController::Routing::Routes.draw do |map|

  map.resources :account_plans
  map.resources :activities
  map.resources :attachments
  map.resources :bank_accounts
  map.resources :bank_account_transactions
  map.resources :carriers
  map.resources :cars
  map.resources :clients
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
  map.resources :measure_units
  map.resources :messages
  map.resources :ncms
  map.resources :payment_forms
  map.resources :permissions
  map.resources :product_families
  map.resources :product_kinds
  map.resources :products
  map.resources :providers
  map.resources :purchase_orders, :collection => { :reverse => :get }
  map.resources :receivables do |r|
    r.resources :billings, :controller => 'receivable_billings'
  end
  map.resources :sales_orders   , :collection => { :reverse => :get }
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

