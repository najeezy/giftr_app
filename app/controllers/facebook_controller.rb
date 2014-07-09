class FacebookController < ApplicationController

  def access_token
    user = User.find(params[:user_id])
    @oauth = FBHelper.get_oauth_object(user)
    access_token = @oauth.get_access_token(params[:code])
    user.update_attribute(:fb_access_token, access_token)
    user.update_fb_attributes
    redirect_to user_feed_path(user)
  end

end
