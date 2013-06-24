# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :timeline do
    dump_file "MyString"
    test_name "MyString"
  end
end
