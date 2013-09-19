require 'spec_helper'

describe "routing to user events" do

  before do
    @user = FactoryGirl.create(:user)
    @event = FactoryGirl.create(:event)
  end
  
  it "routes /events to events#index (all user events)" do
    {get:"/events"}.should route_to(controller: "events", action: "index")
    {get:events_path}.should route_to(controller: "events", action: "index")
  end

  it "routes events/:user_id/:event_name to events#show (some event of some user)" do
    {get:"/events/#{@user.id}/#{@event.name}"}.should route_to( controller: "events",
                                                                action: "show",
                                                                user_id: @user.id.to_s,
                                                                event_name: @event.name)
    {get:event_path(user_id:@user.id, event_name:@event.name)}.should route_to( controller: "events",
                                                                                action: "show",
                                                                                user_id: @user.id.to_s,
                                                                                event_name: @event.name)
  end

  it "routes /events/:id is wrong" do
    {get:"/events/#{@event.id}"}.should_not route_to( controller: "events",
                                                      action: "show",
                                                      id: @event.id.to_s)
    {get:"/events/#{@event.id}"}.should_not be_routable
  end
end