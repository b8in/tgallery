require 'spec_helper'

describe "routing to pusher" do

  it "routes pusher/auth to pusher#auth" do
    expect(post: '/pusher/auth').to route_to(controller: 'pusher', action: 'auth')
    expect(post: pusher_auth_path).to route_to(controller: 'pusher', action: 'auth')
  end

end