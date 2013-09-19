require 'spec_helper'

describe "routing to categories" do

  before do
    @category = FactoryGirl.create(:g_image_category)
  end
  
  it "routes /categories to categories#index" do
    {get:"/categories"}.should route_to(controller: "categories",action: "index")
    {get:categories_path}.should route_to(controller: "categories",action: "index")
  end

  it "routes categories/:category_name to categories#show_by_name" do
    {get:"/categories/#{@category.name}"}.should route_to(controller: "categories",
                                                          action: "show_by_name",
                                                          category_name: @category.name)
    {get:category_path(category_name: @category.name)}.should route_to(controller: "categories",
                                                          action: "show_by_name",
                                                          category_name: @category.name)
  end

  it "routes /categories/:id is wrong" do
    {get:"/categories/#{@category.id}"}.should_not route_to(controller: "categories",
                                                            action: "show_by_name",
                                                            id: @category.id.to_s)
  end
end