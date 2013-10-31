require 'spec_helper'

describe UserCommentsController do

  let!(:create_events) do
    FactoryGirl.create(:event, name:"comments")
    FactoryGirl.create(:event, name:"navigation")
  end
  let(:image) { FactoryGirl.create(:g_image) }
  let(:user) { FactoryGirl.create(:user) }

  describe "GET #index" do

    let!(:comments) { FactoryGirl.create_list(:user_comment, 3) }

    it "respond success, 200 OK" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it "render template and layouts" do
      get :index
      expect(response).to render_template("index")
      expect(response).to render_with_layout(:application)
    end

    it "@comments" do
      com = FactoryGirl.create(:user_comment, created_at: 100.years.ago)
      get :index
      expect(assigns(:comments)).not_to be_nil
      expect(assigns(:comments)).to have(4).comments
      expect(assigns(:comments)[0]).to eql com
      expect(assigns(:comments)[1]).to eql comments[0]
      expect(assigns(:comments)[3]).to eql comments[2]
    end

  end

  describe "POST #create" do

    context "with user sign in" do
      before do
        sign_in user
      end

      it "status 200 OK" do
        post :create, image_id: image.id, user_comment: {text: "bla-bla"}
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      it "render JSON" do
        post :create, image_id: image.id, user_comment: {text: "bla-bla"}
        expect(response.header['Content-Type']).to match /json/
      end

      it "valid comment" do
        post :create, image_id: image.id, user_comment: {text: "bla-bla"}
        expect(JSON.parse(response.body)['stat']).to eql 'success'
      end

      it "saving in db" do
        expect(UserComment.last).to be_nil

        post :create, image_id: image.id, user_comment: {text: "bla-bla"}
        expect(UserComment.last).not_to be_nil
        expect(UserComment.last).to be_valid
        expect(GImage.find(image.id).user_comments_count).to eq 1
      end
    end

    context "when guest" do

      it "without field 'author'" do
        expect {post :create, image_id: image.id, user_comment: {text: "bla-bla"}}.to raise_error
      end

      it "status 200 OK" do
        post :create, image_id: image.id, user_comment: {text: "bla-bla", author: "John"}
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      it "render JSON" do
        post :create, image_id: image.id, user_comment: {text: "bla-bla", author: "John"}
        expect(response.header['Content-Type']).to match /json/
      end

      it "saving in db" do
        expect(UserComment.last).to be_nil

        post :create, image_id: image.id, user_comment: {text: "bla-bla", author: "John"}
        expect(UserComment.last).not_to be_nil
        expect(UserComment.last).to be_valid
        expect(GImage.find(image.id).user_comments_count).to eq 1
      end
    end
  end

  describe "POST #load_all_comments" do
    it "status 200 OK" do
      post :load_all_comments, id: image.id
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it "render JSON" do
      post :load_all_comments, id: image.id
      expect(response.header['Content-Type']).to match /json/
    end
  end
end
