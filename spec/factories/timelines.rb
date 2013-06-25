# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timeline do
    test_name "MyString"
    test_details "MyText"
    json_file_name "MyString"
    json_digest "MyText"
  end
end
