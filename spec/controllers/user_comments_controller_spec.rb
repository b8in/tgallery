require 'spec_helper'

describe UserCommentsController do

  describe "POST #create" do

    before do
      FactoryGirl.create(:event, name:"comments")
      FactoryGirl.create(:event, name:"navigation")
      @image = FactoryGirl.create(:g_image)
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it "should redirect to back" do
      post :create, image_id: @image.id, user_comment: {text: "bla-bla"}
      should respond_with(:success)
      should respond_with(200)
    end

    it "saving in db" do
      UserComment.last.should be_nil

      post :create, image_id: @image.id, user_comment: {text: "bla-bla"}
      UserComment.last.should_not be_nil
      UserComment.last.should be_valid
      GImage.find(@image.id).user_comments_count.should == 1
    end
  end
end
