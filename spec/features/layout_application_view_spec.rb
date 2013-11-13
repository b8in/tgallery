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
    visit root_path(locale: :en)
  end

  after(:all) do
    clear_db
  end

  it "navbar success" do
    expect(page).to have_selector('.navbar')
  end

  it "footer success" do
    expect(page).to have_selector('.footer')
  end

  it "dropdown-menu categories" do
    10.times { |i|
      expect(page).to have_selector('ul.dropdown-menu li')
      expect(find('.pull-left ul.dropdown-menu')).to have_content @categories[i].name
    }
  end

  it "click dropdown-menu category link" do
    find('.pull-left ul.dropdown-menu').click_link(@categories[9].name)
    expect(current_path).to eq(category_path(category_name: @categories[9].name, locale: :en))
  end

  it "click brand link" do
    find('.navbar .brand').click
    expect(current_path).to eq(root_path(locale: :en))
  end

  it "click 'All images' link" do
    click_link('All images')
    expect(current_path).to eq(pictures_path(locale: :en))
  end

  it "click 'All comments' link" do
    click_link('All comments')
    expect(current_path).to eq(user_comments_path(locale: :en))
  end

  it "click language link" do
    find('.navbar .pull-right .dropdown').click
    language_links = all('.navbar .pull-right .dropdown-menu a')
    language_links[0].click
    #p current_path
    expect(current_path).to eq(root_path(locale: :ru))

    find('.navbar .pull-right .dropdown').click
    language_links = all('.navbar .pull-right .dropdown-menu a')
    language_links[1].click
    #p current_path
    expect(current_path).to eq(root_path(locale: :en))
  end

  it "click 'Sign in' link" do
    click_link('Sign in')
    expect(current_path).to eq(new_user_session_path(locale: :en))
  end

  it "click 'Sign up' link" do
    click_link('Sign up')
    expect(current_path).to eq(new_user_registration_path(locale: :en))
  end
end