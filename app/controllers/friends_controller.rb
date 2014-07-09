class FriendsController < ApplicationController
  before_action :authenticate
  before_action :authorize

  def index
    user = User.find(params[:user_id])
    @suggested_friends = user.suggested_friends
  end

  def create
  end

  def destroy
  end
end
