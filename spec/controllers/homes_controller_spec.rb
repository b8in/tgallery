require 'spec_helper'

describe HomesController do

  describe "GET #index" do

    it "respond success, 200 OK" do
      get :index
      should respond_with(:success)
      should respond_with(200)
      #assert_response(:success)
    end

    it "render template and layouts" do
      get :index
      should render_template("index")
      should render_with_layout(:application)
    end

    context "display page-info:" do

      before do
        @categories = []
        7.times { |i|
          @categories[i] = FactoryGirl.create(:g_image_category)
          @categories[i].g_images.create(FactoryGirl.attributes_for(:g_image))
        }
      end

      it "categories names" do
        get :index
        assigns(:categories).should_not be_nil
        assigns(:categories).should have(6).items
        assigns(:categories).should start_with(@categories[6])
        assigns(:categories).should end_with(@categories[1])
      end

      it "categories images" do
        get :index
        @categories[6].should eql(assigns(:categories)[0])
        assigns(:categories)[0].should respond_to(:g_images)
        assigns(:categories)[0].g_images[0].image.should_not be_nil
      end
    end

    context "if user sign in" do

      before do
        FactoryGirl.create(:event, name: "navigation")
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "save navigation url" do
        get :index
        Navigation.last.should_not be_nil
        Navigation.last.e_history.user_id.should eq(@user.id)
        Navigation.last.e_history.event.name.should eq("navigation")
      end
    end

    context "if guest not sign in" do

      before do
        FactoryGirl.create(:event, name: "navigation")
      end

      it "save navigation url" do
        get :index
        Navigation.last.should be_nil
      end
    end

  end
end
