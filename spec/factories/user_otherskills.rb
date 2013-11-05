# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_otherskill do
    user_id 1
    skill "MyString"
    experience 1
    level "basic"
  end
end
