# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :g_image_category do
    sequence(:name) {|n| "category#{n}" }
    updated_at { Time.now }
  end
end
