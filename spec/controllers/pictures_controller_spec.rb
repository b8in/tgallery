require 'spec_helper'

describe PicturesController do

  describe "GET #show" do

    before do
      @image = FactoryGirl.create(:g_image)
    end

    it "respond success, 200 OK" do
      get :show, category_name: @image.g_image_category.name ,id: @image.id
      should respond_with(:success)
      should respond_with(200)
    end

    it "render template and layouts" do
      get :show, category_name: @image.g_image_category.name ,id: @image.id
      should render_template("show")
      should render_with_layout(:application)
    end

    it "@comment should be new" do
      get :show, category_name: @image.g_image_category.name ,id: @image.id
      assigns(:comment).should be_new_record
    end

    it "@comments" do
      user = FactoryGirl.create(:user)
      comment = @image.user_comments.create(FactoryGirl.attributes_for(:user_comment))
      event = FactoryGirl.create(:event, name: "comments")
      user.e_histories.create(date: Time.now, event_id: event.id, eventable: comment)

      get :show, category_name: @image.g_image_category.name ,id: @image.id
      assigns(:comments).should_not be_nil
      assigns(:comments).should have(1).comment
      GImage.find(@image.id).user_comments_count.should == 1
    end

    it "@image" do
      get :show, category_name: @image.g_image_category.name ,id: @image.id
      assigns(:image).should_not be_nil
      assigns(:image).should eql(@image)
    end
  end
end
