require 'spec_helper'

describe LikesController do

  describe "POST #create" do

    before do
      request.env["HTTP_REFERER"] = "where_i_came_from"
      FactoryGirl.create(:event, name:"likes")
      FactoryGirl.create(:event, name:"navigation")
      @image = FactoryGirl.create(:g_image)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "should redirect to back" do
      post :create, image_id: @image.id
      response.should redirect_to "where_i_came_from"
    end

    it "saving in db" do
      Like.last.should be_nil

      post :create, image_id: @image.id
      Like.last.should_not be_nil
      Like.last.should be_valid
      GImage.find(@image.id).likes_count.should == 1
    end

  end

end
