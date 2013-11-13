# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :service do
    user_id 1
    sequence(:provider) {|n| "Provider#{n}"}
    uid "SOMEUID"
    sequence(:uname) {|n| "User#{n}"}
    sequence(:uemail) {|n| "user#{n}@somemail.com"}
  end
end
