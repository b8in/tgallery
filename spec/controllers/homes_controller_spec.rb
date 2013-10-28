require 'spec_helper'

describe HomesController do

  let!(:event) { FactoryGirl.create(:event, name: "navigation") }

  describe "GET #index" do

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
        expect(assigns(:categories)).not_to be_nil
        expect(assigns(:categories)).to have(6).items
        expect(assigns(:categories)).to start_with(@categories[6])
        expect(assigns(:categories)).to end_with(@categories[1])
      end

      it "categories images" do
        get :index
        expect(@categories[6]).to eql(assigns(:categories)[0])
        expect(assigns(:categories)[0]).to respond_to(:g_images)
        expect(assigns(:categories)[0].g_images[0].image).not_to be_nil
      end
    end

    context "if user sign in" do

      before do
        @user = FactoryGirl.create(:user)
        sign_in @user
      end

      it "save navigation url" do
        get :index
        expect(Navigation.last).not_to be_nil
        expect(Navigation.last.e_history.user_id).to eq(@user.id)
        expect(Navigation.last.e_history.event.name).to eq(event.name)
      end
    end

    context "if guest" do

      it "don't save navigation url" do
        get :index
        expect(Navigation.last).to be_nil
      end
    end

  end

  describe "GET #change_locale" do

    it "change locale" do
      get :index
      I18n.locale = :ru
      get :change_locale, new_locale: 'en', back_url: root_path
      expect(I18n.locale).to eq :en
      get :index
      expect(I18n.locale).to eq :en
    end
  end
end
