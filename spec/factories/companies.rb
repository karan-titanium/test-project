# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :company do
    name "MyString"
    status "active"
    phone "MyString"
    website "http://www.google.com"
    address_line1 "MyString"
    address_line2 "MyString"
    address_town "MyString"
    address_country "UK"
    address_postcode ""
    contact 1
    whitelabel false
    subdomain "MyString"
    displayname "MyString"
    profile "MyText"
    logo 1
  end
end
