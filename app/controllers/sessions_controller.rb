class SessionsController < ApplicationController
  def new
  end

  def create
    @user = User.find_by(username: params[:username])

    if @user && @user.authenticate(params[:password])
        session[:current_user] = @user.id
        @oauth = FBHelper.get_oauth_object(@user)
        flash['last_url'] = sessions_path
        redirect_to @oauth.url_for_oauth_code(:permissions => "user_friends")
    else
      @error = "Wrong username or password"
      render :new
    end
  end

  def destroy
    User.find(session[:current_user]).update_attribute(:fb_access_token, nil)
    session[:current_user] = nil

    redirect_to root_path
  end
end
