require 'spec_helper'

describe "routing to root page" do

  it "routes / to homes#index" do
    {get: "/"}.should route_to(controller: "homes",action: "index")
    {get: root_path}.should route_to(controller: "homes",action: "index")
    #get("/").should route_to(controller: "homes",action: "index")
  end

end