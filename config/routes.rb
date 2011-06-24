ActionController::Routing::Routes.draw do |map|
  map.resources :hollydays

  map.resources :receivables

  map.resources :invoices

  map.resources :func_contacts

  map.resources :dept_contacts


  map.resources :activities
  map.resources :clients
  map.resources :departments
  map.resources :ncms
  map.resources :permissions
  map.resource  :user_session
  map.resources :users

	map.login "login", :controller => "user_sessions", :action => "new"
	map.logout "logout", :controller => "user_sessions", :action => "destroy"

  map.root :controller => "home"

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

