# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :user do
    
    
    first_name 'satish'
    last_name 'Aher'
    email 'satishg.aher@gmail.com'
    password 'changeme'
    user_type 'contact'
    status 'active'
    password_confirmation 'changeme'
    confirmed_at Time.now
    confirmation_sent_at "2013-09-16 12:21:19"
    # required if the Devise Confirmable module is used
  end
  factory :user_deleted , :class => User do
    first_name 'satish'
    last_name 'Aher'
    email 'satish.aher@gmail.com'
    password 'changeme'
    user_type 'contact'
    status 'deleted'
    # password_confirmation 'changeme'
    confirmed_at Time.now
    # required if the Devise Confirmable module is used
  end
  factory :staff_user, :class => User do
    first_name 'satish'
    last_name 'Aher'
    email 'satishg.aher@gmail.com.com'
    password 'changeme'
    user_type 'staff'
    status 'active'
    # password_confirmation 'changeme'
    confirmed_at Time.now
  end
  factory :user_for_signup , :class => User do
    first_name 'satish'
    last_name 'Aher'
    email 'satish.aher@gmail.com'
    password 'changeme'
    password_confirmation 'changeme'
    # user_type 'contact'
    # status 'deleted'
    # password_confirmation 'changeme'
    # confirmed_at Time.now
    # required if the Devise Confirmable module is used
  end

end
