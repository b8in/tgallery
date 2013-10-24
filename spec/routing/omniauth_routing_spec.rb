require 'spec_helper'

describe "routing to omniauth callbacks" do

  it "route /auth/facebook/callback" do
    expect(post: '/auth/facebook/callback').to route_to(controller: 'services', action: 'create')
    expect(post: auth_facebook_callback_path).to route_to(controller: 'services', action: 'create')
  end
end
