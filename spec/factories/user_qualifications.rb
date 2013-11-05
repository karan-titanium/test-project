# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_qualification do
    user_id 1
    qualification_type_id 1
    qualification_location_id 1
    qualification_subject_id 1
    qualification_grade_id 1
    year 1234
  end
end
