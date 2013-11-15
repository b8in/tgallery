require 'spec_helper'

describe "homes/index" do

  before(:all) do
    @comments = []
    6.times do
      @comments << FactoryGirl.create(:user_comment)
    end

    @categories = []
    10.times { |i|
      @categories[i] = FactoryGirl.create(:g_image_category)
      2.times {
        @categories[i].g_images.create(FactoryGirl.attributes_for(:g_image))
      }
    }
  end

  before(:each) do
    visit root_path
  end

  after(:all) do
    clear_db
  end

  context "check page content: " do
    it { expect(find('#about-tgallery')).not_to be_nil }
    it { expect(find('.image-categories-container')).not_to be_nil }

    it "images of categories on page" do
      i = 9
      expect(all('.image-categories-container a > img')).to have(6).images
      all('.image-categories-container a > img').each do |img|
        expect(img[:title]).to eq(@categories[i].name.capitalize)
        i -= 1
      end
    end

    it "page has 6 images from 6 last categories" do
      expect(find('.image-categories-container').find_link(@categories[9].name.capitalize)).to be
      expect(find('.image-categories-container').find_link(@categories[4].name.capitalize)).to be
      expect(find('.image-categories-container')).not_to have_content(@categories[3].name.capitalize)
    end

    it "page has 5 last comments" do
      expect(page).to have_selector('.comments_block')
      expect(find('.comments_block')).to have_content(@comments[5].text)
      expect(find('.comments_block')).to have_content(@comments[1].text)
      expect(find('.comments_block')).not_to have_content(@comments[0].text)
    end

  end

end