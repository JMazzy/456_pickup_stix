class UsersController < ApplicationController
  before_action :require_login, :except => [:index, :show, :new, :create]

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    if signed_in_user?
      flash[:error] = "Already signed in!"
      redirect_to root_path
    else
      @user = User.new( user_params )
      if @user.save
        flash[:success] = "User created!"
        redirect_to user_path(@user)
      else
        flash[:error] = "User NOT created due to errors!"
        render :new
      end
    end
  end

  def edit
    if signed_in_user?
      @user = User.find(current_user)
    else
      flash[:error] = "Not signed in!"
      redirect_to login_path
    end
  end

  def update
    if !signed_in_user?
      flash[:error] = "Not signed in!"
      redirect_to login_path
    else
      @user = User.find(current_user) if signed_in_user?
      if @user.update( user_params )
        flash[:success] = "User updated!"
        redirect_to user_path(current_user)
      else
        flash[:error] = "User not updated due to errors!"
        render :edit
      end
    end
  end

  def destroy
    if signed_in_user?
      user = User.find(current_user)
      user.destroy
      flash[:success] = "Successfully deleted user."
      redirect_to root_path
    else
      flash[:error] = "Not signed in!"
      redirect_to login_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password)
  end
end
