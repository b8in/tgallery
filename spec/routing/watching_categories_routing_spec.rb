require 'spec_helper'

describe "routing to watching_categories" do

  it "routes /watching_categories to watching_categories#create" do
    expect(post: "/watching_categories").to route_to(controller: "watching_categories", action: "create")
    expect(post: watching_categories_path).to route_to(controller: "watching_categories", action: "create")
  end

  it "routes /watching_categories to watching_categories#destroy" do
    expect(delete: "/watching_categories").to route_to(controller: "watching_categories", action: "destroy")
    expect(delete: watching_categories_path).to route_to(controller: "watching_categories", action: "destroy")
  end

end