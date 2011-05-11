class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

  def new
    @user_session = UserSession.new
  end

	def create
	  @user_session = UserSession.new(params[:user_session])


	  respond_to do |format|
	    if @user_session.save
	      flash[:notice] = "Olá."
          format.html { redirect_to "/home" }
          format.xml  { render :xml => {:status => "created"} }
	    else
	    	flash[:notice] = "Dados inválidos"
          format.html { render :action => "new" }
          format.xml  { render :xml => @user_session.errors, :status => :unprocessable_entity }
	    end
    end
	end

	def destroy
	  current_user_session.destroy
    flash[:notice] = "Até mais!"
    redirect_back_or_default login_url
	end

end

