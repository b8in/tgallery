require 'spec_helper'

describe "Profile" do
  let!(:user) { FactoryGirl.create(:user) }
  let!(:create_events) do
    Event.create(name: 'navigation')
    Event.create(name: 'sign_in')
    Event.create(name: 'sign_out')
  end
  before do
    sign_in_tgallery(user)
    visit edit_user_registration_path(locale: :en)
  end

  context "check content" do
    it { page.should have_selector(".navbar-fixed-top") }
    it { page.should have_selector("#page-container") }
    it { find("#page-container").should have_selector("h2") }
    it { find("#page-container").find("h2").should have_content(user.name) }
    it { find("#page-container").should have_selector("form#edit_user") }
    it { find("form#edit_user").should have_selector("#user_name") }
    it { find("form#edit_user").should have_selector("#user_email") }
    it { find("form#edit_user").should have_selector("#user_password") }
    it { find("form#edit_user").should have_selector("#user_password_confirmation") }
    it { find("form#edit_user").has_link?("Link account").should be_true }
    it { find("form#edit_user").should have_selector("#user_current_password") }
    it { find("form#edit_user").has_xpath?('.//input', text: 'Update profile') }
    it { page.has_link?("Delete account").should be_true }
    it { page.has_link?("Back").should be_true }
    it { page.should have_selector(".footer") }
  end

  it "check link 'Back'", js: true do
    visit categories_path
    visit edit_user_registration_path(locale: :en)
    find_link("Back").click
    current_path.should match(categories_path)
  end

  it "check link 'Delete account'", js: true do
    find_link("Delete account").click
    sleep(1)
    page.driver.browser.switch_to.alert.accept
    sleep(1)
    current_path.should match(root_path)
    find(".navbar-fixed-top").has_link?("Sign in").should be_true
    User.first.should be_nil
  end

  context "successful updating profile" do
    it "change user name", js: true do
      fill_in("user[name]", with: "Pele")
      fill_in("user[current_password]", with: user.password)
      click_on 'Update profile'
      sleep(1)
      page.should have_selector(".alert-success")
      first(".alert-success").should have_content("You updated your account successfully")
      User.first.name.should eq "Pele"
    end

    it "change user email", js: true do
      fill_in("user[email]", with: "pele@foot.ball")
      fill_in("user[current_password]", with: user.password)
      click_on 'Update profile'
      sleep(1)
      page.should have_selector(".alert-success")
      first(".alert-success").should have_content("You updated your account successfully")
      User.first.email.should eq "pele@foot.ball"
    end

    it "change user password", js: true do
      fill_in("user[password]", with: "new_password")
      fill_in("user[password_confirmation]", with: "new_password")
      fill_in("user[current_password]", with: user.password)
      click_on 'Update profile'
      sleep(1)
      page.should have_selector(".alert-success")
      first(".alert-success").should have_content("You updated your account successfully")
    end
  end
end