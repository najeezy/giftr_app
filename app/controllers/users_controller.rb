class UsersController < ApplicationController
  before_action :authenticate, only: [:feed, :show, :edit, :update, :destroy]
  before_action :authorize, only: [:feed, :edit, :update, :destroy]

  def feed
    @user = current_user

    gifts_without_buyers = []
    @upcoming_events = []
    @next_event = nil

    @user.friends.each do |friend|
      gifts_without_buyers += friend.gifts.reject { |gift| gift.buyer }

      @upcoming_events += friend.events.reject do |event|
        @next_event = event

        if event.date < @next_event.date && event.date >= Date.today
          @next_event = event
        end

        event.date < Date.today || event.date > 14.days.from_now
      end
    end

    @featured_gifts = gifts_without_buyers.sample(10)
    flash[:last_url] = user_feed_path(@user)
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      @user.buyer = Buyer.create
      session[:current_user] = @user.id
      @oauth = FBHelper.get_oauth_object(@user)
      redirect_to @oauth.url_for_oauth_code(:permissions => "user_friends")
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    num_requests = @user.friend_requests.count
    if num_requests > 0
      @requests = "(#{num_requests})"
    end
    flash[:last_url] = user_path(@user.id)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  def destroy
    session[:current_user] = nil
    User.find(params[:id]).destroy
    redirect_to root_path
  end

  private
  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :first_name, :last_name)
  end
end
