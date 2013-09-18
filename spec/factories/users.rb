# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    admin  false
    sequence(:email) {|n| "user#{n}@somemail.com"}
    password "cucuMber"
    password_confirmation {password}
    created_at { 1.month.ago }
    updated_at { 1.month.ago }
    sequence(:name) { |n| "User#{n}" }
  end
end
