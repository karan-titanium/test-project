require 'spec_helper'


def sign_in_as_a_canditate_user
  # ASk factory girl to generate a valid user for us.
  @user ||= FactoryGirl.create :user
  sign_in @user
  # We action the login request using the parameters before we begin.
  # The login requests will match these to the user we just created in the factory, and authenticate us.
  # post_via_redirect user_session_path, 'user[email]' => @user.email, 'user[password]' => @user.password
end
def sign_in_as_a_staff_user
  @user ||= FactoryGirl.create :staff_user
  sign_in @user
end