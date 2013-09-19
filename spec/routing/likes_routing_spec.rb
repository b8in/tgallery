require 'spec_helper'

describe "routing to likes" do

  it "routes /likes to likes#create (add like to image)" do
    {post: "/likes"}.should route_to(controller: "likes",action: "create")
    {post: set_like_path}.should route_to(controller: "likes", action: "create")
  end

end