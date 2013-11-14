require 'spec_helper'

describe "events" do

  let(:comment)  { "comment!" }
  let(:category) { FactoryGirl.create(:g_image_category) }
  let(:image) { category.g_images.create(FactoryGirl.attributes_for(:g_image)) }

  before(:all) do
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
  end

  after(:all) do
    clear_db
  end

  describe "events/index" do
    context "check page content" do
      before do
        sign_in_tgallery(@users[0])
        visit events_path
      end
      it { page.should have_selector('.navbar') }
      it { page.should have_selector('table') }
      it { all('table > thead > tr > th').count.should eq 2 }
      it { all('table > thead > tr').count.should eq 1 }
      it { all('table > tbody > tr').count.should eq 2 }
      it { all('table > tbody > tr > td').count.should eq 12 }
      it { first('table > tbody > tr').should have_content(@events[0].name) }
      it { first('table > tbody > tr').should have_content(@events[1].name) }
      it { first('table > tbody > tr').should have_content(@events[2].name) }
      it { first('table > tbody > tr').should have_content(@events[3].name) }
      it { first('table > tbody > tr').should have_content(@events[4].name) }
    end

    it "check links 'navigation' in table" do
      sign_in_tgallery(@users[0])
      visit events_path

      first('table > tbody > tr').should have_content(@users[0].email)
      first('table > tbody > tr > td > a').should have_content(@events[0].name)
      first('table > tbody > tr > td > a').click
      current_path.should eq event_path(user_id: @users[0].id, event_name: @events[0].name, locale: 'en')
    end

    it "check links 'comments' in table" do
      create_comment(@users[0])
      sign_in_tgallery(@users[0])
      visit events_path

      first('table > tbody > tr').should have_content(@users[0].email)
      first('table > tbody > tr').find_link("#{@events[4].name}").click
      current_path.should eq event_path(user_id: @users[0].id, event_name: @events[4].name, locale: 'en')
    end

    it "check links 'likes' in table" do
      create_like(@users[0])
      sign_in_tgallery(@users[0])
      visit events_path

      first('table > tbody > tr').should have_content(@users[0].email)
      first('table > tbody > tr').find_link("#{@events[3].name}").click
      current_path.should eq event_path(user_id: @users[0].id, event_name: @events[3].name, locale: 'en')
    end

    it "check links 'sign_in' in table" do
      sign_in_tgallery(@users[0])
      visit events_path

      first('table > tbody > tr').should have_content(@users[0].email)
      first('table > tbody > tr').find_link("#{@events[1].name}").click
      current_path.should eq event_path(user_id: @users[0].id, event_name: @events[1].name, locale: 'en')
    end

    it "check links 'sign_out' in table" do
      sign_in_tgallery(@users[0])
      click_on("Sign out")
      sign_in_tgallery(@users[0])
      visit events_path

      first('table > tbody > tr').should have_content(@users[0].email)
      first('table > tbody > tr').find_link("#{@events[2].name}").click
      current_path.should eq event_path(user_id: @users[0].id, event_name: @events[2].name, locale: 'en')
    end
  end


  describe "events/show" do
    context "common tests" do
      before do
        sign_in_tgallery(@users[0])
        visit event_path(user_id: @users[0].id, event_name: @events[0].name, locale: 'en')
      end

      it { page.should have_selector('.navbar') }
      it { page.should have_selector('table') }
    end

    context "event navigation" do
      before do
        sign_in_tgallery(@users[0])
        visit event_path(user_id: @users[0].id, event_name: @events[0].name, locale: 'en')
      end

      it { all('table > thead > tr').count.should eq 1 }
      it { all('table > thead > tr > th').count.should eq 2 }
      it { all('table > thead > tr > th')[0].should have_content("Date") }
      it { all('table > thead > tr > th')[1].should have_content("Link") }
      it { first('table > tbody > tr').all('td').count.should eq 2 }
    end

    context "event sign_in" do
      before do
        sign_in_tgallery(@users[0])
        visit event_path(user_id: @users[0].id, event_name: @events[1].name, locale: 'en')
      end

      it { all('table > thead > tr').count.should eq 1 }
      it { all('table > thead > tr > th').count.should eq 1 }
      it { all('table > thead > tr > th')[0].should have_content("Date") }
      it { first('table > tbody > tr').all('td').count.should eq 1 }
    end

    context "event sign_out" do
      before do
        sign_in_tgallery(@users[0])
        click_on("Sign out")
        sign_in_tgallery(@users[0])
        visit event_path(user_id: @users[0].id, event_name: @events[2].name, locale: 'en')
      end

      it { all('table > thead > tr').count.should eq 1 }
      it { all('table > thead > tr > th').count.should eq 1 }
      it { all('table > thead > tr > th')[0].should have_content("Date") }
      it { first('table > tbody > tr').all('td').count.should eq 1 }
    end

    context "event likes" do
      before do
        create_like(@users[0])
        sign_in_tgallery(@users[0])
        visit event_path(user_id: @users[0].id, event_name: @events[3].name, locale: 'en')
      end

      it { all('table > thead > tr').count.should eq 1 }
      it { all('table > thead > tr > th').count.should eq 2 }
      it { all('table > thead > tr > th')[0].should have_content("Date") }
      it { all('table > thead > tr > th')[1].should have_content("Image") }
      it { first('table > tbody > tr').all('td').count.should eq 2 }
      it { first('table > tbody > tr').all('td')[1].should have_content(image.name)}
    end

    context "event comments" do
      before do
        create_comment(@users[0])
        sign_in_tgallery(@users[0])
        visit event_path(user_id: @users[0].id, event_name: @events[4].name, locale: 'en')
      end

      it { all('table > thead > tr').count.should eq 1 }
      it { all('table > thead > tr > th').count.should eq 3 }
      it { all('table > thead > tr > th')[0].should have_content("Date") }
      it { all('table > thead > tr > th')[1].should have_content("Image") }
      it { all('table > thead > tr > th')[2].should have_content("Text") }
      it { first('table > tbody > tr').all('td').count.should eq 3 }
      it { first('table > tbody > tr').all('td')[1].should have_content(image.name)}
      it { first('table > tbody > tr').all('td')[2].should have_content(comment)}
    end
  end
end
