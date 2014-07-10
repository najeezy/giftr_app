class FriendRequestsController < ApplicationController
  before_action :authenticate
  # before_action :authorize

  def index
    @requests = current_user.friend_requests
  end

  def create
    user = User.find(params[:user_id])
    user.make_friend_request(User.find(params[:requester_id]))
    redirect_to user_friend_requests_path(user)
  end

  def destroy
    user = current_user
    request = user.friend_requests.find(params[:id])
    binding.pry
    user.friend_requests.delete(request)
    request.destroy
    redirect_to user_friend_requests_path(user)
  end

end
