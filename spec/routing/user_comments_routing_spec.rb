require 'spec_helper'

describe "routing to user_comments" do

  it "routes /user_comments to user_comments#create (create new comment)" do
    expect(post: "/user_comments").to route_to(controller: "user_comments", action: "create")
    expect(post: create_comment_path).to route_to(controller: "user_comments", action: "create")
  end

  it "routes /comments to user_comments#index" do
    expect(get: "/comments").to route_to(controller: "user_comments", action: "index")
    expect(get: user_comments_path).to route_to(controller: "user_comments", action: "index")
  end

  it "routes /:locale/comments to user_comments#index" do
    expect(get: "/ru/comments").to route_to(controller: "user_comments", action: "index", locale: 'ru')
    expect(get: user_comments_path(locale: 'en')).to route_to(controller: "user_comments", action: "index", locale: 'en')
  end

  it "routes /load_all_comments to user_comments#load_all_comments" do
    expect(post: "/load_all_comments").to route_to(controller: "user_comments", action: "load_all_comments")
    expect(post: load_all_comments_path).to route_to(controller: "user_comments", action: "load_all_comments")
  end

end