# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :cdn_file do
    user_id 1
    date "2013-08-02 12:53:10"
    ext "MyString"
    mimetype "MyString"
    size 1
    cf_filename "MyString"
  end
end
