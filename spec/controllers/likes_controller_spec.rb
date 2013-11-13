require 'spec_helper'

describe LikesController do

  let!(:event_likes) { FactoryGirl.create(:event, name:"likes") }
  let!(:event_nav) { FactoryGirl.create(:event, name:"navigation") }
  let(:image) { FactoryGirl.create(:g_image) }
  let(:user) { FactoryGirl.create(:user) }

  describe "POST #create" do

    before do
      #request.env["HTTP_REFERER"] = "where_i_came_from"
      sign_in user
    end

    it "should redirect to back" do
      post :create, image_id: image.id
      expect(response).to be_success
      #response.should redirect_to "where_i_came_from"
    end

    it "saving in db" do
      expect(Like.last).to be_nil

      post :create, image_id: image.id
      expect(Like.last).not_to be_nil
      expect(Like.last).to be_valid
      expect(EHistory.last).not_to be_nil
      expect(GImage.find(image.id).likes_count).to eq 1
    end

  end

end
