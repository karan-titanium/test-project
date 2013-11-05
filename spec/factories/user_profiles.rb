# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_profile do
    passport "yes"
    eligableuk "yes"
    eligabledetails "God"
    gender "male"
    number_mob ""
    number_alt ""
    contact_method "email"
    contact_time ["morning","evening","afternoon"]
    address_line1 "B-2"
    address_line2 "Gulmohar socity"
    address_town "baner"
    address_country "India"
    address_postcode ""
    salary_current 15000
    salary_target 80000
  end
end
