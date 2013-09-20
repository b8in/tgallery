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
      visit categories_path
      page.should have_selector('.navbar')
      page.should have_selector('.categories-list')
      find('.categories-list').should have_selector('.category-item')
      all('.category-item').count.should eq 5
      all('a > img').count.should eq 5
      first('.category-item').should have_content("Category name")
      first('.category-item').should have_content("Images count")
      first('.category-item').should have_content("Total comments count")
      first('.category-item').should have_content("Total likes count")
      first('.category-item').should have_content("Last updated")
      page.should have_selector('nav.pagination')
    end

    it "check links on view" do
      visit categories_path
      i = 9
      all('.category-item > .row > .span2 > a').each do |lnk|
        lnk.click
        current_path.should == category_path(@categories[i].name)
        i -= 1
        visit categories_path
      end

      i = 9
      all('.category-item > .row > .span8 > a').each do |lnk|
        lnk.click
        current_path.should == category_path(@categories[i].name)
        i -= 1
        visit categories_path
      end

      find('.pagination > .next').click_link('Next ›')
      current_path.should == categories_path
      uri = URI.parse(current_url)
      "#{uri.path}?#{uri.query}".should == '/categories?page=2'
      "#{uri.path}?#{uri.query}".should == categories_path(page:'2')

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
      visit category_path(@categories[0].name)
      page.should have_selector('.navbar')
      page.should have_selector('#images-container')
      page.should have_content(@categories[0].name.capitalize)
      find('#images-container').should have_selector('.image-box')
      find('#images-container').should have_css('.text-align-center-aa')
      all('.image-box').count.should eq 5

      first('.image-box > a > img')[:title].should eq(@categories[0].g_images[0].name)

      page.should have_selector('nav.pagination')
    end

    it "check links on view" do
      visit category_path(@categories[0].name)
      i = 0
      all('#images-container > .image-box > a').each do |lnk|
        lnk.click
        current_path.should == picture_path(category_name: @categories[0].name, id: @categories[0].g_images[i].id)
        i += 1
        visit category_path(@categories[0].name)
      end

      find('.pagination > .next').click_link('Next ›')
      current_path.should == category_path(@categories[0].name)
      uri = URI.parse(current_url)
      "#{uri.path}?#{uri.query}".should == "/categories/#{@categories[0].name}?page=2"
      "#{uri.path}?#{uri.query}".should == category_path(category_name: @categories[0].name, page:'2')

      #visit category_path(@categories[0].name)
    end
  end

end