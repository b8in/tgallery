require 'spec_helper'

describe "layouts/application" do

  before(:all) do
    @categories = []
    10.times { |i|
      @categories[i] = FactoryGirl.create(:g_image_category)
      @categories[i].g_images.create(FactoryGirl.attributes_for(:g_image))
    }
  end

  before(:each) do
    visit root_path
  end

  after(:all) do
    clear_db
  end

  it "navbar success" do
    expect(page).to have_selector('.navbar')
    10.times { |i|
      expect(page).to have_selector('ul.dropdown-menu li')
      expect(find('.pull-left ul.dropdown-menu')).to have_content @categories[i].name
    }
  end

end