class UsersController < ApplicationController
  # before_action :set_user, only: [:edit, :update]
  before_action :correct_user, only: [:edit, :update]

  def show
   @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end

  def edit
    unless current_user == @user
      flash[:danger] = "access denied: please login as right user"
      redirect_to login_url
    end
  end

  def update
    @user.update(user_params)
    if @user.save
      flash[:success] = "Your profile has been updated."
      redirect_to @user
    else
      flash[:alert] = "failed to update profile."
      render 'edit'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation,
                                 :location, :profile)
  end

  def correct_user
    begin
      @user = User.find(params[:id])
      if @user != current_user
        flash[:danger] = "pls login and edit your own profile."
      end
    rescue ActiveRecord::RecordNotFound
      flash[:danger] = "User not found."
    end

    if flash[:danger]
      redirect_to root_url
    end
  end
end
