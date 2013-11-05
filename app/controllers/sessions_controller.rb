class SessionsController < Devise::SessionsController
  layout "login_layout" 
  #before_filter :load_and_authorize_resource
  #before_filter :load_permissions # call this after load_and_authorize else it gives a cancan error
	# Objective:
  # Input: Takes user email and password 
  # Output:RAILS S
  # Logic: Redirects user to dashboard only if status is active else to login page with error message 

  def create #session for login user
    self.resource = warden.authenticate!(auth_options)
    set_flash_message(:notice, :signed_in) if is_navigational_format?
    @log_msg = "User Login through TFP Login page" 
    sign_in(resource_name, resource)
    respond_with resource, :location => after_sign_in_path_for(resource)
  end

end
