class UsersController < ApplicationController
  before_action :already_login?, only: [:new, :create, :shoe]
  before_action :login?, only: :show

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path, notice: "サインインしました。"
    else
      render :new
    end
  end

  def show
    @movie = Movie.new
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
