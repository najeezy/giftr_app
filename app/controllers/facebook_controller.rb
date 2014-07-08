class FacebookController < ApplicationController

  def new
    user = User.find(params[:id])
    user.fb_access_token = @oauth.get_access_token(params[:code])
    redirect_to user_feed_path(user)
  end

end
