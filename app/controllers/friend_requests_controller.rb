class FriendRequestsController < ApplicationController
  before_action :authenticate
  # before_action :authorize

  def index
    @requests = current_user.friend_requests
  end

  def create
    main_user = current_user
    main_user.make_friend_request(User.find(params[:user_id]))
    redirect_to flash[:last_url]
  end

  def destroy
    main_user = current_user
    request = FriendRequest.find(params[:id])
    if main_user.id = request.user_id || request.sender_id == main_user.id
      request.destroy
    end
      redirect_to flash[:last_url]
  end

end
