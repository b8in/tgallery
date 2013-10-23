# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :watching_category do
    user_id 1
    g_image_category_id 1
    created_at { 1.day.ago }
  end
end
