# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :like do
    association :g_image, factory: :g_image
  end
end
