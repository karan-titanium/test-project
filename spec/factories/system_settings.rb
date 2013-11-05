# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :system_setting do
    key "MyString"
    name "MyString"
    description "MyString"
    value "MyText"
    type ""
    editable false
  end
end
