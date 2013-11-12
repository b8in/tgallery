require 'spec_helper'

describe "routing to root page" do

  it "routes / to homes#index" do
    expect(get: "/").to route_to(controller: "homes",action: "index")
    expect(get: "/ru").to route_to(controller: "homes",action: "index", locale: 'ru')
    expect(get: root_path).to route_to(controller: "homes",action: "index")
    expect(get: root_path(locale: 'en')).to route_to(controller: "homes",action: "index", locale: 'en')
    #get("/").should route_to(controller: "homes",action: "index")
  end

  it "routes /change_locale to homes#change_locale" do
    expect(get: "/homes/change_locale").to route_to(controller: "homes",action: "change_locale")
    expect(get: "/ru/homes/change_locale").to route_to(controller: "homes",action: "change_locale", locale: 'ru')
    expect(get: change_locale_path).to route_to(controller: "homes",action: "change_locale")
    expect(get: change_locale_path(locale: 'en')).to route_to(controller: "homes",action: "change_locale", locale: 'en')
  end

end