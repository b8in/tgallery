require 'spec_helper'

describe CategoriesController do

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

      before :all do
        CATEGORIES_COUNT = 7
      end

      before do
        @users = []
        3.times { |i|
          @users[i] = FactoryGirl.create(:user)
        }
        @event = FactoryGirl.create(:event, name:"likes")
        @categories = []
        CATEGORIES_COUNT.times { |i|
          @categories[i] = FactoryGirl.create(:g_image_category)
          @categories[i].g_images.create(FactoryGirl.attributes_for(:g_image))
          like = @categories[i].g_images[0].likes.create(FactoryGirl.attributes_for(:like))
          @users[0].e_histories.create(FactoryGirl.attributes_for(:e_history, event_id: @event.id, eventable: like))
        }

      end

      it "categories sorted by last update" do
        @categories[CATEGORIES_COUNT-2].g_images.create(FactoryGirl.attributes_for(:g_image))
        get :index
        expect(assigns(:categories)).to start_with(@categories[CATEGORIES_COUNT-2])
      end

      it "categories on page" do
        get :index
        expect(assigns(:categories)).not_to be_nil
        expect(assigns(:categories)).to have(5).items
        expect(assigns(:categories)).to start_with(@categories[CATEGORIES_COUNT-1])
        expect(assigns(:categories)).to end_with(@categories[CATEGORIES_COUNT-5])
        expect(assigns(:category_likes_count_hash)).not_to be_nil
        expect(assigns(:category_likes_count_hash)).to have(5).items
        expect(assigns(:category_comments_count_hash)).not_to be_nil
        expect(assigns(:category_comments_count_hash)).to have(5).items
      end

      it "categories images" do
        get :index
        expect(@categories[CATEGORIES_COUNT-1]).to eql(assigns(:categories)[0])
        expect(assigns(:categories)[0]).to respond_to(:g_images)
        expect(assigns(:categories)[0].g_images[0].image).not_to be_nil
      end

      it "categories images count" do
        @categories[CATEGORIES_COUNT-2].g_images.create(FactoryGirl.attributes_for(:g_image))
        @categories[CATEGORIES_COUNT-2].g_images.create(FactoryGirl.attributes_for(:g_image))
        @categories[CATEGORIES_COUNT-2].g_images.create(FactoryGirl.attributes_for(:g_image))
        @categories[CATEGORIES_COUNT-1].g_images.create(FactoryGirl.attributes_for(:g_image))
        get :index
        expect(assigns(:categories)[0]).to respond_to(:g_images)
        expect(assigns(:categories)[0].g_images).to have(2).images
        expect(assigns(:categories)[1]).to respond_to(:g_images)
        expect(assigns(:categories)[1].g_images).to have(4).images
        expect(assigns(:categories)[2]).to respond_to(:g_images)
        expect(assigns(:categories)[2].g_images).to have(1).image
      end

      it "categories likes count" do
        @categories[CATEGORIES_COUNT-2].g_images.create(FactoryGirl.attributes_for(:g_image))
        like = @categories[CATEGORIES_COUNT-2].g_images[0].likes.create(FactoryGirl.attributes_for(:like))
        @users[1].e_histories.create(FactoryGirl.attributes_for(:e_history, event_id: @event.id, eventable: like))
        like = @categories[CATEGORIES_COUNT-2].g_images[1].likes.create(FactoryGirl.attributes_for(:like))
        @users[1].e_histories.create(FactoryGirl.attributes_for(:e_history, event_id: @event.id, eventable: like))

        like = @categories[CATEGORIES_COUNT-1].g_images[0].likes.create(FactoryGirl.attributes_for(:like))
        @users[1].e_histories.create(FactoryGirl.attributes_for(:e_history, event_id: @event.id, eventable: like))
        like = @categories[CATEGORIES_COUNT-1].g_images[0].likes.create(FactoryGirl.attributes_for(:like))
        @users[2].e_histories.create(FactoryGirl.attributes_for(:e_history, event_id: @event.id, eventable: like))
        get :index
        expect(assigns(:category_likes_count_hash)).to have_key(@categories[CATEGORIES_COUNT-2].name)
        expect(assigns(:category_likes_count_hash)[@categories[CATEGORIES_COUNT-2].name]).to eq 3
        expect(assigns(:category_likes_count_hash)).to have_key(@categories[CATEGORIES_COUNT-1].name)
        expect(assigns(:category_likes_count_hash)[@categories[CATEGORIES_COUNT-1].name]).to eq 3
        expect(assigns(:category_likes_count_hash)).to have_key(@categories[CATEGORIES_COUNT-3].name)
        expect(assigns(:category_likes_count_hash)[@categories[CATEGORIES_COUNT-3].name]).to eq 1
      end

      it "categories comments count" do
        event = FactoryGirl.create(:event, name:"comments")
        @categories[CATEGORIES_COUNT-2].g_images.create(FactoryGirl.attributes_for(:g_image))

        com = @categories[CATEGORIES_COUNT-2].g_images[0].user_comments.create(FactoryGirl.attributes_for(:user_comment))
        @users[1].e_histories.create(FactoryGirl.attributes_for(:e_history, event_id: event.id, eventable: com))
        com = @categories[CATEGORIES_COUNT-2].g_images[1].user_comments.create(FactoryGirl.attributes_for(:user_comment))
        @users[1].e_histories.create(FactoryGirl.attributes_for(:e_history, event_id: event.id, eventable: com))

        com = @categories[CATEGORIES_COUNT-1].g_images[0].user_comments.create(FactoryGirl.attributes_for(:user_comment))
        @users[1].e_histories.create(FactoryGirl.attributes_for(:e_history, event_id: event.id, eventable: com))
        com = @categories[CATEGORIES_COUNT-1].g_images[0].user_comments.create(FactoryGirl.attributes_for(:user_comment))
        @users[2].e_histories.create(FactoryGirl.attributes_for(:e_history, event_id: event.id, eventable: com))
        get :index
        expect(assigns(:category_comments_count_hash)).to have_key(@categories[CATEGORIES_COUNT-2].name)
        expect(assigns(:category_comments_count_hash)[@categories[CATEGORIES_COUNT-2].name]).to eq 2
        expect(assigns(:category_comments_count_hash)).to have_key(@categories[CATEGORIES_COUNT-1].name)
        expect(assigns(:category_comments_count_hash)[@categories[CATEGORIES_COUNT-1].name]).to eq 2
        expect(assigns(:category_comments_count_hash)).to have_key(@categories[CATEGORIES_COUNT-3].name)
        expect(assigns(:category_comments_count_hash)[@categories[CATEGORIES_COUNT-3].name]).to eq 0
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
        expect(Navigation.last).not_to be_nil
        expect(Navigation.last.e_history.user_id).to eq(@user.id)
        expect(Navigation.last.e_history.event.name).to eq("navigation")
      end
    end

    context "if guest not sign in" do

      before do
        FactoryGirl.create(:event, name: "navigation")
      end

      it "save navigation url" do
        get :index
        expect(Navigation.last).to be_nil
      end
    end

  end

  describe "GET #show_by_name" do

    let(:category) { FactoryGirl.create(:g_image_category) }
    let(:user) { FactoryGirl.create(:user) }

    it "respond success, 200 OK" do
      get :show_by_name, category_name: category.name
      expect(response).to be_success
      expect(response.status).to eq 200
    end

    it "render template and layouts" do
      get :show_by_name, category_name: category.name
      expect(response).to render_template("show_by_name")
      expect(response).to render_with_layout(:application)
    end

    it "have right category" do
      get :show_by_name, category_name: category.name
      expect(assigns(:category)).to eq(category)
    end

    it "show 5 images on page" do

      6.times {
        category.g_images.create(FactoryGirl.attributes_for(:g_image))
      }
      get :show_by_name, category_name: category.name
      expect(assigns(:images)).not_to be_nil
      expect(assigns(:images)).to have(5).images
      expect(assigns(:images)).not_to include(category.g_images[5])
    end

    it "user isn't subscribed to category updates" do
      FactoryGirl.create(:event, name: "navigation")
      sign_in user
      get :show_by_name, category_name: category.name
      expect(assigns(:user_watch_this_category)).not_to be_nil
      expect(assigns(:user_watch_this_category)).to be_false
    end

    it "user is subscribed to category updates" do
      FactoryGirl.create(:event, name: "navigation")
      FactoryGirl.create(:watching_category, user_id: user.id, g_image_category_id: category.id)
      sign_in user
      get :show_by_name, category_name: category.name
      expect(assigns(:user_watch_this_category)).to be_true
    end
  end

end
