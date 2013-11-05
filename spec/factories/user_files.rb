# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_file do
    user_id 1
    user_file_type "cv"
    cdn_file_id 1
  end
end
