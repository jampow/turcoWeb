ActionController::Routing::Routes.draw do |map|

  map.resources :activities
  map.resources :attachments
  map.resources :clients
  map.resources :cst_cofins
  map.resources :cst_icms
  map.resources :cst_ipis
  map.resources :cst_pis
  map.resources :departments
  map.resources :dept_contacts
  map.resources :func_contacts
  map.resources :hollydays
  map.resources :invoices
  map.resources :messages
  map.resources :ncms
  map.resources :permissions
  map.resources :product_families
  map.resources :product_kinds
  map.resources :products
  map.resources :providers
  map.resources :purchase_orders
  map.resources :receivables
  map.resources :sales_orders
  map.resources :sellers
  map.resources :seller_credit_accounts
  map.resources :terms
  map.resources :users
  map.resource  :user_session, :collection => {:timeout => :get}

	map.login  "login" , :controller => "user_sessions", :action => "new"
	map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.root :controller => "home"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

