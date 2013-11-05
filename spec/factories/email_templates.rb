# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :email_template do
    name "MyString"
    subject "MyString"
    content_html "MyText"
    content_plain "MyText"
  end
end
