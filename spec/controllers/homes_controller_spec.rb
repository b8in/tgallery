require 'spec_helper'

describe HomesController do

  it "respond success, 200 OK" do
    get :index
    should respond_with(:success)
    should respond_with(200)
    assert_response(:success)
  end

  it "render template and layouts" do
    get :index
    should render_template("index")
    should render_with_layout(:application)
  end

  context "display root-info: " do
    it "categories names" do
      categories = []
      7.times { |i|
        categories[i] = FactoryGirl.create(:g_image_category)
      }
      get :index
      expect(assigns(:categories)).to_not be_nil
      expect(assigns(:categories)).to_not be_nil
    #  expect(assigns(:categories)).to_has categories[0]
    end
  end
end
