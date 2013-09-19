require 'spec_helper'

describe "routing to picture" do

  before do
    @category = FactoryGirl.create(:g_image_category)
    @image = @category.g_images.create(FactoryGirl.attributes_for(:g_image))
  end

  it "routes /categories/:category_name/:id to pictures#show" do
    {get:"/categories/#{@category.name}/#{@image.id}"}.should route_to( controller: "pictures",
                                                                        action: "show",
                                                                        category_name: @category.name,
                                                                        id: @image.id.to_s)
    {get:picture_path(category_name: @category.name, id: @image.id)}.should route_to( controller: "pictures",
                                                                        action: "show",
                                                                        category_name: @category.name,
                                                                        id: @image.id.to_s)
  end

end