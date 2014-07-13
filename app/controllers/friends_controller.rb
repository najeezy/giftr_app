class FriendsController < ApplicationController
  before_action :authenticate
  before_action :authorize, only: [:index]

  def index
    @user = current_user
    @suggested_friends = @user.suggested_friends.reject { |user| @user.friends.include?(user) }
    @suggested_friends = @suggested_friends.reject { |user| user.nil? }

    flash[:last_url] = user_friends_path(@user)
  end

  def create
    user = current_user
    if request = user.friend_requests.find_by(sender_id: params[:user_id])
      user.accept_friend_request(request)
    end

    redirect_to flash[:last_url]
  end

  def destroy
    current_user.defriend(User.find(params[:id]))

    redirect_to flash[:last_url]
  end

  def search
    @users = User.all
  end

end
