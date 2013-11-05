# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :question_category do
    name "Numeracy"
    trait_id 1
    status "active"
  end
end
