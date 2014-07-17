class EventsController < ApplicationController

  def index
    user = current_user
    @events = current_user.events

  end

  def new
    @user_id = current_user.id
    @event = Event.new
  end

  def create
    user = current_user
    date = params[:event][:date]
    params[:event][:date] = Event.check_date(params[:event][:date])

    @error_message = "You must enter a valid date" if params[:event][:date].nil?

    @event = Event.new(event_params)
    @event.user_id = user.id

    if @event.save
      user.events
      flash['event_id'] = @event.id
      flash['event_to_gift_message'] = 'Add a gift to this Event'
      redirect_to new_user_gift_path
    else
      render :new
    end
  end

  def show
    @event = Event.find(params[:id])
    flash['event_id'] = @event.id
    flash[:last_url] = event_path(@event)
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    @event = Event.find(params[:id])

    user = current_user
    date = params[:event][:date]

    params[:event][:date] = Event.check_date(params[:event][:date])

    @error_message = "You must enter a valid date" if params[:event][:date].nil?

    event.user_id = user.id

    if @event.update(event_params)
      redirect_to event_path(@event)
    else
      render :edit
    end

  end

  def destroy
    event = Event.find(params[:id])

    if session[:current_user] == event.user.id
      event.destroy
    end

    redirect_to user_events_path(current_user)
  end

  def event_params
    params.require(:event).permit(:title, :date)
  end
end
