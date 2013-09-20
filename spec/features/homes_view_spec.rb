require 'spec_helper'

describe "homes/index" do
  before do
    @categories = []
    10.times { |i|
      @categories[i] = FactoryGirl.create(:g_image_category)
      2.times {
        @categories[i].g_images.create(FactoryGirl.attributes_for(:g_image))
      }
    }
  end

  it "check page content" do
    visit root_path
    page.should have_selector('.navbar')
    find('#about-tgallery').should_not be_nil
    find('.image-categories-container').should_not be_nil
    10.times { |i|
      page.should have_selector('ul.dropdown-menu li')
      find('ul.dropdown-menu').should have_content @categories[i].name
    }

    find('.image-categories-container').find_link(@categories[9].name.capitalize).should be
    find('.image-categories-container').find_link(@categories[4].name.capitalize).should be
    find('.image-categories-container').should_not have_content(@categories[3].name.capitalize)

    i = 9
    all('a > img').each do |img|
      img[:title].should eq(@categories[i].name.capitalize)
      i -= 1
    end
  end

end