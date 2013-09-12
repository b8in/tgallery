class EventsController < ApplicationController
  def index
    @users = User.select([:id, :email]).includes(:events).all
    @events = Event.all
  end

  def show
    event= Event.where(name: params[:event_name]).first
    @h_events = EHistory.where(user_id: params[:user_id], event_id: event.id).page params[:page]
  end
end
