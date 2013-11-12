require 'spec_helper'

describe "routing to services" do

  it "routes services/:id to services#destroy" do
    service = double("service")
    service.stub(:id).and_return(1)
    expect(delete: "/services/#{service.id}").to route_to(controller: "services", action: "destroy", id: service.id.to_s)
    expect(delete: service_path(service.id)).to route_to(controller: "services", action: "destroy", id: service.id.to_s)
  end

end