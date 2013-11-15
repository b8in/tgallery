require 'spec_helper'

describe "pictures" do

  describe "#index" do
    let(:category) { FactoryGirl.create(:g_image_category) }
    let(:create_test_images) do
      @images = []
      6.times { @images << FactoryGirl.create(:g_image, g_image_category: category) }
      @images
    end

    before do
      create_test_images
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
      current_path.should eq picture_path(category_name: category.name, id: @images[2].id, locale: 'en')
    end

    it "change central image after click on carosel", js: true do
      sleep(1)
      find('#carousel').first('img').click
      sleep(1)
      find('#central-image a').click
      current_path.should match picture_path(category_name: category.name, id: @images[0].id)
    end

    it "automatic change central image after 5 seconds", js: true do
      sleep(7)
      find('#central-image a').click
      current_path.should match picture_path(category_name: category.name, id: @images[3].id)
    end

    it "check pagination links" do
      find('.pagination > .next').click_link('Next ›')
      expect(current_path).to eq pictures_path(locale: 'en')
      uri = URI.parse(current_url)
      expect("#{uri.path}?#{uri.query}").to eq pictures_path(page:'2', locale: 'en')
    end
  end

  describe "#show" do
    let(:category) { FactoryGirl.create(:g_image_category) }
    let(:image) { FactoryGirl.create(:g_image, g_image_category: category) }
    let(:user) { FactoryGirl.create(:user) }
    let(:create_5_comments) { 5.times { |i| FactoryGirl.create(:user_comment, g_image: image, text: "comment#{i}") } }
    let(:create_events) do
      Event.create(name: 'navigation')
      Event.create(name: 'sign_in')
      Event.create(name: 'sign_out')
      Event.create(name: 'comments')
      Event.create(name: 'likes')
    end

    before do
      visit picture_path(category_name: category.name, id: image.id, locale: :en)
    end

    it "show max last 3 comments by default" do
      4.times { |i| FactoryGirl.create(:user_comment, g_image: image, text: "comment#{i}") }
      visit picture_path(category_name: category.name, id: image.id, locale: :en)
      find('.comments_block .comments').should have_content("comment1")
      find('.comments_block .comments').should have_content("comment2")
      find('.comments_block .comments').should have_content("comment3")
      find('.comments_block .comments').should_not have_content("comment0")
    end

    it { page.should have_selector("h3") }
    it { find("h3").should have_content(image.name) }
    it { page.should have_selector("#span_likes_count") }
    it { page.should have_content("I like") }
    it { page.should have_selector(".image-box > img") }
    it { page.should have_selector("#user_comment_text") }
    it { page.should have_selector(".btn-aa") }
    it { page.should have_selector(".comments_block") }
    it { find(".comments_block").should have_selector(".comments") }

    it "show all comments", js: true do
      create_5_comments
      visit picture_path(category_name: category.name, id: image.id, locale: :en)
      find("#all_comments").click
      sleep(3)
      all("blockquote").count.should eq 5
      find(".comments").should have_content("comment0")
      find(".comments").should have_content("comment4")
    end

    it "hide all comments except 3 last comments", js: true do
      create_5_comments
      visit picture_path(category_name: category.name, id: image.id, locale: :en)
      find("#all_comments").click
      sleep(2)
      find("#close_comments").click
      sleep(2)
      find(".comments").should have_content("comment4")
      find(".comments").should have_content("comment2")
      find(".comments").should_not have_content("comment1")
    end

    context "when user is authorized" do
      before do
        create_events
        sign_in_tgallery(user)
        visit picture_path(category_name: category.name, id: image.id, locale: :en)
      end

      it "add and display new comment", js: true do
        fill_in("user_comment[text]", with: "comment")
        click_on("Add comment")
        sleep(1)
        find("blockquote").should have_content("comment")
        find("#user_comment_text").should_not have_content("comment")
      end

      it "display new comment on main page (root_path)", js: true do
        fill_in("user_comment[text]", with: "comment")
        click_on("Add comment")
        sleep(1)
        visit root_path
        find(".comments_block").find(".comments").find("blockquote").should have_content("comment")
      end

      it "set like", js: true do
        find('#set_like_form').find('button').click
        sleep(1)
        current_path.should eq picture_path(category_name: category.name, id: image.id, locale: :en)
        page.should_not have_selector('.alert-error')
        find('#span_likes_count').should have_content("1")
      end

      it "set like only once per image", js: true do
        find('#set_like_form').find('button').click
        sleep(1)
        find('#set_like_form').find('button').click
        sleep(1)
        current_path.should eq picture_path(category_name: category.name, id: image.id, locale: :en)
        page.should have_selector('.alert-error')
        first('.alert-error').should have_content("You have already voted for this image")
        find('#span_likes_count').should have_content("1")
      end
    end

    context "when guest is not authorized" do
      it { page.should have_selector("#captcha_block") }
      it { page.should have_selector("input#captcha") }
      it { page.should have_selector("#refresh-captcha-btn") }
      it { page.should have_selector("#user_comment_author") }

      it "don't set like", js: true do
        find('#set_like_form').find('button').click
        page.should have_selector('.alert-error')
        first('.alert-error').should have_content("You should been authorized")
        find('#span_likes_count').should have_content("0")
      end

      it "add comment if fill all fields", js: true do
        fill_in("user_comment[author]", with: "User")
        fill_in("user_comment[text]", with: "comment")
        fill_in("captcha", with: "12345")
        click_on("Add comment")
        sleep(1)
        find("blockquote").should have_content("comment")
        find("#user_comment_text").should_not have_content("comment")
      end

      it "don't add comment without filling nickname", js: true do
        fill_in("user_comment[text]", with: "comment")
        fill_in("captcha", with: "12345")
        click_on("Add comment")
        sleep(1)
        page.should_not have_selector("blockquote")
        find("#user_comment_text").should_not have_content("comment")
      end

      it "don't add comment without filling captcha", js: true do
        fill_in("user_comment[author]", with: "User")
        fill_in("user_comment[text]", with: "comment")
        click_on("Add comment")
        sleep(1)
        page.should_not have_selector("blockquote")
        find("#user_comment_text").should_not have_content("comment")
      end
    end

  end

end