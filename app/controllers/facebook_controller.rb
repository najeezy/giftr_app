class FacebookController < ApplicationController

  def access_token
    user = User.find(params[:user_id])
    @oauth = FBHelper.get_oauth_object(user)
    access_token = @oauth.get_access_token(params[:code])

    fb_id = FBHelper.get_id(access_token)
    redirect_url = user_feed_path(user)

    if flash['last_url'] == sessions_path
      user.update_attribute(:fb_access_token, access_token)

      if fb_id != user.facebook_id
        redirect_url = fb_user_error_path
      else
        user.update_profile_image
      end

    else
      flash['signup_id'] = user.id

      if User.find_by(facebook_id: fb_id)
        redirect_url = fb_user_error_path
      else
        user.update_fb_attributes
      end

    end

    redirect_to redirect_url
  end

  def fb_user_error
    if flash['signup_id']
      user = User.find(flash['signup_id'])
      user.destroy if user
    end
    session[:current_user] = nil
  end

end
