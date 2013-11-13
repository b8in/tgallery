require 'spec_helper'

describe "events" do

  before do
    COMMENT_TEXT = "comment!"
    @events = []
    @events[0] = Event.create(name: 'navigation')
    @events[1] = Event.create(name: 'sign_in')
    @events[2] = Event.create(name: 'sign_out')
    @events[3] = Event.create(name: 'likes')
    @events[4] = Event.create(name: 'comments')
    @users = []
    2.times { |i|
      @users[i] = FactoryGirl.create(:user, admin: true)
    }

    @category = FactoryGirl.create(:g_image_category)
    @image = @category.g_images.create(FactoryGirl.attributes_for(:g_image))

    #user events modeling (creating a history)

    current_user = @users[0]
    visit root_path

    visit picture_path(category_name: @category.name, id: @image.id)
    fill_in('user_comment_text', with: COMMENT_TEXT)

    current_user = nil

    current_user =  @users[1]
    visit root_path
    current_user = nil
  end

  describe "events/index" do
    it "check page content", js: true do
      current_user = @users[0]
      visit events_path
      page.should have_selector('.navbar')
      page.should have_selector('table')
      all('table > thead > tr > th').count.should eq 2
      all('table > thead > tr').count.should eq 1
      all('table > tbody > tr').count.should eq 2
      all('table > tbody > tr > td').count.should eq 12
      first('table > tbody > tr').should have_content(@events[0].name)
      first('table > tbody > tr').should have_content(@events[1].name)
      first('table > tbody > tr').should have_content(@events[2].name)
      first('table > tbody > tr').should have_content(@events[3].name)
      first('table > tbody > tr').should have_content(@events[4].name)
    end

    #it "check links on view" do
    #  visit events_path
    #  i = 9
    #  all('.category-item > .row > .span2 > a').each do |lnk|
    #    lnk.click
    #    current_path.should == category_path(@categories[i].name)
    #    i -= 1
    #    visit events_path
    #  end
    #
    #  i = 9
    #  all('.category-item > .row > .span8 > a').each do |lnk|
    #    lnk.click
    #    current_path.should == category_path(@categories[i].name)
    #    i -= 1
    #    visit events_path
    #  end
    #
    #  find('.pagination > .next').click_link('Next ›')
    #  current_path.should == categories_path
    #  uri = URI.parse(current_url)
    #  "#{uri.path}?#{uri.query}".should == '/categories?page=2'
    #  "#{uri.path}?#{uri.query}".should == categories_path(page:'2')
    #
    #  #visit events_path
    #end

  end


  #describe "events/show_by_name" do
  #
  #  before do
  #    5.times {
  #      @categories[0].g_images.create(FactoryGirl.attributes_for(:g_image))
  #    }
  #    # Total: 7 images
  #  end
  #
  #  it "check page content" do
  #    visit category_path(@categories[0].name)
  #    page.should have_selector('.navbar')
  #    page.should have_selector('#images-container')
  #    page.should have_content(@categories[0].name.capitalize)
  #    find('#images-container').should have_selector('.image-box')
  #    find('#images-container').should have_css('.text-align-center-aa')
  #    all('.image-box').count.should eq 5
  #
  #    first('.image-box > a > img')[:title].should eq(@categories[0].g_images[0].name)
  #
  #    page.should have_selector('nav.pagination')
  #  end
  #
  #  it "check links on view" do
  #    visit category_path(@categories[0].name)
  #    i = 0
  #    all('#images-container > .image-box > a').each do |lnk|
  #      lnk.click
  #      current_path.should == picture_path(category_name: @categories[0].name, id: @categories[0].g_images[i].id)
  #      i += 1
  #      visit category_path(@categories[0].name)
  #    end
  #
  #    find('.pagination > .next').click_link('Next ›')
  #    current_path.should == category_path(@categories[0].name)
  #    uri = URI.parse(current_url)
  #    "#{uri.path}?#{uri.query}".should == "/categories/#{@categories[0].name}?page=2"
  #    "#{uri.path}?#{uri.query}".should == category_path(category_name: @categories[0].name, page:'2')
  #
  #    #visit category_path(@categories[0].name)
  #  end
  #end

end