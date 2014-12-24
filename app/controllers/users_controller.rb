class UsersController < ApplicationController
  before_action :set_user, :only => [:edit, :destroy, :update, :show]

  respond_to :html

  def index
    @filter_users = filter_users
    if @filter_users == 'staff'
      @users = User.where.not(:level => 'member').order(:level)
    else
      @users = User.all.order(:level)
    end

    respond_with @users
  end

  def new
    @user = User.new
    respond_with(@user)
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to '/users', :notice => "#{@user.email} has been created"
    else
      respond_with(@user)
    end
  end

  def edit

  end

  def update
    if @user.update(user_params)
      redirect_to '/users', :notice => "#{@user.email} has been updated"
    else
      respond_with(@user)
    end
  end

  def destroy
    if @user.destroy
      redirect_to '/users' , :notice => "#{@user.email} has been deleted"
    else
      respond_with(@gym)
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :first_name, :last_name, :level, :avatar, :avatar_cache)
  end

  def filter_users
    view = params[:filter_users] || session[:filter_users]
    session[:filter_users] = view
    view
  end
end
