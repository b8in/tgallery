require 'spec_helper'

describe PicturesController do

  describe "GET #index" do

    let(:images_count) { 12 }
    before do
      @images = []
      images_count.times do |i|
        lcount = i%2==0 ? 0 : i
        @images << FactoryGirl.create(:g_image, likes_count: lcount)
      end
      #
      # likes_count    0  1  2  3  4  5  ...  9  10  11
      # Index(@images) 0  1  2  3  4  5  ...  9  10  11
      #
    end

    it "respond success, 200 OK" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "render template and layouts" do
      get :index
      expect(response).to render_template("index")
      expect(response).to render_with_layout(:application)
    end

    it "@images only with category, limit = last 5 items, order by likes_count" do
      GImage.last.update_attributes(g_image_category_id: nil)    #last image hasn't category
      get :index
      expect(assigns(:images)).not_to be_nil
      expect(assigns(:images)).to have(5).images
      expect(assigns(:images)[0]).to eq GImage.order('likes_count').reverse_order.first(2).last     #first image with max likes_count hasn't category, then ignore it and take next
      expect(assigns(:images)[0]).to eql @images[9]
      expect(assigns(:images)[4]).to eql @images[1]
    end

  end

  describe "GET #show" do

    let(:image) { FactoryGirl.create(:g_image) }
    let(:user) { FactoryGirl.create(:user) }
    let!(:event) { FactoryGirl.create(:event, name: "comments") }

    it "respond success, 200 OK" do
      get :show, category_name: image.g_image_category.name ,id: image.id
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "render template and layouts" do
      get :show, category_name: image.g_image_category.name ,id: image.id
      expect(response).to render_template("show")
      expect(response).to render_with_layout(:application)
    end

    it "@comment should be new" do
      get :show, category_name: image.g_image_category.name ,id: image.id
      expect(assigns(:comment)).to be_new_record
    end

    it "@comments" do
      comment = image.user_comments.create(FactoryGirl.attributes_for(:user_comment))
      user.e_histories.create(date: Time.now, event_id: event.id, eventable: comment)

      get :show, category_name: image.g_image_category.name ,id: image.id
      expect(assigns(:comments)).not_to be_nil
      expect(assigns(:comments)).to have(1).comment
      expect(GImage.find(image.id).user_comments_count).to eq 1
    end

    it "@comments limit = last 3 items" do
      COMMENTS_COUNT = 4
      COMMENTS_COUNT.times do |i|
        com = image.user_comments.create(FactoryGirl.attributes_for(:user_comment))
        user.e_histories.create(date: Time.now, event_id: event.id, eventable: com)
      end
      comments = image.user_comments

      get :show, category_name: image.g_image_category.name ,id: image.id
      expect(assigns(:comments)).not_to be_nil
      expect(assigns(:comments)).to have(3).comments
      expect(assigns(:comments)[2]).to eql comments[COMMENTS_COUNT - 1]
      expect(assigns(:comments)[0]).to eql comments[COMMENTS_COUNT - 3]
      expect(GImage.find(image.id).user_comments_count).to eq COMMENTS_COUNT
    end

    it "@image" do
      get :show, category_name: image.g_image_category.name ,id: image.id
      expect(assigns(:image)).not_to be_nil
      expect(assigns(:image)).to eql(image)
    end
  end

  describe "POST #refresh_captcha_div" do
    it "respond success, 200 OK" do
      post :refresh_captcha_div
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "render partial without layouts" do
      post :refresh_captcha_div
      expect(response).to render_template("simple_captcha/_simple_captcha_block")
      expect(response).not_to render_with_layout
    end
  end
end
