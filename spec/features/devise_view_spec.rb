require 'spec_helper'


describe "Devise" do
  before do
    @events = []
    @events[0] = Event.create(name: 'navigation')
    @events[1] = Event.create(name: 'sign_in')
    @events[2] = Event.create(name: 'sign_out')
    @events[3] = Event.create(name: 'likes')
    @events[4] = Event.create(name: 'comments')

    @user = FactoryGirl.create(:user, email: "aleks@ukr.net")

    @categories = []
    5.times { |i|
      @categories[i] = FactoryGirl.create(:g_image_category)
      2.times {
        @categories[i].g_images.create(FactoryGirl.attributes_for(:g_image))
      }
    }
  end

  describe "user sign_in" do
    it "successful", js:true do
      visit root_path(locale: :en)
      click_link("Sign in")

      within('#new_user') do
        fill_in 'Email*:', with: @user.email
        fill_in 'Password*:', with: "password"
        click_button('Sign in')
      end

      page.should have_css('div.alert.alert-success')
      #puts find(".alert").text
      find(".alert").should have_content('Signed in successfully')
      current_path.should eql(categories_path(locale: :en))
    end

    it "unsuccessful", js:true do
      visit root_path(locale: :en)
      click_link("Sign in")

      within('#new_user') do
        fill_in 'Email*:', with: @user.email
        fill_in 'Password*:', with: "pass**word"
        click_button('Sign in')
      end

      page.should have_css('div.alert.alert-error')
      find(".alert").should have_content('Invalid email or password')
      current_path.should eql(new_user_session_path(locale: :en))
    end
  end

  describe "user sign_up" do
    it "successful", js:true do
      visit root_path(locale: :en)
      click_link("Sign up")

      within('#new_user') do
        fill_in 'user_name', with: "New User"
        fill_in 'user_email', with: "user#{Time.now.to_i%100000}@mail.com"
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        fill_in 'captcha', with: '12345'
        click_button('Sign up')
      end

      page.should have_css('div.alert.alert-success')
      current_path.should eq(categories_path(locale: :en))
      find(".alert").should have_content('You have signed up successfully')
    end

    it "unsuccessful", js:true do
      visit root_path(locale: :en)
      click_link("Sign up")

      within('#new_user') do
        fill_in 'user_name', with: "New User"
        fill_in 'user_email', with: "user#{Time.now.to_i%100000}mail.com"
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        fill_in 'captcha', with: '12345'
        click_button('Sign up')
      end

      current_path.should eq(new_user_registration_path(locale: :en))
    end
  end

end