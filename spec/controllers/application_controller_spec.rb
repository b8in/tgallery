require 'spec_helper'

describe ApplicationController do

  describe "private methods" do

    before do
      #@user = FactoryGirl.create(:user)
      @controller = ApplicationController.new
    end

    it "load_categories" do
      FactoryGirl.create_list(:g_image_category, 10)

      @controller.send(:load_categories)
      expect(assigns(:categories_menu)).not_to be_nil
      expect(assigns(:categories_menu)).to have(10).categories
    end

  end
end
