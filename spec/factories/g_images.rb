# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :g_image do
    sequence(:name) { |n| "image#{n}.jpg"}
    image { File.open(File.join(Rails.root, 'spec', 'factories', 'files', 'test_image.jpg')) }
    association :g_image_category, factory: :g_image_category
  end
end
