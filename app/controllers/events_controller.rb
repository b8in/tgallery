class EventsController < ApplicationController
  before_filter :must_be_admin

  def index
    @users = User.select([:id, :email]).includes(:events).order(:email).all
    @events = Event.all
  end

  def show
    event= Event.where(name: params[:event_name]).first
    @h_events = EHistory.where(user_id: params[:user_id], event_id: event.id).page params[:page]
  end

  private
  def must_be_admin
    redirect_to root_path, alert: t('events.must_be_admin.access_denied') unless (!!current_user && current_user.try(:admin))
  end
end
