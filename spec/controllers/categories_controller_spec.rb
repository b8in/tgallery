require 'spec_helper'

describe CategoriesController do

  describe "GET #index" do

    it "respond success, 200 OK" do
      get :index
      expect(response).to be_success
      expect(response.status).to eq(200)
    end

    it "render template" do
      get :index
      expect(response).to render_template("index")
    end


  end

  #describe "GET #show" do
  #
  #end

end
