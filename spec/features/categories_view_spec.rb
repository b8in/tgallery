require 'spec_helper'

describe "categories" do

  before(:all) do
    @categories = []
    10.times { |i|
      @categories[i] = FactoryGirl.create(:g_image_category)
      2.times { @categories[i].g_images.create(FactoryGirl.attributes_for(:g_image)) }
    }
  end

  after(:all) do
    clear_db
  end

  describe "categories/index" do
    before do
      visit categories_path(locale: 'en')
    end

    context "check page content" do
      it { expect(page).to have_selector('.navbar') }
      it { expect(page).to have_selector('.categories-list') }
      it { expect(find('.categories-list')).to have_selector('.category-item') }
      it { expect(all('.category-item').count).to eq 5 }
      it { expect(all('.categories-list a > img').count).to eq 5 }
      it { expect(first('.category-item')).to have_content("Category name") }
      it { expect(first('.category-item')).to have_content("Images count") }
      it { expect(first('.category-item')).to have_content("Total comments count") }
      it { expect(first('.category-item')).to have_content("Total likes count") }
      it { expect(first('.category-item')).to have_content("Last updated") }
      it { expect(page).to have_selector('nav.pagination') }
    end

    context "check links on view" do
      it "click all image-links on page" do
        i = 9
        all('.category-item > .row > .span2 > a').each do |lnk|
          lnk.click
          expect(current_path).to eq category_path(@categories[i].name, locale: 'en')
          i -= 1
        end
      end

      it "click all category-links on page" do
        i = 9
        all('.category-item > .row > .span8 > a').each do |lnk|
          lnk.click
          expect(current_path).to eq category_path(@categories[i].name, locale: 'en')
          i -= 1
        end
      end

      it "check pagination links" do
        find('.pagination > .next').click_link('Next ›')
        expect(current_path).to eq categories_path(locale: 'en')
        uri = URI.parse(current_url)
        expect("#{uri.path}?#{uri.query}").to eq '/en/categories?page=2'
        expect("#{uri.path}?#{uri.query}").to eq categories_path(page:'2', locale: 'en')
      end
    end

  end


  describe "categories/show_by_name" do

    before(:all) do
      5.times {
        @categories[0].g_images.create(FactoryGirl.attributes_for(:g_image))
      }
      # Total: 7 images
    end

    before do
      visit category_path(category_name: @categories[0].name)
    end

    context "check page content" do
      it { expect(page).to have_selector('.navbar') }
      it { expect(page).to have_selector('#images-container') }
      it { expect(page).to have_content(@categories[0].name.capitalize) }
      it { expect(find('#images-container')).to have_selector('.image-box') }
      it { expect(find('#images-container')).to have_css('.text-align-center-aa') }
      it { expect(all('.image-box').count).to eq 5 }
      it { expect(first('.image-box > a > img')[:title]).to eq(@categories[0].g_images[0].name) }
      it { expect(page).to have_selector('nav.pagination') }
    end

    context "check links on view" do
      it "all images are the links and they all work" do
        i = 0
        all('#images-container > .image-box > a').each do |lnk|
          lnk.click
          expect(current_path).to eq picture_path(category_name: @categories[0].name, id: @categories[0].g_images[i].id, locale: 'en')
          i += 1
        end
      end

      it "check pagination links" do
        find('.pagination > .next').click_link('Next ›')
        expect(current_path).to eq category_path(category_name: @categories[0].name, locale: 'en')
        uri = URI.parse(current_url)
        expect("#{uri.path}?#{uri.query}").to eq "/en/categories/#{@categories[0].name}?page=2"
        expect("#{uri.path}?#{uri.query}").to eq category_path(category_name: @categories[0].name, page:'2', locale: 'en')
      end
    end
  end

end