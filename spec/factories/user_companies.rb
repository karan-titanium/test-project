# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user_company do
    user_id 1
    company_id 1
    current false
    clientcontact false
    from "2013-08-02 12:49:55"
    untill "2013-08-02 12:49:55"
    position "MyString"
  end
end
