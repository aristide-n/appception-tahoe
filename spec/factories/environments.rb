# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :environment do
    user_agent "MyString"
    platform "MyString"
    device_name "MyString"
  end
end
