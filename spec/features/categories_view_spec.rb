require 'spec_helper'

describe "categories" do

  before do
    @categories = []
    10.times { |i|
      @categories[i] = FactoryGirl.create(:g_image_category)
      2.times {
        @categories[i].g_images.create(FactoryGirl.attributes_for(:g_image))
      }
    }
  end

  describe "categories/index" do
    it "check page content" do
      visit categories_path(locale: 'en')
      expect(page).to have_selector('.navbar')
      expect(page).to have_selector('.categories-list')
      expect(find('.categories-list')).to have_selector('.category-item')
      expect(all('.category-item').count).to eq 5
      expect(all('.categories-list a > img').count).to eq 5
      expect(first('.category-item')).to have_content("Category name")
      expect(first('.category-item')).to have_content("Images count")
      expect(first('.category-item')).to have_content("Total comments count")
      expect(first('.category-item')).to have_content("Total likes count")
      expect(first('.category-item')).to have_content("Last updated")
      expect(page).to have_selector('nav.pagination')
    end

    it "check links on view" do
      visit categories_path(locale: 'en')
      i = 9
      all('.category-item > .row > .span2 > a').each do |lnk|
        lnk.click
        expect(current_path).to eq category_path(@categories[i].name, locale: 'en')
        i -= 1
        visit categories_path(locale: 'en')
      end

      i = 9
      all('.category-item > .row > .span8 > a').each do |lnk|
        lnk.click
        expect(current_path).to eq category_path(@categories[i].name, locale: 'en')
        i -= 1
        visit categories_path(locale: 'en')
      end

      find('.pagination > .next').click_link('Next ›')
      expect(current_path).to eq categories_path(locale: 'en')
      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to eq '/en/categories?page=2'
      expect("#{uri.path}?#{uri.query}").to eq categories_path(page:'2', locale: 'en')

      #visit categories_path
    end

  end


  describe "categories/show_by_name" do

    before do
      5.times {
        @categories[0].g_images.create(FactoryGirl.attributes_for(:g_image))
      }
      # Total: 7 images
    end

    it "check page content" do
      visit category_path(category_name: @categories[0].name)
      expect(page).to have_selector('.navbar')
      expect(page).to have_selector('#images-container')
      expect(page).to have_content(@categories[0].name.capitalize)
      expect(find('#images-container')).to have_selector('.image-box')
      expect(find('#images-container')).to have_css('.text-align-center-aa')
      expect(all('.image-box').count).to eq 5

      expect(first('.image-box > a > img')[:title]).to eq(@categories[0].g_images[0].name)

      expect(page).to have_selector('nav.pagination')
    end

    it "check links on view" do
      visit category_path(category_name: @categories[0].name, locale: 'en')
      i = 0
      all('#images-container > .image-box > a').each do |lnk|
        lnk.click
        expect(current_path).to eq picture_path(category_name: @categories[0].name, id: @categories[0].g_images[i].id, locale: 'en')
        i += 1
        visit category_path(category_name: @categories[0].name, locale: 'en')
      end

      find('.pagination > .next').click_link('Next ›')
      expect(current_path).to eq category_path(category_name: @categories[0].name, locale: 'en')
      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to eq "/en/categories/#{@categories[0].name}?page=2"
      expect("#{uri.path}?#{uri.query}").to eq category_path(category_name: @categories[0].name, page:'2', locale: 'en')

      #visit category_path(@categories[0].name)
    end
  end

end