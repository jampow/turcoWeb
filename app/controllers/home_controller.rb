class HomeController < ApplicationController
  has_mobile_fu
  before_filter :is_system_user?, :only => [:index]

  #FIXME: mensagem de boas vindas aparece duas vezes.
  def index
    flash[:notice] = "Bem vindo #{current_user.name}."
    @message = Message.last.message
  end

protected

  def is_system_user?
    redirect_to login_path if current_user.nil?
  end

end

