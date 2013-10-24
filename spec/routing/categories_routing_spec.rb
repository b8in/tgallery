require 'spec_helper'

describe "routing to categories" do

  let(:category) { FactoryGirl.create(:g_image_category) }
  
  it "routes /categories to categories#index" do
    expect(get:"/categories").to route_to(controller: "categories",action: "index")
    expect(get:categories_path).to route_to(controller: "categories",action: "index")
  end

  it "routes categories/:category_name to categories#show_by_name" do
    expect(get:"/categories/#{category.name}").to route_to(controller: "categories",
                                                           action: "show_by_name",
                                                           category_name: category.name)
    expect(get:category_path(category_name: category.name)).to route_to(controller: "categories",
                                                                        action: "show_by_name",
                                                                        category_name: category.name)
  end

  it "routes /:locale/categories to categories#index" do
    expect(get:"/ru/categories").to route_to(controller: "categories",action: "index", locale: 'ru')
    expect(get:categories_path(locale: 'en')).to route_to(controller: "categories",action: "index", locale: 'en')
  end

  it "routes /categories/:id is wrong" do
    expect(get:"/categories/#{category.id}").not_to route_to(controller: "categories",
                                                             action: "show_by_name",
                                                             id: category.id.to_s)
  end
end