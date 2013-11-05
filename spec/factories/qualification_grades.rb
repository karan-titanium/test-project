# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :qualification_grade do
    name "MyString"
    status "MyString"
    qualification_type_id 1
    order 1
  end
end
