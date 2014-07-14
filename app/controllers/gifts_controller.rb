class GiftsController < ApplicationController
  before_action :authenticate
  before_action :authorize, only: [:new, :create]

  def index
    user = User.find(params[:user_id])
    @events = user.events
    flash['last_url'] = user_gifts_path(user)
  end

  def new
    @message_from_event = flash['event_to_gift_message']
    @event = Event.find(flash['event_id']) if flash['event_id']
    flash['event_id'] = @event.id if @event
  end

  def create
    @gift = Gift.new(gift_params)
    @gift.user_id = current_user.id
    if @gift.save
      render :specifics
    else
      @error = "That search result did not save. Try again."
      render :new
    end
  end

  def show
    @gift = Gift.find(params[:id])
    flash['last_url'] = gift_path(@gift)
  end

  def edit
    @gift = current_user.gifts.find(params[:id])
  end

  def update
    user = current_user
    @gift = Gift.find(params[:id])

    if @gift.update(gift_params)
      redirect_to user_gifts_path(user)
    else
      redirect_to user_feed_path(user)
    end
  end

  def destroy
    gift = Gift.find(params[:id])

    if gift.user.id == session[:current_user]
      gift.destroy
    else
      redirect_to root_path
    end

    redirect_to user_gifts_path(gift.user)
  end

  def claim
    user = current_user
    gift = Gift.find(params[:gift_id])

    if user.friends.include?(gift.user)
      gift.buyer = user.buyer
      gift.save
    end

    redirect_to flash['last_url']
  end

  def cancel
    user = current_user
    gift = Gift.find(params[:gift_id])

    if user = gift.buyer.purchaser
      gift.buyer_id = nil
      gift.status = 'cancelled'
      gift.save
    end

    redirect_to flash['last_url']
  end

  def search
    @gift = Gift.new
    @user = current_user
    events = @user.events
    @events_select = events.map { |event| [event.title, event.id] }
    @selected_event_id = flash['event_id']
    @search_term = params[:search_term]
    @results = Amazon.search(params[:search_term])

  end

  def gift_params
    params.require(:gift).permit(:name, :specifics, :category, :price, :small_image_url, :large_image_url, :amazon_url, :event_id, :status, :buyer_id, :user_id)
  end
end
