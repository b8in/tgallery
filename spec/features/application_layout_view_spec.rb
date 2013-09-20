require 'spec_helper'


describe "application layout" do
  before do
    @events = []
    @events[0] = Event.create(name: 'navigation')
    @events[1] = Event.create(name: 'sign_in')
    @events[2] = Event.create(name: 'sign_out')
    @events[3] = Event.create(name: 'likes')
    @events[4] = Event.create(name: 'comments')

    @user = FactoryGirl.create(:user, email: "ya@ya.su")

    @categories = []
    10.times { |i|
      @categories[i] = FactoryGirl.create(:g_image_category)
      2.times {
        @categories[i].g_images.create(FactoryGirl.attributes_for(:g_image))
      }
    }
  end

  it "user sign_in & sign_out", js:true do
    puts "#{@user.inspect}"
    puts "#{User.last.inspect}"
    visit root_path
    click_link("Sign in")

    within('#new_user') do
      fill_in 'user_email', with: @user.email
      fill_in 'user_password', with: 'password'
      click_button('Sign in')
    end

    page.should have_content('Signed in successfully')
    current_path.should eq(categories_path)


  end

  it "user sign_up & sign_out", js:true do
    visit root_path
    click_link("Sign up")

    within('#new_user') do
      fill_in 'user_email', with: "user#{Time.now.to_i%100000}@mail.com"
      fill_in 'user_password', with: 'password'
      fill_in 'user_password_confirmation', with: 'password'
      click_button('Sign up')
    end

    current_path.should eq(categories_path)
    page.should have_content('You have signed up successfully')

  end

end