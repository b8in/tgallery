require 'spec_helper'

describe "pictures" do

  before(:all) do
    @category = FactoryGirl.create(:g_image_category)
    @images = []
    6.times { @images << FactoryGirl.create(:g_image, g_image_category: @category) }
    #FactoryGirl.create_list(:g_image, 6)
  end

  after(:all) do
    clear_db
  end

  describe "#index" do
    before do
      visit pictures_path(locale: :en)
    end

    context "page content" do
      it { page.should have_selector('#central-image') }
      it { all('#central-image img').count.should eq 1 }
      it { all('#central-image > a > img').count.should eq 1 }
      it { page.should have_selector('#carousel') }
      it { all('#carousel img').count.should eq 5 }
    end

    it "check central image link" do
      find('#central-image a').click
      current_path.should eq picture_path(category_name: @category.name, id: @images[2].id, locale: 'en')
    end

    it "change central image after click on carosel", js: true do
      sleep(1)
      find('#carousel').first('img').click
      sleep(1)
      find('#central-image a').click
      current_path.should match picture_path(category_name: @category.name, id: @images[0].id)
    end

    it "automatic change central image after 5 seconds", js: true do
      sleep(7)
      find('#central-image a').click
      p current_path
      current_path.should match picture_path(category_name: @category.name, id: @images[3].id)
    end

    it "check pagination links" do
      find('.pagination > .next').click_link('Next ›')
      expect(current_path).to eq pictures_path(locale: 'en')
      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to eq pictures_path(page:'2', locale: 'en')
    end
  end

  describe "#show" do

  end

end