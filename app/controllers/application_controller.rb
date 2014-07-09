class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  private
  def current_user
    User.find(session[:current_user]) if session[:current_user]
  end

  def authenticate
    if !session[:current_user]
      redirect_to login_path
    end
  end

  def authorize
    if session[:current_user] != params[:id].to_i && session[:current_user] != params[:user_id].to_i
      redirect_to user_feed_path(User.find(session[:current_user]))
    end
  end
end
