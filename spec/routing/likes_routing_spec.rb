require 'spec_helper'

describe "routing to likes" do

  it "routes /likes to likes#create (add like to image)" do
    expect(post: "/likes").to route_to(controller: "likes",action: "create")
    expect(post: set_like_path).to route_to(controller: "likes", action: "create")
  end

end