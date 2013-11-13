require 'spec_helper'

describe "routing to pictures" do

  let(:category) { FactoryGirl.create(:g_image_category) }
  let(:image) { category.g_images.create(FactoryGirl.attributes_for(:g_image)) }

  it "routes /categories/:category_name/:id to pictures#show" do
    expect(get:"/categories/#{category.name}/#{image.id}").to route_to( controller: "pictures",
                                                                        action: "show",
                                                                        category_name: category.name,
                                                                        id: image.id.to_s)
    expect(get:picture_path(category_name: category.name, id: image.id)).to route_to( controller: "pictures",
                                                                        action: "show",
                                                                        category_name: category.name,
                                                                        id: image.id.to_s)
  end

  it "routes /pictures to pictures#index" do
    expect(get: "/pictures").to route_to(controller: "pictures", action: "index")
    expect(get: pictures_path).to route_to(controller: "pictures", action: "index")
  end

  it "routes /:locale/pictures to pictures#index" do
    expect(get: "/ru/pictures").to route_to(controller: "pictures", action: "index", locale: 'ru')
    expect(get: pictures_path(locale: 'en')).to route_to(controller: "pictures", action: "index", locale: 'en')
  end

  it "routes /pictures/refresh_captcha_div to pictures#refresh_captcha_div" do
    expect(post: "/pictures/refresh_captcha_div").to route_to(controller: "pictures", action: "refresh_captcha_div")
    expect(post: pictures_refresh_captcha_div_path).to route_to(controller: "pictures", action: "refresh_captcha_div")
  end

end