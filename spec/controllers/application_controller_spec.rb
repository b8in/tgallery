require 'spec_helper'

describe ApplicationController do

  describe "private methods" do

    before do
      @user = FactoryGirl.create(:user)
      @controller = ApplicationController.new
    end

    it "load_categories" do
      10.times {
        FactoryGirl.create(:g_image_category)
      }
      @controller.send(:load_categories)
      assigns(:categories_menu).should_not be_nil
      assigns(:categories_menu).should have(10).categories
    end

  end
end
