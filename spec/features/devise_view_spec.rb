require 'spec_helper'

describe "Devise" do
  let!(:create_events) do
    events = []
    events[0] = Event.create(name: 'navigation')
    events[1] = Event.create(name: 'sign_in')
    events[2] = Event.create(name: 'sign_out')
    events[3] = Event.create(name: 'likes')
    events[4] = Event.create(name: 'comments')
    events
  end
  let!(:create_10_categories) do
    categories = []
    5.times { |i|
      categories[i] = FactoryGirl.create(:g_image_category)
      2.times {
        categories[i].g_images.create(FactoryGirl.attributes_for(:g_image))
      }
    }
    categories
  end

  let(:user) { FactoryGirl.create(:user, email: "aleks@ukr.net") }

  describe "user sign_in" do
    it "successful", js:true do
      sign_in_tgallery(user)

      expect(page).to have_css('div.alert.alert-success')
      #puts find(".alert").text
      expect(find(".alert")).to have_content('Signed in successfully')
      expect(current_path).to eql(categories_path(locale: :en))
    end

    it "unsuccessful", js:true do
      visit root_path(locale: :en)
      click_link("Sign in")

      within('#new_user') do
        fill_in 'Email*:', with: user.email
        fill_in 'Password*:', with: "wrong #{user.password}"
        click_button('Sign in')
      end

      expect(page).to have_css('div.alert.alert-error')
      expect(find(".alert")).to have_content('Invalid email or password')
      expect(current_path).to eql(new_user_session_path(locale: :en))
    end
  end

  describe "user sign_up" do
    it "successful", js:true do
      visit root_path(locale: :en)
      click_link("Sign up")

      within('#new_user') do
        fill_in 'user_name', with: "New User"
        fill_in 'user_email', with: "user1@mail.com"
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        fill_in 'captcha', with: '12345'
        click_button('Sign up')
      end

      expect(page).to have_css('div.alert.alert-success')
      expect(current_path).to eq(categories_path(locale: :en))
      expect(find(".alert")).to have_content('You have signed up successfully')
    end

    it "unsuccessful", js:true do
      visit root_path(locale: :en)
      click_link("Sign up")

      within('#new_user') do
        fill_in 'user_name', with: "New User"
        fill_in 'user_email', with: "user1-mail.com"
        fill_in 'user_password', with: 'password'
        fill_in 'user_password_confirmation', with: 'password'
        fill_in 'captcha', with: '12345'
        click_button('Sign up')
      end

      expect(current_path).to eq(new_user_registration_path(locale: :en))
    end
  end

end