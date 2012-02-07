class HomeController < ApplicationController
  has_mobile_fu
  before_filter :is_system_user?, :only => [:index]

  #FIXME: mensagem de boas vindas aparece duas vezes.
  def index
    @message = Message.last.message rescue ''
  end

protected

  def is_system_user?
    redirect_to login_path if current_user.nil?
  end

end

