class WelcomeController < ApplicationController

  def index
    if session[:current_user]
      redirect_to user_feed_path(User.find(session[:current_user]))
    end
  end
end
