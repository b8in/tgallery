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
    expect(page).to have_selector('.navbar')
    expect(find('#about-tgallery')).not_to be_nil
    expect(find('.image-categories-container')).not_to be_nil
    10.times { |i|
      expect(page).to have_selector('ul.dropdown-menu li')
      expect(find('.pull-left ul.dropdown-menu')).to have_content @categories[i].name
    }

    expect(find('.image-categories-container').find_link(@categories[9].name.capitalize)).to be
    expect(find('.image-categories-container').find_link(@categories[4].name.capitalize)).to be
    expect(find('.image-categories-container')).not_to have_content(@categories[3].name.capitalize)

    i = 9
    all('.image-categories-container a > img').each do |img|
      expect(img[:title]).to eq(@categories[i].name.capitalize)
      i -= 1
    end
  end

end