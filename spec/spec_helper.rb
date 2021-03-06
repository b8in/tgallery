# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
#require 'factory_girl'
require 'capybara/rails'
require 'capybara/rspec'

# Requires supporting ruby files with custom matchers and macros, etc,
# in spec/support/ and its subdirectories.

#!!!!!! http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

RSpec.configure do |config|

  # ## Mock Framework
  #
  # If you prefer to use mocha, flexmock or RR, uncomment the appropriate line:
  #
  # config.mock_with :mocha
  # config.mock_with :flexmock
  # config.mock_with :rr

  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # If true, the base class of anonymous controllers will be inferred
  # automatically. This will be the default behavior in future versions of
  # rspec-rails.
  config.infer_base_class_for_anonymous_controllers = false

  # Run specs in random order to surface order dependencies. If you find an
  # order dependency and want to debug it, you can fix the order by providing
  # the seed, which is printed after each run.
  #     --seed 1234
  config.order = "random"
end

def sign_in_tgallery(user)
  visit new_user_session_path(locale: :en)
  #p "$$ "+current_path
  within('#new_user') do
    fill_in 'Email*:', with: user.email
    fill_in 'Password*:', with: user.password
    click_button('Sign in')
  end
end

def clear_db(verbose=false)
  Rails.application.eager_load!
  models = ActiveRecord::Base.subclasses
  models.each do |m|
    begin
      m.delete_all
      p m.to_s+": Clean" if verbose
    rescue
      p m.to_s+": Table doesn't exist" if verbose
      next
    end
  end
end

def create_comment(user, comment)
  sign_in_tgallery(user)

  visit picture_path(category_name: category.name, id: image.id)
  fill_in('user_comment_text', with: comment)
  click_on("Add comment")

  reset_session!
end

def create_like(user)
  sign_in_tgallery(user)

  visit picture_path(category_name: category.name, id: image.id)
  click_on("I like")

  reset_session!
end