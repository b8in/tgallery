# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :e_history do
    date { 1.days.ago }
    association :user, factory: :user
    association :event, factory: :event
  end
end
