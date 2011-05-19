class HomeController < ApplicationController
  has_mobile_fu
  before_filter :is_system_user?, :only => [:index]

  def index
  end

protected

  def is_system_user?
    redirect_to login_path if current_user.nil?
  end

end
