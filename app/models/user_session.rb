class UserSession < Authlogic::Session::Base
  #logout_on_timeout true
  logout_on_timeout Rails.env.production?
end

