require 'spec_helper'

describe EventsController do

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

    it "variables" do
      users = []
      3.times { |i|
        users[i] = FactoryGirl.create(:user)
      }
      event = FactoryGirl.create(:event, name:"navigation")
      sign_in users[0]
      get :index
      assigns(:users).should_not be_nil
      assigns(:users).should have(3).users
      assigns(:users)[0].should respond_to(:email)
      assigns(:users)[0].should respond_to(:id)
      lambda { assigns(:users)[0] }.should_not respond_to(:encrypted_password)
      lambda { assigns(:users)[0] }.should_not respond_to(:admin)

      assigns(:events).should_not be_nil
      assigns(:events).should have(1).event
      assigns(:events)[0].name.should eq event.name
    end
  end

  describe "Get #show" do

    before do
      @event = FactoryGirl.create(:event, name:"navigation")
      @user = FactoryGirl.create(:user)
    end

    it "respond success, 200 OK" do
      get :show, user_id: @user.id, event_name: @event.name
      should respond_with(:success)
      should respond_with(200)
    end

    it "render template and layouts" do
      get :show, user_id: @user.id, event_name: @event.name
      should render_template("show")
      should render_with_layout(:application)
    end

    it "variables" do
      sign_in @user
      get :show, user_id: @user.id, event_name: @event.name
      assigns(:h_events).should_not be_nil
      assigns(:h_events).should have(1).event

      get :index
      get :show, user_id: @user.id, event_name: @event.name
      assigns(:h_events).should_not be_nil
      assigns(:h_events).should have(3).events

      assigns(:h_events)[0].event.name.should eq @event.name
    end
  end

end
