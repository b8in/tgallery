# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :navigation do
    sequence(:target_url) {"http://localhost/some/url/{n}"}
  end
end
