class UsersController < ApplicationController
  before_action :authenticate, only: [:show, :edit, :update, :destroy]
  before_action :authorize, only: [:edit, :update, :destroy]


  def feed
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @oauth = Koala::Facebook::OAuth.new(305510936292740, '59d7fcd67796896198c3c150d4b0ac5c', user_feed_path(@user))
      code_url = @oauth.url_for_oauth_code
      binding.pry
      session[:current_user] = @user.id
      redirect_to user_feed_path(@user)
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    session[:current_user] = nil
    User.find(params[:id]).destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name)
  end
end
