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
        format.html   { redirect_to "/home" }
        format.mobile { redirect_to "/home" }
        format.xml    { render :xml  => {:status => "created"} }
	    else
	    	flash[:notice] = "Dados inválidos"
        format.html   { render :action => "new" }
        format.mobile { render :action => "new" }
        format.xml    { render :xml    => @user_session.errors, :status => :unprocessable_entity }
	    end
    end
	end

	def destroy
	  current_user_session.destroy
    flash[:notice] = "Até mais!"
    redirect_back_or_default login_url
	end


  def timeout
    if Rails.env.development?
      logout = false
    else
      logout = current_user_session.stale?
    end

    respond_to do |format|
      format.json { render :json => logout}
    end
  end

  # Authlogic attempts to call this method within your
  # controller, you can define whatever you'd like in here to
  # not track the last_request_at. We need to disable the
  # update of last_request_at for our ajax timeout action 'timeout'
  # since we would basically be overwriting ourselves. You can
  # put whatever functionality you need in here, it just needs
  # to return true/false.
  def last_request_update_allowed?
    action_name != "timeout"
  end

end

