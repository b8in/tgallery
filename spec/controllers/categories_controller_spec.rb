require 'spec_helper'

describe CategoriesController do

  describe "GET #index" do

    it "respond success, 200 OK" do
      get :index
      should respond_with(:success)
      should respond_with(200)
    end

    it "render template and layouts" do
      get :index
      should render_template("index")
      should render_with_layout(:application)
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
        assigns(:categories).should start_with(@categories[CATEGORIES_COUNT-2])
      end

      it "categories on page" do
        get :index
        assigns(:categories).should_not be_nil
        assigns(:categories).should have(5).items
        assigns(:categories).should start_with(@categories[CATEGORIES_COUNT-1])
        assigns(:categories).should end_with(@categories[CATEGORIES_COUNT-5])
        assigns(:category_likes_count_hash).should_not be_nil
        assigns(:category_likes_count_hash).should have(5).items
        assigns(:category_comments_count_hash).should_not be_nil
        assigns(:category_comments_count_hash).should have(5).items
      end

      it "categories images" do
        get :index
        @categories[CATEGORIES_COUNT-1].should eql(assigns(:categories)[0])
        assigns(:categories)[0].should respond_to(:g_images)
        assigns(:categories)[0].g_images[0].image.should_not be_nil
      end

      it "categories images count" do
        @categories[CATEGORIES_COUNT-2].g_images.create(FactoryGirl.attributes_for(:g_image))
        @categories[CATEGORIES_COUNT-2].g_images.create(FactoryGirl.attributes_for(:g_image))
        @categories[CATEGORIES_COUNT-2].g_images.create(FactoryGirl.attributes_for(:g_image))
        @categories[CATEGORIES_COUNT-1].g_images.create(FactoryGirl.attributes_for(:g_image))
        get :index
        assigns(:categories)[0].should respond_to(:g_images)
        assigns(:categories)[0].g_images.should have(2).images
        assigns(:categories)[1].should respond_to(:g_images)
        assigns(:categories)[1].g_images.should have(4).images
        assigns(:categories)[2].should respond_to(:g_images)
        assigns(:categories)[2].g_images.should have(1).image
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
        assigns(:category_likes_count_hash).should have_key(@categories[CATEGORIES_COUNT-2].name)
        assigns(:category_likes_count_hash)[@categories[CATEGORIES_COUNT-2].name].should == 3
        assigns(:category_likes_count_hash).should have_key(@categories[CATEGORIES_COUNT-1].name)
        assigns(:category_likes_count_hash)[@categories[CATEGORIES_COUNT-1].name].should == 3
        assigns(:category_likes_count_hash).should have_key(@categories[CATEGORIES_COUNT-3].name)
        assigns(:category_likes_count_hash)[@categories[CATEGORIES_COUNT-3].name].should == 1
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
        assigns(:category_comments_count_hash).should have_key(@categories[CATEGORIES_COUNT-2].name)
        assigns(:category_comments_count_hash)[@categories[CATEGORIES_COUNT-2].name].should == 2
        assigns(:category_comments_count_hash).should have_key(@categories[CATEGORIES_COUNT-1].name)
        assigns(:category_comments_count_hash)[@categories[CATEGORIES_COUNT-1].name].should == 2
        assigns(:category_comments_count_hash).should have_key(@categories[CATEGORIES_COUNT-3].name)
        assigns(:category_comments_count_hash)[@categories[CATEGORIES_COUNT-3].name].should == 0
      end
    end

    #context "if user sign in" do
    #
    #  before do
    #    FactoryGirl.create(:event, name: "navigation")
    #    @user = FactoryGirl.create(:user)
    #    sign_in @user
    #  end
    #
    #  it "save navigation url" do
    #    get :index
    #    Navigation.last.should_not be_nil
    #    Navigation.last.e_history.user_id.should eq(@user.id)
    #    Navigation.last.e_history.event.name.should eq("navigation")
    #  end
    #end
    #
    #context "if guest not sign in" do
    #
    #  before do
    #    FactoryGirl.create(:event, name: "navigation")
    #  end
    #
    #  it "save navigation url" do
    #    get :index
    #    Navigation.last.should be_nil
    #  end
    #end

  end

  describe "GET #show_by_name" do
    before do
      @category = FactoryGirl.create(:g_image_category)
    end

    it "respond success, 200 OK" do
      get :show_by_name, category_name: @category.name
      should respond_with(:success)
      should respond_with(200)
    end

    it "render template and layouts" do
      get :show_by_name, category_name: @category.name
      should render_template("show_by_name")
      should render_with_layout(:application)
    end

    it "show 5 images on page" do
      6.times {
        @category.g_images.create(FactoryGirl.attributes_for(:g_image))
      }
      get :show_by_name, category_name: @category.name
      assigns(:images).should_not be_nil
      assigns(:images).should have(5).images
      assigns(:images).should_not include(@category.g_images[5])
    end
  end

end
