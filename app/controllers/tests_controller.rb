class TestsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
      session[:current_user] = @user.id
      redirect_to user_feed_path(@user)
    else
      @error = "Wrong username or password"
      render :new
    end

  end

  def destroy
    session[:current_user] = nil

    redirect_to root_path
  end

end
