# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  #protect_from_forgery # See ActionController::RequestForgeryProtection for details

	filter_parameter_logging :password, :password_confirmation
	helper_method :current_user, :current_user_session

  has_mobile_fu #true #pass true parameter to test on webkit

private

  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end

  def require_user
    unless current_user
      store_location
      flash[:notice] = "Você precisa estar logado para acessar esta página"
      redirect_to new_user_session_url
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash[:notice] = "Você precisa estar logado para acessar esta página"
      redirect_to "/home"
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  rescue_from 'Acl9::AccessDenied', :with => :access_denied

  def access_denied
    if current_user
      render :template => '/access_denied/index'
    else
      flash[:notice] = 'Acesso negado. Você precisa estar logado.'
      redirect_to login_path
    end
  end

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end

