# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_comment do
    sequence(:text) {|n| "Comment_#{n}"}
    association :user, factory: :user
    association :g_image, factory: :g_image
  end
end
