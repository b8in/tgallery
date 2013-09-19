require 'spec_helper'

describe "routing to user_comments" do

  it "routes /user_comments to user_comments#create (create new comment)" do
    {post: "/user_comments"}.should route_to(controller: "user_comments", action: "create")
    {post: create_comment_path}.should route_to(controller: "user_comments", action: "create")
  end

end