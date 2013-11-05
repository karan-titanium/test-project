class UsersController < ApplicationController
  # before_filter :load_and_authorize_resource
  # before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error
  
    def show
      sign_out :user
      redirect_to new_user_session_path
    end
  
end
