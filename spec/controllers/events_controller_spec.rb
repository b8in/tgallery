require 'spec_helper'

describe EventsController do

  let!(:event) { FactoryGirl.create(:event, name:"navigation") }
  let!(:admin) { FactoryGirl.create(:user, admin: true) }

  describe "GET #index" do

    context "sign in as admin" do

      before do
        sign_in admin
      end

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

      it "show statistics info" do
        users = FactoryGirl.create_list(:user, 2)

        get :index
        expect(assigns(:users)).not_to be_nil
        expect(assigns(:users)).to have(3).users
        expect(assigns(:users)[0]).to respond_to(:email)
        expect(assigns(:users)[0]).to respond_to(:id)
        expect { assigns(:users)[0] }.not_to respond_to(:admin)

        expect(assigns(:events)).not_to be_nil
        expect(assigns(:events)).to have(1).event
        expect(assigns(:events)[0].name).to eq event.name
      end
    end

    context "guest or sign in as user" do

      it "redirect to root page" do
        get :index
        expect(response).not_to render_template("index")
        expect(response).to redirect_to(root_path)
      end

    end
  end

  describe "Get #show" do

    let(:user) { FactoryGirl.create(:user) }

    context "sign in as admin" do
      before do
        sign_in admin
      end

      it "respond success, 200 OK" do
        get :show, user_id: user.id, event_name: event.name
        expect(response).to be_success
        expect(response.status).to eq 200
      end

      it "render template and layouts" do
        get :show, user_id: user.id, event_name: event.name
        expect(response).to render_template("show")
        expect(response).to render_with_layout(:application)
      end

      it "variables" do
        get :show, user_id: admin.id, event_name: event.name
        expect(assigns(:h_events)).not_to be_nil
        expect(assigns(:h_events)).to have(1).event

        get :index
        get :show, user_id: admin.id, event_name: event.name
        expect(assigns(:h_events)).not_to be_nil
        expect(assigns(:h_events)).to have(3).events

        expect(assigns(:h_events)[0].event.name).to eq event.name
      end
    end

    context "guest or sign in as user" do

      it "redirect to root page" do
        get :show, user_id: admin.id, event_name: event.name
        expect(response).not_to render_template("show")
        expect(response).to redirect_to(root_path)
      end

    end
  end

end
