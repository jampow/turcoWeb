class PermissionsController < ApplicationController

  access_control do
    allow :permissions_e, :to => [:index, :show, :new, :edit, :create, :update, :destroy]
    allow :permissions_l, :to => [:index, :show]
    allow :permissions_s, :to => []
  end

  def index
    @users = User.all
  end

  def edit
    @controllers = Role.roles
    @user        = User.find(params[:id])
  end

  def update
    @user = User.find(params[:user][:id])
    @user.has_no_roles!

    params[:permission].each do |controller, level|
      @user.has_role! controller + '_' + level
    end

    flash[:notice] = 'Permissões redefinidas.'
    redirect_to("/permissions/show/#{@user.id}")
  end

  def show
    @user = User.find(params[:id])
    @perm = @user.role_objects
  end

end

