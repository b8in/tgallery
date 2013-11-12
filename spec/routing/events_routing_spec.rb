require 'spec_helper'

describe "routing to user events" do

  let(:user) { FactoryGirl.create(:user) }
  let(:event) { FactoryGirl.create(:event) }
  
  it "routes /events to events#index (all user events)" do
    expect(get:"/events").to route_to(controller: "events", action: "index")
    expect(get:events_path).to route_to(controller: "events", action: "index")
  end

  it "routes events/:user_id/:event_name to events#show (some event of some user)" do
    expect(get:"/events/#{user.id}/#{event.name}").to route_to( controller: "events",
                                                                  action: "show",
                                                                  user_id: user.id.to_s,
                                                                  event_name: event.name)
    expect(get:event_path(user_id:user.id, event_name:event.name)).to route_to( controller: "events",
                                                                                  action: "show",
                                                                                  user_id: user.id.to_s,
                                                                                  event_name: event.name)
  end

  it "routes /:locale/events to events#index (all user events)" do
    expect(get:"/ru/events").to route_to(controller: "events", action: "index", locale: 'ru')
    expect(get:events_path(locale: 'en')).to route_to(controller: "events", action: "index", locale: 'en')
  end

  it "routes /events/:id is wrong" do
    expect(get:"/events/#{event.id}").not_to route_to( controller: "events",
                                                      action: "show",
                                                      id: event.id.to_s)
    expect(get:"/events/#{event.id}").not_to be_routable
  end
end